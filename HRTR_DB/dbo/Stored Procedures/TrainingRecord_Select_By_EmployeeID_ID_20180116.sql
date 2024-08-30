
CREATE PROC [dbo].[TrainingRecord_Select_By_EmployeeID_ID_20180116] 
(	
	@EmployeeID_ID			int
)
AS
BEGIN
	SET NOCOUNT ON 
	SELECT A.[TrainingRecordID]
		  ,A.[EmployeeID_ID]
		  ,E.[EmployeeID]
		  ,E.[EmployeeName]
		  ,A.[ProductID]
		  ,A.[Trainer]
		  ,A.[CourseID]
		  ,A.[CertDate]
		  ,(CASE WHEN A.[OJT] = 1 THEN A.[ExpDate] ELSE [dbo].[ufn_GetExpDate](A.[CertDate], B.[ExpiredInMonths], B.[ExpiredInMonths]) END) AS [ExpDate]
		  ,A.[Score] 
		  ,A.[CertifiedLevelID]
		  ,C.[CertifiedLevelName]
		  ,ISNULL(A.[OJT], 0) AS [OJT]
		  ,B.[CourseName]
		  ,B.[CourseGroupID]
		  ,B.[CourseGroupName]
		  ,B.[TrainingGroupID]
		  ,B.[TrainingGroupName]
		  
	 FROM	[dbo].[TrainingRecord] A WITH (NOLOCK) 
			INNER JOIN [dbo].[HR_Employee] E WITH (NOLOCK) ON A.[EmployeeID_ID] = E.[EmployeeID_ID]
			INNER JOIN [dbo].[CR_Course_V1] B WITH (NOLOCK) ON A.[CourseID] = B.[CourseID]
			LEFT OUTER JOIN [dbo].[CR_CertifiedLevel] C WITH (NOLOCK) ON C.[CertifiedLevelID] = A.[CertifiedLevelID]
	WHERE	A.[EmployeeID_ID] = @EmployeeID_ID
	ORDER BY B.[CourseName]
	  
END



