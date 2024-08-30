CREATE PROCEDURE [dbo].[TrainingRecordTemp_Verify_After_Loading]
(
	@LastUpdatedBy INT
)
AS
	BEGIN
		SET NOCOUNT ON
	    
		-- Delete old training data of current user and employee he/she's handling
		DELETE FROM [dbo].[TrainingRecordTemp]
		WHERE
			[LastUpdatedBy] = @LastUpdatedBy
			AND ISNULL([EmployeeID], '') = ''

		-- Fix imported data in TrainingRecordTemp
		UPDATE [dbo].[TrainingRecordTemp]
		SET
			[EmployeeID_ID] = 0,
			[EmployeeID] = LTRIM(RTRIM([EmployeeID])),
			[ProductID] = 0, -- All
			[ProductName] = LTRIM(RTRIM([ProductName])),
			[CourseID] = 0,
			[CourseName] = LTRIM(RTRIM([CourseName])),
			[CourseGroupID] = 0,
			[CourseGroupName] = LTRIM(RTRIM([CourseGroupName])),
			[TrainingGroupID] = 0,
			[TrainingGroupName] = LTRIM(RTRIM([TrainingGroupName])),
			[CertifiedLevelID] = 0,
			[CertifiedLevelName] = LTRIM(RTRIM([CertifiedLevelName])),
			[Score] = ISNULL([Score], 0),
			[OJT] = ISNULL([OJT], 0),
			[IsActive] = ISNULL([IsActive], 0),
			[Comments] = LTRIM(RTRIM([Comments])),
			[IsValid] = 0,
			[ErrorMessage] = ''
		WHERE [LastUpdatedBy] = @LastUpdatedBy

		-- Update EmployeeID_ID in imported data with EmployeeID_ID from HR_Employee table (?)
		UPDATE A
		SET [EmployeeID_ID] = B.[EmployeeID_ID]
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[HR_Employee] B WITH(NOLOCK) ON A.[EmployeeID] = B.[EmployeeID]
		WHERE A.[LastUpdatedBy] = @LastUpdatedBy

		-- Update TrainingGroupID using TrainingGroupName
		UPDATE A
		SET [TrainingGroupID] = B.[TrainingGroupID]
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[CR_TrainingGroup] B WITH(NOLOCK) ON A.[TrainingGroupName] = B.[TrainingGroupName]
		WHERE
			A.[LastUpdatedBy] = @LastUpdatedBy
			AND B.[IsActive] = 1

		-- Update CourseGroupID using CourseGroupName
		UPDATE A
		SET [CourseGroupID] = B.[CourseGroupID]
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[CR_CourseGroup] B WITH(NOLOCK) ON A.[CourseGroupName] = B.[CourseGroupName]
		WHERE
			A.[LastUpdatedBy] = @LastUpdatedBy
			AND B.[IsActive] = 1

        -- Update ProductID
		UPDATE A
		SET [ProductID] = B.[ProductID]
		FROM
            [dbo].[TrainingRecordTemp] A WITH (NOLOCK)
            INNER JOIN [dbo].[CR_Product] B WITH (NOLOCK) ON A.[ProductName] = B.[ProductName]
		WHERE A.[LastUpdatedBy] = @LastUpdatedBy

		--UPDATE A
		--SET [CertifiedLevelID] = B.[CertifiedLevelID]
		--FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK)
		--		INNER JOIN [dbo].[CR_CertifiedLevel] B WITH (NOLOCK) ON A.[CertifiedLevelName] = B.[CertifiedLevelName]
		--WHERE A.[LastUpdatedBy] = @LastUpdatedBy

		-- Update CourseID using CourseName

		UPDATE A
		SET [CourseID] =  B.[CourseID]
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[CR_Course] B WITH(NOLOCK)
				ON A.[CourseName] = B.[CourseName]
				AND A.[TrainingGroupID] = B.[TrainingGroupID]
				AND A.[CourseGroupID] = B.[CourseGroupID]
		WHERE
			A.[LastUpdatedBy] = @LastUpdatedBy
			AND B.[IsActive] = 1

		-- Update ErrorMessage if any
		UPDATE [dbo].[TrainingRecordTemp]
		SET [ErrorMessage] = [ErrorMessage]
			+ (CASE WHEN [EmployeeID_ID] = 0 THEN N'Invalid Employee ID. ' ELSE N'' END)
			+ (CASE WHEN [TrainingGroupID] = 0 THEN N'Invalid Training Group. ' ELSE N'' END)
			+ (CASE WHEN [CourseGroupID] = 0 THEN N'Invalid Course Group. ' ELSE N'' END)
			+ (CASE WHEN [CertDate] IS NULL AND [IsActive] = 1 THEN N'Invalid Cert Date. ' ELSE N'' END)
			+ (CASE WHEN [CertDate] IS NOT NULL AND [CertDate] > GETDATE() AND [IsActive] = 1 THEN N'Cert Date must be less than or equal to current date. ' ELSE N'' END)
			+ (CASE WHEN [CourseID] = 0 THEN N'Invalid Course. ' ELSE N'' END)
			+ (CASE WHEN ([ProductID] IS NULL OR [ProductID] = 0) THEN N'The family ' + '“' + [ProductName] + '” is not in the family list. ' ELSE N'' END)
			+ (CASE WHEN ([OJT] = 1 AND [ExpDate] IS NULL) OR ([OJT] = 0 AND [ExpDate] IS NOT NULL)
					THEN N'Invalid Exp Date. ' 
					ELSE N'' END)
			+ (CASE WHEN [Comments] IS NULL AND [IsActive] = 0 THEN N'Invalid Comments. ' ELSE N'' END)
			
		WHERE [LastUpdatedBy] = @LastUpdatedBy
		
		UPDATE A
		SET [ErrorMessage] = [ErrorMessage] + N'Please select a specific family. '
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[CR_Course] B WITH(NOLOCK) ON A.[CourseID] = B.[CourseID]
		WHERE A.[LastUpdatedBy] = @LastUpdatedBy
			AND A.[OJT] = 0
			AND A.[IsActive] = 1
			AND (B.IsCertifiedPerFamily = 1 and A.ProductName = 'All') 
		
		UPDATE A
		SET [ErrorMessage] = [ErrorMessage] + N'Please select value is All with family. '
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[CR_Course] B WITH(NOLOCK) ON A.[CourseID] = B.[CourseID]
		WHERE A.[LastUpdatedBy] = @LastUpdatedBy
			AND A.[OJT] = 0
			AND A.[IsActive] = 1
			AND (B.IsCertifiedPerFamily IS NULL or B.IsCertifiedPerFamily = 0) and A.ProductName <> 'All'

		-- Validate Score and Update ErrorMessage
		-- Allow to import score < min score -> Certificate level: failed
		UPDATE A
		SET [ErrorMessage] = [ErrorMessage] + N'Invalid Score. '
		FROM
			[dbo].[TrainingRecordTemp] A WITH(NOLOCK)
			INNER JOIN [dbo].[CR_Course] B WITH(NOLOCK) ON A.[CourseID] = B.[CourseID]
		WHERE
			A.[LastUpdatedBy] = @LastUpdatedBy
			AND A.[OJT] = 0
			AND A.[IsActive] = 1
			AND A.[Score] NOT BETWEEN 0 AND B.[MaxPoint]

		-- Update Score (if Score is valid) and CertifiedLevelID
		UPDATE [dbo].[TrainingRecordTemp]
		SET
			[Score] = 0,
			[CertifiedLevelID] = 6 -- OJT
		WHERE
			[LastUpdatedBy] = @LastUpdatedBy
			AND [OJT] = 1
		--AND [IsActive] = 1

		-- Update IsValid
		UPDATE [dbo].[TrainingRecordTemp]
		SET [IsValid] = 1
		WHERE
			[LastUpdatedBy] = @LastUpdatedBy
			AND [ErrorMessage] = ''
	END