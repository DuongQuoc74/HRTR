CREATE TABLE [dbo].[CR_TrainingStatus] (
    [TrainingStatusID]   INT           IDENTITY (1, 1) NOT NULL,
    [TrainingStatusName] NVARCHAR (50) NULL,
    [LastUpdated]        DATETIME      NULL,
    [LastUpdatedBy]      INT           NULL,
    CONSTRAINT [PK_CR_TrainingStatus] PRIMARY KEY CLUSTERED ([TrainingStatusID] ASC)
);

