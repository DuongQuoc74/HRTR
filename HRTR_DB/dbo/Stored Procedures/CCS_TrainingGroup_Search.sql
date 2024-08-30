CREATE PROC [dbo].[CCS_TrainingGroup_Search]
AS
BEGIN
	SET NOCOUNT ON
	SELECT [TrainingGroupID]
		  ,[TrainingGroupName]
		  ,[EDCCWorkcellID]
	FROM [dbo].[CR_TrainingGroup] WITH (NOLOCK)
	WHERE [IsActive] = 1
END


