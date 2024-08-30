CREATE PROC [dbo].[CR_CourseGroup_Search_By_TrainingGroupIDList] 
(
	@TrainingGroupIDList		nvarchar(1000) = ''
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT DISTINCT A.[CourseGroupID]
		  ,A.[CourseGroupName]
		  ,A.[ExpiredInMonths]
		  --,B.[TrainingGroupID]
	FROM	[dbo].[CR_CourseGroup] A WITH (NOLOCK)
				INNER JOIN [dbo].[CR_Course] B  WITH (NOLOCK) ON A.[CourseGroupID] = B.[CourseGroupID]
	WHERE	B.[TrainingGroupID] IN (SELECT [Items] AS [TrainingGroupID] FROM [dbo].[Split](@TrainingGroupIDList, ';'))
	ORDER BY A.[CourseGroupName]
END


