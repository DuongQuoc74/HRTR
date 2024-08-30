CREATE TABLE [dbo].[CR_CertifiedLevel] (
    [CertifiedLevelID]   INT           NOT NULL,
    [CertifiedLevelName] NVARCHAR (50) NULL,
    [LastUpdated]        DATETIME      NULL,
    [LastUpdatedBy]      INT           NULL,
    CONSTRAINT [PK_CR_CertifiedLevel] PRIMARY KEY CLUSTERED ([CertifiedLevelID] ASC)
);

