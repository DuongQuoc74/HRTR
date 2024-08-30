CREATE FUNCTION [dbo].[ufn_GetEmailList_QE]
(
	@Customer_ID			int
)
RETURNS  nvarchar(4000)
AS
BEGIN
	-- From
	DECLARE @R						nvarchar(4000)
	
	SELECT  @R = COALESCE(@R + ';', '') +	 A.[Email]
	FROM (SELECT DISTINCT A.[Email]
			FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK) 
					INNER JOIN [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK) ON A.[UserProfileID] = B.[UserProfileID]
					INNER JOIN [dbo].[SC_UserProfileCustomers] C WITH (NOLOCK) ON A.[UserProfileID] = C.[UserProfileID]
			WHERE	B.[PermissionRoleID] = 4 -- QE
					AND A.[IsActive] = 1
					AND B.[IsActive] = 1
					AND C.[IsActive] = 1
					AND A.[DepartmentID] = 12 -- QA (QE)
					AND C.[Customer_ID] = @Customer_ID
					AND [dbo].[ufn_IsValidEmail] (A.[Email]) = 1
			) A
			
	RETURN ISNULL(@R, '')

END