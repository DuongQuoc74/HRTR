CREATE TABLE [dbo].[CCS_ProcessLog] (
    [CCS_AuthenticationLogID] INT          NOT NULL,
    [ProcessName]             VARCHAR (50) NULL,
    [DomainName]              VARCHAR (50) NULL,
    [UserName]                VARCHAR (50) NULL,
    [CurrentProcessID]        INT          NULL,
    [ProcessOwner]            VARCHAR (50) NULL,
    [ProcessID]               INT          NULL,
    [LastUpdated]             DATETIME     NULL,
    [LastUpdatedBy]           INT          NULL
);

