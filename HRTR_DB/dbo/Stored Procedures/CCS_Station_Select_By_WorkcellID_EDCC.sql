CREATE PROC [dbo].[CCS_Station_Select_By_WorkcellID_EDCC] 
(
	@WorkcellID varchar(5)
)
AS
BEGIN
	SET NOCOUNT ON
    SELECT 0 [StationID]
			,'---Select All---' [StationName]
			,'0' [WorkcellID]
    UNION ALL
	SELECT	[StationID], [StationName], [WorkcellID] 
	FROM	[EDCC].[dbo].[Station] WITH (NOLOCK)
	WHERE	[WorkcellID] = @WorkcellID
	ORDER BY [StationID]
END


