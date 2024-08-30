CREATE PROC [dbo].[SC_PermissionRole_Save] 
(
	@PermissionRoleID	int, 
	@PermissionRoleName		varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (SELECT	1
				FROM	[dbo].[SC_PermissionRole] WITH (NOLOCK)
				WHERE	[PermissionRoleID]=@PermissionRoleID)
	BEGIN
		--update existing record
		UPDATE	[dbo].[SC_PermissionRole] 
		SET		[PermissionRoleName]=@PermissionRoleName
		WHERE	[PermissionRoleID]=@PermissionRoleID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SC_PermissionRole] ([PermissionRoleID], [PermissionRoleName])
		VALUES (@PermissionRoleID, @PermissionRoleName)
		
	END
	EXEC [dbo].[SC_PermissionRole_Select] @PermissionRoleID
	
END

