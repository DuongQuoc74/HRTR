CREATE TABLE [dbo].[CCS_ServerStatus] (
    [ServerStatusID] INT            NOT NULL,
    [ServerMessage]  NVARCHAR (500) NOT NULL,
    [LastUpdated]    DATETIME       NULL,
    [LastUpdatedBy]  INT            NULL,
    CONSTRAINT [PK_CCS_ServerStatus] PRIMARY KEY CLUSTERED ([ServerStatusID] ASC)
);

