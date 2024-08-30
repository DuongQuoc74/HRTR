--exec AL_LockRecodReport_Search @EmployeeID=N'',@EmployeeIDSAP=N'',@UserName=N'',@EmployeeName=N'',@TrainingCodeID=N'',@DueDate=NULL,@ExtendDay=0,@CompleteDate=NULL,@IsActive=1,@IsDL=-1,@IsComplete=1
CREATE PROC [dbo].[AL_LockRecodReport_Search] 
(
	@EmployeeID			varchar(20), 
	@EmployeeIDSAP		varchar(20),
	@UserName			nvarchar(50),
	@EmployeeName		nvarchar(100),
	@TrainingCodeID		nvarchar(100), 
	@DueDate			datetime,
	@ExtendDay			smallint,
	@CompleteDate		datetime,
	@IsActive			int,
	@IsDL		        int,
	@IsComplete	        int
)
AS
BEGIN

		
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
				, @Querydk						nvarchar(max)
	IF(@IsComplete = 0)
		SET @Querydk = 'ISNULL(A.CompleteDate,''1900-01-01 00:00:00.000'') = ''1900-01-01 00:00:00.000'''
	ELSE
		SET @Querydk = 'ISNULL(A.CompleteDate,''1900-01-01 00:00:00.000'') <> ''1900-01-01 00:00:00.000'''
					
	SET @Query = N'SELECT A.[LockID]
					  ,A.[EmployeeID]
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
					  ,IsDL = case A.IsDL
						 when ''1'' then ''DL''
						 when ''0'' then ''IL''
						 end
					  ,Reminder = case when CompleteDate < DueDate then 1
									when CompleteDate >= DueDate and CompleteDate < isnull(ExtendFromDate,''2020-01-01 00:00:00.000'') then 2 
									when CompleteDate >= ExtendFromDate then 3
									else null end 
				  FROM [dbo].[AL_TrainingAutoLock] A WITH (NOLOCK) 
						INNER JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]'
	SET @Query2 = ''
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + N' AND A.[EmployeeID] = @EmployeeID'
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
	IF @IsDL != -1
		SET @Query2 = @Query2 + N' AND A.[IsDL] = @IsDL'
	IF @IsComplete != -1
		SET @Query2 = @Query2 + N' AND ' + @Querydk
	--print @Query2
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
	SET @Query2 = @Query2 + N' ORDER BY A.[EmployeeID]'
	SET @ParmDef = '@EmployeeID			varchar(20), 
					@EmployeeIDSAP		varchar(20),
					@UserName			nvarchar(50),
					@EmployeeName		nvarchar(100), 
					@TrainingCodeID		nvarchar(100), 
					@DueDate			datetime,
					@ExtendDay			smallint,
					@CompleteDate		datetime,
					@IsActive			int,
					@IsDL			    int,
					@IsComplete			int'
	SET @Query = @Query + @Query2
	EXEC sp_executesql @Query, @ParmDef
								, @EmployeeID			
								, @EmployeeIDSAP
								, @UserName		
								, @EmployeeName
								, @TrainingCodeID		
								, @DueDate			
								, @ExtendDay			 
								, @CompleteDate 			
								, @IsActive	
								, @IsDL	
								, @IsComplete
								
END

