CREATE PROC [dbo].[rptGC_SummaryChart] 
(
	@EscapedDateFrom		datetime,
	@EscapedDateTo			datetime,
	--@WorkcellID				int = 1,
	@Customer_ID			int = 0,
	@ShiftID				int = 0,
	@EmployeeID				nvarchar(10),
	@TopN					int,
	@GrapeChartTypeID		int, -- 1: Escape, 2: Detect
	@GroupTypeID			int, -- 1: CRD, 2: Defect, 3: Station, 4: Employee
	@GroupBy				int = 0 -- 1: Day, 2: Week, 3: Month
)
AS
BEGIN
	SET NOCOUNT ON
	SET @EscapedDateFrom = CONVERT(VARCHAR(10), @EscapedDateFrom , 120)  + ' 00:00:00.000' 
	SET @EscapedDateTo = CONVERT(VARCHAR(10), @EscapedDateTo , 120)  + ' 23:59:59.990' 
	
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				--, @QueryTopN					nvarchar(20)
				, @QueryGroupBy1				nvarchar(100)
				, @QueryGroupBy2				nvarchar(100)
				, @QueryList					nvarchar(max)
				, @Query2						nvarchar(max)
				, @EmployeeID_ID				int
				, @EscapedDate					datetime
	SET @EmployeeID_ID = 0
	IF @EmployeeID != ''
	BEGIN
		SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
		FROM [dbo].[HR_Employee] WITH (NOLOCK)
		WHERE [EmployeeID] = @EmployeeID
	END
	
	SET @ParmDef = N'@EscapedDateFrom		datetime,
					@EscapedDateTo			datetime,
					@Customer_ID			int,
					@ShiftID				int,
					@EmployeeID_ID			int,
					@TopN					int,
					@GrapeChartTypeID		int,
					@GroupTypeID			int '			
	SET @Query2 = ''	
	IF @TopN = 0
	BEGIN
		IF  @GroupTypeID = 1 OR @GroupTypeID = 4 -- 1: CRD, 2: Defect, 3: Station, 4: Employee
			SET @TopN = 20
		ELSE
			SET @TopN = 100
	END
	SET @EscapedDate = @EscapedDateFrom
	SET @QueryList = ''
	IF @GroupBy = 1 -- Day
	BEGIN
		SET @QueryGroupBy1 = 'CONVERT(NVARCHAR(10), [EscapedDate], 120) AS [GroupName]'
		SET @QueryGroupBy2 = 'CONVERT(NVARCHAR(10), [EscapedDate], 120), '
		WHILE @EscapedDate <= @EscapedDateTo
		BEGIN
			SET @QueryList = @QueryList + '[' + CONVERT(NVARCHAR(10), @EscapedDate, 120) + '], '
			SET @EscapedDate = DATEADD(DAY, 1, @EscapedDate)
		END
	END
	ELSE IF @GroupBy = 2 -- Week
	BEGIN
		SET @QueryGroupBy1 = '[Week] AS [GroupName]'
		SET @QueryGroupBy2 = '[Week], '
		DECLARE @WeekEnd	datetime
		SET @WeekEnd = DATEADD(ww, DATEDIFF(ww, 0, @EscapedDateTo - 1), 0) + 6
		--PRINT @WeekEnd
		WHILE @EscapedDate <= @WeekEnd
		BEGIN
			SET @QueryList = @QueryList + '[' + [dbo].[ufn_GC_Week_By_DateTime](@EscapedDate) + '], '
			SET @EscapedDate = DATEADD(WEEK, 1, @EscapedDate)
		END
	END
	ELSE IF @GroupBy = 3 -- Month
	BEGIN
		SET @QueryGroupBy1 = '[Month] AS [GroupName]'
		SET @QueryGroupBy2 = '[Month], '
		DECLARE @MonthEnd	datetime
		SET @MonthEnd = DATEADD(MM, 1, CONVERT(DATETIME, CONVERT(VARCHAR(8), @EscapedDateTo, 102) + '01', 102))
		--PRINT @MonthEnd
		WHILE @EscapedDate <= @MonthEnd
		BEGIN
		--PRINT @EscapedDate
			SET @QueryList = @QueryList + '[' + [dbo].[ufn_GC_Month_By_DateTime](@EscapedDate) + '], '
			SET @EscapedDate = DATEADD(MONTH, 1, @EscapedDate)
		END
	END
	ELSE
	BEGIN
		SET @QueryGroupBy1 = ''
		SET @QueryGroupBy2 = ''
	END
	IF @QueryList != ''
		SET @QueryList = LEFT(@QueryList, LEN(@QueryList) - 1)
	--PRINT @QueryList
	CREATE TABLE #tmp
	(
		[No.]			[int] NULL,
		[GroupName]		[nvarchar](50),
		[Name]			[nvarchar](200),
		[Total]			[int]
	)
	--CREATE CLUSTERED INDEX [IX_tmp] ON #tmp([No.])
	IF  @GroupTypeID = 1 AND @GrapeChartTypeID = 1 -- CRD & Escaped
	BEGIN
		SET @Query = N'SELECT ' + @QueryGroupBy1 + N', A.[CRD] AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK)
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
		'
		
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != ''
			SET @Query2 = @Query2 + N' AND B.[EscapedByEmployeeID_ID] = @EmployeeID_ID'
		
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'A.[CRD] ORDER BY [Total] DESC'
	END
	ELSE IF  @GroupTypeID = 1 AND @GrapeChartTypeID = 2 -- CRD & Detected
	BEGIN

		SET @Query = N'SELECT ' + @QueryGroupBy1 + N', A.[CRD] AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK)
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
		'
		
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != ''
			SET @Query2 = @Query2 + N' AND B.[DetectedByEmployeeID_ID] = @EmployeeID_ID'
		
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'A.[CRD] ORDER BY [Total] DESC'
		
		
	END
	ELSE IF  @GroupTypeID = 2 -- Defect
	BEGIN
		SET @Query = N'SELECT ' + @QueryGroupBy1 + N', B.[DefectText] AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK) INNER JOIN [dbo].[QM_Defects_V] B WITH (NOLOCK) ON A.[Defect_ID] = B.[Defect_ID]
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
		'
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != 0
			SET @Query2 = @Query2 + N' AND B.[EscapedByEmployeeID_ID] = @EmployeeID_ID'
		
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'B.[DefectText] ORDER BY [Total] DESC'
	END
	ELSE IF  @GroupTypeID = 3 AND @GrapeChartTypeID = 1 -- Station & Escaped
	BEGIN
		SET @Query =N'SELECT ' + @QueryGroupBy1 + N', B.[StationName] AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK) INNER JOIN [dbo].[GC_Station] B WITH (NOLOCK) ON A.[EscapedStationID] = B.[GC_StationID]
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
		'
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != 0
			SET @Query2 = @Query2 + N' AND B.[EscapedByEmployeeID_ID] = @EmployeeID_ID'
			
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'B.[StationName] ORDER BY [Total] DESC'

	END
	ELSE IF  @GroupTypeID = 3 AND @GrapeChartTypeID = 2 -- Station & Detected
	BEGIN
		SET @Query = N'SELECT ' + @QueryGroupBy1 + N', B.[StationName] AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK) INNER JOIN [dbo].[GC_Station] B WITH (NOLOCK) ON A.[DetectedStationID] = B.[GC_StationID]
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
		'
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != 0
			SET @Query2 = @Query2 + N' AND B.[DetectedByEmployeeID_ID] = @EmployeeID_ID'
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'B.[StationName] ORDER BY [Total] DESC'
	END
	ELSE IF  @GroupTypeID = 4 AND @GrapeChartTypeID = 1 -- Employee & Escaped
	BEGIN
		SET @Query =N'SELECT ' + @QueryGroupBy1 + N', (B.[EmployeeID] + ''-'' + B.[EmployeeName]) AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK) INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EscapedByEmployeeID_ID] = B.[EmployeeID_ID]
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
				AND A.[EscapedByEmployeeID_ID] NOT IN (-1, -2, -3)
		'
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != 0
			SET @Query2 = @Query2 + N' AND B.[EscapedByEmployeeID_ID] = @EmployeeID_ID'
			
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'B.[EmployeeID], B.[EmployeeName] ORDER BY [Total] DESC'

	END
	ELSE IF  @GroupTypeID = 4 AND @GrapeChartTypeID = 2 -- Employee & Detected
	BEGIN
		SET @Query =N'SELECT ' + @QueryGroupBy1 + N', (B.[EmployeeID] + ''-'' + B.[EmployeeName]) AS [Name]
					   , COUNT(DISTINCT A.[SerialNumber]) AS [Total]
		FROM	[dbo].[GC_Data_V] A WITH (NOLOCK) INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[DetectedByEmployeeID_ID] = B.[EmployeeID_ID]
		WHERE 	A.[Customer_ID] = @Customer_ID
				AND A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
				AND A.[DetectedByEmployeeID_ID] NOT IN (-1, -2, -3)'
		IF @ShiftID != 0
			SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
		IF @EmployeeID != 0
			SET @Query2 = @Query2 + N' AND B.[DetectedByEmployeeID_ID] = @EmployeeID_ID'
			
		SET @Query2 = @Query2 + ' GROUP BY ' + @QueryGroupBy2 + N'B.[EmployeeID], B.[EmployeeName] ORDER BY [Total] DESC'
	END
	
	SET @Query = 'INSERT INTO #tmp ([GroupName], [Name], [Total]) ' + @Query + @Query2 
	--SELECT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @EscapedDateFrom
								, @EscapedDateTo
								, @Customer_ID
								, @ShiftID
								, @EmployeeID_ID
								, @TopN
								, @GrapeChartTypeID
								, @GroupTypeID
								
	UPDATE A
	SET [No.] = B.[No.]
	FROM #tmp A WITH (NOLOCK) INNER JOIN (SELECT ROW_NUMBER() OVER (ORDER BY SUM(B.[Total]) DESC) AS [No.]
												, B.[Name]
												, SUM(B.[Total]) AS [Total]
										FROM #tmp B WITH (NOLOCK) 
										GROUP BY B.[Name]) B ON A.[Name] = B.[Name]
	--EXEC sp_executesql @Query
	
	SELECT	
			--[No.]
			--, 
			B.[Name]
			, SUM(B.[Total]) AS [Total]
	FROM #tmp B WITH (NOLOCK) 
	WHERE [No.] <= @TopN
	GROUP BY B.[Name], [No.]
	--ORDER BY [No.]
	
	SET @Query = 'SELECT [Name], ' + @QueryList + N' FROM (SELECT [GroupName]
																, [Name]
																, [Total]
																, [No.]
															FROM #tmp B WITH (NOLOCK) 
															WHERE [No.] <= @TopN) AS p  
					  PIVOT  
					  (  
						 SUM([Total])  FOR [GroupName] IN (' + @QueryList + N')
					  ) AS pvt ORDER BY [No.]'
	SET @ParmDef = N'@TopN int'
	EXEC sp_executesql @Query, @ParmDef
								, @TopN
	
	DROP TABLE #tmp
	

END

