CREATE PROC [dbo].[TrainingRecord_Search_Map_Doc] 
(
	@WorkcellID					int,
	@StationID					int,
	@CourseID					int,
	@DocumentNumber				nvarchar(255),
	@Revision					nvarchar(10),
	@CerDateFrom				date,
	@CerDateTo					date
)
AS
BEGIN
EXEC TrainingRecord_InactiveExpiredOJTCourses
	SET NOCOUNT ON

	SELECT H.[TrainingRecordID]
		  ,A.[EmployeeID_ID]
		  ,A.[EmployeeID]
		  ,A.[EmployeeName]
		  ,A.[WorkcellID]
		  ,A.[WorkcellName]
		  ,H.[CertDate]
		  ,H.[CourseID]
		  ,H.[CourseName]
		  ,H.[CourseGroupID]
		  ,H.[CourseGroupName]
		  ,H.[TrainingGroupID]
		  ,H.[TrainingGroupName]
		  ,H.[IsActive]
	FROM [dbo].[TrainingRecord_V] H WITH (NOLOCK)
		 INNER JOIN [dbo].[HR_Employee_V] A WITH (NOLOCK) ON H.[EmployeeID_ID] = A.[EmployeeID_ID]
		 LEFT OUTER JOIN [dbo].[CR_CertifiedLevel] CL WITH (NOLOCK) ON H.[CertifiedLevelID] = CL.[CertifiedLevelID]
	WHERE (@CourseID = 0 OR (H.[CourseID] = @CourseID AND H.[IsActive] = 1 AND A.[IsActive] = 1))
			AND (@CerDateFrom IS NULL OR H.[CertDate] >= CONVERT(varchar(10), @CerDateFrom, 120) + ' 00:00:00.000')
			AND (@CerDateTo IS NULL OR H.[CertDate] <= CONVERT(varchar(10), @CerDateTo, 120) + ' 00:00:00.000')
			AND H.[TrainingRecordID] = (SELECT TOP 1 H1.[TrainingRecordID]
								  FROM [dbo].[TrainingRecord] H1 WITH (NOLOCK)
								  WHERE H1.ProductID = H.ProductID AND H1.[EmployeeID_ID] = H.[EmployeeID_ID] AND H1.[CourseID] = H.[CourseID] 
								  ORDER BY CASE
										 WHEN H1.[CertifiedLevelID] = 5 then 1
										 WHEN H1.[CertifiedLevelID] = 2 then 2 
										 WHEN H1.[CertifiedLevelID] = 4 then 3
										 WHEN H1.[CertifiedLevelID] = 1 then 4
										 WHEN H1.[CertifiedLevelID] = 6 then 5
										 ELSE 6
										 END ASC, H1.[CertDate] DESC)
			AND (NOT EXISTS (
				SELECT 1
				FROM CR_EmployeeDocument AS ce WITH (NOLOCK)
				WHERE ce.EmployeeID_ID = A.EmployeeID_ID
					AND ce.CourseID = H.CourseID
					AND ce.WorkcellID = @WorkcellID
					AND ce.StationID = @StationID
					AND ce.DocumentNumber = @DocumentNumber
					AND ce.Revision = @Revision
					AND ce.Active = 1
			))
	ORDER BY H.TrainingRecordID
END