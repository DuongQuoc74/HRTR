CREATE TABLE [dbo].[CR_Routes] (
    [Route_ID]       INT            NOT NULL,
    [Route]          NVARCHAR (200) NOT NULL,
    [Customer_ID]    INT            NULL,
    [MESCustomer_ID] INT            NULL,
    [IsBOXBUILD]     BIT            NULL,
    [IsPCBA]         BIT            NULL,
    [IsBASE]         BIT            NULL,
    [IsRMA]          BIT            NULL,
    [IsActive]       BIT            NULL,
    [LastUpdated]    DATETIME       NULL,
    [LastUpdatedBy]  INT            NULL,
    CONSTRAINT [PK_GC_Routes] PRIMARY KEY NONCLUSTERED ([Route_ID] ASC)
);

