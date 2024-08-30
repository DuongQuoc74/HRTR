-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GC_DayStatus]
(
	@EmployeeID_ID	int
	, @EscapedDate	datetime
	, @DayStatus	int
)
RETURNS int
AS
BEGIN
	DECLARE @R	int
	IF EXISTS (SELECT 1
			FROM [dbo].[GC_BlockLogs] WITH (NOLOCK)
			WHERE [EmployeeID_ID] = @EmployeeID_ID
					AND [IsConfirmed] = 1
					AND [ConfirmedDate] >= @EscapedDate
				)
		SET @R = 4 -- Retrained
	ELSE
		SET @R = @DayStatus
	--RETURN 4
	RETURN ISNULL(@R, 0)

END
