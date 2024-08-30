CREATE TABLE [dbo].[CR_Position] (
    [PositionID]    INT          IDENTITY (1, 1) NOT NULL,
    [PositionName]  VARCHAR (50) NULL,
    [LastUpdated]   DATETIME     NULL,
    [LastUpdatedBy] INT          NULL,
    CONSTRAINT [PK_CR_Position] PRIMARY KEY CLUSTERED ([PositionID] ASC)
);

