CREATE PROCEDURE [dbo].[SC_Controls_Select_By_UserProfileID_MenuID]
(
	@UserProfileID	int,
	@MenuID			int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT C.[ControlID]
	   ,C.[ControlName]
	   ,CONVERT(BIT, MIN(CONVERT(INT, ISNULL(A.[IsDenied], 1)))) AS [IsDenied]
	   ,CONVERT(BIT, MAX(CONVERT(INT, ISNULL(A.[IsViewed], 0)))) AS [IsViewed]
	   ,CONVERT(BIT, MAX(CONVERT(INT, ISNULL(A.[IsUpdated], 0)))) AS [IsUpdated]
	FROM	[dbo].[SC_Controls] C WITH (NOLOCK)
			LEFT OUTER JOIN (SELECT B.[ControlID]
								  ,B.[IsDenied]
								  ,B.[IsViewed]
								  ,B.[IsUpdated]
						FROM	[dbo].[SC_ControlsPermissionRole] B WITH (NOLOCK) 
								INNER JOIN [dbo].[SC_UserProfilePermissionRole] A WITH (NOLOCK) ON A.[PermissionRoleID] = B.[PermissionRoleID]
						WHERE	A.[UserProfileID] = @UserProfileID
								AND A.[IsActive] = 1) A ON C.[ControlID] = A.[ControlID]
	WHERE C.[MenuID] = @MenuID
	GROUP BY C.[ControlID]
			, C.[ControlName]
END;

