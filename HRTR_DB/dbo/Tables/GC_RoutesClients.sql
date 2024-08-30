CREATE TABLE [dbo].[GC_RoutesClients] (
    [Route_ID]      INT           NOT NULL,
    [ClientName]    VARCHAR (150) NOT NULL,
    [GC_StationID]  INT           NOT NULL,
    [LastUpdated]   DATETIME      NULL,
    [LastUpdatedBy] INT           NULL,
    CONSTRAINT [PK_GC_RoutesClients] PRIMARY KEY CLUSTERED ([Route_ID] ASC, [ClientName] ASC, [GC_StationID] ASC)
);

