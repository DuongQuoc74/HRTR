
-- For MES Moving Back HCM Project
CREATE PROCEDURE [dbo].[TL_Check] 
(
	@TerminalName	varchar(50),
	@UserName		varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO [dbo].[TL_Logs](
	[EmployeeID_ID]
      ,[UserName]
      ,[TerminalName]
      ,[LastUpdated]
      ,[LastUpdatedBy])
	VALUES(
	0
	, @UserName
	, @TerminalName
	, GETDATE()
	, -1)
--//0: Admin, just exit
--           ///1: Just exit
--           ///2: Under construction
--           ///3: obsolete
	DECLARE @StatusID		int = 2
			, @CurrentDate	datetime
	SET @CurrentDate = GETDATE()
	IF  EXISTS (SELECT	1
						FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
						WHERE	[TerminalName] = @TerminalName
								AND [IsVA] = 0)
		AND @TerminalName LIKE 'SINHCMTRM%'
		--AND (NOT EXISTS (SELECT 1
		--	  FROM [dbo].[HR_Employee] WITH (NOLOCK)
		--		WHERE [UserName] = @UserName
		--				AND [DepartmentID] = 7)
		--)
	BEGIN
		SET @StatusID = 3 -- 3: obsolete
	END
	
	ELSE
	BEGIN
		IF @CurrentDate <= '2015-12-30 08:00:00.000'
		BEGIN
			--PRINT 'A'
			IF EXISTS (SELECT	1
						FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
						WHERE	[TerminalName] = @TerminalName
								AND [IsVA] = 0)
				AND @TerminalName LIKE 'SINHCMTRM%'
			BEGIN
				SET @StatusID = 1 -- Just exit
			END
			ELSE IF @TerminalName LIKE 'VNHCMM0TRM%'
			BEGIN
				SET @StatusID = 2 -- Under construction
			END
		END
		ELSE
		BEGIN
			--PRINT 'A'
			IF EXISTS (SELECT	1
						FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
						WHERE	[TerminalName] = @TerminalName
								AND [IsVA] = 0)
				AND @TerminalName LIKE 'SINHCMTRM%'
			BEGIN
				SET @StatusID = 3 -- 3: obsolete
			END
			ELSE IF @TerminalName LIKE 'VNHCMM0TRM%'
			BEGIN
				SET @StatusID = 0 -- 1: Just exit
			END
		END
	END
	IF  EXISTS (SELECT	1
						FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
						WHERE	[TerminalName] = @TerminalName
								AND [IsVA] = 1)
		AND @TerminalName LIKE 'SINHCMTRMVA%'
		--AND (NOT EXISTS (SELECT 1
		--	  FROM [dbo].[HR_Employee] WITH (NOLOCK)
		--		WHERE [UserName] = @UserName
		--				AND [DepartmentID] = 7)
		--	)
	BEGIN
		SET @StatusID = 4 -- 3: obsolete
	END
	IF @TerminalName LIKE 'HCMIT018'
	BEGIN
		SET @StatusID = 4 -- 3: obsolete
	END
	--SET @StatusID = 4 -- 3: obsolete
	--SET @StatusID = 2
	--IF @UserName = 'ThanhH1' OR @UserName = 'NguyenN28'
	--	SET @StatusID = 1 
	SELECT @StatusID AS [StatusID]
END

