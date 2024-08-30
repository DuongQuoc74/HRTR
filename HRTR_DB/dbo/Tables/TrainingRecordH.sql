CREATE TABLE [dbo].[TrainingRecordH] (
    [TrainingRecordID] INT            NOT NULL,
    [EmployeeID]       VARCHAR (10)   NULL,
    [ProductID]        INT            NULL,
    [Trainer]          NVARCHAR (100) NULL,
    [CourseID]         INT            NULL,
    [CertDate]         DATE           NULL,
    [ExpDate]          DATE           NULL,
    [Score]            DECIMAL (4, 1) NULL,
    [CertifiedLevelID] INT            NULL,
    [LastUpdated]      DATETIME       NULL,
    [LastUpdatedBy]    INT            NULL,
    [EmployeeID_ID]    INT            NULL,
    [OJT]              BIT            NULL,
    [Remarks]          NVARCHAR (255) NULL,
    [IsActive]         BIT            NULL,
    [Comments]         NVARCHAR (255) NULL
);

