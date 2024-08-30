-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Name:	find BankID by Name, if not, continue to find with BankCode
-- 
-- =============================================
CREATE FUNCTION [dbo].[ufn_IsValidEmail]
(
	@Email			nvarchar(100)
)
RETURNS  bit
AS
BEGIN

	DECLARE @R						bit
	IF (@Email <> '' AND @Email NOT LIKE '_%@__%.__%') OR @Email IS NULL OR @Email = ''
		SET @R = 0  -- Invalid
	ELSE 
		SET @R = 1   -- Valid
	
	RETURN ISNULL(@R, 0)

END
