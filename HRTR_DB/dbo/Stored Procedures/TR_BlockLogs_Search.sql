--exec TR_BlockLogs_Search @CreatedDateFrom='2016-01-30 00:00:00',@CreatedDateTo='2016-07-29 00:00:00',@EmployeeID=N'66',@IsConfirmed=-1

CREATE PROC [dbo].[TR_BlockLogs_Search] 
(
	@CreatedDateFrom			datetime,
	@CreatedDateTo				datetime,
	@EmployeeID					nvarchar(10),
	@IsConfirmed				int = -1 -- -1: All, 1: Yes, 0: No
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@CreatedDateFrom			datetime,
					@CreatedDateTo				datetime,
					@EmployeeID					nvarchar(10),
					@IsConfirmed				int'			
	
	SET @Query = N'SELECT A.[TR_BlockLogsID]
      ,A.[EmployeeID_ID]
      ,B.[EmployeeID]
      ,B.[EmployeeName]
      ,B.[UserName]
      ,CO.[CourseName]
      ,A.[LastLogonDate]
      ,A.[IsConfirmed]
      ,A.[Comments]
      ,A.[ConfirmedBy]
      ,A.[ConfirmedDate]
      ,UP.[FullName] AS [ConfirmedByFullName]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
	FROM	[dbo].[TR_BlockLogs_V] A WITH (NOLOCK) INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
			LEFT OUTER JOIN [dbo].[SC_UserProfile] UP WITH (NOLOCK) ON UP.[UserProfileID] = A.[ConfirmedBy]
			LEFT OUTER JOIN [dbo].[TrainingRecord] TR WITH (NOLOCK) ON TR.[TrainingRecordID] = A.[TrainingRecordID]
			LEFT OUTER JOIN [dbo].[CR_Course] CO WITH (NOLOCK) ON CO.[CourseID] = TR.[CourseID] '
	SET @Query2 = ''
	IF @CreatedDateFrom IS NOT NULL
	BEGIN
		SET @CreatedDateFrom = CONVERT(VARCHAR(10), @CreatedDateFrom , 120)  + ' 00:00:00.000' 
		SET @Query2 = @Query2 + N' AND A.[CreatedDate] >= @CreatedDateFrom'
	END
	IF @CreatedDateTo IS NOT NULL
	BEGIN
		SET @CreatedDateTo = CONVERT(VARCHAR(10), @CreatedDateTo , 120)  + ' 23:59:59.990' 
		SET @Query2 = @Query2 + N' AND A.[CreatedDate] <= @CreatedDateTo'
	END	
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + N' AND B.[EmployeeID] = @EmployeeID'	
	--IF @IsBlocked != -1
	--	SET @Query2 = @Query2 + N' AND A.[IsBlocked] = @IsBlocked'	
	IF @IsConfirmed != -1
		SET @Query2 = @Query2 + N' AND A.[IsConfirmed] = @IsConfirmed'	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
	SET @Query = @Query + @Query2
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @CreatedDateFrom
								, @CreatedDateTo
								, @EmployeeID
								, @IsConfirmed
								
END


