

CREATE PROCEDURE [dbo].[CCS_AuthenticationLog_Create_20160323] 
(
	@EmployeeID_ID	INT,
	@CourseID		INT,
	@ClientName		VARCHAR(50),	
	@UserName		VARCHAR(50),
	@IsSupervisor	BIT,
	@IsVA			BIT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ExpDate							DATETIME
			, @TimeVA							INT
			, @DocumentID						UNIQUEIDENTIFIER
			, @CCS_AuthenticationLogID			INT
			, @CourseExpiredAlert				INT
			, @AlertDay							INT = -1
			, @Tmp								INT
			, @IsValid							BIT = 1
			, @IsUnderstand						BIT = 1

	SELECT TOP 1 @CCS_AuthenticationLogID = [CCS_AuthenticationLogID]
	FROM		[dbo].[CCS_AuthenticationLog] WITH (NOLOCK)
	WHERE		[EmployeeID_ID] = @EmployeeID_ID
	ORDER BY  [CCS_AuthenticationLogID] DESC

	
	UPDATE [dbo].[CCS_AuthenticationLog]
	SET		
			--[UserName] = <UserName, varchar(50),>
			--,[EmployeeID_ID] = <EmployeeID_ID, int,>
			--,[ClientName] = <ClientName, varchar(150),>
			--,[LoginTime] = <LoginTime, datetime,>
			--,[IsSupervisor] = @IsSupervisor
			--,[LogoffTime] = <LogoffTime, datetime,>
			--,[IsValid] = <IsValid, bit,>
			--,
			[CourseID] = @CourseID
			, [IsCCS] = 1
			--,[IsUnderstand] = <IsUnderstand, bit,>
			--,[DocumentID] = <DocumentID, uniqueidentifier,>
			,[LastUpdated] = GETDATE()
			,[LastUpdatedBy] = @EmployeeID_ID
	WHERE [CCS_AuthenticationLogID] = @CCS_AuthenticationLogID

	IF (@IsSupervisor = 0)
	BEGIN
		SELECT TOP 1 @ExpDate = ISNULL([ExpDate], '2100-01-01')
		FROM		[dbo].[TrainingRecord_V1] WITH (NOLOCK)
		WHERE		[EmployeeID_ID] = @EmployeeID_ID 
					AND [CourseID] = @CourseID 
					AND [IsActive] = 1
		
		
		
		IF (@ExpDate IS NOT NULL)
		BEGIN
			SET @Tmp = DATEDIFF(DAY, GETDATE(), @ExpDate)
			IF (@Tmp < 0)
			BEGIN
				--SELECT -2 --Khoa hoc nay da bi expire.
				RAISERROR(N'Chứng nhận cho công đoạn này của bạn đã bị hết hạn. Vui lòng liên hệ bộ phận đào tạo để được đào tạo lại.', 16, 1)
				RETURN;				
			END
			ELSE
			BEGIN				
				SELECT	TOP 1 @CourseExpiredAlert = ISNULL([Value], 14) 
				FROM	[dbo].[CCS_Config] WITH (NOLOCK)
				WHERE	[ConfigID] = 10 -- Course Expired Alert
				
				IF (@CourseExpiredAlert IS NULL) 
					SET @CourseExpiredAlert = 14
					
				IF (@Tmp <= @CourseExpiredAlert)
				BEGIN
					SET @AlertDay = @Tmp
				END
			END
		END
		ELSE
		BEGIN
			--SELECT -1 --Chua duoc dao tao khoa hoc nay.
			RAISERROR(N'Bạn chưa được đào tạo công đoạn này.', 16, 1)
			RETURN;
		END
	END
	
	IF	(@IsVA = 0 
		AND EXISTS (SELECT 1 
						FROM	[dbo].[CR_Course] WITH (NOLOCK) 
						WHERE	[CourseID] = @CourseID 
								AND [HasVA] = 1)
		)
	BEGIN
		IF EXISTS (SELECT 1 
					FROM [dbo].[CR_CourseStation] WITH (NOLOCK)
					WHERE [CourseID] = @CourseID 
					--AND [StationID] <> 0
					)
		BEGIN
			SELECT TOP 1 @TimeVA = ISNULL([Value], 480) 
			FROM [dbo].[CCS_Config] WITH (NOLOCK)
			WHERE [ConfigID] = 6 -- Time VA To Alert
			
			IF (@TimeVA IS NULL) 
				SET @TimeVA = 480
				
			SELECT TOP 1 @DocumentID = [DocumentID]
			FROM	[dbo].[CCS_AuthenticationLog] WITH (NOLOCK)
			WHERE	[EmployeeID_ID] = @EmployeeID_ID
						AND [CourseID] = @CourseID
						AND [DocumentID] IS NOT NULL
						AND DATEDIFF(MI, [LoginTime], GETDATE()) <= @TimeVA
						--AND DATEADD(MINUTE, @TimeVA, [LoginTime]) > GETDATE()
			ORDER BY [CCS_AuthenticationLogID] DESC
			
			IF (@DocumentID IS NULL)
			BEGIN
				RAISERROR(N'Bạn chưa mở VA. Vui lòng mở VA trước khi mở MES.', 16, 1)
				RETURN;
			END
			
		END
	END
	
	--INSERT INTO [dbo].[CCS_AuthenticationLog] (
	--	 [UserName]
	--	  ,[EmployeeID_ID]
	--	  ,[ClientName]
	--	  ,[LoginTime]
	--	  ,[IsSupervisor]
	--	  --,[LogoffTime]
	--	  ,[IsValid]
	--	  ,[CourseID]
	--	  ,[IsUnderstand]
	--	  ,[DocumentID]
	--	  ,[LastUpdated]
	--	  ,[LastUpdatedBy]
           
	--	)
	--VALUES (
	--	@UserName
	--	  ,@EmployeeID_ID
	--	  ,@ClientName
	--	  ,GETDATE()
	--	  ,@IsSupervisor
	--	  --,NULL
	--	  ,@IsValid
	--	  ,@CourseID
	--	  ,@IsUnderstand
	--	  ,@DocumentID
	--	  ,GETDATE()
	--	  ,@EmployeeID_ID
	--	)
	
	--SET @CCS_AuthenticationLogID = SCOPE_IDENTITY()
	
	SELECT @CCS_AuthenticationLogID AS [CCS_AuthenticationLogID]
			, @AlertDay AS [AlertDay]
	
	--RETURN 0
END


