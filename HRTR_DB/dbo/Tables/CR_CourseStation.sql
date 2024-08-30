CREATE TABLE [dbo].[CR_CourseStation] (
    [CourseStationID] INT      IDENTITY (1, 1) NOT NULL,
    [CourseID]        INT      NOT NULL,
    [StationID]       INT      NOT NULL,
    [IsActive]        BIT      NULL,
    [LastUpdated]     DATETIME NULL,
    [LastUpdatedBy]   INT      NULL,
    CONSTRAINT [PK_CR_CourseStation] PRIMARY KEY CLUSTERED ([CourseStationID] ASC)
);

