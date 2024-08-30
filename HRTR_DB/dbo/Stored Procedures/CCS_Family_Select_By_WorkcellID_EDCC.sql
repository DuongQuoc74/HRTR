CREATE PROC [dbo].[CCS_Family_Select_By_WorkcellID_EDCC] 
(
	@WorkcellID		varchar(5)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 0 [FamilyID], '---Select All---' [FamilyName], '0' [WorkcellID]
	UNION ALL
	SELECT	[FamilyID], [FamilyName], [WorkcellID] 
	FROM	[EDCC].[dbo].[Family]  WITH (NOLOCK)
	WHERE	[WorkcellID] = @WorkcellID
	ORDER BY [FamilyID]
END


