CREATE PROC [dbo].[GC_BlockLogs_Search] 
(
	@CreatedDateFrom			datetime,
	@CreatedDateTo				datetime,
	@Customer_ID				int = 0,
	@EmployeeID					nvarchar(10),
	@IsBlocked					int = -1, -- -1: All, 1: Yes, 0: No
	@IsConfirmed				int = -1, -- -1: All, 1: Yes, 0: No
	@IsActive				    int = -1  -- -1: All, 1: Yes, 0: No
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@CreatedDateFrom			datetime,
					@CreatedDateTo				datetime,
					@Customer_ID				int,
					@EmployeeID					nvarchar(10),
					@IsBlocked					int,
					@IsConfirmed				int,
					@IsActive				    int'			
	
	SET @Query = N'SELECT A.[GC_BlockLogsID]
      ,A.[EmployeeID_ID]
      ,A.[Customer_ID]
      ,CS.[Customer]
      ,B.[EmployeeID]
      ,B.[EmployeeName]
      ,B.[UserName]
      ,A.[CreatedDate]
      ,A.[Aging]
      ,A.[StartDate]
      ,A.[EndDate]
      ,A.[TotalRedGrapes]
      ,A.[IsBlocked]
      ,A.[BlockedDate]
      ,A.[IsConfirmed]
      ,A.[Comments]
      ,A.[ConfirmedBy]
      ,A.[ConfirmedDate]
      ,UP.[FullName] AS [ConfirmedByFullName]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
	FROM	[dbo].[GC_BlockLogs_V] A WITH (NOLOCK) INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
			INNER JOIN [dbo].[GC_Customers] CS WITH (NOLOCK) ON CS.[Customer_ID] = A.[Customer_ID]
			LEFT OUTER JOIN [dbo].[SC_UserProfile] UP WITH (NOLOCK) ON UP.[UserProfileID] = A.[ConfirmedBy] '
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
	IF @Customer_ID != 0
		SET @Query2 = @Query2 + N' AND A.[Customer_ID] = @Customer_ID'	
	IF @EmployeeID != ''
		SET @Query2 = @Query2 + N' AND B.[EmployeeID] = @EmployeeID'	
	IF @IsBlocked != -1
		SET @Query2 = @Query2 + N' AND A.[IsBlocked] = @IsBlocked'	
	IF @IsConfirmed != -1
		SET @Query2 = @Query2 + N' AND A.[IsConfirmed] = @IsConfirmed'
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' AND UP.[IsActive] = @IsActive'	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
	SET @Query = @Query + @Query2
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @CreatedDateFrom
								, @CreatedDateTo
								, @Customer_ID
								, @EmployeeID
								, @IsBlocked
								, @IsConfirmed
								, @IsActive
								
END

