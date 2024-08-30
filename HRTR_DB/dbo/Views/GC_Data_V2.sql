






CREATE VIEW [dbo].[GC_Data_V2]
AS

	SELECT	[EscapedDate]
			,[EscapedByEmployeeID_ID] AS [EmployeeID_ID]
			
			
			,COUNT(DISTINCT [SerialNumber]) AS [TotalDefect]
			,1 AS [GrapeChartTypeID]
	FROM	[dbo].[GC_Data] WITH (NOLOCK) 
	GROUP BY	[EscapedDate]
				,[EscapedByEmployeeID_ID]
				
	UNION
	SELECT	[EscapedDate]
			,[DetectedByEmployeeID_ID] AS [EmployeeID_ID]
			,COUNT(DISTINCT [SerialNumber]) AS [TotalDefect]
			,2 AS [GrapeChartTypeID]
	FROM	[dbo].[GC_Data] WITH (NOLOCK) 
	GROUP BY	[EscapedDate]
				,[DetectedByEmployeeID_ID]





