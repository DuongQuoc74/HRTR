CREATE PROC [dbo].[CR_Course_Delete] 
(
	@CourseID		int,
	@LastUpdatedBy	int = 0	
)
AS
BEGIN
	DELETE 
	FROM [dbo].[CR_Course] 
	WHERE [CourseID]=@CourseID
END

