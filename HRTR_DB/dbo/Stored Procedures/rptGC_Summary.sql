CREATE PROC [dbo].[rptGC_Summary] 
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
	@IsMESAutoLinked			int = -1, -- -1: All, 1: Yes, 0: No
	@GrapeChartTypeID			int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	--SET @EscapedDateFrom = CONVERT(VARCHAR(10), @EscapedDateFrom , 120)  + ' 00:00:00.000' 
	--SET @EscapedDateTo = CONVERT(VARCHAR(10), @EscapedDateTo , 120)  + ' 23:59:59.990' 
	--SELECT	
	--		A.[EmployeeID_ID]
	--		,B.[EmployeeID] -- Escaped
	--		,B.[EmployeeName]
	--		,COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
	--		,[dbo].[ufn_GetDefectText_By_EmployeeID_ID](A.[EmployeeID_ID], @EscapedDateFrom, @EscapedDateTo) AS [DefectText]
	--FROM	[dbo].[GC_Data_V1] A WITH (NOLOCK)	INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
	--											INNER JOIN [dbo].[CR_Shift] C WITH (NOLOCK) ON C.[ShiftID] = A.[ShiftID]
	--											INNER JOIN [dbo].[Station] D WITH (NOLOCK) ON D.[StationID] = A.[EscapedStationID]
	--											INNER JOIN [dbo].[Station] DS WITH (NOLOCK) ON DS.[StationID] = A.[DetectedStationID]
	--											INNER JOIN [dbo].[QM_Defects_V] E WITH (NOLOCK) ON E.[Defect_ID] = A.[Defect_ID]
	--WHERE 	A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
	--		AND (A.[ShiftID] = @ShiftID OR @ShiftID = 0)	
	--		AND (B.[WorkcellID] = @WorkcellID OR @WorkcellID = 0)
	--		AND (A.[EscapedStationID] = @EscapedStationID OR @EscapedStationID = 0)
	--		AND (A.[Defect_ID] = @Defect_ID OR @Defect_ID = 0)
	--		AND (A.[CRD] LIKE '%' + @CRD + '%' OR @CRD = '')
	--		AND (A.[SerialNumber] LIKE '%' + @SerialNumber + '%' OR @SerialNumber = '')
	--		AND (B.[EmployeeID] = @EscapedByEmployeeID OR @EscapedByEmployeeID = '')
			
	--		AND 
	--		(
	--			(ISNULL(A.[IsMESAutoLinked],0)=0 AND @IsMESAutoLinked = 0)
	--			OR (ISNULL(A.[IsMESAutoLinked],0)=1 AND @IsMESAutoLinked = 1)
	--			OR @IsMESAutoLinked = -1
	--		)
	--		AND A.[GrapeChartTypeID] = @GrapeChartTypeID
	--GROUP BY A.[EmployeeID_ID]
	--		,B.[EmployeeID] -- Escaped
	--		,B.[EmployeeName]
			
	
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
					@IsMESAutoLinked			int,
					@GrapeChartTypeID			int '			
								
	SET @EscapedDateFrom = CONVERT(VARCHAR(10), @EscapedDateFrom , 120)  + ' 00:00:00.000' 
	SET @EscapedDateTo = CONVERT(VARCHAR(10), @EscapedDateTo , 120)  + ' 23:59:59.990' 
	SET @Query = N'SELECT	
			A.[EmployeeID_ID]
			,B.[EmployeeID]
			,B.[EmployeeName]
			,COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
			,[dbo].[ufn_GetDefectText_By_EmployeeID_ID](A.[EmployeeID_ID], @EscapedDateFrom, @EscapedDateTo) AS [DefectText]
	FROM	[dbo].[GC_Data_V1] A WITH (NOLOCK)	INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
												INNER JOIN [dbo].[CR_Shift] C WITH (NOLOCK) ON C.[ShiftID] = A.[ShiftID]
												INNER JOIN [dbo].[GC_Station] D WITH (NOLOCK) ON D.[GC_StationID] = A.[EscapedStationID]
												INNER JOIN [dbo].[GC_Station] DS WITH (NOLOCK) ON DS.[GC_StationID] = A.[DetectedStationID]
												INNER JOIN [dbo].[QM_Defects_V] E WITH (NOLOCK) ON E.[Defect_ID] = A.[Defect_ID]
	WHERE 	A.[Customer_ID] = @Customer_ID AND B.[IsActive] = 1 '

	SET @Query2 = ''
	IF @EscapedDateFrom IS NOT NULL
		SET @Query2 = @Query2 + N' AND A.[EscapedDate] >= @EscapedDateFrom'
	IF @EscapedDateTo IS NOT NULL
		SET @Query2 = @Query2 + N' AND A.[EscapedDate] <= @EscapedDateTo'
	SET @Query2 =  @Query2 + N' AND A.[GrapeChartTypeID] = @GrapeChartTypeID'
	
	IF @ShiftID != 0
		SET @Query2 = @Query2 + + N' AND A.[ShiftID] = @ShiftID'
	IF @EscapedStationID != 0
		SET @Query2 = @Query2 + + N' AND A.[EscapedStationID] = @EscapedStationID'
	IF @DetectedStationID != 0
		SET @Query2 = @Query2 + + N' AND A.[DetectedStationID] = @DetectedStationID'
	IF @Defect_ID != 0
		SET @Query2 = @Query2 + + N' AND A.[Defect_ID] = @Defect_ID'
	IF @CRD != ''
		SET @Query2 = @Query2 + + N' AND A.[CRD] = @CRD'
	IF @SerialNumber != ''
		SET @Query2 = @Query2 + + N' AND A.[SerialNumber] = @SerialNumber'	
	IF @EscapedByEmployeeID != ''
		SET @Query2 = @Query2 + + N' AND B.[EmployeeID] = @EscapedByEmployeeID'	
	IF @DetectedByEmployeeID != ''
		SET @Query2 = @Query2 + + N' AND B.[EmployeeID] = @DetectedByEmployeeID'
	IF @IsMESAutoLinked != -1
		SET @Query2 = @Query2 + + N' AND A.[IsMESAutoLinked] = @IsMESAutoLinked'	
	SET @Query2 = @Query2 + ' GROUP BY A.[EmployeeID_ID]
										,B.[EmployeeID]
										,B.[EmployeeName]'	
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
								, @GrapeChartTypeID
								
END

