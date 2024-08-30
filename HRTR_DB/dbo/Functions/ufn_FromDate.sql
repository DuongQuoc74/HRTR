-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_FromDate]
(
	@Month	int,
	@Year	int
)
RETURNS  datetime
AS
BEGIN

	DECLARE @R						datetime
	
	SET @R = STR(@Year) + '-' + STR(@Month) + '-01 00:00:00.000' 
			
	RETURN @R

END
