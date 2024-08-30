-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_CRD]
(
	@CRD VARCHAR(255)
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @R	VARCHAR(255)
			, @I	INT
	SET @I = CHARINDEX('/', @CRD)
	IF @I > 1
		SET @R = LEFT(@CRD, @I - 1)
	ELSE
		SET @R = @CRD
	RETURN ISNULL(@R, '')

END
