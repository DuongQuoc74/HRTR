CREATE PROC [dbo].[CR_CourseGroup_Select] @CourseGroupID int
AS
SELECT [CourseGroupID]
      ,[CourseGroupName]
      ,[ExpiredInMonths]
      --,[LastUpdated]
      --,[LastUpdatedBy]
      ,[IsActive]
      FROM [dbo].[CR_CourseGroup] WHERE [CourseGroupID]=@CourseGroupID


