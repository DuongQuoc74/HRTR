CREATE PROC [dbo].[GC_Data_EmployeeSkillTracker_To_Date] 
(
	@EmployeeID_ID  int,
	@SelectedDay	DateTime
	
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @FromDate		datetime
			, @ToDate		datetime
			, @FromDate2	datetime
			
	SET @FromDate = DateAdd(Day, -29, @SelectedDay)
	SET @ToDate = @SelectedDay
	--PRINT @FromDate
	--PRINT @ToDate
	CREATE TABLE #tmp 
	(
		[EscapedDate] datetime
	)
	--SET @FromDate2 = @FromDate
	--WHILE (@FromDate2 <= @ToDate)
	--BEGIN
	--	INSERT INTO #tmp
	--	VALUES(@FromDate2)
	--	SET @FromDate2 = DATEADD(DAY, 1, @FromDate2)
	--END
	;
	WITH [DatesOfMonth] AS
	(
	  SELECT @FromDate AS [DateValue]
	  UNION ALL
	  SELECT  [DateValue] + 1
	  FROM    [DatesOfMonth]   
	  WHERE   [DateValue] + 1 <= @ToDate
	)
	INSERT INTO #tmp
	SELECT  [DateValue]
	FROM    [DatesOfMonth]
	OPTION	(MAXRECURSION 0);

	SELECT	  @EmployeeID_ID AS [EmployeeID_ID]
			  			  
			  ,A.[EscapedDate]
			  
			  ,DATEPART(DAY, A.[EscapedDate]) AS [Day]
			  
			 -- ,(CASE	WHEN A.[EscapedDate] > GETDATE() THEN 0 
				--		WHEN B.[TotalDefect] <= 3 AND B.[TotalDefect] > 0 THEN 2
				--		--WHEN B.[TotalDefect] > 3 THEN 3
				--		WHEN B.[TotalDefect] > 3 THEN [dbo].[ufn_GC_DayStatus](@EmployeeID_ID, A.[EscapedDate], 3)
				--ELSE 1 END) AS [DayStatus] -- -1: Invisible (hide date), 0: Not working, 1: Green, 2: Yellow, 3: Red
			,(CASE	WHEN A.[EscapedDate] > GETDATE() THEN 0 
						WHEN B.[TotalDefect] <= 2 AND B.[TotalDefect] > 0 THEN [dbo].[ufn_GC_DayStatus](@EmployeeID_ID, A.[EscapedDate], 2) -- 2 or 5
						WHEN B.[TotalDefect] > 2 AND B.[TotalDefect] <= 5 THEN [dbo].[ufn_GC_DayStatus](@EmployeeID_ID, A.[EscapedDate], 3) -- 3 or 5
						WHEN B.[TotalDefect] > 5 THEN [dbo].[ufn_GC_DayStatus](@EmployeeID_ID, A.[EscapedDate], 4) -- 4 or 5						
				ELSE 1 END) AS [DayStatus] -- -1: Invisible (hide date), 0: Not working, 1: Green, 2: Yellow, 3: Red, 4: Brown, 5: Violet
				,(CASE	WHEN A.[EscapedDate] > GETDATE() THEN 0 
						WHEN B.[TotalDefect] <= 2 AND B.[TotalDefect] > 0 THEN  2
						WHEN B.[TotalDefect] > 2 AND B.[TotalDefect] <= 5 THEN 3
						WHEN B.[TotalDefect] > 5 THEN 4
				ELSE 1 END) AS [TextColorStatus] -- -1: Invisible (hide date), 0: Not working, 1: Green, 2: Yellow, 3: Red, 4: Brown
			  ,ISNULL(B.[TotalDefect], 0) AS [TotalDefect]
			  
			  ,ISNULL(B.[DefectText], '') AS [DefectText]
			 
	FROM #tmp A LEFT OUTER JOIN (
	
							SELECT	  A.[EmployeeID_ID]
									  ,A.[EscapedDate]
									  ,A.[TotalDefect]
									  ,[dbo].[ufn_GetDefectText_By_EmployeeID_ID_EscapedDate] (A.[EmployeeID_ID], A.[EscapedDate]) AS [DefectText]
									  
							FROM		[dbo].[GC_Data_V2] A WITH (NOLOCK) 
							WHERE		A.[EmployeeID_ID] = @EmployeeID_ID
										AND A.[EscapedDate] BETWEEN @FromDate AND @ToDate
										AND A.[GrapeChartTypeID] = 1 -- Defect Maker
							) B ON A.[EscapedDate] = B.[EscapedDate]
							
							
	DROP TABLE #tmp 	
END
GO