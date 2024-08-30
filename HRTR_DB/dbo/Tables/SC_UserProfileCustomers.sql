CREATE TABLE [dbo].[SC_UserProfileCustomers] (
    [UserProfileID] INT      NOT NULL,
    [Customer_ID]   INT      NOT NULL,
    [IsActive]      BIT      CONSTRAINT [DF_UserProfileCR_Customers_IsActive] DEFAULT ((1)) NOT NULL,
    [LastUpdated]   DATETIME NULL,
    [LastUpdatedBy] INT      NULL,
    CONSTRAINT [PK_SC_UserProfileCustomer] PRIMARY KEY CLUSTERED ([UserProfileID] ASC, [Customer_ID] ASC)
);

