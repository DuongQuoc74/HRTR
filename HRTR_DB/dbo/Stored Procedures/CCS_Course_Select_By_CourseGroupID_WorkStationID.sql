-- 2017-10-10: CHG0064373, PR 21300 HRTR Enhancement for Awareness Reports (HCM)
-- Remove courses which are configured as Orientation in HRTR system from CCS.
CREATE PROC [dbo].[CCS_Course_Select_By_CourseGroupID_WorkStationID]
( 
	@CourseGroupID		int,
	@WorkStationID		varchar(100),
	@TrainingGroupID	int,
	@UserName			varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @WorkcellID					int
			, @IsAppliedClientProcess	int
	SELECT TOP 1 @WorkcellID = [WorkcellID]
	FROM	[dbo].[HR_Employee] WITH (NOLOCK)
	WHERE	[UserName] = @UserName	
	SELECT TOP 1 @IsAppliedClientProcess = ISNULL([IsAppliedClientProcess], 0)
	FROM	[dbo].[CR_Workcell] WITH (NOLOCK)
	WHERE	[WorkcellID] = @WorkCellID
	
	SET @IsAppliedClientProcess = ISNULL(@IsAppliedClientProcess, 0)
	IF @IsAppliedClientProcess = 1
		AND EXISTS (SELECT 1
							FROM [dbo].[CCS_WorkStationCourse] WITH (NOLOCK)
							WHERE [WorkStationID] = @WorkStationID
							)
	BEGIN
			SELECT C.[CourseID]
					, C.[CourseName]
			FROM	[dbo].[CR_Course] C WITH (NOLOCK) INNER JOIN [dbo].[CR_TrainingGroup] TG WITH (NOLOCK) ON TG.TrainingGroupID = C.[TrainingGroupID]
											  INNER JOIN [dbo].[CR_CourseGroup] CG WITH (NOLOCK) ON CG.[CourseGroupID] = C.[CourseGroupID]
											  INNER JOIN [dbo].[CCS_WorkStationCourse] WSC WITH (NOLOCK) ON WSC.[CourseID] = C.[CourseID]
			WHERE	C.[CourseGroupID] = @CourseGroupID
					AND C.[TrainingGroupID] = @TrainingGroupID
					AND C.[IsOrientation] = 0
					AND C.[IsActive] = 1
					AND TG.[IsActive] = 1
					AND CG.[IsActive] = 1
					AND WSC.[WorkStationID] = @WorkStationID
			ORDER BY C.[CourseName]
			
	END
	ELSE
	BEGIN
			SELECT C.[CourseID]
					, C.[CourseName]
			FROM	[dbo].[CR_Course] C WITH (NOLOCK) INNER JOIN [dbo].[CR_TrainingGroup] TG WITH (NOLOCK) ON TG.TrainingGroupID = C.[TrainingGroupID]
											  INNER JOIN [dbo].[CR_CourseGroup] CG WITH (NOLOCK) ON CG.[CourseGroupID] = C.[CourseGroupID]
			WHERE	C.[CourseGroupID] = @CourseGroupID
					AND C.[TrainingGroupID] = @TrainingGroupID
					AND C.[IsOrientation] = 0
					AND C.[IsActive] = 1
					AND TG.[IsActive] = 1
					AND CG.[IsActive] = 1
			ORDER BY C.[CourseName]
	END
END

