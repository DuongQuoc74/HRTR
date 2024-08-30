CREATE PROCEDURE [dbo].[CR_EmployeeDocument_Search]
	@StationID AS int,
	@WorkcellID AS int,
	@CourseID AS int,
	@CourseGroupID AS int,
	@TrainingGroupID AS int,
	@DocumentNumber AS nvarchar(255),
	@Revision AS nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON

	SELECT E.[EmployeeDocID]
		,A.[EmployeeID_ID]
		,A.[EmployeeID]
		,A.[EmployeeName]
		,W.[WorkcellName]
		,S.[Name] AS "StationName"
		,C.[CourseName]
		,CG.[CourseGroupName]
		,TG.[TrainingGroupName]
		,E.[DocumentNumber]
		,E.[Revision]
		,E.[Created]
		,UP.[FullName] AS [CreatedByFullName]
	FROM [dbo].[CR_EmployeeDocument] E WITH (NOLOCK)
		INNER JOIN [dbo].[HR_Employee_V] A WITH (NOLOCK) ON A.[EmployeeID_ID] = E.[EmployeeID_ID]
		INNER JOIN [dbo].[CR_Course] C WITH (NOLOCK) ON C.CourseID = E.CourseID
		INNER JOIN [dbo].[CR_TrainingGroup] TG WITH (NOLOCK) ON TG.TrainingGroupID = C.TrainingGroupID
		INNER JOIN [dbo].[CR_CourseGroup] CG WITH (NOLOCK) ON CG.CourseGroupID = C.CourseGroupID
		INNER JOIN [dbo].[CR_Station] S WITH (NOLOCK) ON S.ID = E.StationID
		INNER JOIN [dbo].[CR_Workcell] W WITH (NOLOCK) ON W.WorkcellID = E.WorkcellID
		LEFT OUTER JOIN [dbo].[SC_UserProfile] UP WITH (NOLOCK) ON E.[CreatedBy] = UP.[UserProfileID]
	WHERE (@StationID = 0 OR E.[StationID] = @StationID)
		AND (@WorkcellID = 0 OR E.[WorkcellID] = @WorkcellID)
		AND (@CourseID = 0 OR E.[CourseID] = @CourseID)
		AND (@DocumentNumber = N'' OR E.[DocumentNumber] = @DocumentNumber)
		AND (@Revision = N'' OR E.[Revision] = @Revision)
		AND (@CourseGroupID = 0 OR CG.[CourseGroupID] = @CourseGroupID)
		AND (@TrainingGroupID = 0 OR TG.[TrainingGroupID] = @TrainingGroupID)
		AND E.[Active] = 1
END