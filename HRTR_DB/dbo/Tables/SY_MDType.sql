CREATE TABLE [dbo].[SY_MDType] (
    [MDTypeID]        INT          NOT NULL,
    [MDTypeName]      VARCHAR (50) NULL,
    [IsActive]        BIT          NULL,
    [DefaultMDItemID] INT          CONSTRAINT [DF_SY_MDType_DefaultMDItemID] DEFAULT ((0)) NULL,
    [LastUpdated]     DATETIME     NULL,
    [LastUpdatedBy]   INT          NULL,
    CONSTRAINT [PK_SY_MDType] PRIMARY KEY CLUSTERED ([MDTypeID] ASC)
);

