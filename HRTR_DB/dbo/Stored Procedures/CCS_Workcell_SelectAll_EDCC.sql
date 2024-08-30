CREATE PROC [dbo].[CCS_Workcell_SelectAll_EDCC]
AS
BEGIN
	SET NOCOUNT ON
	SELECT	'0' [WorkcellID]
			, '---Select All---' [WorkcellName]
	UNION ALL
	SELECT	[WorkcellID]
			, [WorkcellName]
	FROM	[EDCC].[dbo].[CR_Workcell] WITH (NOLOCK)
	WHERE	ISNULL([IsActive], 0) = 1
END


