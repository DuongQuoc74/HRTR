-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetUserProfileID_By_UserName]
(
	@v_UserName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	TOP 1 @R = [UserProfileID]
	FROM	[dbo].[SC_UserProfile] WITH (NOLOCK)
	WHERE	[UserName]=@v_UserName
			
	RETURN @R

END
