CREATE TABLE [dbo].[CR_OperatorGroup] (
    [OperatorGroupID]   INT           IDENTITY (1, 1) NOT NULL,
    [OperatorGroupName] VARCHAR (100) NULL,
    [LastUpdated]       DATETIME      NULL,
    [LastUpdatedBy]     INT           NULL,
    CONSTRAINT [PK_CR_OperatorGroup] PRIMARY KEY CLUSTERED ([OperatorGroupID] ASC)
);

