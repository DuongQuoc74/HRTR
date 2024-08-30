
CREATE PROC [dbo].[AL_TrainingEmpLock_Search] 
(
	@EmployeeID			varchar(20), 
	@WDNo				nvarchar(20) = '',
	@EmployeeIDSAP		varchar(20),
	@UserName			nvarchar(50),
	@EmployeeName		nvarchar(100),
	@TrainingCodeID		nvarchar(100), 
	@DueDate			datetime,
	@ExtendDay			smallint,
	@CompleteDate		datetime,
	@IsActive			int,
	@IsDL int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT A.[LockID]
					  ,A.[EmployeeID]
					  ,A.[WDNo]
					  ,A.[EmployeeIDSAP]
					  ,A.[UserName]
					  ,A.[EmployeeName]
					  ,A.[TrainingCodeID]
					  ,A.[Description]
					  ,A.[DueDate]
					  ,A.[ExtendDay]
					  ,A.[ExtendFromDate]
					  ,A.[CompleteDate]
					  ,A.[IsActive]
					  ,A.[LastUpdated]
					  ,A.[LastUpdatedBy]
					  ,B.[FullName] AS [LastUpdatedByFullName]
					  ,A.[IsDL]
				  FROM [dbo].[AL_TrainingAutoLock] A WITH (NOLOCK) 
						INNER JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]'
	SET @Query2 = ''
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeID] = @EmployeeID'
	IF 	@WDNo <> ''
		SET @Query2 = @Query2 + N' AND A.[WDNo] LIKE + ''%'' + @WDNo + ''%'''

	IF @EmployeeIDSAP != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeIDSAP] = @EmployeeIDSAP'
	IF @UserName != ''
		SET @Query2 = @Query2 + N' AND A.[UserName] = @UserName'
	IF @EmployeeName != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeName] LIKE ''%'' + @EmployeeName + ''%'''
	IF @TrainingCodeID != ''
		SET @Query2 = @Query2 + N' AND A.[TrainingCodeID] LIKE ''%'' + @TrainingCodeID + ''%'''	
	IF @DueDate IS NOT NULL
		SET @Query2 = @Query2 + N' AND A.[DueDate] = @DueDate'
	IF @ExtendDay != 0
		SET @Query2 = @Query2 + N' AND A.[ExtendDay] = @ExtendDay'
	IF @CompleteDate IS NOT NULL
		SET @Query2 = @Query2 + N' AND A.[CompleteDate] = @CompleteDate'
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' AND A.[IsActive] = @IsActive'
	ELSE
		SET @Query2 = @Query2 + N' AND A.[IsActive] IS NOT NULL'
	IF @IsDL != -1
		SET @Query2 = @Query2 + N' AND A.[IsDL] = @IsDL'
	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)	
	SET @Query2 = @Query2 + N' ORDER BY A.[EmployeeID]'
	SET @ParmDef = '@EmployeeID			varchar(20), 
					@WDNo				nvarchar(20),
					@EmployeeIDSAP		varchar(20),
					@UserName			nvarchar(50),
					@EmployeeName		nvarchar(100), 
					@TrainingCodeID		nvarchar(100), 
					@DueDate			datetime,
					@ExtendDay			smallint,
					@CompleteDate		datetime,
					@IsActive			int,
					@IsDL			    int'
	SET @Query = @Query + @Query2
	EXEC sp_executesql @Query, @ParmDef
								, @EmployeeID	
								, @WDNo		
								, @EmployeeIDSAP
								, @UserName		
								, @EmployeeName
								, @TrainingCodeID		
								, @DueDate			
								, @ExtendDay			 
								, @CompleteDate 			
								, @IsActive
								, @IsDL			
END


