CREATE PROC [dbo].[GC_Dashboards_Customer] 
(
	@Customer_ID			int,
	@GrapeChartTypeID	int = 1, -- 1: Defect Maker, 2: Defect Finder
	@GC_Month			int,
	@GC_Year			int,
	@EmployeeID_ID		int = 0,
	@TopN				int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @FromDate					datetime
			, @ToDate					datetime
			, @FromDate2				datetime
			, @NextEmployeeID_ID		int
	SET @FromDate = [dbo].[ufn_FromDate](@GC_Month, @GC_Year)
	SET @ToDate = [dbo].[ufn_ToDate](@GC_Month, @GC_Year)
	
	IF @TopN = 0
	BEGIN
		SELECT TOP 1 @NextEmployeeID_ID = A.[EmployeeID_ID]
		FROM	[dbo].[HR_Employee] A WITH (NOLOCK)
		WHERE	A.[Customer_ID] = @Customer_ID
				AND A.[IsActive] = 1
				AND A.[EmployeeID_ID] > @EmployeeID_ID
				AND EXISTS (SELECT 1
							FROM [dbo].[GC_Daily_EmployeeID_ID] B WITH (NOLOCK)
							WHERE	B.[EmployeeID_ID] = A.[EmployeeID_ID]
									AND B.[GrapeChartTypeID] = @GrapeChartTypeID
									AND B.[EscapedDate] BETWEEN @FromDate AND @ToDate
									)
		ORDER BY A.[EmployeeID_ID]
			
		SET @NextEmployeeID_ID = ISNULL(@NextEmployeeID_ID, 0)
		IF @NextEmployeeID_ID = 0
		BEGIN
			SELECT TOP 1 @NextEmployeeID_ID = A.[EmployeeID_ID]
			FROM	[dbo].[HR_Employee] A WITH (NOLOCK)
			WHERE	A.[Customer_ID] = @Customer_ID
					AND A.[IsActive] = 1
					AND EXISTS (SELECT 1
								FROM [dbo].[GC_Daily_EmployeeID_ID] B WITH (NOLOCK)
								WHERE	B.[EmployeeID_ID] = A.[EmployeeID_ID]
										AND B.[GrapeChartTypeID] = @GrapeChartTypeID
										AND B.[EscapedDate] BETWEEN @FromDate AND @ToDate
										)
			ORDER BY A.[EmployeeID_ID]
		END
	END
	ELSE -- Top 10
	BEGIN
		DECLARE @tmpTop10 AS TABLE
		(
			[No]				[int],
			[EmployeeID_ID]		[int],
			[TotalDefect]		[int]
		)
		INSERT INTO @tmpTop10
		SELECT ROW_NUMBER() OVER (ORDER BY B.[TotalDefect] DESC) AS [No]
				, A.[EmployeeID_ID]
				, B.[TotalDefect]
		FROM	[dbo].[HR_Employee] A WITH (NOLOCK) INNER JOIN (SELECT B.[EmployeeID_ID]
																, SUM(B.[TotalDefect]) AS [TotalDefect]
																FROM [dbo].[GC_Daily_EmployeeID_ID] B WITH (NOLOCK)
																WHERE	B.[GrapeChartTypeID] = @GrapeChartTypeID
																		AND B.[EscapedDate] BETWEEN @FromDate AND @ToDate
															GROUP BY B.[EmployeeID_ID]
															) B ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
		WHERE	A.[Customer_ID] = @Customer_ID
				AND A.[IsActive] = 1		
		
		SELECT TOP 1 @NextEmployeeID_ID = [EmployeeID_ID]
		FROM 	@tmpTop10
		WHERE 	[No] = @TopN
		--SELECT A.[EmployeeID_ID], A.[No], A.[TotalDefect], B.[EmployeeName]
		--FROM @tmpTop10 A INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
									
	END
	
	DECLARE @tmp AS TABLE
	(
		[EscapedDate] datetime
	)
	SET @FromDate2 = @FromDate
	WHILE (@FromDate2 <= @ToDate)
	BEGIN
		INSERT INTO @tmp
		VALUES(@FromDate2)
		SET @FromDate2 = DATEADD(DAY, 1, @FromDate2)
	END						
							
	SELECT	  @NextEmployeeID_ID AS [EmployeeID_ID]
			  ,@GC_Year AS [Year]
			  ,@GC_Month AS [Month]
			  
			  ,A.[EscapedDate]
			  ,DATEPART(DAY, A.[EscapedDate]) AS [Day]
			  ,(CASE WHEN A.[EscapedDate] > GETDATE() THEN 0 
					WHEN ISNULL(B.[TotalDefect], 0) > 0 AND ISNULL(B.[TotalDefect], 0) <= 3 AND @GrapeChartTypeID = 1 THEN 2
					--WHEN ISNULL(B.[TotalDefect], 0) > 3 AND @GrapeChartTypeID = 1 THEN 3
					WHEN ISNULL(B.[TotalDefect], 0) > 3 THEN [dbo].[ufn_GC_DayStatus](@NextEmployeeID_ID, A.[EscapedDate], 3)
					WHEN ISNULL(B.[TotalDefect], 0) = 0 AND @GrapeChartTypeID = 2 THEN 0
				ELSE 1 END) AS [DayStatus] -- -1: Invisible (hide date), 0: Not working, 1: Green, 2: Yellow, 3: Red
			 
	FROM @tmp A LEFT OUTER JOIN (
								SELECT [EmployeeID_ID]
									  ,[GrapeChartTypeID]
									  ,[EscapedDate]
									  ,[TotalDefect]
									  ,[DefectText]
								  
								FROM [dbo].[GC_Daily_EmployeeID_ID] WITH (NOLOCK)
								WHERE [EmployeeID_ID] = @NextEmployeeID_ID
									AND [GrapeChartTypeID] = @GrapeChartTypeID
									AND [EscapedDate] BETWEEN @FromDate AND @ToDate
										 
							) B ON A.[EscapedDate] = B.[EscapedDate]
								
END

