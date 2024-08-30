CREATE PROC [dbo].[SC_UserProfilePermissionRole_Select] 
(
	@UserProfileID int, 
	@PermissionRoleID int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [UserProfileID]
		  ,[PermissionRoleID] 
	FROM	 [dbo].[SC_UserProfilePermissionRole]  WITH (NOLOCK)
	WHERE	[UserProfileID] = @UserProfileID 
			AND [PermissionRoleID] = @PermissionRoleID
END

