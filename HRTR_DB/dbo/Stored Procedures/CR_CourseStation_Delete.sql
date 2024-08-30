CREATE PROC [dbo].[CR_CourseStation_Delete] 
(
	@CourseStationID int,
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE
	FROM [dbo].[CR_CourseStation]
	WHERE [CourseStationID] = @CourseStationID
END

