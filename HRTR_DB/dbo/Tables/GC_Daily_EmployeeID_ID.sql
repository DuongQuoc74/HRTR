CREATE TABLE [dbo].[GC_Daily_EmployeeID_ID] (
    [EmployeeID_ID]    INT            NOT NULL,
    [GrapeChartTypeID] INT            NOT NULL,
    [EscapedDate]      DATETIME       NOT NULL,
    [TotalDefect]      INT            NULL,
    [DefectText]       NVARCHAR (MAX) NULL,
    [LastUpdated]      DATETIME       NULL,
    [LastUpdatedBy]    INT            NULL,
    CONSTRAINT [PK_GC_Daily_EmployeeID_ID] PRIMARY KEY CLUSTERED ([EmployeeID_ID] ASC, [GrapeChartTypeID] ASC, [EscapedDate] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_GC_Daily_EmployeeID_ID]
    ON [dbo].[GC_Daily_EmployeeID_ID]([EscapedDate] ASC)
    ON [INDEXES];

