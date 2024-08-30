CREATE TABLE [dbo].[CCS_WorkStationCourse] (
    [WorkStationID] NVARCHAR (100) NOT NULL,
    [CourseID]      INT            NOT NULL,
    [LastUpdatedBy] INT            NULL,
    [LastUpdated]   DATETIME       NULL,
    CONSTRAINT [PK_CCS_WorkStationCourse] PRIMARY KEY CLUSTERED ([WorkStationID] ASC, [CourseID] ASC)
);

