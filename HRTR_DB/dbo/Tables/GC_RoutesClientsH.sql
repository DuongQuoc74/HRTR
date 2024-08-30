CREATE TABLE [dbo].[GC_RoutesClientsH] (
    [Route_ID]      INT           NOT NULL,
    [ClientName]    VARCHAR (150) NOT NULL,
    [GC_StationID]  INT           NOT NULL,
    [LastUpdated]   DATETIME      NULL,
    [LastUpdatedBy] INT           NULL
);

