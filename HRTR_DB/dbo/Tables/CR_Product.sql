CREATE TABLE [dbo].[CR_Product] (
    [ProductID]       INT           IDENTITY (1, 1) NOT NULL,
    [ProductName]     VARCHAR (100) NULL,
    [TrainingGroupID] INT           NULL,
    [LastUpdated]     DATETIME      NULL,
    [LastUpdatedBy]   INT           NULL,
    CONSTRAINT [PK_CR_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [IX_CR_Product] UNIQUE NONCLUSTERED ([ProductName] ASC, [TrainingGroupID] ASC)
);

