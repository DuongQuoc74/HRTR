CREATE PROC [dbo].[SC_PermissionRole_Search]
AS
BEGIN
	SET NOCOUNT ON
	SELECT	[PermissionRoleID]
			,[PermissionRoleName]
	FROM	[dbo].[SC_PermissionRole] WITH (NOLOCK)
	WHERE	ISNULL([IsActive], 0) = 1
END

