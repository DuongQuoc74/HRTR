CREATE TABLE [dbo].[CCS_AuthenticationLog] (
    [CCS_AuthenticationLogID] INT              IDENTITY (1, 1) NOT NULL,
    [UserName]                VARCHAR (50)     NULL,
    [EmployeeID_ID]           INT              NULL,
    [ClientName]              VARCHAR (150)    NULL,
    [LoginTime]               DATETIME         NULL,
    [IsSupervisor]            BIT              NULL,
    [LogoffTime]              DATETIME         NULL,
    [IsCCS]                   BIT              CONSTRAINT [DF_CCS_AuthenticationLog_IsCCS] DEFAULT ((0)) NULL,
    [CourseID]                INT              NULL,
    [IsUnderstand]            BIT              NULL,
    [DocumentID]              UNIQUEIDENTIFIER NULL,
    [TerminalName]            VARCHAR (150)    NULL,
    [LastUpdated]             DATETIME         NULL,
    [LastUpdatedBy]           INT              NULL,
    [IsForcedLogoff]          BIT              NULL,
    [SupervisorUserName]      VARCHAR (50)     NULL,
    CONSTRAINT [PK_CCS_AuthenticationLog] PRIMARY KEY CLUSTERED ([CCS_AuthenticationLogID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CCS_AuthenticationLog]
    ON [dbo].[CCS_AuthenticationLog]([EmployeeID_ID] ASC, [LoginTime] ASC, [CourseID] ASC)
    INCLUDE([CCS_AuthenticationLogID], [TerminalName], [ClientName], [DocumentID])
    ON [INDEXES];

