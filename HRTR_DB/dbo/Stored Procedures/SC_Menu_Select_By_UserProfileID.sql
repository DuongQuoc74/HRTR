CREATE PROCEDURE [dbo].[SC_Menu_Select_By_UserProfileID]
(
	@UserProfileID int
)
AS
BEGIN
	SET NOCOUNT ON;
			
	WITH [MenuHierarchy]([MenuID],  [FLevel])
	AS (
		SELECT	A.[MenuID], CAST(A.[MenuID] AS VARCHAR(50))
		FROM	[dbo].[SC_Menu] A WITH (NOLOCK)
		WHERE	ISNULL(A.[ParentID], 0) = 0
				AND	ISNULL(A.[IsActive], 0) = 1
		UNION ALL
		SELECT	A.[MenuID], CAST(([FLevel] + '.' + CAST( A.[MenuID] AS VARCHAR(50))) AS VARCHAR(50))
		FROM	[dbo].[SC_Menu] A WITH (NOLOCK) INNER JOIN [MenuHierarchy] B ON B.[MenuID] = A.[ParentID]
																				AND	ISNULL(A.[IsActive], 0) = 1
	)
	
	SELECT	DISTINCT A.[MenuID]
			, A.[MenuName]
			, A.[MenuPath]
			, A.[Description]
			, A.[ParentID]
			, @UserProfileID AS [UserProfileID]
			, A.[FileName]
			, C.[FLevel]
	FROM	[dbo].[SC_Menu] A WITH (NOLOCK)
							INNER JOIN [dbo].[SC_MenuPermissionRole] D WITH (NOLOCK) ON A.[MenuID] = D.[MenuID]
							INNER JOIN [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK) ON D.[PermissionRoleID] = B.[PermissionRoleID]
																							AND ISNULL(B.[IsActive], 0) = 1
																			
							INNER JOIN (SELECT	UP.[UserProfileID]
										FROM	[dbo].[SC_UserProfile] UP WITH (NOLOCK) 
										WHERE	UP.[UserProfileID] = @UserProfileID
												AND UP.[IsActive] = 1
												AND ISNULL(UP.[IsDeleted], 0) = 0
										UNION 
										SELECT 0 AS [UserProfileID]
											) UP
										ON B.[UserProfileID] = UP.[UserProfileID]
							INNER JOIN [MenuHierarchy] C ON C.[MenuID] = A.[MenuID]
	ORDER BY C.[FLevel];
	
END;

