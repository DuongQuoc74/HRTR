CREATE TABLE [dbo].[GC_Station] (
    [GC_StationID]  INT            IDENTITY (1, 1) NOT NULL,
    [StationName]   NVARCHAR (255) NULL,
    [WorkcellID]    INT            NULL,
    [Customer_ID]   INT            NULL,
    [IsActive]      BIT            NULL,
    [LastUpdated]   DATETIME       NULL,
    [LastUpdatedBy] INT            NULL,
    CONSTRAINT [PK_GC_Station] PRIMARY KEY NONCLUSTERED ([GC_StationID] ASC),
    CONSTRAINT [IX_GC_Station] UNIQUE CLUSTERED ([StationName] ASC, [WorkcellID] ASC)
);

