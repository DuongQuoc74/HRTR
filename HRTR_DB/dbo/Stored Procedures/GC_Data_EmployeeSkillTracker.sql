CREATE PROC [dbo].[GC_Data_EmployeeSkillTracker] 
(
	@EmployeeID_ID  int,
	@Year			int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @FromDate	datetime
			, @ToDate	datetime
			, @I		int
	DECLARE @tmp TABLE 
	(
		[MonthName]		varchar(20),
		[Month]			int,
		[Year]			int
	)
	SET @I = 1
	WHILE (@I <= 12)
	BEGIN
		INSERT INTO @tmp
		VALUES (DATENAME(MM, STR(@I) + '/1/' + STR(@Year)), @I, @Year)
		SET @I = @I + 1
	END

	SET @FromDate = STR(@Year) + '-01-01'  + ' 00:00:00.000' 
	SET @ToDate = DATEADD(YEAR, 1, @FromDate)
	--PRINT @FromDate
	--PRINT @ToDate
	SELECT D.[EmployeeID_ID]
			,D.[EmployeeID]
			,C.[MonthName]
			,C.[Month]
			,C.[Year]
			,D.[WorkcellName]
			,(100.00 - ISNULL(B.[Red], 0)) AS [Green]
			,ISNULL(B.[Red], 0) AS [Red]
	FROM	[dbo].[HR_Employee_V] D CROSS JOIN @tmp C
			LEFT OUTER JOIN (
							SELECT	A.[EmployeeID_ID]
									  ,A.[MonthName]
									  ,A.[Month]
									  ,A.[Year]
									  ,(SUM(A.[Red])*100/[dbo].[ufn_TotalDayOfMonth](A.[Month], A.[Year])*1.00) AS [Red]
									  
							FROM		[dbo].[GC_Data_V3] A
							WHERE		A.[EscapedDate] BETWEEN @FromDate AND @ToDate
										AND A.[EmployeeID_ID] = @EmployeeID_ID
										AND A.[GrapeChartTypeID] = 1 -- Defect Maker
							GROUP BY	A.[EmployeeID_ID]
										,A.[MonthName]
										,A.[Month]
										,A.[Year]
				) B ON B.[Month] = C.[Month]
						AND B.[Year] = C.[Year]
						AND D.[EmployeeID_ID] = B.[EmployeeID_ID]
						
	WHERE D.[EmployeeID_ID] = @EmployeeID_ID
			
END


