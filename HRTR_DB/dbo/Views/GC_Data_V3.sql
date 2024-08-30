







CREATE VIEW [dbo].[GC_Data_V3]
AS

	SELECT  [EmployeeID_ID]
	  ,[EscapedDate]
	  ,DATEPART(MM, [EscapedDate]) AS [Month]
	  ,DATENAME(MM, [EscapedDate]) AS [MonthName]
	  ,DATEPART(YYYY, [EscapedDate]) AS [Year]
	  
	  ,[TotalDefect]
	  --,0 AS [Yellow]
	  ,(CASE WHEN [TotalDefect] > 0 THEN 1
			ELSE 0 END) AS [Yellow]
	  
	  ,(CASE WHEN [TotalDefect] > 3 THEN 1
			ELSE 0 END) AS [Red]
	  ,[GrapeChartTypeID]
	FROM [dbo].[GC_Data_V2]
	








