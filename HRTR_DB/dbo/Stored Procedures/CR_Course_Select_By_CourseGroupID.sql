CREATE PROC [dbo].[CR_Course_Select_By_CourseGroupID] @CourseGroupID int
AS
SELECT [CourseID], [CourseName], [CourseGroupID], [TrainingGroupID], [ExpiredInMonths]
FROM [dbo].[CR_Course] WITH (NOLOCK)
WHERE [CourseGroupID]=@CourseGroupID
ORDER BY [CourseName]


