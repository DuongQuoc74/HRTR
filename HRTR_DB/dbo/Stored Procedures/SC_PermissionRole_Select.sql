CREATE PROC [dbo].[SC_PermissionRole_Select] 
(
	@PermissionRoleID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	[PermissionRoleID]
			,[PermissionRoleName]
	FROM	[dbo].[SC_PermissionRole] WITH (NOLOCK)
	WHERE	[PermissionRoleID]=@PermissionRoleID
END

