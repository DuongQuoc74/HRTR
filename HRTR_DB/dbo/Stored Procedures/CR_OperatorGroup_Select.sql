CREATE PROC [dbo].[CR_OperatorGroup_Select] @OperatorGroupID int
AS
SELECT	[OperatorGroupID]
			,[OperatorGroupName] 
	FROM	[dbo].[CR_OperatorGroup] 
	WHERE	[OperatorGroupID]=@OperatorGroupID


