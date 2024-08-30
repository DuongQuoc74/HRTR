-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[ufn_GetShiftID_By_ShiftName] 
(
	@v_ShiftName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	@R = ShiftID
	FROM	[dbo].[CR_Shift]
	WHERE	[ShiftName] = @v_ShiftName
			
	RETURN @R

END
