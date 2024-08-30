CREATE PROC [dbo].[SC_UserProfileCustomers_Save] 
(
	@UserProfileID			int, 
	@Customer_ID			int,
	@LastUpdatedBy			int
)
AS
BEGIN
	SET NOCOUNT ON
	IF NOT EXISTS (SELECT 1
					FROM	[dbo].[SC_UserProfileCustomers]  WITH (NOLOCK)
					WHERE	[UserProfileID]=@UserProfileID 
							AND [Customer_ID]=@Customer_ID)
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SC_UserProfileCustomers] ([UserProfileID], [Customer_ID], [IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@UserProfileID, @Customer_ID, 1, GETDATE(), @LastUpdatedBy)
		
	END
	ELSE
	BEGIN
		UPDATE	[dbo].[SC_UserProfileCustomers]
		SET		[IsActive] = 1
				,[LastUpdated] = GETDATE()
				,[LastUpdatedBy] = @LastUpdatedBy
		WHERE	[UserProfileID]=@UserProfileID 
				AND [Customer_ID]=@Customer_ID
	END
END

