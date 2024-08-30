CREATE PROC [dbo].[GC_Data_WorkcellSkillTracker] 
(
	@WorkcellID		int,
	@Year			int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @FromDate	datetime
			, @ToDate	datetime

	SET @FromDate = STR(@Year) + '-01-01'  + ' 00:00:00.000' 
	SET @ToDate = DATEADD(YEAR, 1, @FromDate)
	--PRINT @FromDate
	--PRINT @ToDate
	
	
	
	CREATE TABLE #tmp
	(
		[EmployeeID_ID] [int] NOT NULL,
		[MonthName]		[nvarchar](20) NOT NULL,
		[Green]			[decimal](5,2) NULL
	)
	INSERT INTO #tmp
	SELECT D.[EmployeeID_ID]
			, B.[MonthName]
			, (100.00 - ISNULL(B.[Red], 0)) AS [Green]
	FROM	[dbo].[HR_Employee] D WITH (NOLOCK) INNER JOIN 
				(
							SELECT	A.[EmployeeID_ID]
									  ,A.[MonthName]
									  ,A.[Month]
									  ,A.[Year]
									  ,(SUM(A.[Red])*100/[dbo].[ufn_TotalDayOfMonth](A.[Month], A.[Year])*1.00) AS [Red]
							FROM		[dbo].[GC_Data_V3] A WITH (NOLOCK)
							WHERE		A.[EscapedDate] BETWEEN @FromDate AND @ToDate
										AND A.[GrapeChartTypeID] = 1 -- Defect Maker
							GROUP BY	A.[EmployeeID_ID]
										,A.[MonthName]
										,A.[Month]
										,A.[Year]
				) B ON D.[EmployeeID_ID] = B.[EmployeeID_ID]
	--WHERE D.[WorkcellID] = @WorkcellID
	CREATE TABLE #tmp2
	(
		[EmployeeID_ID] [int],
		[EmployeeID]	[varchar](10),
		[EmployeeName]	[nvarchar](100),
		[January]		[decimal](5,2),
		[February]		[decimal](5,2),
		[March]			[decimal](5,2),
		[April]			[decimal](5,2),
		[May]			[decimal](5,2),
		[June]			[decimal](5,2),
		[July]			[decimal](5,2),
		[August]		[decimal](5,2),
		[September]		[decimal](5,2),
		[October]		[decimal](5,2),
		[November]		[decimal](5,2),
		[December]		[decimal](5,2)
	)
	INSERT INTO #tmp2
	SELECT E.[EmployeeID_ID]
			, E.[EmployeeID]
			, E.[EmployeeName]
			, ISNULL([January], 100) AS [January]
			, ISNULL([February], 100) AS [February]
			, ISNULL([March], 100) AS [March]
			, ISNULL([April], 100) AS [April]
			, ISNULL([May], 100) AS [May]
			, ISNULL([June], 100) AS [June]
			, ISNULL([July], 100) AS [July]
			, ISNULL([August], 100) AS [August]
			, ISNULL([September], 100) AS [September]
			, ISNULL([October], 100) AS [October]
			, ISNULL([November], 100) AS [November]
			, ISNULL([December], 100) AS [December]
	FROM [dbo].[HR_Employee] E WITH (NOLOCK, INDEX([IX_HR_Employee_1]))
		LEFT OUTER JOIN (
							SELECT	[EmployeeID_ID]
									, [January], [February], [March]
									, [April], [May], [June]
									, [July], [August], [September]
									, [October], [November], [December]
									
							FROM	(	SELECT [EmployeeID_ID]
									  ,[Green]
									  ,[MonthName]
										FROM #tmp
									 ) AS p  
									 PIVOT  
									 (  
										 MAX([Green])  FOR [MonthName] IN ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
									 ) AS pvt
								 ) P
						ON E.[EmployeeID_ID] = P.[EmployeeID_ID]
	WHERE	E.[WorkcellID] = @WorkcellID
			AND ISNULL(E.[IsActive], 0) = 1
			
	SELECT *
	FROM	#tmp2

	SELECT [MonthName], [Green]
	FROM (SELECT SUM([January])/COUNT(*) AS [January]
			, SUM([February])/COUNT(*) AS [February]
			, SUM([March])/COUNT(*) AS [March]
			, SUM([April])/COUNT(*) AS [April]
			, SUM([May])/COUNT(*) AS [May]
			, SUM([June])/COUNT(*) AS [June]
			, SUM([July])/COUNT(*) AS [July]
			, SUM([August])/COUNT(*) AS [August]
			, SUM([September])/COUNT(*) AS [September]
			, SUM([October])/COUNT(*) AS [October]
			, SUM([November])/COUNT(*) AS [November]
			, SUM([December])/COUNT(*) AS [December]
	 FROM #tmp2) p
	UNPIVOT ( [Green] FOR [MonthName] IN ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
	)
	AS unpvt
 
	 
	 DROP TABLE #tmp
	 DROP TABLE #tmp2
END


