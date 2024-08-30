CREATE PROC [dbo].[GC_Data_eGrapeChart] 
(
	@UserName		varchar(50),
	@TerminalName	varchar(150) = '',
	@Year			int,
	@Month			int,
	@ProductName	nvarchar(50) = '',
	@ProductVersion	nvarchar(50) = ''
)
AS
BEGIN
	SET NOCOUNT ON
	
	--IF @UserName != 'NguyenN28'
	--	RETURN
		
	DECLARE @EmployeeID_ID		int
			, @EmployeeID		nvarchar(20)
			, @EmployeeName		nvarchar(100)
	SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
				, @EmployeeID	= [EmployeeID]
				, @EmployeeName = [EmployeeName]
	FROM [dbo].[HR_Employee] WITH (NOLOCK)
	WHERE [UserName] = @UserName
			AND [PositionID] = 1 -- for DL only
	--WHERE [EmployeeID] = '15659'
	--AND 1= 2
	SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, 0)
	SET @EmployeeID = ISNULL(@EmployeeID, N'Unknown')
	SET @EmployeeName = ISNULL(@EmployeeName, N'Unknown')
	
	IF @EmployeeID_ID = 0
	BEGIN
		RETURN
	END
	--IF @EmployeeID_ID = 4024
	--BEGIN
	--	SET @EmployeeID_ID = 1072
	--END
	INSERT INTO [dbo].[GC_Logs]
           ([EmployeeID_ID]
           ,[UserName]
           ,[TerminalName]
		   ,[ProductName]
		   ,[ProductVersion]
           ,[LastUpdated]
           ,[LastUpdatedBy])
     VALUES
           (@EmployeeID_ID
           ,@UserName
           ,@TerminalName
		   ,@ProductName
		   ,@ProductVersion
           ,GETDATE()
           ,-1)
    UPDATE [dbo].[CCS_Terminal]
	SET [eGCProductName] = @ProductName
		, [eGCProductVersion] = @ProductVersion
	WHERE [TerminalName] = @TerminalName
	       
	DECLARE @FromDate		datetime
			, @ToDate		datetime
			, @FromDate2	datetime
			
	SET @FromDate = [dbo].[ufn_FromDate](@Month, @Year)
	SET @ToDate = [dbo].[ufn_ToDate](@Month, @Year)
	--PRINT @FromDate
	--PRINT @ToDate
	CREATE TABLE #tmp 
	(
		[EscapedDate] datetime
	)
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
			  ,(@EmployeeID + N' - ' + @EmployeeName) AS [FullName]
			  ,@Year AS [Year]
			  ,@Month AS [Month]
			  
			  ,A.[EscapedDate]
			  
			  ,DATEPART(DAY, A.[EscapedDate]) AS [Day]
			  
			  ,(CASE	WHEN A.[EscapedDate] > GETDATE() THEN 0 
						WHEN B.[TotalDefect] <= 3 AND B.[TotalDefect] > 0 THEN 2
						WHEN B.[TotalDefect] > 3 THEN [dbo].[ufn_GC_DayStatus](@EmployeeID_ID, A.[EscapedDate], 3)
						--WHEN B.[TotalDefect] > 3 THEN 3
				ELSE 1 END) AS [DayStatus] -- -1: Invisible (hide date), 0: Not working, 1: Green, 2: Yellow, 3: Red, 4: Violet
				
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


