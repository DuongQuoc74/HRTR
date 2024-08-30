CREATE PROC [dbo].[GC_AnalysisData_Process_CCS]

AS
BEGIN
	SET NOCOUNT ON
	DECLARE @FromDate	datetime
			, @ToDate	datetime
			, @I		int
			, @Cnt		int
			, @Analysis_ID	int
	SET @ToDate = GETDATE()
	SET @FromDate = DATEADD(HH, -8, @ToDate)
	
	CREATE TABLE #tmpGC_AnalysisData
	(
		[No.]			int IDENTITY(1, 1),
		[Analysis_ID]	int
	)
	INSERT INTO #tmpGC_AnalysisData
	SELECT  [Analysis_ID]
	FROM [dbo].[GC_AnalysisData] WITH (NOLOCK)
	WHERE [AnalysisDateTime] BETWEEN @FromDate AND @ToDate
			AND [Customer_ID] = 5
			AND [GC_ProcessStatusID] IN (1, 2, 3, 4)
			--AND [Route_ID] = 33 -- ING BOXBUILD ROUTE 01
			--AND ANALYSIS_ID = 8607802
	SELECT @Cnt = MAX([No.])
	FROM #tmpGC_AnalysisData
	SET @I = 1
	WHILE @I <= @Cnt
	BEGIN
		SELECT TOP 1 @Analysis_ID = [Analysis_ID]
		FROM #tmpGC_AnalysisData
		WHERE [No.] = @I
		
		--PRINT @Analysis_ID
		-- Process 1 record START
		-- From StepIns + Customer => Station
		DECLARE	@GC_StationID					int = 0
				, @AnalysisDateTime				datetime = NULL
				
				, @MESCustomer_ID				int = 0
				, @Customer_ID					int = 0
				, @Assembly_ID					int = 0
				, @SerialNumber					nvarchar(60) = ''
				, @AssyNumber					nvarchar(60) = ''
				, @Revision						nvarchar(20) = ''
				, @StepIns						nvarchar(50) = ''
				, @UserID						nvarchar(20) = ''
				, @WindowsUserID				nvarchar(20) = ''
				, @CRDStepIns					nvarchar(50) = ''
				, @StartDateTime				datetime = NULL
				, @Defect_ID					int = 0
				, @DefectText					nvarchar(200) = ''
				, @DefectLocation				nvarchar(27) = ''
				, @EscapedStepIns				nvarchar(50) = ''
				, @EscapedWindowsUserID			nvarchar(20) = ''
				
				, @Route_ID						int = 0
				, @Route						nvarchar(50) = ''
				, @FailureLabel					nvarchar(100) = ''
				
				, @EscapedStationID				int = -1
				, @ClientName					varchar(150) = ''
				, @EscapedByEmployeeID_ID		int = -1
		--SET @FailureLabel = ''		
		--SET @EscapedStationID = 0
		SELECT TOP 1 @GC_StationID = B.[GC_StationID]
					, @AnalysisDateTime = A.[AnalysisDateTime]
					
					, @MESCustomer_ID = A.[MESCustomer_ID]
					, @Customer_ID = A.[Customer_ID]
					, @Assembly_ID = A.[Assembly_ID]
					, @SerialNumber = A.[SerialNumber]
					, @AssyNumber = A.[AssyNumber]
					, @Revision = A.[Revision]
					, @StepIns = A.[StepIns]
					, @UserID = A.[UserID]
					, @WindowsUserID = A.[WindowsUserID]
					, @CRDStepIns = A.[CRDStepIns]
					--, @StartDateTime = A.[StartDateTime]
					, @Defect_ID = A.[Defect_ID]
					, @DefectText = A.[DefectText]-- + N'/ ' + A.[FailureLabel]
					, @DefectLocation = A.[DefectLocation]

					, @Route_ID = A.[Route_ID]
					, @Route = A.[Route]
					, @FailureLabel = A.[FailureLabel]
		FROM [dbo].[GC_AnalysisData] A WITH (NOLOCK)
				INNER JOIN [dbo].[GC_StepInsStation] B WITH (NOLOCK) ON A.[Customer_ID] = B.[Customer_ID] AND A.[StepIns] = B.[StepIns]
		WHERE A.[Analysis_ID] = @Analysis_ID
		
		SET @GC_StationID = ISNULL(@GC_StationID, 0)
		SET @Route_ID = ISNULL(@Route_ID, 0)
		SET @FailureLabel = LTRIM(RTRIM(ISNULL(@FailureLabel, '')))
		
		-- If FC Station -> Check FailureLabel -> Escape Station 
		IF @GC_StationID <> 0 AND @Route_ID <> 0
			AND @FailureLabel <> ''
		BEGIN
			
			SELECT TOP 1 @EscapedStationID = A.[EscapedGC_StationID]
						, @EscapedStepIns = B.[StationName]
			FROM [dbo].[GC_MESRulesFailureLabel] A WITH (NOLOCK) INNER JOIN [dbo].[GC_Station] B WITH (NOLOCK) ON A.[EscapedGC_StationID] = B.[GC_StationID]
			WHERE A.[GC_StationID] = @GC_StationID
					AND A.[FailureLabel] = @FailureLabel
					
			
					
			SET @EscapedStationID = ISNULL(@EscapedStationID, 0)
			
			--PRINT @EscapedStepIns
			-- From Route and Station -> Client Name
			IF @EscapedStationID <> 0 
			BEGIN
			--PRINT @FailureLabel
			--PRINT @EscapedStationID
			
			--SELECT A.[EscapedGC_StationID]
			--			 , B.[StationName]
			--			 , A.[GC_StationID]
			--			 , A.[FailureLabel]
			--FROM [dbo].[GC_MESRulesFailureLabel] A WITH (NOLOCK) INNER JOIN [dbo].[GC_Station] B WITH (NOLOCK) ON A.[EscapedGC_StationID] = B.[GC_StationID]
			--WHERE A.[GC_StationID] = @GC_StationID
			--		AND A.[FailureLabel] = @FailureLabel
					
			--RETURN
				--PRINT @EscapedStationID
				SELECT TOP 1 @ClientName = [ClientName]
				FROM	[dbo].[GC_RoutesClients] WITH (NOLOCK)
				WHERE	[Route_ID] = @Route_ID
						AND [GC_StationID] = @EscapedStationID
				SET @ClientName = ISNULL(@ClientName, '')
				-- From Client Name & Login (CCS) -> Escaped Employee ID
				IF @ClientName <> ''
				BEGIN
					SELECT TOP 1 @EscapedByEmployeeID_ID = B.[EmployeeID_ID]
								, @StartDateTime = A.[LoginTime]
								, @EscapedWindowsUserID = A.[UserName]
					FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)
							INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[UserName] = B.[UserName]
					WHERE A.[ClientName] = @ClientName
							AND A.[LoginTime] < @AnalysisDateTime
					ORDER BY A.[LoginTime] DESC
					SET @EscapedByEmployeeID_ID = ISNULL(@EscapedByEmployeeID_ID, -1)
					
				END
				--IF @EscapedByEmployeeID_ID <> -1
				--BEGIN
				-- UPDATE
				UPDATE [dbo].[GC_AnalysisData]
				SET   [GC_ProcessStatusID] = 5 -- 20150729: New logic for Ingenico BB, testing
					,[LastUpdated] = GETDATE()
					,[LastUpdatedBy] = -1
				WHERE [Analysis_ID] = @Analysis_ID
				
				EXEC[dbo].[GC_GrapeChart_Save_From_CCS]
						@Analysis_ID,
						@MESCustomer_ID,
						@Customer_ID,
						@Assembly_ID,
						@SerialNumber, 
						@AssyNumber,
						@Revision,
						@StepIns,
						@UserID,
						@WindowsUserID,
						@CRDStepIns,
						@StartDateTime,
						@AnalysisDateTime,
						@Defect_ID,
						@DefectText,
						@DefectLocation,
						@EscapedStepIns,
						@EscapedWindowsUserID,
						@EscapedStationID,
						@EscapedByEmployeeID_ID,
						@Route,
						@FailureLabel,
						@ClientName
				--END
				
				--PRINT 'Escaped Employee_ID'
				--PRINT @EscapedByEmployeeID_ID
				
			END
		END
		
		
		-- Process 1 record END
		
		SET @I = @I + 1
	END
	DROP TABLE #tmpGC_AnalysisData

	EXEC [dbo].[GC_Daily_Calculate_All]
	--DECLARE @tmpReviewDate AS TABLE
	--(
	--	[No]			[int],
	--	[ReviewDate]	[datetime]
	--)
	--INSERT INTO @tmpReviewDate
	--SELECT DISTINCT DENSE_RANK () OVER (ORDER BY [ReviewDate])
	--		, [ReviewDate]
	--FROM [dbo].[GC_AnalysisData] WITH (NOLOCK)
	--WHERE [AnalysisDateTime] BETWEEN @FromDate AND @ToDate
	--		AND [Customer_ID] = 5
	---- Calculate Summary Data START
	--DECLARE @TotalDays		int
	--		--, @I			int
	--		, @ReviewDate	datetime
	--SELECT TOP 1 @TotalDays = [No]
	--FROM @tmpReviewDate
	--ORDER BY [No] DESC
	--SET @I = 1
	--WHILE (@I <= @TotalDays)
	--BEGIN
	--	SELECT TOP 1 @ReviewDate = [ReviewDate]
	--	FROM @tmpReviewDate
	--	WHERE [No] = @I
	--	EXECUTE [dbo].[GC_Daily_Calculate] @ReviewDate
	--	SET @I = @I + 1
	--END
	
	---- Calculate Summary Data END
	
END

