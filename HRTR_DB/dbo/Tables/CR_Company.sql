CREATE TABLE [dbo].[CR_Company] (
    [CompanyID]     INT          IDENTITY (1, 1) NOT NULL,
    [CompanyName]   VARCHAR (50) NULL,
    [LastUpdated]   DATETIME     NULL,
    [LastUpdatedBy] INT          NULL,
    [CompanyCode]   VARCHAR (50) NULL,
    CONSTRAINT [PK_CR_Company] PRIMARY KEY CLUSTERED ([CompanyID] ASC)
);

