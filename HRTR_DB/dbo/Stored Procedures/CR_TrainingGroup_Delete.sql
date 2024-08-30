CREATE PROC [dbo].[CR_TrainingGroup_Delete] @TrainingGroupID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[CR_TrainingGroup] WHERE [TrainingGroupID]=@TrainingGroupID


