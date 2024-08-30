CREATE PROC [dbo].[CCS_AuthenticationLog_Search] 
(
	@LoginTimeFrom				datetime,
	@LoginTimeTo				datetime,
	@EmployeeID					varchar(10),
	@UserName					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
				, @EmployeeID_ID				int = 0
	SET @ParmDef = N'@EmployeeID_ID				int,
					@LoginTimeFrom				datetime,
					@LoginTimeTo				datetime,
					@UserName					varchar(50)'			
	
	SET @Query = N'SELECT A.[UserName] AS [User Name]
	,B.[EmployeeID] AS [Employee ID]
	,B.[EmployeeIDSAP] AS [Employee ID SAP]
	,B.[EmployeeName] AS [Employee Name]
	,A.[ClientName] AS [Client Name]
	,A.[TerminalName] AS [Terminal Name]
	,C.[Route]
	,C.[StationName] AS [Station]
	,A.[LoginTime] AS [Login Time]
	,A.[IsSupervisor] AS [Supervisor?]
	,A.[LogoffTime] AS [Logoff Time]
	FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)		
	INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID] 
	LEFT OUTER JOIN [dbo].[GC_RoutesClients_V1] C WITH (NOLOCK) ON A.[ClientName] = C.[ClientName]'

	IF @EmployeeID != ''
	BEGIN
		SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
		FROM [dbo].[HR_Employee] B WITH (NOLOCK)
		--WHERE B.[EmployeeID] = @EmployeeID
		WHERE B.[EmployeeIDSAP] = @EmployeeID
	END
	--ELSE IF @UserName != ''
	--BEGIN
	--	SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
	--	FROM [dbo].[HR_Employee] B WITH (NOLOCK)
	--	--WHERE B.[EmployeeID] = @EmployeeID
	--	WHERE B.[EmployeeIDSAP] = @EmployeeID
	--END
	

	SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, 0)
	SET @Query2 = ''
	IF @EmployeeID_ID != 0
		SET @Query2 = @Query2 + N' AND A.[EmployeeID_ID] = @EmployeeID_ID'	

	IF @EmployeeID = '' AND @UserName = ''
	BEGIN
		SET @Query2 = @Query2 + N' AND A.[EmployeeID_ID] = 0'	
	END

	IF @LoginTimeFrom IS NOT NULL
	BEGIN
		SET @LoginTimeFrom = CONVERT(VARCHAR(10), @LoginTimeFrom , 120)  + ' 00:00:00.000' 
		SET @Query2 = @Query2 + N' AND A.[LoginTime] >= @LoginTimeFrom'
	END
	IF @LoginTimeTo IS NOT NULL
	BEGIN
		SET @LoginTimeTo = CONVERT(VARCHAR(10), @LoginTimeTo , 120)  + ' 23:59:59.990' 
		SET @Query2 = @Query2 + N' AND A.[LoginTime] <= @LoginTimeTo'
	END
	IF @UserName != ''
		SET @Query2 = @Query2 + N' AND A.[UserName] = @UserName'	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
	SET @Query = @Query + @Query2 + N' ORDER BY A.[LoginTime] DESC'
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @EmployeeID_ID
								, @LoginTimeFrom
								, @LoginTimeTo
								, @UserName
								
END


