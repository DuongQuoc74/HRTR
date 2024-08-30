


-- From CCS V1.0.0.3
-- V1.0.0.3
CREATE PROC [dbo].[CCS_AuthenticationLog_Start_20170222]
(
	@UserName			varchar(50),
	@ClientName			varchar(150),
	@TerminalName		varchar(150),
	@ProductName		nvarchar(50) = '',
	@ProductVersion		nvarchar(50) = ''
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @CCS_AuthenticationLogID	int = 0
			, @WorkcellID			int
			, @EmployeeID_ID	int
			, @EmployeeID		varchar(10)
			, @EmployeeIDSAP	varchar(20)
			, @EmployeeName		nvarchar(100)

			, @IsCCS			bit = 1
			, @IsDL				bit = 0
			, @IsVA				bit
			, @MESFullPath		nvarchar(255) = 'C:\Program Files\MES\MES.exe'
			
			, @IsSupervisor		bit = 0
			, @CourseID			int = 0
			, @IsUnderstand		bit = 0
			, @PositionID		int
			, @DepartmentID		int
		
			-- e Grape Chart
			, @IsBlockedGC				bit = 0
			, @eGrapeChartFullPath		nvarchar(255) = 'C:\Program Files\Jabil Circuit\e Grape Chart\eGrapeChartWpf.exe'
			, @EstimatedBlockedDateGC	datetime

			, @ServerStatusID	int = 1-- 1: Normal (for alert), 2: Message
			, @ServerMessage	nvarchar(500) = ''
			, @Found					bit = 0
	SELECT TOP 1 @EmployeeID_ID = EmployeeID_ID
					, @EmployeeID = [EmployeeID]
					, @EmployeeIDSAP = [EmployeeIDSAP]
					, @EmployeeName = [EmployeeName]
					, @WorkcellID = [WorkcellID]
					, @PositionID = [PositionID]
					, @DepartmentID = [DepartmentID]
    FROM	[dbo].[HR_Employee] WITH (NOLOCK)
    WHERE	[UserName] = @UserName 
			AND [IsActive] = 1

    SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, -1)
    SET @EmployeeID = ISNULL(@EmployeeID, 'Unknown')
    SET @EmployeeIDSAP = ISNULL(@EmployeeIDSAP, 'Unknown')
    SET @EmployeeName = ISNULL(@EmployeeName, 'Unknown')
    SET @WorkcellID = ISNULL(@WorkcellID, -1)
    SET @PositionID = ISNULL(@PositionID, 1)
	SET @DepartmentID = ISNULL(@DepartmentID, -1)
    IF @EmployeeID_ID != -1
    BEGIN
		SELECT TOP 1 @IsBlockedGC = ISNULL([IsBlocked], 0)
					, @EstimatedBlockedDateGC = [dbo].[ufn_GC_BlockedDate](3, [CreatedDate])
					, @Found = 1
		FROM [dbo].[GC_BlockLogs] WITH (NOLOCK)
		WHERE [EmployeeID_ID] = @EmployeeID_ID
				AND [IsConfirmed] = 0
		SET @IsBlockedGC = ISNULL(@IsBlockedGC, 0)		
		IF @Found = 1 AND @IsBlockedGC = 0 
		BEGIN
			SET @ServerStatusID = 1
			SET @ServerMessage = N'User [' + @UserName + N'] còn [' 
			+ [dbo].[ufn_DATEDIFF] (GETDATE(), @EstimatedBlockedDateGC) + N'] nữa sẽ bị khóa trên hệ thống e Grape Chart.' 
			+ N' Vui lòng liên hệ Line Trainers & Trainers của bạn để kiểm tra.' 
			+ N' Please contact Line Trainers & Trainers to conduct refresher course.'
		END
		ELSE IF @IsBlockedGC = 1
		BEGIN
			SET @ServerStatusID = 2
			SET @ServerMessage = N'User [' + @UserName + N'] đang bị khóa trên hệ thống e Grape Chart. Vui lòng liên hệ bộ phận đào tạo để kiểm tra.' 
			+ N' User [' + @UserName + N'] is blocked by e Grape Chart system.'
			+ N' Please contact Line Trainers & HR Trainers to conduct refresher course.'
		END
    END

	SELECT TOP 1 @IsCCS = ISNULL([IsCCS], 1)
	FROM [dbo].[CR_Workcell] WITH (NOLOCK)
	WHERE [WorkcellID] = @WorkcellID
	SET @IsCCS = ISNULL(@IsCCS, 1)
	IF @DepartmentID = 7 --IT 
	BEGIN
		SET @IsCCS = 0
	END
    INSERT INTO [dbo].[CCS_AuthenticationLog] (
		[UserName]
		  ,[EmployeeID_ID]
		  ,[ClientName]
		  ,[LoginTime]
		  ,[IsSupervisor]
		  ,[IsCCS]
		  ,[CourseID]
		  ,[IsUnderstand]
		  ,[DocumentID]
		  ,[TerminalName]
		  ,[LastUpdated]
		  ,[LastUpdatedBy]         
		)
	VALUES (
		@UserName
		  ,@EmployeeID_ID
		  ,@ClientName
		  ,GETDATE()
		  ,@IsSupervisor
		  ,@IsCCS
		  ,@CourseID
		  ,@IsUnderstand
		  ,NULL -- @DocumentID
		  ,@TerminalName
		  ,GETDATE()
		  ,@EmployeeID_ID
		)
	SET @CCS_AuthenticationLogID = SCOPE_IDENTITY()
    IF @PositionID = 1
	BEGIN
		SET @IsDL = 1
	END
	--Temp, not applied for IL
	IF @IsDL = 0
	BEGIN
		SET @IsCCS = 0
	END

	
