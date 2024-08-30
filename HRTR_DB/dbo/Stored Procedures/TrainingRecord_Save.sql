CREATE PROC [dbo].[TrainingRecord_Save] 
(
	@TrainingRecordID	int, 
	@EmployeeID_ID		int = 0, 
	--@EmployeeID		varchar(10), 
	@ProductID			int, 
	@Trainer			nvarchar(100), 
	@CourseID			int, 
	@CertDate			date = NULL, 
	@ExpDate			date = NULL, 
	@Score				decimal(4,1),
	@OJT				bit,
	@IsActive			bit,
	@Comments			nvarchar(255),
	@LastUpdatedBy		int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @CertifiedLevelID		int
			, @MinPoint				decimal(4, 1) = 0
			, @MaxPoint				decimal(4, 1) = 0
			, @OJTDays				int = 14 -- days
	
	DECLARE @EmployeeID varchar(10)
	SELECT TOP 1 @EmployeeID = [EmployeeID]
	FROM		[dbo].[HR_Employee] WITH (NOLOCK)
	WHERE		[EmployeeID_ID] = @EmployeeID_ID

	IF @IsActive = 1
	BEGIN
		--IF(YEAR(@CertDate) = 1900)
		--	SET @CertDate = NULL
		--IF(YEAR(@ExpDate) = 1900)
		--	SET @ExpDate = NULL
		IF @CertDate IS NULL AND @OJT = 0
		BEGIN
			RETURN
		END

		IF @CertDate IS NOT NULL
		BEGIN
			IF @CertDate > GETDATE()
			BEGIN
				RAISERROR(N'Cert Date must be less than or equal to current date.', 16, 1)
				RETURN
			END
		END
		SELECT TOP 1 @MinPoint = [MinPoint]
				, @MaxPoint = [MaxPoint]
		FROM [dbo].[CR_Course] WITH (NOLOCK)
		WHERE [CourseID] = @CourseID
		-- Allow to import score < min score -> Certificate level: failed
		IF NOT (@Score BETWEEN 0 AND @MaxPoint)
			AND @OJT = 0
		BEGIN
			RAISERROR(N'Score is not in valid range.', 16, 1)
			RETURN
		END
		SELECT TOP 1 @OJTDays = CONVERT(INT, [ConfigurationValue])
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'OJTDays'

		IF @OJT = 1
		BEGIN
			IF @ExpDate IS NULL 
				SET @ExpDate = DATEADD(DAY, @OJTDays, ISNULL(@CertDate, GETDATE()))
			--LoanNguyen 20171212
			SET @CertifiedLevelID = 6 --OJT
		END
		ELSE 
		BEGIN
			SET @ExpDate = NULL
		END

		IF EXISTS (SELECT 1 
					FROM	[dbo].[TrainingRecord] WITH (NOLOCK)
					WHERE	[TrainingRecordID] = @TrainingRecordID)
		BEGIN
			--update existing record
			UPDATE [dbo].[TrainingRecord] 
			SET [Trainer] = @Trainer, 
				[CertDate] = @CertDate, 
				[ExpDate] = @ExpDate, 
				[Score] = @Score,
				[CertifiedLevelID] = @CertifiedLevelID,
				[OJT] = @OJT,
				[IsActive] = @IsActive,
				[Comments] = @Comments,
				[LastUpdated] = GETDATE(),
				[LastUpdatedBy] = @LastUpdatedBy
			WHERE [TrainingRecordID] = @TrainingRecordID
		END
		ELSE
		BEGIN
			--insert new record
			INSERT INTO [dbo].[TrainingRecord] ([EmployeeID_ID], [EmployeeID], [ProductID], [Trainer], [CourseID], [CertDate]
			, [ExpDate]
			, [Score], [CertifiedLevelID]
			, [OJT], [IsActive], [Comments]
			, [LastUpdated], [LastUpdatedBy])
			VALUES (@EmployeeID_ID, @EmployeeID, @ProductID, @Trainer, @CourseID, @CertDate
			, @ExpDate
			, @Score, @CertifiedLevelID
			, @OJT, @IsActive, @Comments
			, GETDATE(), @LastUpdatedBy)
			SET @TrainingRecordID = SCOPE_IDENTITY()
		END
	END
	ELSE
	BEGIN
		--update existing record
		UPDATE [dbo].[TrainingRecord]
		SET [OJT] = @OJT,
			[IsActive] = @IsActive,
			[Comments] = @Comments,
			[LastUpdated] = GETDATE(),
			[LastUpdatedBy] = @LastUpdatedBy
		WHERE [TrainingRecordID] = @TrainingRecordID
		--LoanNguyen 20171212
		--UPDATE [dbo].[TrainingRecord] 
		--SET [IsActive] = @IsActive,
		--	[Comments] = @Comments,
		--	[LastUpdated] = GETDATE(),
		--	[LastUpdatedBy] = @LastUpdatedBy
		--WHERE [EmployeeID_ID] = @EmployeeID_ID
		--	AND [CourseID] = @CourseID
		--	AND [CertDate] <= @CertDate
		--	AND [TrainingRecordID] <> @TrainingRecordID 	


--ThienNguyen6339 20200721 
	UPDATE A
	SET [IsActive] = 0
	,Comments = @Comments
	FROM [dbo].[TrainingRecord] A WITH (NOLOCK)
		INNER JOIN [dbo].[CR_Course] C WITH (NOLOCK) ON A.[CourseID] = C.[CourseID]
	WHERE A.[EmployeeID_ID] = @EmployeeID_ID
		AND A.[CourseID] = @CourseID 
		AND A.[ProductID] = @ProductID --LoanNguyen 20180109
		AND A.[OJT] = 0
		AND A.[IsActive] = 1
	END
	
	UPDATE A
	SET [CertifiedLevelID] = (CASE WHEN C.[IsOrientation] = 1 THEN 4 ELSE 5 END)
	FROM [dbo].[TrainingRecord] A WITH (NOLOCK)
		INNER JOIN [dbo].[CR_Course] C WITH (NOLOCK) ON A.[CourseID] = C.[CourseID]
	WHERE A.TrainingRecordID = @TrainingRecordID 
	    AND A.[EmployeeID_ID] = @EmployeeID_ID
		AND A.[CourseID] = @CourseID 
		AND A.[ProductID] = @ProductID --LoanNguyen 20180109
		AND A.[OJT] = 0
		--AND A.[IsActive] = 1  --ThienNguyen6339 20200805

	UPDATE A
	SET [CertifiedLevelID] = (CASE WHEN C.[IsOrientation] = 1 THEN 1 ELSE 2 END)
	FROM [dbo].[TrainingRecord] A WITH (NOLOCK)
		INNER JOIN [dbo].[CR_Course] C WITH (NOLOCK) ON A.[CourseID] = C.[CourseID]
	WHERE A.TrainingRecordID = @TrainingRecordID 
	    AND A.[EmployeeID_ID] = @EmployeeID_ID
		AND A.[CourseID] = @CourseID 
		AND A.[ProductID] = @ProductID --LoanNguyen 20180109
		AND A.[OJT] = 0
		-- AND A.[IsActive] = 1 --Thien Nguyen 6339 20200805
		AND A.[CertDate] = (SELECT TOP 1 D.[CertDate]
									FROM [dbo].[TrainingRecord] D WITH (NOLOCK)
									WHERE D.[EmployeeID_ID] = A.[EmployeeID_ID] 
											AND D.[CourseID] = A.[CourseID]
											AND D.[ProductID] = A.[ProductID] --LoanNguyen 20180109
											AND D.[OJT] = 0
											--AND D.[IsActive] = 1 --LoanNguyen 20180105 --ThienNguyen6339 20200805
									ORDER BY D.[CertDate])

	--Update Level to Failed for case score < minpoint
	UPDATE A
	SET [CertifiedLevelID] = 3
		,[Comments] = 'Failed Certification'
		,[ExpDate] = NULL
	FROM [dbo].[TrainingRecord] A WITH (NOLOCK)
		INNER JOIN [dbo].[CR_Course] C WITH (NOLOCK) ON A.[CourseID] = C.[CourseID]
	WHERE A.TrainingRecordID = @TrainingRecordID 
	    AND A.[EmployeeID_ID] = @EmployeeID_ID
		AND A.[CourseID] = @CourseID 
		AND A.[ProductID] = @ProductID
		AND A.[OJT] = 0
		AND A.[Score] < C.[MinPoint]

	----LoanNguyen 20171218
	--SELECT @IsOrientation = [IsOrientation]
	--FROM [dbo].[CR_Course] WITH (NOLOCK)
	--WHERE [CourseID] = @CourseID
	
	--IF @IsOrientation = 1
	--	SET @CertifiedLevelID = 4 --Re-trained
	--ELSE
	--	SET @CertifiedLevelID = 5 --Re-certified
		
	--UPDATE [dbo].[TrainingRecord] 
	--SET [CertifiedLevelID] = @CertifiedLevelID
	--WHERE [EmployeeID_ID] = @EmployeeID_ID
	--	   AND [CourseID] = @CourseID 
	--	   AND [OJT] = 0
	--	   AND [IsActive] = 1 
		   
		
	--IF @IsOrientation = 1
	--	SET @CertifiedLevelID = 1 --Trained
	--ELSE
	--	SET @CertifiedLevelID = 2 --Certified
	
	--UPDATE [dbo].[TrainingRecord] 
	--SET [CertifiedLevelID] = @CertifiedLevelID
	--WHERE [TrainingRecordID] = (SELECT TOP 1 [TrainingRecordID]
	--							FROM [dbo].[TrainingRecord] WITH (NOLOCK)
	--							WHERE [EmployeeID_ID] = @EmployeeID_ID
	--							   AND [CourseID] = @CourseID
	--							   AND [OJT] = 0
	--							   AND [IsActive] = 1 
	--						    ORDER BY [CertDate])
	
	----EXEC [dbo].[TrainingRecord_Select] @TrainingRecordID
END