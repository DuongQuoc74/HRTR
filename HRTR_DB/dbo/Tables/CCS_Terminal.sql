CREATE TABLE [dbo].[CCS_Terminal] (
    [TerminalID]          INT            IDENTITY (1, 1) NOT NULL,
    [TerminalName]        VARCHAR (150)  NULL,
    [MESFullPath]         NVARCHAR (255) NULL,
    [eGrapeChartFullPath] NVARCHAR (255) NULL,
    [LastLogonTime]       DATETIME       NULL,
    [LogonCount]          INT            CONSTRAINT [DF_CCS_Terminal_LogonCount] DEFAULT ((0)) NULL,
    [ProductName]         NVARCHAR (50)  NULL,
    [ProductVersion]      NVARCHAR (50)  NULL,
    [eGCProductName]      NVARCHAR (50)  NULL,
    [eGCProductVersion]   NVARCHAR (50)  NULL,
    [IsVA]                BIT            NULL,
    [IsActive]            BIT            CONSTRAINT [DF_CCS_Terminal_IsActive] DEFAULT ((1)) NOT NULL,
    [ServerStatusID]      INT            CONSTRAINT [DF_CCS_Terminal_ServerStatusID] DEFAULT ((1)) NULL,
    [LastUpdatedBy]       INT            NULL,
    [LastUpdated]         DATETIME       NULL,
    CONSTRAINT [PK_CCS_Terminal] PRIMARY KEY NONCLUSTERED ([TerminalID] ASC) ON [INDEXES],
    CONSTRAINT [IX_CCS_Terminal] UNIQUE CLUSTERED ([TerminalName] ASC)
);

