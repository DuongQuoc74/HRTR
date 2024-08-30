CREATE TABLE [dbo].[GC_BlockLogs] (
    [GC_BlockLogsID] INT            IDENTITY (-2000000001, 1) NOT NULL,
    [EmployeeID_ID]  INT            NOT NULL,
    [StartDate]      DATETIME       NOT NULL,
    [Customer_ID]    INT            NOT NULL,
    [EndDate]        DATETIME       NOT NULL,
    [TotalRedGrapes] INT            NOT NULL,
    [IsBlocked]      BIT            NULL,
    [BlockedDate]    DATETIME       NULL,
    [IsConfirmed]    BIT            NULL,
    [ConfirmedBy]    INT            NULL,
    [ConfirmedDate]  DATETIME       NULL,
    [CreatedDate]    DATETIME       NOT NULL,
    [Comments]       NVARCHAR (255) NULL,
    [LastUpdated]    DATETIME       NULL,
    [LastUpdatedBy]  INT            NULL,
    CONSTRAINT [PK_GC_BlockLogs] PRIMARY KEY NONCLUSTERED ([GC_BlockLogsID] ASC) ON [INDEXES],
    CONSTRAINT [IX_GC_BlockLogs] UNIQUE CLUSTERED ([EmployeeID_ID] ASC, [StartDate] ASC, [Customer_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_GC_BlockLogs_1]
    ON [dbo].[GC_BlockLogs]([CreatedDate] ASC, [Customer_ID] ASC)
    ON [INDEXES];

