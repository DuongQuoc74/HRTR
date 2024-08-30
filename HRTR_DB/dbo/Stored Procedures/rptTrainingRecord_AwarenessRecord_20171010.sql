CREATE PROC [dbo].[rptTrainingRecord_AwarenessRecord_20171010] 
(
	@EmployeeID						nvarchar(20), 
	@EmployeeIDSAP					nvarchar(1000) = '', 
	@EmployeeName					nvarchar(100), 
	@OperatorGroupID				int, 
	@CompanyID						int, 
	@DepartmentID					int, 
	@JobTitle						varchar(50) = '', 
	@PositionID						int, 
	@WorkcellID						int, 
	@Supervisor						nvarchar(100),
	@IsActive						int,
	@TrainingGroupID				int,
	@CourseGroupID					int,
	@CourseID						int,
	@ProductID						int,
	@ExpDateFrom					date,
	@ExpDateTo						date,
	@CerDateFrom					date,
	@CerDateTo						date,
	@JoinedDateFrom					date,
	@JoinedDateTo					date,
	@WorkingStatusID				int,
	@WorkingStatusIDList			nvarchar(1000) = '',
	@IsWorking						int = -1,
	@ExpectedToCompleteBefore_Days  int = 2,
	@OutputTypeID					int,
	@TrainingStatusID				int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(max)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@EmployeeID					nvarchar(20), 
	                @EmployeeIDSAP					nvarchar(1000), 
					@EmployeeName					nvarchar(100), 
					@OperatorGroupID				int, 
					@CompanyID						int, 
					@DepartmentID					int, 
					@JobTitle						varchar(50), 
					@PositionID						int, 
					@WorkcellID						int, 
					@Supervisor						nvarchar(100),
					@IsActive						int,
					@TrainingGroupID				int,
					@CourseGroupID					int,
					@CourseID						int,
					@ProductID						int,
					@ExpDateFrom					date,
					@ExpDateTo						date,
					@CerDateFrom					date,
					@CerDateTo						date,
					@JoinedDateFrom					date,
					@JoinedDateTo					date,
					@WorkingStatusID				int,
					@WorkingStatusIDList			nvarchar(1000),
					@IsWorking						int,
					@ExpectedToCompleteBefore_Days  int,
					@TrainingStatusID				int'
								
	IF @OutputTypeID = 1
	BEGIN	
		SET @Query = N'SELECT A.[CourseID], B.[EmployeeID] As [Employee ID]
					         ,B.[EmployeeIDSAP] As [Employee ID SAP], B.[EmployeeName] As [Employee Name]
					         ,B.[DepartmentName] As [Department], B.[WorkcellName] As [Workcell]
					         ,B.[Supervisor] As [Supervisor], B.[JoinedDate] As [Joined Date]
					         ,A.[CourseName] As [Course], A.[CourseGroupName] As [Course Group]
					         ,A.[TrainingGroupName] As [Training Group]
		                     ,DATEADD(DAY, @ExpectedToCompleteBefore_Days, B.[JoinedDate]) As [Expected Cert Date]
		                     ,C.[CertDate] As [Cert Date], C.[Trainer] As [Trainer Name], C.[Score]
							 ,(CASE WHEN C.[TrainingRecordID] IS NOT NULL THEN ''Completed''
							WHEN DATEDIFF(DAY, B.[JoinedDate], GETDATE()) > @ExpectedToCompleteBefore_Days THEN ''Overdue''
							ELSE ''In-completed'' END) AS [Status]
					   FROM [dbo].[CR_Course_V1] A WITH (NOLOCK) CROSS JOIN [dbo].[HR_Employee_V] B WITH (NOLOCK)
																 LEFT JOIN [dbo].[TrainingRecord_V1] C WITH (NOLOCK)
																 ON B.[EmployeeID_ID] = C.[EmployeeID_ID] AND A.[CourseID] = C.[CourseID]'
	END
	IF @OutputTypeID = 2
	BEGIN
		SET @Query = N'INSERT INTO #tmpAwarenessRecord SELECT SUM(CASE WHEN C.[TrainingRecordID] IS NULL THEN 0 ELSE 1 END) AS [Completed]
					,SUM(CASE WHEN C.[TrainingRecordID] IS NULL AND DATEDIFF(DAY, B.[JoinedDate], GETDATE()) > @ExpectedToCompleteBefore_Days THEN 1 ELSE 0 END) AS [Overdue]
					,SUM(CASE WHEN C.[TrainingRecordID] IS NULL AND DATEDIFF(DAY, B.[JoinedDate], GETDATE()) <= @ExpectedToCompleteBefore_Days THEN 1 ELSE 0 END) AS [Incompleted]
					FROM [dbo].[CR_Course_V1] A WITH (NOLOCK) CROSS JOIN [dbo].[HR_Employee_V] B WITH (NOLOCK)
																LEFT JOIN [dbo].[TrainingRecord_V1] C WITH (NOLOCK)
																ON B.[EmployeeID_ID] = C.[EmployeeID_ID] AND A.[CourseID] = C.[CourseID]'
	END
	SET @Query2 = N''
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + N' AND B.[EmployeeID] = @EmployeeID' 
	IF @EmployeeIDSAP != ''
		SET @Query2 = @Query2 + N' AND B.[EmployeeIDSAP] IN (SELECT [Items] AS [EmployeeIDSAP] FROM [dbo].[Split](@EmployeeIDSAP, '';''))' 
	IF @EmployeeName != ''
		SET @Query2 = @Query2 + N' AND B.[EmployeeName] LIKE ''%'' + @EmployeeName + ''%''' 
	IF @OperatorGroupID != 0
		SET @Query2 = @Query2 + N' AND B.[OperatorGroupID] = @OperatorGroupID' 
	IF @CompanyID != 0
		SET @Query2 = @Query2 + N' AND B.[CompanyID] = @CompanyID' 
	IF @DepartmentID != 0
		SET @Query2 = @Query2 + N' AND B.[DepartmentID] = @DepartmentID' 
	IF @JobTitle != ''
		SET @Query2 = @Query2 + N' AND B.[JobTitle] LIKE ''%'' + @JobTitle + ''%''' 	
	IF @PositionID != 0
		SET @Query2 = @Query2 + N' AND B.[PositionID] = @PositionID' 
	IF @WorkcellID != 0
		SET @Query2 = @Query2 + N' AND B.[WorkcellID] = @WorkcellID' 
	IF @Supervisor != ''
		SET @Query2 = @Query2 + N' AND B.[Supervisor] LIKE ''%'' + @Supervisor + ''%''' 	
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' AND B.[IsActive] = @IsActive'
	IF @WorkingStatusID != 0
		SET @Query2 = @Query2 + N' AND B.[WorkingStatusID] = @WorkingStatusID' 
	IF @WorkingStatusIDList != ''
		SET @Query2 = @Query2 + N' AND B.[WorkingStatusID] IN (SELECT [Items] AS [WorkingStatusID] FROM [dbo].[Split](@WorkingStatusIDList, '';''))' 
	IF @IsWorking != -1
		SET @Query2 = @Query2 + N' AND B.[IsWorking] = @IsWorking'
	IF @CourseID != 0
		SET @Query2 = @Query2 + N' AND A.[CourseID] = @CourseID'  
	IF @CourseGroupID != 0
		SET @Query2 = @Query2 + N' AND A.[CourseGroupID] = @CourseGroupID'  
	IF @TrainingGroupID != 0
		SET @Query2 = @Query2 + N' AND A.[TrainingGroupID] = @TrainingGroupID'  	
	IF @ProductID != 0
		SET @Query2 = @Query2 + N' AND C.[ProductID] = @ProductID'
	IF @CerDateFrom IS NOT NULL
	BEGIN
		SET @CerDateFrom = CONVERT(varchar(10), @CerDateFrom , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND C.[CertDate] >= @CerDateFrom'			
	END
	IF @CerDateTo IS NOT NULL
	BEGIN
		SET @CerDateTo = CONVERT(varchar(10), @CerDateTo , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND C.[CertDate] <= @CerDateTo'			
	END 
	IF @ExpDateFrom IS NOT NULL
	BEGIN
		SET @ExpDateFrom = CONVERT(varchar(10), @ExpDateFrom , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND C.[ExpDate] >= @ExpDateFrom'			
	END
	IF @ExpDateTo IS NOT NULL
	BEGIN
		SET @ExpDateTo = CONVERT(varchar(10), @ExpDateTo , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND C.[ExpDate] <= @ExpDateTo'			
	END
	IF @JoinedDateFrom IS NOT NULL
	BEGIN
		SET @JoinedDateFrom = CONVERT(varchar(10), @JoinedDateFrom , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND B.[JoinedDate] >= @JoinedDateFrom'			
	END
	IF @JoinedDateTo IS NOT NULL
	BEGIN
		SET @JoinedDateTo = CONVERT(varchar(10), @JoinedDateTo , 120)  + ' 00:00:00.000'	
		SET @Query2 = @Query2 + N' AND B.[JoinedDate] <= @JoinedDateTo'			
	END
	IF @OutputTypeID = 1
	BEGIN
		IF @TrainingStatusID != 0
			SET @Query2 = @Query2 + N' AND (CASE WHEN C.[TrainingRecordID] IS NOT NULL THEN 1
							                WHEN DATEDIFF(DAY, B.[JoinedDate], GETDATE()) > @ExpectedToCompleteBefore_Days THEN 3
							                ELSE 2 END) = @TrainingStatusID' 
	END
	SET @Query2 = @Query2 + N' AND A.[IsActive] = 1'
	SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
	SET @Query = @Query + @Query2 
	IF @OutputTypeID = 1
	BEGIN
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
								, @IsActive			
								, @TrainingGroupID	
								, @CourseGroupID		
								, @CourseID		
								, @ProductID			
								, @ExpDateFrom		
								, @ExpDateTo			
								, @CerDateFrom		
								, @CerDateTo	
								, @JoinedDateFrom
								, @JoinedDateTo		
								, @WorkingStatusID	
								, @WorkingStatusIDList
								, @IsWorking
								, @ExpectedToCompleteBefore_Days
								, @TrainingStatusID
	END
	ELSE IF @OutputTypeID = 2
	BEGIN
		CREATE TABLE #tmpAwarenessRecord
		(
			[Completed]		[int],
			[Incompleted]	[int],
			[Overdue]		[int]
		)
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
							, @IsActive			
							, @TrainingGroupID	
							, @CourseGroupID		
							, @CourseID	
							, @ProductID			
							, @ExpDateFrom		
							, @ExpDateTo			
							, @CerDateFrom		
							, @CerDateTo	
							, @JoinedDateFrom
							, @JoinedDateTo		
							, @WorkingStatusID	
							, @WorkingStatusIDList
							, @IsWorking
							, @ExpectedToCompleteBefore_Days
							, @TrainingStatusID
		DECLARE @Total	int
		CREATE TABLE #tmpAwarenessRecordDetails
		(
			[Status]		[nvarchar](50),
			[Number]		[int],
			[Percent]		[decimal](7,4)
		)
		SELECT @Total = [Completed] + [Incompleted] + [Overdue]
		FROM #tmpAwarenessRecord
		INSERT INTO #tmpAwarenessRecordDetails
		SELECT N'Completed'
			, [Completed]
			, (CASE WHEN @Total = 0 THEN 0 ELSE [Completed]*1.0000/ @Total END) AS [Percent]
		FROM #tmpAwarenessRecord
		INSERT INTO #tmpAwarenessRecordDetails
		SELECT N'Incompleted'
			, [Incompleted]
			, (CASE WHEN @Total = 0 THEN 0 ELSE [Incompleted]*1.0000/ @Total END) AS [Percent]
		FROM #tmpAwarenessRecord
		INSERT INTO #tmpAwarenessRecordDetails
		SELECT N'Overdue'
			, [Overdue]
			, (CASE WHEN @Total = 0 THEN 0 ELSE [Overdue]*1.0000/ @Total END) AS [Percent]
		FROM #tmpAwarenessRecord

		SELECT *
		FROM #tmpAwarenessRecordDetails
		DROP TABLE #tmpAwarenessRecordDetails
		DROP TABLE #tmpAwarenessRecord
	END
END

