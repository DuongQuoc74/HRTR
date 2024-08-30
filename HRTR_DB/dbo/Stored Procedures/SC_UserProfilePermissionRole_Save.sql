CREATE PROC [dbo].[SC_UserProfilePermissionRole_Save] 
(
	@UserProfileID		int, 
	@PermissionRoleID	int,
	@LastUpdatedBy		int
)
AS
BEGIN
	IF NOT EXISTS (SELECT 1
					FROM	[dbo].[SC_UserProfilePermissionRole]  WITH (NOLOCK)
					WHERE	[UserProfileID] = @UserProfileID 
							AND [PermissionRoleID] = @PermissionRoleID)
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SC_UserProfilePermissionRole] ([UserProfileID], [PermissionRoleID], [LastUpdated], [LastUpdatedBy])
		VALUES (@UserProfileID, @PermissionRoleID, GETDATE(), @LastUpdatedBy)
	END
	ELSE
	BEGIN
		UPDATE	[dbo].[SC_UserProfilePermissionRole]
		SET		[IsActive] = 1
				,[LastUpdated] = GETDATE()
				,[LastUpdatedBy] = @LastUpdatedBy
		WHERE	[UserProfileID] = @UserProfileID 
				AND [PermissionRoleID] = @PermissionRoleID
	END
END

