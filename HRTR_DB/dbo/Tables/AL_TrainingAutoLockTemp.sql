CREATE TABLE [dbo].[AL_TrainingAutoLockTemp] (
    [ID]             INT             IDENTITY (1, 1) NOT NULL,
    [EmployeeID]     VARCHAR (20)    NULL,
    [EmployeeIDSAP]  VARCHAR (20)    NULL,
    [UserName]       VARCHAR (50)    NULL,
    [EmployeeName]   NVARCHAR (100)  NULL,
    [IsDL]           INT             NULL,
    [TrainingCodeID] NVARCHAR (100)  NULL,
    [Description]    NVARCHAR (250)  NULL,
    [DueDate]        DATETIME        NULL,
    [ExtendDay]      INT             NULL,
    [ExtendFromDate] DATETIME        NULL,
    [CompleteDate]   DATETIME        NULL,
    [IsValid]        BIT             NULL,
    [ErrorMessage]   NVARCHAR (1000) NULL,
    [LastUpdated]    DATETIME        NULL,
    [LastUpdatedBy]  INT             NULL,
    [WDNo]           NVARCHAR (20)   NULL
);

