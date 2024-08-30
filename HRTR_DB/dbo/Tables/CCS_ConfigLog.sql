CREATE TABLE [dbo].[CCS_ConfigLog] (
    [ConfigLogID]   INT            IDENTITY (1, 1) NOT NULL,
    [ConfigName]    VARCHAR (50)   NOT NULL,
    [ConfigValue]   VARCHAR (50)   NULL,
    [Comments]      NVARCHAR (255) NULL,
    [LastUpdatedBy] INT            NULL,
    [LastUpdated]   DATETIME       NULL
);

