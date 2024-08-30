
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TrainingRecordTemp_Verify_After_Loading_20180116]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE
	FROM	[dbo].[TrainingRecordTemp]
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND ISNULL([EmployeeID], '') = ''
			
	UPDATE [dbo].[TrainingRecordTemp]
	SET		[EmployeeID_ID] = 0
			, [EmployeeID] = LTRIM(RTRIM([EmployeeID]))
			, [ProductID] = 1 -- All
			, [ProductName] = LTRIM(RTRIM([ProductName]))
			, [CourseID] = 0
			, [CourseName] = LTRIM(RTRIM([CourseName]))
			, [CourseGroupID] = 0
			, [CourseGroupName] = LTRIM(RTRIM([CourseGroupName]))
			, [TrainingGroupID] = 0
			, [TrainingGroupName] = LTRIM(RTRIM([TrainingGroupName]))
			, [CertifiedLevelID] = 0
			, [CertifiedLevelName] = LTRIM(RTRIM([CertifiedLevelName]))
			, [Score] = ISNULL([Score], 0)
			, [OJT] = ISNULL([OJT], 0)
			, [IsValid] = 0
			, [ErrorMessage] = ''
	WHERE [LastUpdatedBy] = @LastUpdatedBy
	
	-- Get EmployeeID_ID START
	UPDATE A
	SET [EmployeeID_ID] = B.[EmployeeID_ID]
	FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK) 
			INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID] = B.[EmployeeID]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
	-- Get EmployeeID_ID END
	
	UPDATE A
	SET [TrainingGroupID] = B.[TrainingGroupID]
	FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK) 
			INNER JOIN [dbo].[CR_TrainingGroup] B WITH (NOLOCK) ON A.[TrainingGroupName] = B.[TrainingGroupName]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
	UPDATE A
	SET [CourseGroupID] = B.[CourseGroupID]
	FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK) 
			INNER JOIN [dbo].[CR_CourseGroup] B WITH (NOLOCK) ON A.[CourseGroupName] = B.[CourseGroupName]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
	--UPDATE A
	--SET [ProductID] = B.[ProductID]
	--FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK) 
	--		INNER JOIN [dbo].[CR_Product] B WITH (NOLOCK) ON A.[ProductName] = B.[ProductName]
	--WHERE A.[LastUpdatedBy] = @LastUpdatedBy
	UPDATE A
	SET [CertifiedLevelID] = B.[CertifiedLevelID]
	FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK) 
			INNER JOIN [dbo].[CR_CertifiedLevel] B WITH (NOLOCK) ON A.[CertifiedLevelName] = B.[CertifiedLevelName]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
	UPDATE A
	SET [CourseID] = B.[CourseID]
	FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK) 
			INNER JOIN [dbo].[CR_Course] B WITH (NOLOCK) ON A.[CourseName] = B.[CourseName]
														AND A.[TrainingGroupID] = B.[TrainingGroupID]
														AND A.[CourseGroupID] = B.[CourseGroupID]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
	
			
	UPDATE	[dbo].[TrainingRecordTemp]
	SET		[ErrorMessage] = [ErrorMessage] 
							+ (CASE WHEN [EmployeeID_ID] = 0
												THEN N'Invalid Employee ID. '
												ELSE N'' END)
							+ (CASE WHEN [TrainingGroupID] = 0
												THEN N'Invalid Training Group. '
												ELSE N'' END)
							+ (CASE WHEN [CourseGroupID] = 0
												THEN N'Invalid Course Group. '
												ELSE N'' END)
							+ (CASE WHEN [CertDate] IS NULL
												THEN N'Invalid Cert Date. '
												ELSE N'' END)
							+ (CASE WHEN [CertDate] IS NOT NULL AND [CertDate] > GETDATE()
												THEN N'Cert Date must be less than or equal to current date. '
												ELSE N'' END)
							+ (CASE WHEN [CertifiedLevelID] = 0
												THEN N'Invalid Certified Level. '
												ELSE N'' END)
							+ (CASE WHEN [CourseID] = 0
												THEN N'Invalid Course. '
												ELSE N'' END)
							+ (CASE WHEN [OJT] = 1 AND [ExpDate] IS NULL
												THEN N'Invalid Exp Date. '
												ELSE N'' END)
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
	--
   	UPDATE	[dbo].[TrainingRecordTemp]
	SET		[IsValid] = 1
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND [ErrorMessage] = ''		
END



