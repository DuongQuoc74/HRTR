-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_DATEDIFF]
(
	@FromDate	datetime,
	@ToDate		datetime
)
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @R VARCHAR(255)
			, @Days		int
			, @Hours	int
			, @Minutes	int
			, @Seconds	int
	SET @Days = CEILING(DATEDIFF(HH, @FromDate, @ToDate)/24)
	SET @Hours = DATEDIFF(MI, @FromDate, @ToDate)/60 - @Days*24
	SET @Minutes = DATEDIFF(MI, @FromDate, @ToDate) - @Hours*60 - @Days*24*60
	SET @Seconds = DATEDIFF(SS, @FromDate, @ToDate)%60
	SET @R = CONVERT(VARCHAR, @Days) + ' day(s) '
			+ RIGHT('00' + CONVERT(VARCHAR, @Hours), 2) + ':'
			+ RIGHT('00' + CONVERT(VARCHAR, @Minutes), 2) + ':'
			+ RIGHT('00' + CONVERT(VARCHAR, @Seconds), 2)
			
	RETURN ISNULL(@R, '')

END
