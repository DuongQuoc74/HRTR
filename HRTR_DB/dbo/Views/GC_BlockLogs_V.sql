
























CREATE VIEW [dbo].[GC_BlockLogs_V]
AS
	SELECT [GC_BlockLogsID]
	  ,[EmployeeID_ID]
	  ,[StartDate]
	  ,[Customer_ID]
	  ,[EndDate]
	  ,[TotalRedGrapes]
	  ,[IsBlocked]
	  ,[BlockedDate]
	  --,[dbo].[ufn_GC_BlockedDate] (3, [CreatedDate]) AS [EstimatedBlockedDate]
	  ,[IsConfirmed]
	  ,[ConfirmedBy]
	  ,[ConfirmedDate]
	  ,[Comments]
	  ,[CreatedDate]
	  --,[dbo].[ufn_DATEDIFF]([CreatedDate], GETDATE()) AS [Aging]
	  ,DATEDIFF(DAY, [CreatedDate], ISNULL([ConfirmedDate], GETDATE())) AS [Aging]
	  ,[LastUpdated]
	  ,[LastUpdatedBy]
	FROM [dbo].[GC_BlockLogs] WITH (NOLOCK)









