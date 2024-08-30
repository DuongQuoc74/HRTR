
-- From CCS V1.0.0.3
-- Return 0: no log off
-- Return 1: log off
CREATE PROCEDURE [dbo].[CCS_AuthenticationLog_Check] 
(
	@CCS_AuthenticationLogID	int,
	@EmployeeID_ID				int,
	@UserName					varchar(50),
	@ClientName					varchar(150),
	@TerminalName				varchar(150),
	@CourseID					int,
	@IsSupervisor				bit
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @R								bit = 0
			, @IsApplied1Session			bit = 0
			, @IsVA							bit = 0

			, @LoginTime					datetime
			, @Found						bit = 0
			--, @CCS_AuthenticationLogIDO		int = -1	
			--, @ClientNameO					varchar(150) = ''
			, @TerminalNameO				varchar(150) = ''

	SELECT	TOP 1 @IsApplied1Session = ISNULL([ConfigValue], 14) 
	FROM	[dbo].[CCS_Config] WITH (NOLOCK)
	WHERE	[ConfigName] = 'IsApplied1Session' -- Course Expired Alert
	SET @IsApplied1Session = ISNULL(@IsApplied1Session, 0)
	IF @IsApplied1Session = 0
	BEGIN
		SELECT ISNULL(@R, 0)
		RETURN
	END
	SELECT TOP 1 @IsVA = ISNULL([IsVA], 0)
	FROM	[dbo].[CCS_Terminal] WITH (NOLOCK)
	WHERE [TerminalName] = @TerminalName
	-- Neu chua duoc xet trong table Terminal thi mac dinh la MES server
	SET @IsVA = ISNULL(@IsVA, 0) 
	IF NOT EXISTS (SELECT 1
				FROM [dbo].[CCS_Terminal] WITH (NOLOCK)
				WHERE [TerminalName] = @TerminalName)
	BEGIN
		IF @TerminalName LIKE '%VA%'
			SET @IsVA = 1
		ELSE
			SET @IsVA = 0
	END
	SELECT TOP 1 @LoginTime = A.[LoginTime]
	FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)
	WHERE A.[CCS_AuthenticationLogID] = @CCS_AuthenticationLogID
	IF @LoginTime IS NULL
	BEGIN
		SELECT TOP 1 @LoginTime = A.[LoginTime]
		FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)
		WHERE A.[EmployeeID_ID] = @EmployeeID_ID
				AND A.[TerminalName] = @TerminalName
		ORDER BY A.[LoginTime] DESC
	END
	SET @LoginTime = ISNULL(@LoginTime, GETDATE())
	-- latest login record group by VA servers or MES servers	
	SELECT TOP 1 --@ClientNameO = ISNULL(A.[ClientName], '')
				--, 
				@TerminalNameO = ISNULL(A.[TerminalName], '')
				, @Found = 1
	FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)
			INNER JOIN [dbo].[CCS_Terminal] B WITH (NOLOCK) ON A.[TerminalName] = B.[TerminalName]
			AND B.[IsVA] = @IsVA -- group by VA servers or MES servers	
	WHERE A.[EmployeeID_ID] = @EmployeeID_ID
			AND A.[LoginTime] > @LoginTime
	ORDER BY A.[LoginTime] DESC
	--SET @ClientNameO = ISNULL(@ClientNameO, '')
	SET @TerminalNameO = ISNULL(@TerminalNameO, '')
	IF @Found = 1 AND @TerminalNameO <> @TerminalName
	BEGIN
		SET @R = 1
	END

	SELECT ISNULL(@R, 0)
END



