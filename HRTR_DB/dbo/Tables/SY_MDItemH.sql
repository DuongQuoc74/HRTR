CREATE TABLE [dbo].[SY_MDItemH] (
    [MDItemID]      INT           NOT NULL,
    [MDTypeID]      INT           NULL,
    [MDItemCode]    VARCHAR (50)  NULL,
    [Description]   VARCHAR (255) NULL,
    [IsActive]      BIT           CONSTRAINT [DF_MDItem_IsActiveH] DEFAULT ((0)) NULL,
    [LastUpdated]   DATETIME      NULL,
    [LastUpdatedBy] INT           NULL,
    CONSTRAINT [PK_SY_MDItemH] PRIMARY KEY CLUSTERED ([MDItemID] ASC)
);

