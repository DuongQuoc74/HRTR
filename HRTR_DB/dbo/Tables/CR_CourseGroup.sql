CREATE TABLE [dbo].[CR_CourseGroup] (
    [CourseGroupID]   INT          IDENTITY (1, 1) NOT NULL,
    [CourseGroupName] VARCHAR (50) NULL,
    [ExpiredInMonths] INT          NULL,
    [LastUpdated]     DATETIME     NULL,
    [LastUpdatedBy]   INT          NULL,
    [IsActive]        BIT          NULL,
    CONSTRAINT [PK_CR_CourseGroup] PRIMARY KEY CLUSTERED ([CourseGroupID] ASC),
    CONSTRAINT [IX_CR_CourseGroup] UNIQUE NONCLUSTERED ([CourseGroupName] ASC)
);

