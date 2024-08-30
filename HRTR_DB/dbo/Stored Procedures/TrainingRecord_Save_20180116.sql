
CREATE PROC [dbo].[TrainingRecord_Save_20180116] 
(
	@TrainingRecordID	int, 
	@EmployeeID_ID			int = 0, 
	--@EmployeeID			varchar(10), 
	@ProductID			int, 
	@Trainer			nvarchar(100), 
	@CourseID			int, 
	@CertDate			date = NULL, 
	@ExpDate			date = NULL, 
	@Score				decimal(4,1),
	@CertifiedLevelID	int,
	@OJT				bit,
	@LastUpdatedBy		int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	--DECLARE @ExpDate	datetime
	
	IF(YEAR(@CertDate) = 1900)
		SET @CertDate = NULL
	IF(YEAR(@ExpDate) = 1900)
		SET @ExpDate = NULL
		
	IF @CertDate IS NULL AND @OJT = 0
	BEGIN
		--RAISERROR('Certified data must be input.', 16, 1)
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
	
	IF @OJT = 1
	BEGIN
		IF @ExpDate IS NULL 
			SET @ExpDate = DATEADD(DAY, 14, ISNULL(@CertDate, GETDATE()))
	END
	ELSE 
	BEGIN
		SET @ExpDate = NULL
	END
	
	--SET @EmployeeID = LTRIM(RTRIM(@EmployeeID))
	DECLARE @EmployeeID varchar(10)
	SELECT TOP 1 @EmployeeID = [EmployeeID]
	FROM		[dbo].[HR_Employee] WITH (NOLOCK)
	WHERE		[EmployeeID_ID] = @EmployeeID_ID
	
	IF EXISTS (SELECT	1 
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
			[LastUpdated] = GETDATE(),
			[LastUpdatedBy] = @LastUpdatedBy--,
			--[EmployeeID_ID]=@EmployeeID_ID
		WHERE [TrainingRecordID] = @TrainingRecordID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[TrainingRecord] ([EmployeeID_ID], [EmployeeID], [ProductID], [Trainer], [CourseID], [CertDate]
		, [ExpDate]
		, [Score], [CertifiedLevelID]
		, [OJT]
		, [LastUpdated], [LastUpdatedBy])
		VALUES (@EmployeeID_ID, @EmployeeID, @ProductID, @Trainer, @CourseID, @CertDate
		, @ExpDate
		, @Score, @CertifiedLevelID
		, @OJT
		, GETDATE(), @LastUpdatedBy)
		SET @TrainingRecordID = SCOPE_IDENTITY()
	END
	
	--EXEC [dbo].[TrainingRecord_Select] @TrainingRecordID

END



