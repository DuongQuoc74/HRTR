CREATE PROC [dbo].[SC_DomainAccount_Save] 
(
	@UserName		nvarchar(50),
	@EmployeeID			nvarchar(20),
	@EmployeeIDSAP		nvarchar(20),
	@Email				nvarchar(100),
	@DisplayName		nvarchar(100),
	@Department			nvarchar(100),
	@Title				nvarchar(100),
	@Manager			nvarchar(100),
	@Extension			nvarchar(100),
	@Mobile				nvarchar(100),
	@TelephoneNumber	nvarchar(100),
	@CreatedDate		datetime,
	@LastLoggonDate		datetime,
	@PasswordLastSetStr		nvarchar(100) = '',
	@AccountIsDisabled		nvarchar(100),
	@AccountExpires			nvarchar(255) = '',
	@AccountExpiresDateStr	nvarchar(100) = '',
	@IsPasswordNeverExpired	nvarchar(100) = '',
	@LastLogonStr			nvarchar(100) = '',
	@LogonWorkstation		varchar(50) = '',
	@Path					varchar(255) = ''
)
AS
BEGIN
	SET NOCOUNT ON
	--SET @EmployeeID = [dbo].[ufn_TRIM](@EmployeeID)
	--SET @EmployeeIDSAP = [dbo].[ufn_TRIM](@EmployeeIDSAP)
	--SET @Path = REPLACE(@Path, 'LDAP://', '')
	IF YEAR(@CreatedDate) = 1900
		SET @CreatedDate = NULL
		
	IF YEAR(@LastLoggonDate) = 1900
		SET @LastLoggonDate = NULL

	DECLARE @PasswordStatus			nvarchar(255) = ''
			, @ExpiredDate			datetime = NULL
			, @AccountExpiresDate	datetime
			, @PasswordLastSet		datetime
			, @LastLogon			datetime
	IF ISDATE(@PasswordLastSetStr) = 1
	BEGIN
		SET @PasswordLastSet = CONVERT(DATETIME, @PasswordLastSetStr)
	END
	IF YEAR(@PasswordLastSet) = 1900
		SET @PasswordLastSet = NULL
	
	IF ISDATE(@LastLogonStr) = 1
	BEGIN
		SET @LastLogon = CONVERT(DATETIME, @LastLogonStr)
		IF YEAR(@LastLogon) = 1900
			SET @LastLogon = NULL
	END		
		
			
	IF ISDATE(@AccountExpiresDateStr) = 1
	BEGIN
		SET @AccountExpiresDate = CONVERT(DATETIME, @AccountExpiresDateStr)
		IF YEAR(@AccountExpiresDate) = 1900
			SET @AccountExpiresDate = NULL
	END		

	IF @IsPasswordNeverExpired = 'TRUE'
	BEGIN
		SET @PasswordStatus = N'Password never expires'
	END
	ELSE
	BEGIN
		IF @PasswordLastSet IS NOT NULL
		BEGIN
			--IF @AccountExpiresDate IS NULL
				SET @ExpiredDate = DATEADD(DAY, 90, @PasswordLastSet)
			--ELSE
			--	SET @ExpiredDate = @AccountExpiresDate
				
			IF @ExpiredDate >= GETDATE()
				SET @PasswordStatus = N'Expires at: ' + CONVERT(NVARCHAR, @ExpiredDate) --+ N' (' + @AccountExpiresDate + N')'
			ELSE
				SET @PasswordStatus = N'Expired (' + @AccountExpires + N')'
		END
	END
	IF @PasswordLastSet IS NULL 
		AND @LastLoggonDate IS NULL 
		AND @PasswordStatus = ''
		AND @AccountIsDisabled = 'FALSE'
	BEGIN
		SET @PasswordStatus = N'User must change password at next logon.'
	END
	--Expires at: Monday, October 27, 2014

	IF @LastLogon IS NOT NULL 
	BEGIN
		IF @LastLoggonDate IS NULL
		BEGIN
			SET @LastLoggonDate = @LastLogon
		END
		ELSE
		BEGIN
			IF @LastLogon > @LastLoggonDate
			BEGIN
				SET @LastLoggonDate = @LastLogon
			END
		END
	END
	DECLARE @EmployeeID_ID	int = 0
			, @SupervisorID	int = 0
			, @IsNotOnBoard	bit
			, @IsActive		bit
			, @ResignedDate datetime
			, @IsValid		bit
			, @Remarks		nvarchar(255)
	SET @IsValid = 1
	SET @Remarks = N''
	IF @EmployeeID = '' AND @EmployeeIDSAP = ''
	BEGIN
		SET @IsValid = 0
		SET @Remarks = N'Missing Employee ID & Employee ID SAP.'
	END
	
	SET @IsNotOnBoard = ISNULL(@IsNotOnBoard, 0)
	SET @IsActive = ISNULL(@IsActive, 0)
	
	IF @EmployeeID_ID = 0 AND @IsValid = 1
	BEGIN
		SET @IsValid = 0
		SET @Remarks = N'Invalid Employee ID/ Employee ID SAP.'
	END
	IF @IsNotOnBoard = 1 AND @IsValid = 1
	BEGIN
		SET @IsValid = 0
		SET @Remarks = N'Not on board.'
	END
	-- If already resigned but not disable account
	IF @AccountIsDisabled = 'FALSE' AND @IsActive = 0 AND @IsValid = 1
	BEGIN
		SET @IsValid = 0
		SET @Remarks = N'Resigned but still active in Active Directory.'
		IF @ResignedDate IS NOT NULL
		BEGIN
			IF @ResignedDate < @LastLoggonDate
				SET @Remarks = N'Resigned but still active in Active Directory and log on by others.'
		END
		
	END
	-- From @Manager => Manager Display Name => EmployeeID_ID of manager => update SupervisorID
	
	IF LEN(@Manager) >= 10
	BEGIN
		DECLARE @DisplayNameManager nvarchar(100)
			, @Find1				int
			, @Find2				int
		
		SET @Find1 = CHARINDEX('=', @Manager, 0)
		SET @Find2 = CHARINDEX(',', @Manager, 0)
		IF @Find1 + 1 < @Find2 -4
		BEGIN
			SET @DisplayNameManager = SUBSTRING(@Manager, @Find1 + 1, @Find2 - 4)
			SELECT TOP 1 @SupervisorID = [EmployeeID_ID]
			FROM [dbo].[SC_DomainAccount] WITH (NOLOCK)
			WHERE [DisplayName] = @DisplayNameManager
		END
	END
	
	IF EXISTS (SELECT 1
				FROM [dbo].[SC_DomainAccount] WITH (NOLOCK)
				WHERE [UserName] = @UserName
				)
	BEGIN
		UPDATE [dbo].[SC_DomainAccount]
		SET		[EmployeeID_ID] = @EmployeeID_ID
			,[SupervisorID] = @SupervisorID
			,[EmployeeID] = @EmployeeID
			,[EmployeeIDSAP] = @EmployeeIDSAP
			,[Email] = @Email
			,[DisplayName] = @DisplayName
			,[Department] = @Department
			,[Title] = @Title
			,[Manager] = @Manager 
			,[Extension] = @Extension 
			,[Mobile] = @Mobile
			,[TelephoneNumber] = @TelephoneNumber 
			,[CreatedDate] = @CreatedDate
			,[LastLoggonDate] = @LastLoggonDate
			,[PasswordLastSet] = @PasswordLastSet
			,[ExpiredDate] = @ExpiredDate
			,[AccountIsDisabled] = @AccountIsDisabled
			,[PasswordStatus] = @PasswordStatus
			,[AccountExpiresDate] = @AccountExpiresDate
			,[LastLogon] = @LastLogon
			,[IsValid] = @IsValid
			,[Remarks] = @Remarks
			,[LogonWorkstation] = @LogonWorkstation
			--,[IsMES] = 0
			--,[IsMESActive] = 0
			,[Path] = @Path
			,[LastUpdated] = GETDATE()
			,[LastUpdatedBy] = -1
		WHERE [UserName] = @UserName
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[SC_DomainAccount]
			([UserName]
			,[EmployeeID_ID]
			,[SupervisorID]
			,[EmployeeID]
			,[EmployeeIDSAP]
			,[Email]
			,[DisplayName]
			,[Department]
			,[Title]
			,[Manager]
			,[Extension]
			,[Mobile]
			,[TelephoneNumber]
			,[CreatedDate]
			,[LastLoggonDate]
			,[PasswordLastSet]
			,[ExpiredDate]
			,[AccountIsDisabled]
			,[PasswordStatus]
			,[AccountExpiresDate]
			,[LastLogon]
			,[IsServiceAccount]
			,[IsValid]
			,[Remarks]
			,[LogonWorkstation]
			--,[IsMES]
			--,[IsMESActive]
			,[Path]
			,[LastUpdated]
			,[LastUpdatedBy])
		 VALUES
			   (@UserName
			   ,@EmployeeID_ID
			   ,@SupervisorID
			   ,@EmployeeID
			   ,@EmployeeIDSAP
			   ,@Email
			   ,@DisplayName
			   ,@Department
			   ,@Title
			   ,@Manager
			   ,@Extension
			   ,@Mobile
			   ,@TelephoneNumber
			   ,@CreatedDate
			   ,@LastLoggonDate
			   ,@PasswordLastSet
			   ,@ExpiredDate
			   ,@AccountIsDisabled
			   ,@PasswordStatus
			   ,@AccountExpiresDate
			   ,@LastLogon
			   ,0 -- [IsServiceAccount]
			   ,@IsValid
			   ,@Remarks
			   ,@LogonWorkstation
			   --,0 --[IsMES]
			   --,0 --[IsMESActive]
			   ,@Path
			   ,GETDATE()
			   ,-1)
	END
	-- Check Duplicate
	IF @EmployeeID_ID <> 0
	BEGIN
		UPDATE	A
		SET		[IsValid] = 0
				, [Remarks] = N'Duplicate Employee ID.'
				, [LastUpdated] = GETDATE()
				, [LastUpdatedBy] = -1 -- System
		FROM [dbo].[SC_DomainAccount] A WITH (NOLOCK)
					INNER JOIN (SELECT [EmployeeID_ID]
								  FROM [dbo].[SC_DomainAccount] WITH (NOLOCK)
								  WHERE [EmployeeID_ID] = @EmployeeID_ID
										AND [AccountIsDisabled] = 'FALSE'
								  GROUP BY [EmployeeID_ID]
								  HAVING COUNT([EmployeeID_ID])>1) B ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
	END
	
	
END

