-- more than 3 days, block
CREATE FUNCTION [dbo].[ufn_GC_BlockedDate]  
(
	@Aging				int	
	, @CreatedDate		datetime
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
	SET @R = DATEADD(DAY, @Aging, @R)
	RETURN ISNULL(@R, @CreatedDate)
END
