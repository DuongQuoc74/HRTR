CREATE PROC [dbo].[GC_BlockLogs_Select] 
(
	@GC_BlockLogsID				int
	
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [GC_BlockLogsID]
      ,[EmployeeID_ID]
      ,[StartDate]
      ,[Customer_ID]
      ,[EndDate]
      ,[TotalRedGrapes]
      ,[IsBlocked]
      ,[IsConfirmed]
      ,[ConfirmedBy]
      ,[ConfirmedDate]
      ,[CreatedDate]
      ,[Comments]
      ,[LastUpdated]
      ,[LastUpdatedBy]
	FROM [dbo].[GC_BlockLogs] WITH (NOLOCK)
	WHERE [GC_BlockLogsID] = @GC_BlockLogsID
	 					
END

