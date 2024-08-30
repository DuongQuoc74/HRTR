
CREATE PROC [dbo].[SC_UserProfile_CheckPermissionRole] 
(
	@PermissionRoleID			int,
	@UserProfileID				int
)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (SELECT	1
				FROM	[dbo].[SC_UserProfilePermissionRole] A WITH (NOLOCK) 
				WHERE	A.[UserProfileID] = @UserProfileID
						AND A.[PermissionRoleID] = @PermissionRoleID 
						AND A.[IsActive] = 1
						
				)
	BEGIN
		SELECT 1
		RETURN
	END
				
	SELECT 0
	RETURN
END

