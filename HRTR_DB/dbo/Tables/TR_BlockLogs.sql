CREATE TABLE [dbo].[TR_BlockLogs] (
    [TR_BlockLogsID]   INT            IDENTITY (-2000000000, 1) NOT NULL,
    [EmployeeID_ID]    INT            NOT NULL,
    [TrainingRecordID] INT            NOT NULL,
    [LastLogonDate]    DATETIME       NOT NULL,
    [IsConfirmed]      BIT            NULL,
    [ConfirmedBy]      INT            NULL,
    [ConfirmedDate]    DATETIME       NULL,
    [CreatedDate]      DATETIME       NULL,
    [Comments]         NVARCHAR (255) NULL,
    [LastUpdated]      DATETIME       NULL,
    [LastUpdatedBy]    INT            NULL,
    CONSTRAINT [PK_TR_BlockLogs] PRIMARY KEY NONCLUSTERED ([TR_BlockLogsID] ASC) ON [INDEXES],
    CONSTRAINT [IX_TR_BlockLogs] UNIQUE CLUSTERED ([EmployeeID_ID] ASC, [TrainingRecordID] ASC, [LastLogonDate] ASC)
);

