CREATE TABLE [dbo].[CCS_ConfigH] (
    [ConfigID]      INT            NOT NULL,
    [Name]          VARCHAR (50)   NOT NULL,
    [ConfigName]    VARCHAR (50)   NULL,
    [Value]         VARCHAR (50)   NOT NULL,
    [ConfigValue]   VARCHAR (50)   NULL,
    [WorkcellID]    INT            NULL,
    [Descr]         NVARCHAR (255) NULL,
    [LastUpdatedBy] INT            NULL,
    [LastUpdated]   DATETIME       NULL
);

