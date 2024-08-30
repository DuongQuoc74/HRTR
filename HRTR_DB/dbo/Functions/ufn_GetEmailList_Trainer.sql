-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetEmailList_Trainer]
()
RETURNS  nvarchar(4000)
AS
BEGIN
	-- From
	DECLARE @R						nvarchar(4000)
	
	SELECT  @R = COALESCE(@R + ';', '') +	 A.[Email]
	FROM (SELECT DISTINCT A.[Email]
			FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK) 
					INNER JOIN [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK) ON A.[UserProfileID] = B.[UserProfileID]
			WHERE	B.[PermissionRoleID] = 1 -- Trainers
					AND A.[IsActive] = 1
					AND B.[IsActive] = 1
					AND [dbo].[ufn_IsValidEmail] (A.[Email]) = 1
			) A
			
	RETURN ISNULL(@R, '')
	

END
