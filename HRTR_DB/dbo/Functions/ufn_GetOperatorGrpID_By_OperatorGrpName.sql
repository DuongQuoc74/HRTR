-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[ufn_GetOperatorGrpID_By_OperatorGrpName] 
(
	@v_OperatorName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	@R = [OperatorGroupID]
	FROM	[dbo].[CR_OperatorGroup]
	WHERE	[OperatorGroupName]=@v_OperatorName
			
	RETURN @R

END
