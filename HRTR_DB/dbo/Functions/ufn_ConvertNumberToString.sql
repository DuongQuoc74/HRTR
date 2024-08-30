-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_ConvertNumberToString]
(
	@Num	int
)
RETURNS  nvarchar(50)
AS
BEGIN

	DECLARE @R				nvarchar(50)
			, @END			nvarchar(1)

	SET @END = RIGHT(CONVERT(nvarchar, @Num), 1)

	SET  @R = CONVERT(NVARCHAR, @Num) + (CASE
					WHEN @Num IN (11, 12, 13) THEN 'th'
					WHEN @END = '1' THEN 'st'
					WHEN @END = '2' THEN 'nd'
					WHEN @END = '3' THEN 'rd'
					ELSE 'th'  
					END)
			
	RETURN ISNULL(@R,'')

END
