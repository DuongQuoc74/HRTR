-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GC_Week_By_DateTime]
(
	@DateTime		DATETIME
)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @R	VARCHAR(50)
	-- Temp
	SET @DateTime = DATEADD(DAY, -1, @DateTime)
	
	SET @R = DATENAME(WEEK, @DateTime) + ' - ' + DATENAME(YEAR, @DateTime)
	RETURN ISNULL(@R, '')

END
