CREATE PROC [dbo].[SC_UserProfile_Delete] 
(
	@UserProfileID	int,
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE	[dbo].[SC_UserProfile] 
	SET		[IsDeleted] = 1
			, [LastUpdatedBy] = @LastUpdatedBy
			, [LastUpdated] = GETDATE()
	WHERE	[UserProfileID]=@UserProfileID

	-- Remove roles
	UPDATE	[dbo].[SC_UserProfilePermissionRole]
	SET		[IsActive] = 0
			,[LastUpdated] = GETDATE()
			,[LastUpdatedBy] = @LastUpdatedBy
	WHERE	[UserProfileID]= @UserProfileID 

	-- Remove customers
		UPDATE	[dbo].[SC_UserProfileCustomers]
	SET		[IsActive] = 0
			,[LastUpdated] = GETDATE()
			,[LastUpdatedBy] = @LastUpdatedBy
	WHERE	[UserProfileID] = @UserProfileID 
			
END
