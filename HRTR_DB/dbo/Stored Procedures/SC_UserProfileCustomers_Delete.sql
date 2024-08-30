CREATE PROC [dbo].[SC_UserProfileCustomers_Delete] 
(
	@UserProfileID			int, 
	@Customer_ID			int,
	@LastUpdatedBy			int
)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE	[dbo].[SC_UserProfileCustomers]
	SET		[IsActive] = 0
			,[LastUpdated] = GETDATE()
			,[LastUpdatedBy] = @LastUpdatedBy
	WHERE	[UserProfileID]=@UserProfileID 
			AND [Customer_ID]=@Customer_ID
END

