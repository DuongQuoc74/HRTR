CREATE TABLE [dbo].[AL_ScanLog] (
    [LogID]          INT            IDENTITY (1, 1) NOT NULL,
    [UserName]       VARCHAR (50)   NULL,
    [TrainingCodeID] NVARCHAR (100) NULL,
    [PcName]         VARCHAR (50)   NULL,
    [SessionID]      INT            NULL,
    [RemindLevel]    INT            NULL,
    [RemainDay]      INT            NULL,
    [Message]        NVARCHAR (MAX) NULL,
    [LastUpdated]    DATETIME       NULL,
    [LastUpdatedBy]  INT            NULL,
    [MachineName]    NVARCHAR (50)  NULL,
    CONSTRAINT [PK_AL_ScanLog] PRIMARY KEY CLUSTERED ([LogID] ASC)
);

