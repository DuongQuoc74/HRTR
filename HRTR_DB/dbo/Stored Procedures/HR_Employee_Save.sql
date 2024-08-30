CREATE PROC [dbo].[HR_Employee_Save] 
(
	@EmployeeID_ID		int = 0, 
	@EmployeeID			nvarchar(20), 
	@EmployeeIDSAP		nvarchar(20), 
	@WDNo				nvarchar(20) = '',
	@EmployeeName		nvarchar(100), 
	@OperatorGroupID	int, 
	@CompanyID			int, 
	@DepartmentID		int, 
	@JobTitle			varchar(50), 
	@PositionID			int, 
	--@ShiftID			int,
	@WorkcellID			int,
	@Supervisor			nvarchar(100),
	@JoinedDate			datetime,
	@IsActive			bit, 
	@IsSupervisor		bit, 
	@WorkingStatusID	int = 6,--04. Làm việc bình thường (Normal Working)
	@UserName			varchar(50),
	@LastUpdatedBy		int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ErrorMessage		nvarchar(255)
			, @EmployeeIDO		varchar(10)
			--, @WorkingStatusID	int = 6 --04. Làm việc bình thường (Normal Working)
	IF ISNUMERIC(@EmployeeID) = 1
	BEGIN
		SET @EmployeeID = CONVERT(VARCHAR, CONVERT(INT, @EmployeeID))
	END
	SELECT TOP 1 @EmployeeIDO = [EmployeeID]
	FROM	[dbo].[HR_Employee] WITH (NOLOCK) 		
	WHERE	[UserName] = @UserName
			AND [EmployeeID_ID] != @EmployeeID_ID
	SET @EmployeeIDO = ISNULL(@EmployeeIDO, '')
	IF @EmployeeIDO <> ''
	BEGIN
		SET @ErrorMessage = N'User Name (NTID) has been assigned to Employee ID [' + @EmployeeIDO + N'].'
		RAISERROR(@ErrorMessage, 16, 1)
		RETURN
	END
	IF EXISTS (SELECT	1
				FROM	[dbo].[HR_Employee] WITH (NOLOCK) 
				WHERE	[EmployeeID_ID]=@EmployeeID_ID)
	BEGIN
		--De-active resigned user
		IF @WorkingStatusID = 7
		BEGIN
			SET @IsActive = 0
		END
		--De-active training records of user has changed from DL to IL
		UPDATE A
		SET A.[IsActive] = 0, A.[Comments] = 'The user has changed from DL to IL'
		FROM [dbo].[TrainingRecord] A INNER JOIN [dbo].[HR_Employee] B 
		ON A.EmployeeID = B.EmployeeID
		WHERE B.PositionID = 1 AND @PositionID = 2 AND B.EmployeeID = @EmployeeID

		--update existing record
		UPDATE	[dbo].[HR_Employee] 
		SET		[EmployeeIDSAP]=@EmployeeIDSAP
				, [EmployeeName]=@EmployeeName
				, [OperatorGroupID]=@OperatorGroupID
				, [CompanyID]=@CompanyID
				, [DepartmentID]=@DepartmentID
				, [JobTitle]=@JobTitle
				, [PositionID]=@PositionID 
				--, [ShiftID]=@ShiftID
				, [WorkcellID]=@WorkcellID
				, [Supervisor]=@Supervisor
				, [IsActive]=@IsActive
				, [IsSupervisor]=@IsSupervisor
				, [WorkingStatusID]=@WorkingStatusID
				, [LastUpdated]=GETDATE()
				, [LastUpdatedBy]=@LastUpdatedBy
				, [JoinedDate]= @JoinedDate
				, [UserName]= @UserName
		WHERE [EmployeeID_ID]=@EmployeeID_ID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[HR_Employee] ([EmployeeID], [EmployeeIDSAP], [WDNo]
		, [UserName]
		, [IsSupervisor]
		, [EmployeeName], [OperatorGroupID], [CompanyID], [DepartmentID], [JobTitle], [PositionID]
		--, [ShiftID]
		, [WorkcellID], [Supervisor], [IsActive], [LastUpdated], [LastUpdatedBy], [JoinedDate], [WorkingStatusID])
		VALUES (@EmployeeID, @EmployeeIDSAP, @WDNo
		, @UserName
		, @IsSupervisor
		, @EmployeeName, @OperatorGroupID, @CompanyID, @DepartmentID, @JobTitle, @PositionID
		--, @ShiftID
		, @WorkcellID, @Supervisor, @IsActive, GETDATE(), @LastUpdatedBy, @JoinedDate, @WorkingStatusID)
		SET @EmployeeID_ID=SCOPE_IDENTITY()
		
	END
	EXEC [dbo].[HR_Employee_Select] @EmployeeID_ID

END