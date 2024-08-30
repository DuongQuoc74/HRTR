

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GC_CRDStepIns_Find_CRDStepIns]
(
	@Customer_ID				int
	, @StepIns				nvarchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN

	DECLARE @R	nvarchar(50)
	
	SELECT	TOP 1 @R = [CRDStepIns]
	FROM	[dbo].[GC_CRDStepIns] WITH (NOLOCK)
	WHERE	[Customer_ID] = @Customer_ID
			AND [StepIns] = @StepIns
			
	RETURN ISNULL(@R, '')

END


