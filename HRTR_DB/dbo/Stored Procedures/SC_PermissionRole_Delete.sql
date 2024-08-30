CREATE PROC [dbo].[SC_PermissionRole_Delete] 
(
	@PermissionRoleID	int,
	@LastUpdatedBy		int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE 
	FROM	[dbo].[SC_PermissionRole] 
	WHERE	[PermissionRoleID]=@PermissionRoleID
END

