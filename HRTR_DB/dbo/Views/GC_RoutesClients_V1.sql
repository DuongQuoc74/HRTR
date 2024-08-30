







CREATE VIEW [dbo].[GC_RoutesClients_V1]
AS
	SELECT A.[Route_ID]
	  ,B.[Route]
      ,A.[ClientName]
      ,A.[GC_StationID]
      ,C.[StationName]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
  FROM [dbo].[GC_RoutesClients] A WITH (NOLOCK)
  INNER JOIN [dbo].[CR_Routes] B WITH (NOLOCK) ON A.[Route_ID] = B.[Route_ID]
  INNER JOIN [dbo].[GC_Station] C WITH (NOLOCK) ON C.[GC_StationID] = A.[GC_StationID]






