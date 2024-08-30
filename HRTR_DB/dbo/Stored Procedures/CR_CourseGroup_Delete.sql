CREATE PROC [dbo].[CR_CourseGroup_Delete] @CourseGroupID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[CR_CourseGroup] WHERE [CourseGroupID]=@CourseGroupID


