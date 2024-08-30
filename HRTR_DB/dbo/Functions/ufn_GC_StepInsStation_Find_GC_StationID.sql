
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GC_StepInsStation_Find_GC_StationID]
(
	@Customer_ID			int
	, @StepIns				nvarchar(50)
	, @MESCustomer_ID		int
)
RETURNS int
AS
BEGIN

	DECLARE @R	int
	
	SELECT	TOP 1 @R = [GC_StationID]
	FROM	[dbo].[GC_StepInsStation] WITH (NOLOCK)
	WHERE	[Customer_ID] = @Customer_ID
			AND [StepIns] = @StepIns
			AND [MESCustomer_ID] = @MESCustomer_ID
			
	RETURN ISNULL(@R, 0)

END

