CREATE PROC [dbo].[GC_BlockLogs_Confirm] 
(
	@GC_BlockLogsID				int,
	@Comments					nvarchar(255),
	@LastUpdatedBy				int
	
)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE [dbo].[GC_BlockLogs]
	SET [IsConfirmed] = 1
      ,[ConfirmedBy] = @LastUpdatedBy
      ,[ConfirmedDate] = GETDATE()
      ,[Comments] = @Comments
	WHERE [GC_BlockLogsID] = @GC_BlockLogsID
	EXEC [dbo].[GC_BlockLogs_Select] @GC_BlockLogsID	 					
END

