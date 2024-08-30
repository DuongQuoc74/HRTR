
CREATE PROC [dbo].[TrainingRecord_Select_By_ETCID_20180116] 
(	
	@EmployeeID_ID			int,
	@TraningGroupID			int,
	@CourseGroupID			int,
	@ProductID				int
)
AS
BEGIN
	SET NOCOUNT ON 
	--TrainingRecord_Select_By_EmployeeID_ID_TraningGroupID_CourseGroupID
	SELECT A.[CourseID]
		  ,A.[CourseName]
		  ,A.[CourseGroupID]
		  ,B.[TrainingRecordID]
		  ,B.[EmployeeID]
		  ,B.[ProductID]
		  ,B.[Trainer]
		  ,B.[CourseID]
		  ,B.[CertDate]
		  ,(CASE WHEN ISNULL(B.[OJT], 0) = 1 THEN B.[ExpDate] ELSE NULL END) AS [ExpDate]
		  ,B.[Score] 
		  ,B.[CertifiedLevelID]
		  ,ISNULL(B.[OJT], 0) AS [OJT]
	FROM	[dbo].[CR_Course] A WITH (NOLOCK) LEFT OUTER JOIN (SELECT A.[TrainingRecordID]
											  ,A.[EmployeeID]
											  ,A.[ProductID]
											  ,A.[Trainer]
											  ,A.[CourseID]
											  ,A.[CertDate]
											  ,A.[ExpDate]
											  ,A.[Score] 
											  ,A.[CertifiedLevelID]
											  ,A.[OJT]
											  FROM	[dbo].[TrainingRecord] A WITH (NOLOCK)	
													INNER JOIN (SELECT B.[EmployeeID_ID]
																	, B.[CourseID]
																	, B.[ProductID]
																	, MAX(B.[CertDate]) AS [CertDate]
															 FROM	[dbo].[TrainingRecord] B WITH (NOLOCK)
															 WHERE	B.[EmployeeID_ID] = @EmployeeID_ID
																		AND B.[ProductID] = @ProductID	
															GROUP BY B.[EmployeeID_ID], B.[CourseID], B.[ProductID]
															 ) B ON A.[EmployeeID_ID] = B.[EmployeeID_ID] 
																	AND A.[CourseID] = B.[CourseID]
																	AND A.[CertDate] = B.[CertDate]
																	AND A.[ProductID] = B.[ProductID]
											  WHERE	A.[EmployeeID_ID] = @EmployeeID_ID
													AND A.[ProductID] = @ProductID
													) B ON A.[CourseID] = B.[CourseID]
	WHERE	A.[CourseGroupID] = @CourseGroupID
			AND A.[TrainingGroupID] = @TraningGroupID
			AND A.[IsActive] = 1
	ORDER BY A.[CourseName]
  
END



