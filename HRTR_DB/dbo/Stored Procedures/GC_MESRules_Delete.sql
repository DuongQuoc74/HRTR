CREATE PROC [dbo].[GC_MESRules_Delete] 
(
	@GC_MESRulesID		int,
	@LastUpdatedBy				int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE
	FROM [dbo].[GC_MESRules]
	WHERE [GC_MESRulesID]=@GC_MESRulesID
END

