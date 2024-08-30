-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_MESSQLNodeA]()
RETURNS nvarchar(50)
AS
BEGIN
	DECLARE @R	nvarchar(50) = ''
	SELECT TOP 1 @R = [ConfigurationValue]
	FROM [dbo].[SY_Configuration] WITH (NOLOCK)
	WHERE [ConfigurationName] = 'MESSQLNodeA'
	SET @R = ISNULL(@R, '')
	RETURN @R
END
