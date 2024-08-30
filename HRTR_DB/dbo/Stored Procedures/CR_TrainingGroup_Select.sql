CREATE PROC [dbo].[CR_TrainingGroup_Select] @TrainingGroupID int
AS
SELECT [TrainingGroupID]
      ,[TrainingGroupName]
      ,[EDCCWorkcellID]
      ,[IsActive]
      ,[Remarks]
      --,[LastUpdated]
      --,[LastUpdatedBy]
      FROM [dbo].[CR_TrainingGroup] WITH (NOLOCK)
      WHERE [TrainingGroupID]=@TrainingGroupID


