-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GC_Month_By_DateTime]
(
	@DateTime		DATETIME
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @R	VARCHAR(50)
	SET @R = DATENAME(MM, @DateTime) + ' - ' + DATENAME(YEAR, @DateTime)
	RETURN ISNULL(@R, '')

END
