CREATE TABLE [dbo].[SY_Configuration] (
    [ConfigurationID]    INT            IDENTITY (1, 1) NOT NULL,
    [ConfigurationName]  NVARCHAR (255) NOT NULL,
    [ConfigurationValue] NVARCHAR (255) NULL,
    [ConfigurationDescr] NVARCHAR (255) NULL,
    [LastUpdated]        DATETIME       NULL,
    [LastUpdatedBy]      INT            NULL,
    CONSTRAINT [PK_SY_Configuration] PRIMARY KEY NONCLUSTERED ([ConfigurationID] ASC) ON [INDEXES],
    CONSTRAINT [IX_SY_Configuration] UNIQUE CLUSTERED ([ConfigurationName] ASC)
);

