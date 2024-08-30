CREATE TABLE [dbo].[CCS_TerminalH] (
    [TerminalID]          INT            NOT NULL,
    [TerminalName]        VARCHAR (150)  NULL,
    [MESFullPath]         NVARCHAR (255) NULL,
    [eGrapeChartFullPath] NVARCHAR (255) NULL,
    [LastLogonTime]       DATETIME       NULL,
    [LogonCount]          INT            CONSTRAINT [DF_CCS_TerminalH_LogonCount] DEFAULT ((0)) NULL,
    [ProductName]         NVARCHAR (50)  NULL,
    [ProductVersion]      NVARCHAR (50)  NULL,
    [eGCProductName]      NVARCHAR (50)  NULL,
    [eGCProductVersion]   NVARCHAR (50)  NULL,
    [IsVA]                BIT            NULL,
    [IsActive]            BIT            NOT NULL,
    [ServerStatusID]      INT            NULL,
    [LastUpdatedBy]       INT            NULL,
    [LastUpdated]         DATETIME       NULL
);

