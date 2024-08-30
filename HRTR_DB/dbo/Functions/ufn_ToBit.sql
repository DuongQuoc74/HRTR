
CREATE FUNCTION [dbo].[ufn_ToBit]  
(
	@v_Input	varchar(20)
)
RETURNS bit
AS
BEGIN
	DECLARE @R bit
	SET @v_Input = LTRIM(RTRIM(UPPER(@v_Input)))
	IF @v_Input IN ('TRUE', 'YES', '1', 'Y', 'T', 'Active')
		SET @R = 1
	ELSE IF @v_Input IN ('FALSE', 'NO', '0', 'N', 'F', 'Non-Active')
		SET @R = 0
	
	RETURN(@R)
END

