


-- From CCS V1.0.0.3
-- V1.0.0.3
CREATE PROCEDURE [dbo].[CCS_AuthenticationLog_Verify_20171011] 
(
	@CCS_AuthenticationLogID	int,
	@EmployeeID_ID				int,
	@UserName					varchar(50),
	@ClientName					varchar(150),
	@TerminalName				varchar(150),
	@CourseID					int,
	@IsSupervisor				bit,
	@SupervisorUserName			varchar(50) = '',
	@IsVA						bit = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ExpDate							DATETIME
			, @TimeVA							INT
			, @DocumentID						UNIQUEIDENTIFIER
			--, @CCS_AuthenticationLogID			INT
			, @ConfigAlertDay					INT
			, @AlertDay							INT = -1
			, @Tmp								INT
			, @IsValid							BIT = 1
			, @IsUnderstand						BIT = 1
			, @IsOJT							BIT = 0
			, @Experience						NVARCHAR(50) = ''
			, @ResetMonths						int = 6
			, @IsBlockedTR		   		        BIT = 0
			, @Found					        BIT = 0
	SELECT TOP 1 @CCS_AuthenticationLogID = [CCS_AuthenticationLogID]
	FROM		[dbo].[CCS_AuthenticationLog] WITH (NOLOCK)
	WHERE		[EmployeeID_ID] = @EmployeeID_ID
				AND [TerminalName] = @TerminalName
	ORDER BY  [CCS_AuthenticationLogID] DESC
	
	UPDATE [dbo].[CCS_AuthenticationLog]
	SET		[CourseID] = @CourseID
			, [IsCCS] = 1
			, [IsSupervisor] = @IsSupervisor
			, [SupervisorUserName] = @SupervisorUserName
			, [LastUpdated] = GETDATE()
			, [LastUpdatedBy] = @EmployeeID_ID
	WHERE [CCS_AuthenticationLogID] = @CCS_AuthenticationLogID

	IF (@IsSupervisor = 0)
	BEGIN
		SELECT TOP 1 @ExpDate = ISNULL([ExpDate], '2100-01-01')
					, @IsOJT = [OJT]
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
				SELECT	TOP 1 @ConfigAlertDay = ISNULL([ConfigValue], 14) 
				FROM	[dbo].[CCS_Config] WITH (NOLOCK)
				WHERE	[ConfigName] = 'AlertDay' -- Course Expired Alert
				
				SET @ConfigAlertDay = ISNULL(@ConfigAlertDay, 14)
					
				IF (@Tmp <= @ConfigAlertDay)
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
		IF @IsOJT = 0
		BEGIN
			--PRINT @EmployeeID_ID
			--PRINT @CourseID
			--PRINT @ResetMonths
			SET @Experience = [dbo].[ufn_GetTrainingRecord_Experience](@EmployeeID_ID, @CourseID, @ResetMonths)
		END
	END
	--TR_Critical - Begin
	SELECT TOP 1 @IsBlockedTR = ISNULL([IsConfirmed], 0)
			, @Found = 1
	FROM [dbo].[TR_BlockLogs] A WITH (NOLOCK)
	LEFT OUTER JOIN [dbo].[TrainingRecord] TR WITH (NOLOCK) ON TR.[TrainingRecordID] = A.[TrainingRecordID]
	LEFT OUTER JOIN [dbo].[CR_Course] CO WITH (NOLOCK) ON CO.[CourseID] = TR.[CourseID]
	WHERE A.[EmployeeID_ID] = @EmployeeID_ID
			AND [IsConfirmed] = 0	
			AND CO.[CourseID] = @CourseID
	IF @Found = 1
	BEGIN
		RAISERROR(N'Bạn đã không đăng nhập để sử dụng kỹ năng này sau một thời gian đã quy định. Vui lòng liên hệ với trainer để được đào tạo lại.', 16, 1)
		RETURN;		
	END				
	--TR_Critical - End
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
					)
		BEGIN
			SELECT TOP 1 @TimeVA = ISNULL([ConfigValue], 480) 
			FROM [dbo].[CCS_Config] WITH (NOLOCK)
			WHERE [ConfigName] = 'TimeAlertVA' -- Time VA To Alert
			SET @TimeVA = ISNULL(@TimeVA, 480)

			SELECT TOP 1 @DocumentID = [DocumentID]
			FROM	[dbo].[CCS_AuthenticationLog] WITH (NOLOCK)
			WHERE	[EmployeeID_ID] = @EmployeeID_ID
						AND [CourseID] = @CourseID
						AND [DocumentID] IS NOT NULL
						AND [LogoffTime] IS NULL
						AND [LoginTime] >= DATEADD(MI, -@TimeVA, GETDATE())
			ORDER BY [CCS_AuthenticationLogID] DESC
			
			IF (@DocumentID IS NULL)
			BEGIN
				RAISERROR(N'Bạn chưa mở VA. Vui lòng mở VA trước khi mở MES.', 16, 1)
				RETURN;
			END
			
		END
	END

	SELECT @CCS_AuthenticationLogID AS [CCS_AuthenticationLogID]
			, @AlertDay AS [AlertDay]
			, @IsOJT AS [OJT]
			, @Experience AS [Experience]
END




