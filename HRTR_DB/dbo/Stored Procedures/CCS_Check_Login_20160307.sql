
CREATE PROC [dbo].[CCS_Check_Login_20160307]
(
	@UserName			varchar(50),
	@ClientName			varchar(150),
	@TerminalName		varchar(150)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @WorkcellID			int
			, @EmployeeID_ID	int
			, @EmployeeID		varchar(10)
			, @EmployeeName		nvarchar(100)
			, @IsVA				bit
			, @IsBlockedGC		bit = 0
			, @IsSupervisor		bit
			, @CourseID			int = 0
			, @IsUnderstand		bit = 0
			, @PositionID		int
			, @ServerMessageID	int = 1-- 1: Normal (for alert), 2: Message
			, @ServerMessage	nvarchar(500) = ''
	SELECT TOP 1 @EmployeeID_ID = EmployeeID_ID
					, @EmployeeID = [EmployeeID]
					, @EmployeeName = [EmployeeName]
					, @WorkcellID = [WorkcellID]
					, @PositionID = [PositionID]
    FROM	[dbo].[HR_Employee] WITH (NOLOCK)
    WHERE	[UserName] = @UserName 
			AND [IsActive] = 1
    SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, -1)
    SET @EmployeeID = ISNULL(@EmployeeID, 'Unknown')
    SET @EmployeeName = ISNULL(@EmployeeName, 'Unknown')
    SET @WorkcellID = ISNULL(@WorkcellID, -1)
    SET @PositionID = ISNULL(@PositionID, 1)
    IF @EmployeeID_ID != -1
    BEGIN
		IF EXISTS (SELECT 1
					FROM [dbo].[GC_BlockLogs] WITH (NOLOCK)
					WHERE [EmployeeID_ID] = @EmployeeID_ID
							AND [IsBlocked] = 1
							AND [IsConfirmed] = 0)
		BEGIN
			SET @IsBlockedGC = 1
		END
    END
    --PRINT @EmployeeID_ID
    --PRINT @EmployeeID
    --PRINT @EmployeeName
    --PRINT @WorkcellID
    --PRINT @PositionID
    --RETURN
    
    INSERT INTO [dbo].[CCS_AuthenticationLog] (
		[UserName]
		  ,[EmployeeID_ID]
		  ,[ClientName]
		  ,[LoginTime]
		  ,[IsSupervisor]
		  --,[LogoffTime]
		  --,[IsValid]
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
		  --,NULL
		  --,@IsValid
		  ,@CourseID
		  ,@IsUnderstand
		  ,NULL -- @DocumentID
		  ,@TerminalName
		  ,GETDATE()
		  ,@EmployeeID_ID
		)
    
 --   IF EXISTS (SELECT	1
	--			FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
	--			WHERE	[TerminalName] = @TerminalName
	--					AND [IsVA] = 1)
	--	AND @TerminalName LIKE 'VNHCMM0TRMVA%'
	--	--AND NOT EXISTS (SELECT 1
	--	--	  FROM [dbo].[HR_Employee] WITH (NOLOCK)
	--	--		WHERE [UserName] = @UserName
	--	--				AND [DepartmentID] = 7)
	--	--AND NOT (@UserName IN ('NguyenC10'))
	--BEGIN
	--	SET @PositionID = 1 -- DL
	--	SET @WorkcellID = 1	-- DL
	--	SET @EmployeeID_ID = -1
	--END
	
    IF (@PositionID != 1) -- !DL
    BEGIN
		--PRINT 'Khong applied cho IL'
		RETURN
    END
	
	IF (@WorkcellID != -1)
	BEGIN
		IF NOT EXISTS (SELECT 1
						FROM [dbo].[CR_Workcell] WITH (NOLOCK)
						WHERE [WorkcellID] = @WorkcellID
							AND ISNULL([IsAppliedCCS], 0) = 1
					)
		BEGIN
			--PRINT 'Chua applied cho WC cua Employee nay'
			RETURN
		END
	END
--PRINT @PositionID
--PRINT @WorkcellID
--PRINT @EmployeeID_ID
	SELECT TOP 1 @IsVA = ISNULL([IsVA], 0)
	FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
	WHERE [TerminalName] = @TerminalName
	-- Neu chua duoc xet trong table Terminal thi mac dinh la MES server
	SET @IsVA = ISNULL(@IsVA, 0) 
	
	--IF @UserName = 'LeM12' AND @IsBlockedGC = 1
	--BEGIN
	--	SET @IsBlockedGC = 1
	--END
	--ELSE
	--BEGIN
	--SET @IsBlockedGC = 0
	--END
	
	--IF @UserName = 'NguyenN28'
	--	SET @IsBlockedGC = 1
	
	SELECT  @EmployeeID_ID AS [EmployeeID_ID]
			, @EmployeeID AS [EmployeeID]
			, @EmployeeName AS [EmployeeName]
			, @IsVA AS [IsVA]
			, @IsBlockedGC AS [IsBlockedGC]		
			, @ServerMessageID AS [ServerMessageID]	
			, @ServerMessage AS [ServerMessage]
	--PRINT 'Applied cho WC cua Employee nay'
	RETURN	

END






