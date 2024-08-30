-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetGC_StationID_By_StepIns]
(
	@Customer_ID		int,
	@StepIns			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	TOP 1 @R = [GC_StationID]
	FROM	[dbo].[GC_StepInsStation] WITH (NOLOCK)
	WHERE	[Customer_ID] = @Customer_ID
			AND [StepIns] = @StepIns
			
	RETURN ISNULL(@R, -1)

END
