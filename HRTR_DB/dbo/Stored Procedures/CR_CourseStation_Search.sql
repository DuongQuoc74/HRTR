CREATE PROC [dbo].[CR_CourseStation_Search] 
(
	@CourseID	int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				--, @Query2						nvarchar(max)
	SET @Query = N'SELECT	C.[TrainingGroupName]
			, D.[CourseStationID]
			, B.[CourseGroupName]
			, D.[CourseID]
			, A.[CourseName]
			, A.[CourseGroupID]
			, A.[TrainingGroupID]
			, G.[WorkcellName]
			, F.[StationName]
			, D.[IsActive]
			, D.[LastUpdated]
			, E.[UserName] AS [LastUpdatedByUserName]
	FROM	[dbo].[CR_CourseStation] D WITH (NOLOCK) INNER JOIN [dbo].[CR_Course] A WITH (NOLOCK) ON D.[CourseID] = A.[CourseID]
			INNER JOIN [dbo].[CR_CourseGroup] B WITH (NOLOCK) ON A.[CourseGroupID]=B.[CourseGroupID]
			INNER JOIN [dbo].[CR_TrainingGroup] C WITH (NOLOCK) ON A.[TrainingGroupID]=C.[TrainingGroupID]
			INNER JOIN [EDCC].[dbo].[Station] F WITH (NOLOCK) ON F.[StationID] = D.[StationID]
			INNER JOIN [EDCC].[dbo].[Workcell] G WITH (NOLOCK) ON G.[WorkcellID] = F.[WorkcellID] 
			LEFT JOIN [dbo].[SC_UserProfile] E WITH (NOLOCK) ON D.[LastUpdatedBy] = E.[UserProfileID] '
	IF @CourseID != 0
	BEGIN
		SET @Query = @Query + N' WHERE D.[CourseID] = @CourseID '
	END	
	SET @Query = @Query + N' ORDER BY C.[TrainingGroupName]
					, B.[CourseGroupName]
					, A.[CourseName]'
	SET @ParmDef = '@CourseID int'
					
	EXEC sp_executesql @Query, @ParmDef
								, @CourseID
END


