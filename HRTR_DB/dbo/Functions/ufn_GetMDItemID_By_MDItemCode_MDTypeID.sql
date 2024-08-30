-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetMDItemID_By_MDItemCode_MDTypeID]
(
	@v_MDItemCode			varchar(50),
	@v_MDTypeID				int
)
RETURNS  INT
AS
BEGIN

	DECLARE @R						int
	
	SELECT	TOP 1 @R = MDItemID
	FROM	[dbo].[SY_MDItem] WITH (NOLOCK)
	WHERE	[MDTypeID] = @v_MDTypeID
			AND [MDItemCode] = @v_MDItemCode
			
	RETURN @R

END
