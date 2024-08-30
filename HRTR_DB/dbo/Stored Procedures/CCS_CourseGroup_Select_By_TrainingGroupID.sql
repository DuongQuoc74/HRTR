CREATE PROC [dbo].[CCS_CourseGroup_Select_By_TrainingGroupID] 
(
	@TrainingGroupID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT DISTINCT A.[CourseGroupID]
		  ,A.[CourseGroupName]
		  ,A.[ExpiredInMonths]
		  ,B.[TrainingGroupID]
	FROM	[dbo].[CR_CourseGroup] A WITH (NOLOCK)
			RIGHT OUTER JOIN [dbo].[CR_Course] B WITH (NOLOCK) ON A.[CourseGroupID] = B.[CourseGroupID]
	WHERE	B.[TrainingGroupID] = @TrainingGroupID
			AND A.[IsActive] = 1 
			AND B.[IsActive] = 1
END


