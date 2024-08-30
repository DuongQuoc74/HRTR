CREATE FUNCTION [dbo].[ufn_FormatDateVN]  
(
	@ReviewDate		datetime
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @R NVARCHAR(50)
	SET @R = N'Ngày ' + CONVERT(NVARCHAR(2), DATEPART(DAY, @ReviewDate))
			+ N' tháng ' + CONVERT(NVARCHAR(2), DATEPART(MONTH, @ReviewDate))
			+ N' năm ' + CONVERT(NVARCHAR(4), DATEPART(YEAR, @ReviewDate))
	RETURN ISNULL(@R, '')
END
