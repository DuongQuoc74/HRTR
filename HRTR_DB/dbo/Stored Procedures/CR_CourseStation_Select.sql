CREATE PROC [dbo].[CR_CourseStation_Select] 
(
	@CourseStationID	int
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT [CourseStationID]
      ,[CourseID]
      ,[IsActive]
      ,[StationID]
      ,[LastUpdated]
      ,[LastUpdatedBy]
  FROM [dbo].[CR_CourseStation] WITH (NOLOCK)
 WHERE [CourseStationID]=@CourseStationID
						
END

