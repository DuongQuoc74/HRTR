CREATE PROC [dbo].[HR_Employee_Search] 
(
	@EmployeeID			nvarchar(255), --delimited by ;
	@WDNo				nvarchar(20) = '',
	@EmployeeIDSAP		nvarchar(20), 
	
	@UserName			varchar(50), 
	@EmployeeName		nvarchar(100), 
	@OperatorGroupID	int, 
	@CompanyID			int, 
	@DepartmentID		int, 
	@JobTitle			varchar(50), 
	@PositionID			int, 
	@WorkcellID			int, 
	@Supervisor			nvarchar(100),
	@IsActive			int,
	@IsSupervisor		int,
	@JoinedDate			datetime = NULL,
	@WorkingStatusID	int = 0,
	@IsWorking			int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
				
	SET @Query = N'SELECT A.[EmployeeID_ID]
		,A.[EmployeeID]
		,A.[WDNo]
		,A.[EmployeeIDSAP]
		,A.[EmployeeName]
		,A.[EmployeeIDName]
		,A.[OperatorGroupName]
		,A.[CompanyName]
		,A.[DepartmentName]
		,A.[JobTitle]
		,A.[PositionName]
		,A.[WorkcellName]
		,A.[Supervisor]
		,A.[IsActive]
		,A.[IsSupervisor]
		,A.[JoinedDate]
		,A.[UserName]
		,A.[WorkingStatusName]
		,A.[IsContract]
		,A.[IsWorking], A.[LastUpdated], B.[UserName] AS [LastUpdatedByUserName]
	FROM	[dbo].[HR_Employee_V] A WITH (NOLOCK) LEFT JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]'
	SET @Query2 = N''
	IF 	@EmployeeID <> ''
		--SET @Query2 = @Query2 + ' AND A.[EmployeeID] LIKE + ''%'' + @EmployeeID + ''%'''	
		SET @Query2 = @Query2 + ' AND A.[EmployeeID] IN (SELECT TRIM([Items]) AS [EmployeeID] FROM [dbo].[Split](@EmployeeID, '';''))'
	IF 	@WDNo <> ''
		SET @Query2 = @Query2 + ' AND A.[WDNo] LIKE + ''%'' + @WDNo + ''%'''

	IF 	@EmployeeIDSAP <> ''
		SET @Query2 = @Query2 + ' AND A.[EmployeeIDSAP] LIKE + ''%'' + @EmployeeIDSAP + ''%'''
	
	IF 	@UserName <> ''
		SET @Query2 = @Query2 + ' AND A.[UserName] LIKE + ''%'' + @UserName + ''%'''	
	IF 	@EmployeeName <> ''
		SET @Query2 = @Query2 + ' AND A.[EmployeeName] LIKE + ''%'' + @EmployeeName + ''%'''	
	IF @OperatorGroupID <> 0 
		SET @Query2 = @Query2 + ' AND A.[OperatorGroupID] = @OperatorGroupID'	
	IF @CompanyID <> 0 
		SET @Query2 = @Query2 + ' AND A.[CompanyID] = @CompanyID'
	IF @DepartmentID <> 0 
		SET @Query2 = @Query2 + ' AND A.[DepartmentID] = @DepartmentID'
	IF 	@JobTitle <> ''
		SET @Query2 = @Query2 + ' AND A.[JobTitle] LIKE + ''%'' + @JobTitle + ''%'''	
	IF @PositionID <> 0 
		SET @Query2 = @Query2 + ' AND A.[PositionID] = @PositionID'
	IF @WorkcellID <> 0 
		SET @Query2 = @Query2 + ' AND A.[WorkcellID] = @WorkcellID'
	IF 	@Supervisor <> ''
		SET @Query2 = @Query2 + ' AND A.[Supervisor] LIKE + ''%'' + @Supervisor + ''%'''	
	IF @IsActive <> -1
		SET @Query2 = @Query2 + ' AND A.[IsActive] = @IsActive'		
	IF @IsSupervisor <> -1 
		SET @Query2 = @Query2 + ' AND A.[IsSupervisor] = @IsSupervisor'	
	IF @WorkingStatusID != 0
		SET @Query2 = @Query2 + ' AND A.[WorkingStatusID] = @WorkingStatusID'
	IF @IsWorking != -1
		SET @Query2 = @Query2 + ' AND A.[IsWorking] = @IsWorking'
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)										
	SET @Query = @Query + @Query2 + N' ORDER BY A.[EmployeeID]'
	SET @ParmDef = '@EmployeeID nvarchar(255), 
					@WDNo	nvarchar(20),
					@EmployeeIDSAP nvarchar(20), 
					@UserName	varchar(50), 
					@EmployeeName nvarchar(100), 
					@OperatorGroupID int, 
					@CompanyID int, 
					@DepartmentID int, 
					@JobTitle varchar(50), 
					@PositionID int, 
					@WorkcellID int, 
					@Supervisor nvarchar(100),
					@IsActive int,
					@IsSupervisor int,
					@JoinedDate datetime,
					@WorkingStatusID int,
					@IsWorking		int'
					
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @EmployeeID
								, @WDNo
								, @EmployeeIDSAP
								, @UserName
								, @EmployeeName
								, @OperatorGroupID
								, @CompanyID
								, @DepartmentID
								, @JobTitle
								, @PositionID
								, @WorkcellID  
								, @Supervisor
								, @IsActive 
								, @IsSupervisor 
								, @JoinedDate 
								, @WorkingStatusID
								, @IsWorking
END