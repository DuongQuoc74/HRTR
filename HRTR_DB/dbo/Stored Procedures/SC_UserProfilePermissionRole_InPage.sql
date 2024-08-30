-- 2019-01-09: update LastLoggedOn to SC_UserProfile
CREATE PROC [dbo].[SC_UserProfilePermissionRole_InPage]
(
	@UserName				varchar(50), -- NT ID
	@MenuPath				varchar(150) -- ex: TicketDetails.aspx?tt=1&id=43
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @IsPermissionRole	bit = 0,
			@UserProfileID		int = 0,
			@IsActive			bit = 0,
			@IsDeleted			bit = 0,
			@FileName			varchar(50),
			@MenuID				int = 0
	IF @MenuPath = ''
	BEGIN
		SET @IsPermissionRole = 0
		SELECT @IsPermissionRole
		RETURN
	END
	-- Everyone can access my account page
	IF @MenuPath = '~/UserManagement/AccountInfo.aspx'
		OR @MenuPath = 'AccountInfo.aspx'
	BEGIN
		SET @IsPermissionRole = 1
		SELECT @IsPermissionRole
		RETURN
	END
	SELECT TOP 1 @UserProfileID = ISNULL([UserProfileID], 0)
				, @IsActive = ISNULL([IsActive], 0)
				, @IsDeleted = ISNULL([IsDeleted], 0)
	FROM [dbo].[SC_UserProfile] WITH (NOLOCK)
	WHERE [UserName] = @UserName
	IF @IsActive = 0 OR @IsDeleted = 1
	BEGIN
		SET @UserProfileID = 0 -- no UserProfileID, for role All_Employees
	END
	IF CHARINDEX('.aspx?', @MenuPath) > 0
	BEGIN
		SET @FileName = SUBSTRING(@MenuPath, 0, CHARINDEX('.aspx?', @MenuPath) + 5)
	END
	SET @FileName = ISNULL(@FileName, @MenuPath)
	--PRINT @FileName
	-- Find @MenuID
	-- 100% with parameters if any
	SELECT TOP 1 @MenuID = A.[MenuID]
	FROM	[dbo].[SC_Menu] A WITH (NOLOCK)
	WHERE	(A.[FileName] = @MenuPath 
			OR A.[MenuPath] = @MenuPath) AND A.[IsActive] = 1
	-- 100% without parameters
	IF @MenuID = 0 AND @FileName != @MenuPath
	BEGIN
		SELECT TOP 1 @MenuID = A.[MenuID]
		FROM	[dbo].[SC_Menu] A WITH (NOLOCK)
		WHERE	A.[FileName] = @FileName 
				OR A.[MenuPath] = @FileName
	END
	IF @MenuID = 0
	BEGIN
		-- ex: FileName = TicketDetails.aspx?tt=1, input: TicketDetails.aspx?tt=1&id=43 => Ok
		SELECT TOP 1 @MenuID = A.[MenuID]
		FROM	[dbo].[SC_Menu] A WITH (NOLOCK)
		WHERE	CHARINDEX(A.[FileName] + '&', @MenuPath + '&') = 1
				OR CHARINDEX(A.[MenuPath] + '&', @MenuPath + '&') = 1
				OR CHARINDEX(A.[FileName] + '&', @FileName + '&') = 1
	END
	--PRINT 'BBB'
	SELECT	@IsPermissionRole = 1
	FROM	[dbo].[SC_Menu] A WITH (NOLOCK) 
				INNER JOIN [dbo].[SC_MenuPermissionRole] C WITH (NOLOCK) ON A.[MenuID] = C.[MenuID]
				INNER JOIN (SELECT B.[PermissionRoleID]
							FROM [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK)
							WHERE (B.[UserProfileID] = @UserProfileID OR B.[UserProfileID] = 0)
									AND B.[IsActive] = 1
							) UPP ON UPP.[PermissionRoleID] = C.[PermissionRoleID]
							
	WHERE	A.[MenuID] = @MenuID
	-- 2019-01-09: update LastLoggedOn to SC_UserProfile
	DECLARE @AuthenticationName		nvarchar(50) = @UserName
			, @PageName				nvarchar(255) = @MenuPath
			, @LastUpdatedBy		int = -1
	-- TODO: Set parameter values here.
	EXECUTE [dbo].[SC_Logon_Save_InPage] 
		  @AuthenticationName
		  ,@UserProfileID
		  ,@PageName
		  ,@LastUpdatedBy

	SELECT @IsPermissionRole

END
