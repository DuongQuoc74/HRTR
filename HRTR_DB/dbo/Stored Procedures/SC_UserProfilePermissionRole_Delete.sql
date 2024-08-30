CREATE PROC [dbo].[SC_UserProfilePermissionRole_Delete] 
(
	@UserProfileID int, 
	@PermissionRoleID int,
	@LastUpdatedBy int
)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE	[dbo].[SC_UserProfilePermissionRole]
	SET		[IsActive] = 0
			,[LastUpdated] = GETDATE()
			,[LastUpdatedBy] = @LastUpdatedBy
	WHERE	[UserProfileID] = @UserProfileID 
			AND [PermissionRoleID] = @PermissionRoleID

END

