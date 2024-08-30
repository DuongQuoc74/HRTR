CREATE PROC [dbo].[CCS_TrainingGroup_Select] 
(
	@TrainingGroupID	int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [TrainingGroupID]
	  ,[TrainingGroupName]
	  ,[IsActive]
	  ,[LastUpdated]
	  ,[LastUpdatedBy]
	  ,[EDCCWorkcellID]
	FROM [dbo].[CR_TrainingGroup] WITH (NOLOCK)
	WHERE [TrainingGroupID] = @TrainingGroupID
	
END


