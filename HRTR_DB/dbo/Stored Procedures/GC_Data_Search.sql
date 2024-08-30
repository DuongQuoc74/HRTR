CREATE PROC [dbo].[GC_Data_Search] 
(
	@EscapedDateFrom			datetime,
	@EscapedDateTo				datetime,
	--@WorkcellID					int = 1,
	@Customer_ID				int = 0,
	@ShiftID					int = 0,
	
	@EscapedStationID			int = 0,
	@DetectedStationID			int = 0,
	@Defect_ID					int = 0,
	@CRD						nvarchar(255),
	@SerialNumber				nvarchar(50) = '',
	@Description				nvarchar(255),
	@EscapedByEmployeeID		nvarchar(10),
	@DetectedByEmployeeID		nvarchar(10) = '',
	@IsMESAutoLinked			int = -1 -- -1: All, 1: Yes, 0: No
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@EscapedDateFrom			datetime,
					@EscapedDateTo				datetime,
					@Customer_ID				int,
					@ShiftID					int,
					@EscapedStationID			int,
					@DetectedStationID			int,
					@Defect_ID					int,
					@CRD						nvarchar(255),
					@SerialNumber				nvarchar(50),
					@Description				nvarchar(255),
					@EscapedByEmployeeID		nvarchar(10),
					@DetectedByEmployeeID		nvarchar(10),
					@IsMESAutoLinked			int
					'			
								
	SET @EscapedDateFrom = CONVERT(VARCHAR(10), @EscapedDateFrom , 120)  + ' 00:00:00.000' 
	SET @EscapedDateTo = CONVERT(VARCHAR(10), @EscapedDateTo , 120)  + ' 23:59:59.990' 
	SET @Query = N'SELECT	
			A.[GC_DataID]
			,A.[EscapedDate]
			,C.[ShiftName] 
			,DE.[EmployeeID] AS [DetectedByEmployeeID] 
			,DE.[EmployeeName] AS [DetectedByEmployeeName] 
			,A.[DetectedWindowsUserID]
			,DS.[StationName] AS [DetectedStationName]
			,A.[DetectedStepIns]
			,B.[EmployeeID] AS [EscapedByEmployeeID]
			,B.[EmployeeName]  AS [EscapedByEmployeeName]
			,A.[EscapedWindowsUserID]
			,D.[StationName] AS [EscapedStationName]
			,A.[EscapedStepIns]
			
			,E.[DefectText]
			,A.[CRD]
			,A.[CRDStepIns]
			,A.[SerialNumber]
			,A.[ChildSerialNumber]
			,A.[Route]
			,A.[FailureLabel]
			,A.[FailureDetails]
			,A.[ClientName]
			
			,A.[Description]
			
			,A.[StartDateTime]
			,A.[IsMESAutoLinked]
	FROM	[dbo].[GC_Data_V] A WITH (NOLOCK)	INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EscapedByEmployeeID_ID] = B.[EmployeeID_ID]
												INNER JOIN [dbo].[CR_Shift] C WITH (NOLOCK) ON C.[ShiftID] = A.[ShiftID]
												INNER JOIN [dbo].[GC_Station] D WITH (NOLOCK) ON D.[GC_StationID] = A.[EscapedStationID]
												INNER JOIN [dbo].[HR_Employee] DE WITH (NOLOCK) ON DE.[EmployeeID_ID] = A.[DetectedByEmployeeID_ID]
												INNER JOIN [dbo].[GC_Station] DS WITH (NOLOCK) ON DS.[GC_StationID] = A.[DetectedStationID]
												INNER JOIN [dbo].[QM_Defects_V] E WITH (NOLOCK) ON E.[Defect_ID] = A.[Defect_ID]'

	SET @Query2 = ''
	IF @Customer_ID != 0
		SET @Query2 = @Query2 + N' AND A.[Customer_ID] = @Customer_ID'
		
	IF @EscapedDateFrom IS NOT NULL
		SET @Query2 = @Query2 + N' AND A.[EscapedDate] >= @EscapedDateFrom'
	IF @EscapedDateTo IS NOT NULL
		SET @Query2 = @Query2 + N' AND A.[EscapedDate] <= @EscapedDateTo'
	IF @ShiftID != 0
		SET @Query2 = @Query2 + N' AND A.[ShiftID] = @ShiftID'
	IF @EscapedStationID != 0
		SET @Query2 = @Query2 + N' AND A.[EscapedStationID] = @EscapedStationID'
	IF @DetectedStationID != 0
		SET @Query2 = @Query2 + N' AND A.[DetectedStationID] = @DetectedStationID'
	IF @Defect_ID != 0
		SET @Query2 = @Query2 + N' AND A.[Defect_ID] = @Defect_ID'
	IF @CRD != ''
		SET @Query2 = @Query2 + N' AND A.[CRD] = @CRD'
	IF @SerialNumber != ''
		SET @Query2 = @Query2 + N' AND A.[SerialNumber] = @SerialNumber'	
	IF @EscapedByEmployeeID != ''
		SET @Query2 = @Query2 + N' AND B.[EmployeeID] = @EscapedByEmployeeID'	
	IF @DetectedByEmployeeID != ''
		SET @Query2 = @Query2 + N' AND DE.[EmployeeID] = @DetectedByEmployeeID'
	IF @IsMESAutoLinked != -1
		SET @Query2 = @Query2 + N' AND A.[IsMESAutoLinked] = @IsMESAutoLinked'	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)			
	SET @Query = @Query + @Query2
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @EscapedDateFrom
								, @EscapedDateTo
								, @Customer_ID
								, @ShiftID
								, @EscapedStationID
								, @DetectedStationID
								, @Defect_ID
								, @CRD
								, @SerialNumber
								, @Description
								, @EscapedByEmployeeID
								, @DetectedByEmployeeID
								, @IsMESAutoLinked
								
END


