



















CREATE VIEW [dbo].[CR_Course_V1]
AS
	SELECT	A.[CourseID]
		,A.[CourseName]
		,A.[CourseGroupID]
		,B.[CourseGroupName]
		,A.[TrainingGroupID]
		,C.[TrainingGroupName]
		,A.[ExpiredInMonths]
		,A.[HasVA]
		,A.[IsActive]
		,A.[IsOrientation]
		,A.[EffectiveDate]
		,A.[LastUpdated]
		,A.[LastUpdatedBy]
	FROM	[dbo].[CR_Course] A WITH (NOLOCK) 
			LEFT OUTER JOIN [dbo].[CR_CourseGroup] B WITH (NOLOCK) ON A.[CourseGroupID]=B.[CourseGroupID]
			LEFT OUTER JOIN [dbo].[CR_TrainingGroup] C WITH (NOLOCK) ON A.[TrainingGroupID]=C.[TrainingGroupID]





