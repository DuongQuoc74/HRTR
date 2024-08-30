-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[ufn_GetWorkcellID_By_WorkcellName] 
(
	@v_WorkcellName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	@R = WorkcellID
	FROM	[dbo].[CR_Workcell]
	WHERE	WorkcellName = @v_WorkcellName
			
	RETURN @R

END
