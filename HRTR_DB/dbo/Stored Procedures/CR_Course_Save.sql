CREATE PROC [dbo].[CR_Course_Save] 
(
	@CourseID				int, 
	@CourseName				varchar(50),
	@ExpiredInMonths		int, 
	@CourseGroupID			int, 
	@TrainingGroupID		int,
	@HasVA					bit = 1,
	@IsCritical				bit = 0,
	@IsOrientation 			bit = 0,
	@EffectiveDate			datetime,
	@NumberOfCriticalDays	int = 0,
	@IsActive				bit = 1,
	@MinPoint				decimal(4,1),
	@MaxPoint				decimal(4,1),
	@LastUpdatedBy			int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	IF @CourseID = 0
	BEGIN
		SELECT TOP 1 @CourseID = [CourseID]
		FROM [dbo].[CR_Course] WITH (NOLOCK)
		WHERE  [CourseName] = @CourseName
				AND [IsActive] = 0
	END
	
	IF EXISTS (SELECT 1
				FROM [dbo].[CR_Course] WITH (NOLOCK) 
				WHERE [CourseID] = @CourseID)
	BEGIN
		--update existing record
		UPDATE	[dbo].[CR_Course] 
		SET		[CourseName]=@CourseName
				,[ExpiredInMonths]=@ExpiredInMonths
				,[CourseGroupID]=@CourseGroupID
				,[TrainingGroupID]=@TrainingGroupID
				,[HasVA]=@HasVA
				,[IsCritical] = @IsCritical
				,[IsOrientation] = @IsOrientation
				,[EffectiveDate] = @EffectiveDate
				,[NumberOfCriticalDays] = @NumberOfCriticalDays
				,[IsActive] = @IsActive
				,[MinPoint] = @MinPoint
				,[MaxPoint] = @MaxPoint
				,[LastUpdated]=GETDATE()
				,[LastUpdatedBy]=@LastUpdatedBy
		WHERE [CourseID]=@CourseID
		--IF (@EffectiveDate IS NOT NULL)
		--BEGIN
		--	--update existing record
		--	UPDATE	[dbo].[CR_Course] 
		--	SET		[CourseName]=@CourseName
		--			,[ExpiredInMonths]=@ExpiredInMonths
		--			,[CourseGroupID]=@CourseGroupID
		--			,[TrainingGroupID]=@TrainingGroupID
		--			,[HasVA]=@HasVA
		--			,[IsCritical] = @IsCritical
		--			,[IsOrientation] = @IsOrientation
		--			,[EffectiveDate] = @EffectiveDate
		--			,[NumberOfCriticalDays] = @NumberOfCriticalDays
		--			,[IsActive] = @IsActive
		--			,[LastUpdated]=GETDATE()
		--			,[LastUpdatedBy]=@LastUpdatedBy
		--	WHERE [CourseID]=@CourseID
		--END
		--ELSE
		--BEGIN
		--	--update existing record
		--	UPDATE	[dbo].[CR_Course] 
		--	SET		[CourseName]=@CourseName
		--			,[ExpiredInMonths]=@ExpiredInMonths
		--			,[CourseGroupID]=@CourseGroupID
		--			,[TrainingGroupID]=@TrainingGroupID
		--			,[HasVA]=@HasVA
		--			,[IsCritical] = @IsCritical
		--			,[IsOrientation] = @IsOrientation
		--			,[EffectiveDate] = NULL
		--			,[NumberOfCriticalDays] = @NumberOfCriticalDays
		--			,[IsActive] = @IsActive
		--			,[LastUpdated]=GETDATE()
		--			,[LastUpdatedBy]=@LastUpdatedBy
		--	WHERE [CourseID]=@CourseID
		--END
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_Course] ([CourseName], [ExpiredInMonths], [CourseGroupID], [TrainingGroupID]
		, [HasVA]
		, [IsCritical]
		, [IsOrientation]
		, [EffectiveDate]
		, [NumberOfCriticalDays]
		, [IsActive]
		, [MinPoint]
		, [MaxPoint]
		, [LastUpdated], [LastUpdatedBy])
		VALUES (@CourseName, @ExpiredInMonths, @CourseGroupID, @TrainingGroupID
		, @HasVA
		, @IsCritical
		, @IsOrientation
		, @EffectiveDate
		, @NumberOfCriticalDays
		, @IsActive -- [IsActive]
		, @MinPoint
		, @MaxPoint
		, GETDATE(), @LastUpdatedBy)
		SET @CourseID=SCOPE_IDENTITY()
		
	END

	EXEC [dbo].[CR_Course_Select] @CourseID
END


