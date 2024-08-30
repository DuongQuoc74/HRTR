CREATE TABLE [dbo].[CR_Course] (
    [CourseID]             INT            IDENTITY (1, 1) NOT NULL,
    [CourseName]           VARCHAR (50)   NULL,
    [CourseGroupID]        INT            NULL,
    [TrainingGroupID]      INT            NULL,
    [LastUpdated]          DATETIME       NULL,
    [LastUpdatedBy]        INT            NULL,
    [ExpiredInMonths]      INT            NULL,
    [HasVA]                BIT            CONSTRAINT [DF_CR_Course_HasVA] DEFAULT ((1)) NULL,
    [IsActive]             BIT            NULL,
    [IsCritical]           BIT            NULL,
    [NumberOfCriticalDays] INT            NULL,
    [IsOrientation]        BIT            NULL,
    [EffectiveDate]        DATETIME       NULL,
    [MinPoint]             DECIMAL (4, 1) NULL,
    [MaxPoint]             DECIMAL (4, 1) NULL,
    CONSTRAINT [PK_CR_Course] PRIMARY KEY CLUSTERED ([CourseID] ASC),
    CONSTRAINT [FK_CR_Course_CourseGroup] FOREIGN KEY ([CourseGroupID]) REFERENCES [dbo].[CR_CourseGroup] ([CourseGroupID]),
    CONSTRAINT [FK_CR_Course_TrainingGroup] FOREIGN KEY ([TrainingGroupID]) REFERENCES [dbo].[CR_TrainingGroup] ([TrainingGroupID]),
    CONSTRAINT [IX_CR_Course] UNIQUE NONCLUSTERED ([CourseName] ASC, [TrainingGroupID] ASC, [CourseGroupID] ASC)
);