--PRINT @PositionID
--PRINT @WorkcellID
--PRINT @EmployeeID_ID
	SELECT TOP 1 @IsVA = ISNULL([IsVA], 0)
			, @MESFullPath = ISNULL([MESFullPath], '')
			, @eGrapeChartFullPath = ISNULL([eGrapeChartFullPath], '')
			, @ServerStatusID = (CASE WHEN @ServerMessage = '' THEN [ServerStatusID] ELSE @ServerStatusID END)
	FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
	WHERE [TerminalName] = @TerminalName
	-- Neu chua duoc xet trong table Terminal thi mac dinh la MES server
	SET @IsVA = ISNULL(@IsVA, 0) 
	IF @ServerStatusID NOT IN (1, 2)
	BEGIN
		SELECT TOP 1 @ServerMessage = [ServerMessage]
		FROM [dbo].[CCS_ServerStatus] WITH (NOLOCK)
		WHERE [ServerStatusID] = @ServerStatusID
	END
	-- Auto add new server
	IF NOT EXISTS (SELECT 1
				FROM [dbo].[CCS_Terminal] WITH (NOLOCK)
				WHERE [TerminalName] = @TerminalName)
	BEGIN
		IF @TerminalName LIKE '%VA%'
		BEGIN
			SET @IsVA = 1
			SET @eGrapeChartFullPath = 'C:\Program Files (x86)\Jabil Circuit\e Grape Chart\eGrapeChartWpf.exe'
		END
		ELSE
		BEGIN
			SET @IsVA = 0
			SET @eGrapeChartFullPath = 'C:\Program Files\Jabil Circuit\e Grape Chart\eGrapeChartWpf.exe'
		END
		INSERT INTO [dbo].[CCS_Terminal]
           ([TerminalName]
		   ,[MESFullPath]
		   ,[eGrapeChartFullPath]
           ,[IsVA]
           ,[IsActive]
		   ,[ServerStatusID]
           ,[LastUpdatedBy]
           ,[LastUpdated])
		 VALUES
			   (@TerminalName
			   ,@MESFullPath
			   ,@eGrapeChartFullPath
			   ,@IsVA
			   ,1
			   ,1 -- [ServerStatusID] (normal)
			   ,-1
			   ,GETDATE())
	END

	UPDATE [dbo].[CCS_Terminal]
	SET [LastLoginTime] = GETDATE()
		, [ProductName] = @ProductName
		, [ProductVersion] = @ProductVersion
	WHERE [TerminalName] = @TerminalName
	
	SELECT  @CCS_AuthenticationLogID AS [CCS_AuthenticationLogID]
			, @EmployeeID_ID AS [EmployeeID_ID]
			, @EmployeeID AS [EmployeeID]
			, @EmployeeIDSAP AS [EmployeeIDSAP]
			, @EmployeeName AS [EmployeeName]

			, @IsCCS AS [IsCCS]
			, @IsDL AS [IsDL]
			, @IsVA AS [IsVA]
			, @MESFullPath AS [MESFullPath]

			, @eGrapeChartFullPath	AS [eGrapeChartFullPath]

			, @ServerStatusID AS [ServerStatusID]	
			, @ServerMessage AS [ServerMessage]
	RETURN	

END









