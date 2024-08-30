







CREATE VIEW [dbo].[GC_Data_V4]
AS

	SELECT	A.[Customer_ID]
			,A.[EscapedDate]
			,A.[EscapedByEmployeeID_ID] AS [EmployeeID_ID]
			
			,COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
			,1 AS [GrapeChartTypeID]
	FROM	[dbo].[GC_Data] A WITH (NOLOCK) 
	GROUP BY	A.[Customer_ID]
				,A.[EscapedDate]
				,A.[EscapedByEmployeeID_ID]
				
	UNION
	SELECT	A.[Customer_ID]
			,A.[EscapedDate]
			,A.[DetectedByEmployeeID_ID] AS [EmployeeID_ID]
			,COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
			,2 AS [GrapeChartTypeID]
	FROM	[dbo].[GC_Data] A WITH (NOLOCK) 
	GROUP BY	A.[Customer_ID]
				,A.[EscapedDate]
				,A.[DetectedByEmployeeID_ID]




