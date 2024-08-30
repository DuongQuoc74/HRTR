CREATE TABLE [dbo].[GC_ProcessStatus] (
    [GC_ProcessStatusID] INT           NOT NULL,
    [ProcessStatusName]  NVARCHAR (50) NOT NULL,
    [LastUpdated]        DATETIME      NOT NULL,
    [LastUpdatedBy]      INT           NOT NULL,
    CONSTRAINT [PK_GC_ProcessStatus] PRIMARY KEY CLUSTERED ([GC_ProcessStatusID] ASC)
);

