CREATE TABLE [dbo].[GC_Customers] (
    [Customer_ID]    INT           NOT NULL,
    [Customer]       NVARCHAR (50) NOT NULL,
    [MESCustomer_ID] INT           NOT NULL,
    [IsActive]       BIT           CONSTRAINT [DF_GC_Customers_IsActive] DEFAULT ((0)) NOT NULL,
    [LastUpdated]    DATETIME      NULL,
    [LastUpdatedBy]  INT           NULL,
    CONSTRAINT [PK_GC_Customers] PRIMARY KEY CLUSTERED ([Customer_ID] ASC)
);

