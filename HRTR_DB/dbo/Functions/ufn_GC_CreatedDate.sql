-- neu truoc 07:00 là thuoc ngay hom truoc
CREATE FUNCTION [dbo].[ufn_GC_CreatedDate]  
(
	@CreatedDate		datetime
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @R DATETIME
	DECLARE		@BlockedTime							nvarchar(8)
	
	SELECT TOP 1 @BlockedTime = [ConfigurationValue]
	FROM [dbo].[SY_Configuration] WITH (NOLOCK)
	WHERE [ConfigurationName] = 'eGrapeChartGC_BlockTime'
	
	SET @R = CONVERT(DATETIME, CONVERT(VARCHAR(10), @CreatedDate , 120) + ' ' + @BlockedTime, 120)
	IF @CreatedDate < @R
	BEGIN
		SET @R = DATEADD(DAY, -1, @R)
	END
	
	RETURN ISNULL(@R, @CreatedDate)
END
