CREATE PROC [dbo].[SC_UserProfilePermissionRole_Select_By_UserProfileID] 
(
	@UserProfileID int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [UserProfileID]
		  ,[PermissionRoleID] 
	FROM	 [dbo].[SC_UserProfilePermissionRole]  WITH (NOLOCK)
	WHERE	[UserProfileID] = @UserProfileID
			AND [IsActive] = 1
			
END

