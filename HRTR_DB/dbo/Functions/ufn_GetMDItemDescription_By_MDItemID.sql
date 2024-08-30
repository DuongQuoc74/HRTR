-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetMDItemDescription_By_MDItemID]
(
	@v_MDItemID			int
)
RETURNS  nvarchar(255)
AS
BEGIN

	DECLARE @R						nvarchar(255)
	
	SELECT	TOP 1 @R = [Description]
	FROM	[dbo].[SY_MDItem] WITH (NOLOCK)
	WHERE	[MDItemID] = @v_MDItemID
			
	RETURN @R

END
