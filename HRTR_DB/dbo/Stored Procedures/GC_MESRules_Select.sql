CREATE PROC [dbo].[GC_MESRules_Select] 
(
	@GC_MESRulesID		int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	[GC_MESRulesID]
			  ,[MESCustomer_ID]
			  ,[DetectedStepIns]
			  ,[Defect_ID]
			  
			  ,[CRD]
			  ,[EscapedStepIns]
			  ,[IsActive]
			  ,[LastUpdated]
			  ,[LastUpdatedBy]
	FROM [dbo].[GC_MESRules] WITH (NOLOCK)
	WHERE [GC_MESRulesID]=@GC_MESRulesID
END

