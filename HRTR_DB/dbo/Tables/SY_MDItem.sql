CREATE TABLE [dbo].[SY_MDItem] (
    [MDItemID]      INT            IDENTITY (1, 1) NOT NULL,
    [MDTypeID]      INT            NULL,
    [MDItemCode]    VARCHAR (50)   NULL,
    [Description]   NVARCHAR (255) NULL,
    [IsActive]      BIT            CONSTRAINT [DF_MDItem_IsActive] DEFAULT ((0)) NOT NULL,
    [LastUpdated]   DATETIME       NULL,
    [LastUpdatedBy] INT            NULL,
    CONSTRAINT [PK_SY_MDItem] PRIMARY KEY NONCLUSTERED ([MDItemID] ASC) ON [INDEXES],
    CONSTRAINT [IX_SY_MDItem] UNIQUE CLUSTERED ([MDTypeID] ASC, [MDItemCode] ASC)
);

