CREATE TABLE [dbo].[TrainingRecord] (
    [TrainingRecordID] INT            IDENTITY (1, 1) NOT NULL,
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
    [IsActive]         BIT            NULL,
    [Comments]         NVARCHAR (255) NULL,
    CONSTRAINT [PK_TrainingRecord] PRIMARY KEY NONCLUSTERED ([TrainingRecordID] ASC),
    CONSTRAINT [FK_TrainingRecord_Course] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[CR_Course] ([CourseID]),
    CONSTRAINT [FK_TrainingRecord_Product] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[CR_Product] ([ProductID]),
    CONSTRAINT [IX_TrainingRecord] UNIQUE CLUSTERED ([EmployeeID_ID] ASC, [CourseID] ASC, [CertDate] ASC, [ProductID] ASC)
);

