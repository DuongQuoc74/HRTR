-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[ufn_GetPositionID_By_PositionName] 
(
	@v_PositionName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	@R = PositionID
	FROM	[dbo].[CR_Position]
	WHERE	PositionName = @v_PositionName
			
	RETURN @R

END
