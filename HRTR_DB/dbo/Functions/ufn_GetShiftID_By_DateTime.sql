-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetShiftID_By_DateTime] 
(
	@DateTime		datetime
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	IF DATEPART(HH, @DateTime) BETWEEN 6 AND 13
		SET @R = 1
	ELSE IF DATEPART(HH, @DateTime) BETWEEN 14 AND 21
		SET @R = 2
	ELSE
		SET @R = 3
			
	RETURN @R

END
