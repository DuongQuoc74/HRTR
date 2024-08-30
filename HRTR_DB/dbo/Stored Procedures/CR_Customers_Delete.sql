CREATE PROC [dbo].[CR_Customers_Delete] 
(
	@Customer_ID		int, 
	@LastUpdatedBy		int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[CR_Customers] 
	SET		[IsActive]=0,
			[LastUpdated]=GETDATE(),
			[LastUpdatedBy]=@LastUpdatedBy
	WHERE [Customer_ID]=@Customer_ID
END


