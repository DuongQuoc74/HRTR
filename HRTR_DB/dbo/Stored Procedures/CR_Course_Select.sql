CREATE PROC [dbo].[CR_Course_Select] @CourseID int
AS
BEGIN
	SET NOCOUNT ON
	SELECT [CourseID]
      ,[CourseName]
      ,[CourseGroupID]
      ,[TrainingGroupID]
      ,[ExpiredInMonths]
      ,[HasVA]
      ,[IsActive]
      ,[IsCritical]
      ,[NumberOfCriticalDays]
      ,[IsOrientation]
      ,[EffectiveDate]
      ,[MinPoint]
      ,[MaxPoint]
	FROM [dbo].[CR_Course] WITH (NOLOCK)
	WHERE [CourseID] = @CourseID
END


