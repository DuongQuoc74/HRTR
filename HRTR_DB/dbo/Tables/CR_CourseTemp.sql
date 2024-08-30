CREATE TABLE [dbo].[CR_CourseTemp] (
    [TrainingGroupID]      INT            NULL,
    [TrainingGroupName]    NVARCHAR (50)  NULL,
    [CourseGroupID]        INT            NULL,
    [CourseGroupName]      NVARCHAR (50)  NULL,
    [CourseName]           NVARCHAR (50)  NULL,
    [ExpiredInMonths]      INT            NULL,
    [HasVA]                BIT            NULL,
    [IsActive]             BIT            NULL,
    [IsCritical]           BIT            NULL,
    [IsOrientation]        BIT            NULL,
    [MinPoint]             DECIMAL (4, 1) NULL,
    [MaxPoint]             DECIMAL (4, 1) NULL,
    [EffectiveDate]        DATETIME       NULL,
    [NumberOfCriticalDays] INT            NULL,
    [IsValid]              BIT            NULL,
    [ErrorMessage]         NVARCHAR (255) NULL,
    [LastUpdated]          DATETIME       NULL,
    [LastUpdatedBy]        INT            NULL
);

