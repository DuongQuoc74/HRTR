CREATE TABLE [dbo].[SC_Controls] (
    [ControlID]     INT            IDENTITY (1, 1) NOT NULL,
    [MenuID]        INT            NOT NULL,
    [ControlName]   NVARCHAR (100) NOT NULL,
    [LastUpdated]   DATETIME       NULL,
    [LastUpdatedBy] INT            NULL,
    CONSTRAINT [PK_SC_Controls] PRIMARY KEY CLUSTERED ([ControlID] ASC),
    CONSTRAINT [IX_SC_Controls] UNIQUE NONCLUSTERED ([MenuID] ASC, [ControlName] ASC) ON [INDEXES]
);

