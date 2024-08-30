-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetMDItemCode_By_MDItemID]
(
	@v_MDItemID			int
)
RETURNS  varchar(50)
AS
BEGIN

	DECLARE @R						varchar(50)
	
	SELECT	TOP 1 @R = [MDItemCode]
	FROM	[dbo].[SY_MDItem] WITH (NOLOCK)
	WHERE	[MDItemID]=@v_MDItemID
			
	RETURN @R

END
