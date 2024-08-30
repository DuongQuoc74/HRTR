
CREATE PROC [dbo].[TrainingRecord_Search_20180116] 
(
	@EmployeeID			nvarchar(20), 
	@EmployeeIDSAP		nvarchar(1000) = '', 
	@EmployeeName		nvarchar(100), 
	@OperatorGroupID	int, 
	@CompanyID			int, 
	@DepartmentID		int, 
	@JobTitle			varchar(50), 
	@PositionID			int, 
	@WorkcellID			int, 
	@Supervisor			nvarchar(100),
	@IsActive			int,
	@TrainingGroupID	int,
	@TrainingGroupIDList		nvarchar(1000) = '',
	@CourseGroupID		int,
	@CourseGroupIDList		nvarchar(1000) = '',
	@CourseName			nvarchar(50) = '',
	@CourseNameList		nvarchar(MAX) = '',
	@ProductID			int,
	@ExpDateFrom		date,
	@ExpDateTo			date,
	@CerDateFrom		date,
	@CerDateTo			date,
	@IsLatestRecords	bit = 0,
	@WorkingStatusID	int,
	@WorkingStatusIDList		nvarchar(1000) = '',
	@IsWorking			int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(max)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@EmployeeID		nvarchar(20), @EmployeeIDSAP nvarchar(1000), 
					@EmployeeName		nvarchar(100), 
					@OperatorGroupID	int, 
					@CompanyID			int, 
					@DepartmentID		int, 
					@JobTitle			varchar(50), 
					@PositionID			int, 
					@WorkcellID			int, 
					@Supervisor			nvarchar(100),
					@IsActive			int,
					@TrainingGroupID	int,
					@TrainingGroupIDList		nvarchar(1000),
					@CourseGroupID		int,
					@CourseGroupIDList		nvarchar(1000),
					@CourseName			nvarchar(50),
					@CourseNameList		nvarchar(MAX),
					@ProductID			int,
					@ExpDateFrom		date,
					@ExpDateTo			date,
					@CerDateFrom		date,
					@CerDateTo			date,
					@WorkingStatusID	int,
					@WorkingStatusIDList		nvarchar(1000),
					@IsWorking			int'			
					
	
		
	SET @Query = N'SELECT H.[TrainingRecordID]
		  ,A.[EmployeeID_ID]
		  ,A.[EmployeeID]
		  ,A.[EmployeeIDSAP]
		  ,A.[EmployeeName]
		  --,A.[OperatorGroupName]
		  --,A.[CompanyName]
		  ,A.[DepartmentName]
		  ,A.[JobTitle]
		  ,A.[PositionName]
		  ,A.[WorkcellName]
		  ,A.[Supervisor]
		  ,H.[Trainer]
		  ,H.[CertDate]
		  ,H.[ExpDate]
		  ,CAST((CASE WHEN H.[ExpDate] IS NULL THEN 0
			WHEN H.[ExpDate] < GETDATE() THEN 1
			ELSE 0 END) AS BIT) AS [IsExpired]
		  ,H.[CourseName]
		  ,H.[CourseGroupName]
		  ,H.[TrainingGroupName]
		  --,H.[ProductName]
		  --,A.[IsActive]
		  --,A.[WorkingStatusName]
		  ,H.[OJT]
		  ,H.[LastUpdated]
		  ,UP.[FullName] AS [LastUpdatedByFullName]
		  ,A.[UserName] AS [UserName]
		  ,H.[Score] 
	FROM	[dbo].[HR_Employee_V] A WITH (NOLOCK) 
			INNER JOIN [dbo].[TrainingRecord_V] H WITH (NOLOCK) ON H.[EmployeeID_ID] = A.[EmployeeID_ID]
			LEFT OUTER JOIN [dbo].[SC_UserProfile] UP WITH (NOLOCK) ON H.[LastUpdatedBy] = UP.[UserProfileID]'
	SET @Query2 = N''
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + + N' AND A.[EmployeeID] = @EmployeeID' 
	IF @EmployeeIDSAP != ''
		SET @Query2 = @Query2 + + N' AND A.[EmployeeIDSAP] IN (SELECT [Items] AS [EmployeeIDSAP] FROM [dbo].[Split](@EmployeeIDSAP, '';''))' 
	IF @EmployeeName != ''
		SET @Query2 = @Query2 + + N' AND A.[EmployeeName] LIKE ''%'' + @EmployeeName + ''%''' 
	IF @OperatorGroupID != 0
		SET @Query2 = @Query2 + + N' AND A.[OperatorGroupID] = @OperatorGroupID' 
	IF @CompanyID != 0
		SET @Query2 = @Query2 + + N' AND A.[CompanyID] = @CompanyID' 
	IF @DepartmentID != 0
		SET @Query2 = @Query2 + + N' AND A.[DepartmentID] = @DepartmentID' 
	IF @JobTitle != ''
		SET @Query2 = @Query2 + + N' AND A.[JobTitle] LIKE ''%'' + @JobTitle + ''%''' 	
	IF @PositionID != 0
		SET @Query2 = @Query2 + + N' AND A.[PositionID] = @PositionID' 
	IF @WorkcellID != 0
		SET @Query2 = @Query2 + + N' AND A.[WorkcellID] = @WorkcellID' 
	IF @Supervisor != ''
		SET @Query2 = @Query2 + + N' AND A.[Supervisor] LIKE ''%'' + @Supervisor + ''%''' 	
	IF @IsActive != -1
		SET @Query2 = @Query2 + + N' AND A.[IsActive] = @IsActive' 	
		
	IF @WorkingStatusID != 0
		SET @Query2 = @Query2 + + N' AND A.[WorkingStatusID] = @WorkingStatusID' 
	IF @WorkingStatusIDList != ''
		SET @Query2 = @Query2 + + N' AND A.[WorkingStatusID] IN (SELECT [Items] AS [WorkingStatusID] FROM [dbo].[Split](@WorkingStatusIDList, '';''))' 
	IF @IsWorking != -1
		SET @Query2 = @Query2 + ' AND A.[IsWorking] = @IsWorking'
		
	IF @ProductID != 0
		SET @Query2 = @Query2 + + N' AND H.[ProductID] = @ProductID' 
	IF @CourseName != ''
		SET @Query2 = @Query2 + + N' AND H.[CourseName] = @CourseName' 
	IF @CourseNameList != ''
		SET @Query2 = @Query2 + + N' AND H.[CourseName] IN (SELECT [Items] AS [CourseName] FROM [dbo].[Split](@CourseNameList, '';''))' 
	IF @CourseGroupID != 0
		SET @Query2 = @Query2 + + N' AND H.[CourseGroupID] = @CourseGroupID' 
	IF @CourseGroupIDList != ''
		SET @Query2 = @Query2 + + N' AND H.[CourseGroupID] IN (SELECT [Items] AS [CourseGroupID] FROM [dbo].[Split](@CourseGroupIDList, '';''))' 
	IF @TrainingGroupID != 0
		SET @Query2 = @Query2 + + N' AND H.[TrainingGroupID] = @TrainingGroupID' 
	IF @TrainingGroupIDList != ''
		SET @Query2 = @Query2 + + N' AND H.[TrainingGroupID] IN (SELECT [Items] AS [TrainingGroupID] FROM [dbo].[Split](@TrainingGroupIDList, '';''))' 
	IF @ExpDateFrom IS NOT NULL
	BEGIN
		SET @ExpDateFrom = CONVERT(varchar(10), @ExpDateFrom , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND H.[ExpDate] >= @ExpDateFrom'			
	END
	IF @ExpDateTo IS NOT NULL
	BEGIN
		SET @ExpDateTo = CONVERT(varchar(10), @ExpDateTo , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND H.[ExpDate] <= @ExpDateTo'			
	END
	IF @CerDateFrom IS NOT NULL
	BEGIN
		SET @CerDateFrom = CONVERT(varchar(10), @CerDateFrom , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND H.[CertDate] >= @CerDateFrom'			
	END
	IF @CerDateTo IS NOT NULL
	BEGIN
		SET @CerDateTo = CONVERT(varchar(10), @CerDateTo , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND H.[CertDate] <= @CerDateTo'			
	END
	
	IF @IsLatestRecords = 1
	BEGIN
		SET @Query2 = @Query2 + N' AND H.[TrainingRecordID] = (SELECT TOP 1 H1.[TrainingRecordID]
								  FROM [dbo].[TrainingRecord] H1 WITH (NOLOCK)
								  WHERE  H1.[EmployeeID_ID] = H.[EmployeeID_ID] AND H1.[CourseID] = H.[CourseID] ORDER BY H1.[CertDate] DESC)'		
	END
	
	SET @Query2 = @Query2 + + N' AND H.[IsActive] = 1' 	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
	SET @Query = @Query + @Query2 
	EXEC sp_executesql @Query, @ParmDef
							, @EmployeeID
							, @EmployeeIDSAP
							, @EmployeeName
							, @OperatorGroupID
							, @CompanyID	
							, @DepartmentID	
							, @JobTitle			
							, @PositionID			 
							--, @ShiftID			
							, @WorkcellID			
							, @Supervisor			
							, @IsActive			
							, @TrainingGroupID	
							, @TrainingGroupIDList
							, @CourseGroupID
							, @CourseGroupIDList		
							, @CourseName			
							, @CourseNameList
							, @ProductID			
							, @ExpDateFrom		
							, @ExpDateTo			
							, @CerDateFrom		
							, @CerDateTo			
							, @WorkingStatusID	
							, @WorkingStatusIDList
							, @IsWorking
								
	
END




