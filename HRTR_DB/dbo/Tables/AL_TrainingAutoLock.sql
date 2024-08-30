CREATE TABLE [dbo].[AL_TrainingAutoLock] (
    [LockID]         INT            IDENTITY (1, 1) NOT NULL,
    [EmployeeID]     VARCHAR (20)   NULL,
    [EmployeeIDSAP]  VARCHAR (20)   NULL,
    [UserName]       VARCHAR (50)   NULL,
    [EmployeeName]   NVARCHAR (100) NULL,
    [IsDL]           INT            NULL,
    [TrainingCodeID] NVARCHAR (100) NULL,
    [Description]    NVARCHAR (250) NULL,
    [DueDate]        DATETIME       NULL,
    [ExtendDay]      INT            NULL,
    [ExtendFromDate] DATETIME       NULL,
    [CompleteDate]   DATETIME       NULL,
    [IsActive]       BIT            NULL,
    [LastUpdated]    DATETIME       NULL,
    [LastUpdatedBy]  INT            NULL,
    [WDNo]           NVARCHAR (20)  NULL,
    CONSTRAINT [PK_AL_TrainingAutoLock] PRIMARY KEY CLUSTERED ([LockID] ASC)
);

