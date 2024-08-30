CREATE PROC [dbo].[SC_UserProfilePermissionRole_InPage_V100]
(
	@UserName				varchar(50), 
	@MenuPath				varchar(150)
)
AS
BEGIN
	SET NOCOUNT ON

	IF @MenuPath = ''
	BEGIN
		SELECT 0
		RETURN
	END
	-- Everyone can access my account page
	IF @MenuPath = '~/UserManagement/AccountInfo.aspx'
		OR @MenuPath = 'AccountInfo.aspx'
	BEGIN
		SELECT 1
		RETURN
	END
	
	DECLARE @IsPermissionRole	bit,
			@UserProfileID		int,
			@IsActive			bit,
			@IsDeleted			bit,
			@FileName			varchar(50)
	SELECT TOP 1 @UserProfileID = [UserProfileID]
				, @IsActive = ISNULL([IsActive], 0)
				, @IsDeleted = ISNULL([IsDeleted], 0)
	FROM [dbo].[SC_UserProfile] WITH (NOLOCK)
	WHERE [UserName] = @UserName
	SET @UserProfileID = ISNULL(@UserProfileID, 0)
	IF @IsActive = 0 OR @IsDeleted = 1
	BEGIN
		SELECT 0
		RETURN
	END
	
	--PRINT 'AAA'
	IF NOT EXISTS (SELECT 1
					FROM	[dbo].[SC_Menu] A WITH (NOLOCK)
					WHERE	A.[FileName] = @MenuPath 
							OR A.[MenuPath] = @MenuPath
							OR @MenuPath LIKE ('%' + A.[FileName] + '%')
						)
	BEGIN
		SELECT 1
		RETURN
	END
	SET @FileName = SUBSTRING(@MenuPath, 0, CHARINDEX('.aspx?', @MenuPath) + 5)
	--PRINT @FileName
	SET @FileName = ISNULL(@FileName, @MenuPath)
		--PRINT 'BBB'
	
	SELECT	@IsPermissionRole = 1
	FROM	[dbo].[SC_Menu] A WITH (NOLOCK) 
				INNER JOIN [dbo].[SC_MenuPermissionRole] C WITH (NOLOCK) ON A.[MenuID] = C.[MenuID]
				INNER JOIN (SELECT B.[PermissionRoleID]
							FROM [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK)
							WHERE (B.[UserProfileID] = @UserProfileID OR B.[UserProfileID] = 0)
									AND B.[IsActive] = 1) UPP ON UPP.[PermissionRoleID] = C.[PermissionRoleID]
							
	WHERE	(A.[FileName] = @MenuPath OR A.[MenuPath]= @MenuPath OR A.[FileName] = @FileName)
		
	SELECT ISNULL(@IsPermissionRole, 0)

END

