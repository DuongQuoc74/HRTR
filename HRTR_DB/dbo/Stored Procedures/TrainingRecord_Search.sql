CREATE PROC [dbo].[TrainingRecord_Search] 
(
	@EmployeeID					nvarchar(1000), 
	@EmployeeIDSAP				nvarchar(1000) = '', 
	@EmployeeName				nvarchar(100), 
	@OperatorGroupID			int, 
	@CompanyID					int, 
	@DepartmentID				int, 
	@JobTitle					varchar(50), 
	@PositionID					int, 
	@WorkcellID					int, 
	@Supervisor					nvarchar(100),
	@IsActive_Employee			int,
	@TrainingGroupID			int,
	@TrainingGroupIDList		nvarchar(1000) = '',
	@CourseGroupID				int,
	@CourseGroupIDList			nvarchar(1000) = '',
	@CourseName					nvarchar(50) = '',
	@CourseNameList				nvarchar(MAX) = '',
	@ProductID					int,
	@ExpDateFrom				date,
	@ExpDateTo					date,
	@CerDateFrom				date,
	@CerDateTo					date,
	@IsLatestRecords			bit = 0,
	@IsActive_TrainingRecord	int,
	@WorkingStatusID			int,
	@WorkingStatusIDList		nvarchar(1000) = '',
	@CertifiedLevelID			int,
	@CertifiedLevelIDList		nvarchar(100) = '',
	@IsWorking					int = -1
)
AS
BEGIN
EXEC TrainingRecord_InactiveExpiredOJTCourses
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(max)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@EmployeeID				nvarchar(20), 
	                @EmployeeIDSAP				nvarchar(1000), 
					@EmployeeName				nvarchar(100), 
					@OperatorGroupID			int, 
					@CompanyID					int, 
					@DepartmentID				int, 
					@JobTitle					varchar(50), 
					@PositionID					int, 
					@WorkcellID					int, 
					@Supervisor					nvarchar(100),
					@IsActive_Employee			int,
					@TrainingGroupID			int,
					@TrainingGroupIDList		nvarchar(1000),
					@CourseGroupID				int,
					@CourseGroupIDList			nvarchar(1000),
					@CourseName					nvarchar(50),
					@CourseNameList				nvarchar(MAX),
					@ProductID					int,
					@ExpDateFrom				date,
					@ExpDateTo					date,
					@CerDateFrom				date,
					@CerDateTo					date,
					@IsLatestRecords			bit,
					@IsActive_TrainingRecord	int,
					@WorkingStatusID			int,
					@WorkingStatusIDList		nvarchar(1000),
					@CertifiedLevelID			int,
					@CertifiedLevelIDList		nvarchar(100),
					@IsWorking					int'			
					
	
		
	SET @Query = N'SELECT H.[TrainingRecordID]
		  ,A.[EmployeeID_ID]
		  ,A.[EmployeeID]
		  ,A.[WDNo]
		  ,A.[EmployeeIDSAP]
		  ,A.[EmployeeName]
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
		  ,P.[ProductName] AS "Family"
		  ,H.[CourseName]
		  ,H.[CourseGroupName]
		  ,H.[TrainingGroupName]
		  ,H.[OJT]
		  ,H.[LastUpdated]
		  ,UP.[FullName] AS [LastUpdatedByFullName]
		  ,A.[UserName] AS [UserName]
		  ,H.[Score] 
		  ,CL.[CertifiedLevelName]
		  ,H.Comments
		  ,H.[IsActive]
	FROM	[dbo].[HR_Employee_V] A WITH (NOLOCK) 
			INNER JOIN [dbo].[TrainingRecord_V] H WITH (NOLOCK) ON H.[EmployeeID_ID] = A.[EmployeeID_ID]
			INNER JOIN [dbo].[CR_Product] P WITH (NOLOCK) ON H.ProductID = P.ProductID
			LEFT OUTER JOIN [dbo].[SC_UserProfile] UP WITH (NOLOCK) ON H.[LastUpdatedBy] = UP.[UserProfileID]
			LEFT OUTER JOIN [dbo].[CR_CertifiedLevel] CL WITH (NOLOCK) ON H.[CertifiedLevelID] = CL.[CertifiedLevelID]'
	SET @Query2 = N''
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeID] IN (SELECT TRIM([Items]) AS [EmployeeID] FROM [dbo].[Split](@EmployeeID, '';''))' 
	IF @EmployeeIDSAP != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeIDSAP] IN (SELECT TRIM([Items]) AS [EmployeeIDSAP] FROM [dbo].[Split](@EmployeeIDSAP, '';''))' 
	IF @EmployeeName != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeName] LIKE ''%'' + @EmployeeName + ''%''' 
	IF @OperatorGroupID != 0
		SET @Query2 = @Query2 + N' AND A.[OperatorGroupID] = @OperatorGroupID' 
	IF @CompanyID != 0
		SET @Query2 = @Query2 + N' AND A.[CompanyID] = @CompanyID' 
	IF @DepartmentID != 0
		SET @Query2 = @Query2 + N' AND A.[DepartmentID] = @DepartmentID' 
	IF @JobTitle != ''
		SET @Query2 = @Query2 + N' AND A.[JobTitle] LIKE ''%'' + @JobTitle + ''%''' 	
	IF @PositionID != 0
		SET @Query2 = @Query2 + N' AND A.[PositionID] = @PositionID' 
	IF @WorkcellID != 0
		SET @Query2 = @Query2 + N' AND A.[WorkcellID] = @WorkcellID' 
	IF @Supervisor != ''
		SET @Query2 = @Query2 + N' AND A.[Supervisor] LIKE ''%'' + @Supervisor + ''%''' 	
	IF @IsActive_Employee != -1
		SET @Query2 = @Query2 + N' AND A.[IsActive] = @IsActive_Employee' 	
	--IF @IsActive_TrainingRecord != -1
	--	SET @Query2 = @Query2 + N' AND H.[TrainingRecordActive] = @IsActive_TrainingRecord' 
	IF @IsActive_TrainingRecord != -1
	   SET @Query2 = @Query2 + N' AND H.[IsActive] = @IsActive_TrainingRecord' 
	IF @WorkingStatusID != 0
		SET @Query2 = @Query2 + N' AND A.[WorkingStatusID] = @WorkingStatusID' 
	IF @WorkingStatusIDList != ''
		SET @Query2 = @Query2 + N' AND A.[WorkingStatusID] IN (SELECT [Items] AS [WorkingStatusID] FROM [dbo].[Split](@WorkingStatusIDList, '';''))' 
	IF @IsWorking != -1
		SET @Query2 = @Query2 + ' AND A.[IsWorking] = @IsWorking'
		
	IF @ProductID != 0
		SET @Query2 = @Query2 + N' AND H.[ProductID] = @ProductID' 
	IF @CourseName != ''
		SET @Query2 = @Query2 + N' AND H.[CourseName] = @CourseName' 
	IF @CourseNameList != ''
		SET @Query2 = @Query2 + N' AND H.[CourseName] IN (SELECT [Items] AS [CourseName] FROM [dbo].[Split](@CourseNameList, '';''))' 
	IF @CourseGroupID != 0
		SET @Query2 = @Query2 + N' AND H.[CourseGroupID] = @CourseGroupID' 
	IF @CourseGroupIDList != ''
		SET @Query2 = @Query2 + N' AND H.[CourseGroupID] IN (SELECT [Items] AS [CourseGroupID] FROM [dbo].[Split](@CourseGroupIDList, '';''))' 
	IF @TrainingGroupID != 0
		SET @Query2 = @Query2 + N' AND H.[TrainingGroupID] = @TrainingGroupID' 
	IF @TrainingGroupIDList != ''
		SET @Query2 = @Query2 + N' AND H.[TrainingGroupID] IN (SELECT [Items] AS [TrainingGroupID] FROM [dbo].[Split](@TrainingGroupIDList, '';''))' 
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
	IF @CertifiedLevelID != 0
		SET @Query2 = @Query2 + N' AND H.[CertifiedLevelID] = @CertifiedLevelID' 
	IF @CertifiedLevelIDList != ''
		SET @Query2 = @Query2 + N' AND H.[CertifiedLevelID] IN (SELECT [Items] AS [CertifiedLevelID] FROM [dbo].[Split](@CertifiedLevelIDList, '';''))' 
	
	IF @IsLatestRecords = 1
	BEGIN
		SET @Query2 = @Query2 + N' AND H.[TrainingRecordID] = (SELECT TOP 1 H1.[TrainingRecordID]
								  FROM [dbo].[TrainingRecord] H1 WITH (NOLOCK)
								  WHERE H1.ProductID = H.ProductID AND H1.[EmployeeID_ID] = H.[EmployeeID_ID] AND H1.[CourseID] = H.[CourseID] 
								  ORDER BY CASE
										 WHEN H1.[CertifiedLevelID] = 5 then 1
										 WHEN H1.[CertifiedLevelID] = 2 then 2 
										 WHEN H1.[CertifiedLevelID] = 4 then 3
										 WHEN H1.[CertifiedLevelID] = 1 then 4
										 WHEN H1.[CertifiedLevelID] = 6 then 5
										 ELSE 6
										 END  ASC, H1.[CertDate] DESC)'		
	END
	--SET @Query2 = @Query2 + N' AND H.[IsActive] = 1' 	
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
							, @WorkcellID			
							, @Supervisor			
							, @IsActive_Employee			
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
							, @IsLatestRecords
							, @IsActive_TrainingRecord			
							, @WorkingStatusID	
							, @WorkingStatusIDList
							, @CertifiedLevelID
							, @CertifiedLevelIDList
							, @IsWorking
END
