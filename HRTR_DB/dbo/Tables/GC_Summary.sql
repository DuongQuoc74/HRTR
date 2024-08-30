CREATE TABLE [dbo].[GC_Summary] (
    [EmployeeID_ID]    INT            NOT NULL,
    [GrapeChartTypeID] INT            NOT NULL,
    [CG_Month]         INT            NOT NULL,
    [CG_Year]          INT            NOT NULL,
    [TotalDefect]      INT            NULL,
    [DefectText]       NVARCHAR (MAX) NULL,
    [LastUpdated]      DATETIME       NULL,
    [LastUpdatedBy]    INT            NULL,
    CONSTRAINT [PK_GC_Summary] PRIMARY KEY CLUSTERED ([EmployeeID_ID] ASC, [GrapeChartTypeID] ASC, [CG_Month] ASC, [CG_Year] ASC)
);

