CREATE PROC [dbo].[TR_BlockLogs_Confirm] 
(
	@TR_BlockLogsID				int,
	@Comments					nvarchar(255),
	@LastUpdatedBy				int
	
)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE [dbo].[TR_BlockLogs]
	SET [IsConfirmed] = 1
      ,[ConfirmedBy] = @LastUpdatedBy
      ,[ConfirmedDate] = GETDATE()
      ,[Comments] = @Comments
	WHERE [TR_BlockLogsID] = @TR_BlockLogsID
	EXEC [dbo].[TR_BlockLogs_Select] @TR_BlockLogsID	 					
END


