-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_TotalDayOfMonth]
(
	@Month	int,
	@Year	int
	
)
RETURNS int
AS
BEGIN
	DECLARE @FirstDay	datetime
	SET @FirstDay = STR(@Year) + '-' + STR(@Month) + '-01'  + ' 00:00:00.000' 
	RETURN DATEPART(DAY, DATEADD(DAY, -1, DATEADD(MONTH, 1, @FirstDay)))
END
