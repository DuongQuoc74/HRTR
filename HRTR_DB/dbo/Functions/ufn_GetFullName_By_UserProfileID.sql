-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetFullName_By_UserProfileID]
(
	@v_UserProfileID			int
)
RETURNS  nvarchar(255)
AS
BEGIN

	DECLARE @R						nvarchar(255)
	
	SELECT	TOP 1 @R = [FullName]
	FROM	[dbo].[SC_UserProfile] WITH (NOLOCK)
	WHERE	[UserProfileID]=@v_UserProfileID
			
	RETURN @R

END
