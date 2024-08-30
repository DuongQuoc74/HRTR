











CREATE VIEW [dbo].[TrainingRecord_V1]
AS

SELECT A.[TrainingRecordID]
      ,A.[EmployeeID]
      ,A.[ProductID]
      ,A.[Trainer]
      ,A.[CourseID]
      ,A.[CertDate]
      ,A.[Score]
      ,A.[CertifiedLevelID]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
      ,A.[EmployeeID_ID]
      ,A.[OJT]
      ,I.[CourseName]
      ,I.[CourseGroupID]
	  ,I.[IsCritical]
      ,I.[NumberOfCriticalDays]
	  ,J.[CourseGroupName]
	  ,I.[TrainingGroupID]
	  ,(CASE WHEN A.[OJT] = 1 THEN A.[ExpDate] ELSE [dbo].[ufn_GetExpDate](A.[CertDate], I.[ExpiredInMonths], J.[ExpiredInMonths]) END) AS [ExpDate]
	  ,ISNULL(I.[IsOrientation], 0) AS [IsOrientation]
	  ,K.[TrainingGroupName]
	  ,K.[IsActive]
	  ,P.[ProductName]
	  --,I.[IsCritical]
	  --,I.[NumberOfCriticalDays]
      ,A.[IsActive] AS [TrainingRecordActive]
	  ,A.[Comments]
  FROM [dbo].[TrainingRecord] A WITH (NOLOCK) INNER JOIN [dbo].[CR_Course] I WITH (NOLOCK) ON I.[CourseID]=A.[CourseID]
																							AND I.[IsActive] = 1
		INNER JOIN [dbo].[CR_CourseGroup] J WITH (NOLOCK) ON J.[CourseGroupID]=I.[CourseGroupID]
		INNER JOIN [dbo].[CR_TrainingGroup] K WITH (NOLOCK) ON K.[TrainingGroupID]=I.[TrainingGroupID]
		INNER JOIN [dbo].[CR_Product] P WITH (NOLOCK) ON P.[ProductID]=A.[ProductID]
	WHERE A.[TrainingRecordID] = (SELECT TOP 1 H1.[TrainingRecordID]
								  FROM [dbo].[TrainingRecord] H1 WITH (NOLOCK)
								  WHERE  H1.[EmployeeID_ID] = A.[EmployeeID_ID] AND H1.[CourseID] = A.[CourseID] ORDER BY H1.[CertDate] DESC)












