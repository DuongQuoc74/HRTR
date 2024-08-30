CREATE PROC [dbo].[TrainingRecord_Select] 
(
	@TrainingRecordID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT A.[TrainingRecordID]
		,A.[EmployeeID_ID]
		,A.[EmployeeID]
		,A.[ProductID]
		,A.[Trainer]
		,A.[CourseID]
		,A.[CertDate]
		,A.[ExpDate]
		,A.[Score]
		,A.[CertifiedLevelID]
		,A.[OJT]
		,A.[IsActive]
		,A.[Comments]
		,B.[CourseGroupID]
		,B.[TrainingGroupID]
	FROM [dbo].[TrainingRecord] A WITH (NOLOCK)
			INNER JOIN [dbo].[CR_Course] B WITH (NOLOCK) ON A.[CourseID] = B.[CourseID]
	WHERE A.[TrainingRecordID] = @TrainingRecordID
END


