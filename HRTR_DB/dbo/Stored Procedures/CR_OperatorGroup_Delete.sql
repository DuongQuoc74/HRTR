CREATE PROC [dbo].[CR_OperatorGroup_Delete] @OperatorGroupID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[CR_OperatorGroup] WHERE [OperatorGroupID]=@OperatorGroupID


