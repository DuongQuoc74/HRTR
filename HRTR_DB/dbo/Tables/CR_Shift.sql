CREATE TABLE [dbo].[CR_Shift] (
    [ShiftID]       INT           IDENTITY (1, 1) NOT NULL,
    [ShiftCode]     VARCHAR (5)   NULL,
    [ShiftName]     VARCHAR (100) NULL,
    [LastUpdated]   DATETIME      NULL,
    [LastUpdatedBy] INT           NULL,
    CONSTRAINT [PK_CR_Shift] PRIMARY KEY CLUSTERED ([ShiftID] ASC)
);

