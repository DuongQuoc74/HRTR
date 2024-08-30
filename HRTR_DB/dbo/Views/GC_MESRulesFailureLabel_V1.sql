








CREATE VIEW [dbo].[GC_MESRulesFailureLabel_V1]
AS
	SELECT 	A.[GC_StationID]
		, B.[StationName] AS [DetectedStationName]
		, A.[FailureLabel]
		, D.[Comment]
		, A.[EscapedGC_StationID]
		, C.[StationName] AS [EscapedStationName]
		--,A.[LastUpdated]
		--,A.[LastUpdatedBy]
	FROM [dbo].[GC_MESRulesFailureLabel] A WITH (NOLOCK)
	INNER JOIN [dbo].[GC_Station] B WITH (NOLOCK) ON A.[GC_StationID] = B.[GC_StationID]
	INNER JOIN [dbo].[GC_Station] C WITH (NOLOCK) ON A.[EscapedGC_StationID] = c.[GC_StationID]
	INNER JOIN [dbo].[QM_FailureData_V1] D WITH (NOLOCK) ON A.[FailureLabel] = D.[DataLabel]







