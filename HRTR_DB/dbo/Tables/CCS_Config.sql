CREATE TABLE [dbo].[CCS_Config] (
    [ConfigID]      INT            IDENTITY (1, 1) NOT NULL,
    [ConfigName]    VARCHAR (50)   NULL,
    [ConfigValue]   VARCHAR (50)   NULL,
    [Descr]         NVARCHAR (255) NULL,
    [LastUpdatedBy] INT            NULL,
    [LastUpdated]   DATETIME       NULL,
    CONSTRAINT [PK_CCS_Config] PRIMARY KEY NONCLUSTERED ([ConfigID] ASC) ON [INDEXES],
    CONSTRAINT [IX_CCS_Config] UNIQUE CLUSTERED ([ConfigName] ASC)
);

