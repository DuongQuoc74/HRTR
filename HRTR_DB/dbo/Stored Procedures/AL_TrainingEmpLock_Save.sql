
CREATE PROC [dbo].[AL_TrainingEmpLock_Save] 
(
	@LockID				int, 
	@EmployeeID			varchar(20), 
	@EmployeeIDSAP		varchar(20),
	@UserName			nvarchar(50),
	@EmployeeName		nvarchar(100),
	@TrainingCodeID		nvarchar(100),
	@Description		nvarchar(250),
	@DueDate			datetime,
	@ExtendDay			smallint,
	@CompleteDate		datetime,
	@ExtendFromDate		datetime,
	@IsActive			bit, 
	@LastUpdatedBy		int,
	@IsDL		        int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @WDNo	nvarchar(20) = ''
	IF EXISTS ( SELECT  1
				FROM	[dbo].[AL_TrainingAutoLock] WITH ( NOLOCK )
				WHERE	[LockID] != @LockID AND [UserName] = @UserName AND [TrainingCodeID] = @TrainingCodeID AND [IsDL] = @IsDL)
	BEGIN
		RAISERROR('Duplicate User Name and Training Code ID.', 16, 1)
		RETURN
	END

	SELECT TOP 1 @WDNo = [WDNo]
	FROM [dbo].[HR_Employee] WITH (NOLOCK)
	WHERE [EmployeeID] = @EmployeeID AND [EmployeeID] != ''
	SET @WDNo = ISNULL(@WDNo, '')

	IF @WDNo = ''
	BEGIN
		SELECT TOP 1 @WDNo = [WDNo]
		FROM [dbo].[HR_Employee] WITH (NOLOCK)
		WHERE [EmployeeIDSAP] = @EmployeeIDSAP AND [EmployeeIDSAP] != ''
		SET @WDNo = ISNULL(@WDNo, '')
	END

	IF @WDNo = ''
	BEGIN
		SELECT TOP 1 @WDNo = [WDNo]
		FROM [dbo].[HR_Employee] WITH (NOLOCK)
		WHERE [UserName] = @UserName AND [UserName] != ''
		SET @WDNo = ISNULL(@WDNo, '')
	END

	IF EXISTS ( SELECT  1
				FROM    [dbo].[AL_TrainingAutoLock] WITH ( NOLOCK )
				WHERE   [LockID] = @LockID ) 
		BEGIN
			--update existing record
			UPDATE  [dbo].[AL_TrainingAutoLock]
			SET     [EmployeeID] = @EmployeeID ,
					[WDNo] = @WDNo,
					[EmployeeIDSAP] = @EmployeeIDSAP ,
					[UserName] = @UserName ,
					[EmployeeName] = @EmployeeName ,
					[TrainingCodeID] = @TrainingCodeID ,
					[Description] = @Description ,
					[DueDate] = @DueDate ,
					[ExtendDay] = @ExtendDay ,
					[ExtendFromDate] = @ExtendFromDate ,
					[CompleteDate] = @CompleteDate ,
					[IsActive] = @IsActive ,
					[LastUpdated] = GETDATE() ,
					[LastUpdatedBy] = @LastUpdatedBy,
					[IsDL] = @IsDL
			WHERE   [LockID] = @LockID
		END
	ELSE 
		BEGIN
			--insert new record
			INSERT  INTO [dbo].[AL_TrainingAutoLock]
					( [EmployeeID] ,
					  [WDNo] , 
					  [EmployeeIDSAP] ,
					  [UserName] ,
					  [EmployeeName] ,
					  [TrainingCodeID] ,
					  [Description] ,
					  [DueDate] ,
					  [ExtendDay] ,
					  [ExtendFromDate] ,
					  [CompleteDate] ,
					  [IsActive] ,
					  [LastUpdated] ,
					  [LastUpdatedBy],
					  [IsDL]
					)
			VALUES  ( @EmployeeID ,
					  @WDNo ,
					  @EmployeeIDSAP ,
					  @UserName ,
					  @EmployeeName ,
					  @TrainingCodeID ,
					  @Description ,
					  @DueDate ,
					  @ExtendDay ,
					  @ExtendFromDate ,
					  @CompleteDate ,
					  @IsActive ,
					  GETDATE() ,
					  @LastUpdatedBy,
					  @IsDL
					) 
		END
END

