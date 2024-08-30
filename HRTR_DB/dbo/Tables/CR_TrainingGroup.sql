CREATE TABLE [dbo].[CR_TrainingGroup] (
    [TrainingGroupID]   INT            IDENTITY (1, 1) NOT NULL,
    [TrainingGroupName] VARCHAR (50)   NULL,
    [EDCCWorkcellID]    VARCHAR (5)    NULL,
    [IsActive]          BIT            NULL,
    [Remarks]           NVARCHAR (255) NULL,
    [LastUpdated]       DATETIME       NULL,
    [LastUpdatedBy]     INT            NULL,
    CONSTRAINT [PK_CR_TrainingGroup] PRIMARY KEY NONCLUSTERED ([TrainingGroupID] ASC),
    CONSTRAINT [IX_CR_TrainingGroup] UNIQUE CLUSTERED ([TrainingGroupName] ASC)
);

