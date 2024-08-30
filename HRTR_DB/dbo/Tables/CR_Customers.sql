CREATE TABLE [dbo].[CR_Customers] (
    [Customer_ID]    INT           NOT NULL,
    [Customer]       NVARCHAR (50) NULL,
    [MESCustomer_ID] INT           NULL,
    [IsActive]       BIT           CONSTRAINT [DF_CR_Customers_IsActive] DEFAULT ((1)) NOT NULL,
    [LastUpdated]    DATETIME      NULL,
    [LastUpdatedBy]  INT           NULL,
    CONSTRAINT [PK_CR_Customers] PRIMARY KEY CLUSTERED ([Customer_ID] ASC)
);

