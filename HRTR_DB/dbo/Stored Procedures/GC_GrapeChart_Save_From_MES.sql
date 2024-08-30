CREATE PROC [dbo].[GC_GrapeChart_Save_From_MES] 
(
	@Analysis_ID				int, 
	@MESCustomer_ID				int, 
	@Customer_ID				int = 0,
	@Assembly_ID				int, 
	@SerialNumber				nvarchar(60), 
	@AssyNumber					nvarchar(60),  
	@Revision					nvarchar(20),  
	@StepIns					nvarchar(50), -- Detected
	@UserID						nvarchar(20), 
	@WindowsUserID				nvarchar(20),  -- Detected
	@CRDStepIns					nvarchar(50),
	@StartDateTime				datetime,
	@EscapedStepIns				nvarchar(50), 
	@EscapedUserID				nvarchar(20), 
	@EscapedWindowsUserID		nvarchar(20),
	@ParentSerialNumber			nvarchar(50) = ''
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @EscapedByEmployeeID_ID			int
			, @EscapedDate			datetime
			, @AnalysisDateTime		datetime
			, @ShiftID				int
			, @EscapedStationID		int
			, @Defect_ID			int
			, @DefectText			nvarchar(200)
			, @DefectLocation		nvarchar(27)
			, @DetectedByEmployeeID_ID			int
			, @DetectedStationID	int
			, @WorkcellID			int
			, @ChildSerialNumber	nvarchar(50)
			, @Route_ID				int
			, @Route				nvarchar(50)
			, @FailureLabel			nvarchar(100)
			, @ClientName			varchar(150)
	SELECT TOP 1 @WorkcellID = 	[WorkcellID]
	FROM [dbo].[CR_Workcell] WITH (NOLOCK)
	WHERE [MESCustomer_ID] = @MESCustomer_ID
	IF @Customer_ID = 0
		SET @Customer_ID = @MESCustomer_ID
		
	SET @EscapedByEmployeeID_ID = [dbo].[ufn_GetEmployeeID_ID_By_UserName](@EscapedWindowsUserID)
	SET @EscapedStationID = [dbo].[ufn_GetGC_StationID_By_StepIns](@Customer_ID, @EscapedStepIns)
	
	SET @DetectedByEmployeeID_ID = [dbo].[ufn_GetEmployeeID_ID_By_UserName](@WindowsUserID)
	SET @DetectedStationID = [dbo].[ufn_GetGC_StationID_By_StepIns](@Customer_ID, @StepIns)
	
	SELECT TOP 1 @AnalysisDateTime = [AnalysisDateTime]
				, @Defect_ID = [Defect_ID]
				, @DefectText = [DefectText]
				, @DefectLocation = [DefectLocation]
				, @Route_ID	= [Route_ID]
				, @Route = [Route]
				, @FailureLabel = [FailureLabel]
	FROM	[dbo].[GC_AnalysisData_Processing] WITH (NOLOCK)
	WHERE	[Analysis_ID] = @Analysis_ID
	
	SELECT TOP 1 @ClientName = [ClientName]
	FROM	[dbo].[GC_RoutesClients] WITH (NOLOCK)
	WHERE	[Route_ID] = @Route_ID
			AND [GC_StationID] = @EscapedStationID
	SET @ClientName = ISNULL(@ClientName, '')
	-- 20151124: if GE workcell, if Defect not in
	-- Missing - Thiếu linh kiện (3)
	-- Wrong polarity / reversed / orientation - Sai c?c/ Ngu?c hu?ng (18)
	-- Wrong Part - Sai linh ki?n (13)
	-- No solder - Không chì (9)
	-- ignore
	IF @MESCustomer_ID = 10
	BEGIN
		IF @Defect_ID NOT IN (3, 18, 13, 9)
		BEGIN
			RETURN
		END
	END 
	-- Temporary solution
	IF @Defect_ID = 185 OR @Defect_ID = 98 -- Electrically defective OR Firmware problem
		OR (@Defect_ID = 12 AND @MESCustomer_ID = 10) -- Damaged (GE workcell, not by operators), RITM1104466
	BEGIN
		RETURN
	END
	
	SET @ShiftID = [dbo].[ufn_GetShiftID_By_DateTime](@StartDateTime)
	
	IF DATEPART(HH, @StartDateTime) < 6
	BEGIN
		SET @EscapedDate = CONVERT(VARCHAR(10), DATEADD(DAY, -1, @StartDateTime), 120)
	END
	ELSE
	BEGIN
		SET @EscapedDate = CONVERT(VARCHAR(10), @StartDateTime, 120)
	END
	SET @ChildSerialNumber = ''
	IF @ParentSerialNumber != ''
	BEGIN
		SET @ChildSerialNumber = @SerialNumber
		SET @SerialNumber = @ParentSerialNumber
	END
	IF @EscapedByEmployeeID_ID <> -1 
		OR @EscapedStationID <> -1
	BEGIN
		DELETE 
		FROM [dbo].[GC_Data]
		WHERE [Analysis_ID] = @Analysis_ID
				AND [EscapedStationID] = -1
				AND [EscapedByEmployeeID_ID] = -1
	END
	
	IF EXISTS (SELECT 1
				FROM [dbo].[GC_Data] WITH (NOLOCK)
				WHERE [Analysis_ID] = @Analysis_ID
						--AND [StartDateTime] = @StartDateTime
						AND [EscapedStepIns] = @EscapedStepIns
						AND [EscapedByEmployeeID_ID] = @EscapedByEmployeeID_ID)
	BEGIN
		UPDATE [dbo].[GC_Data]
		SET		[WorkcellID] = @WorkcellID
				,[MESCustomer_ID] = @MESCustomer_ID
				,[Customer_ID] = @Customer_ID
				--,[EscapedByEmployeeID_ID] = @EscapedByEmployeeID_ID
				,[EscapedDate] = @EscapedDate
				,[ShiftID] = @ShiftID
				,[EscapedStationID] = @EscapedStationID
				,[Defect_ID] = @Defect_ID
				,[DefectText] = @DefectText
				,[CRD] = @DefectLocation
				,[Description] = ''
				
				,[DetectedByEmployeeID_ID] = @DetectedByEmployeeID_ID
				,[DetectedStationID] = @DetectedStationID
				,[Analysis_ID] = @Analysis_ID
				,[SerialNumber] = @SerialNumber
				,[ChildSerialNumber] = @ChildSerialNumber
				,[DetectedStepIns] = @StepIns
				,[DetectedWindowsUserID] = @WindowsUserID
				,[CRDStepIns] = @CRDStepIns
				,[StartDateTime] = @StartDateTime
				--,[EscapedStepIns] = @EscapedStepIns
				,[EscapedWindowsUserID] = @EscapedWindowsUserID
				,[IsMESAutoLinked] = 1 -- 
				,[LastUpdated] = GETDATE()
				,[LastUpdatedBy] = -1
				,[Route] = @Route
				,[FailureLabel] = @FailureLabel
				,[ClientName] = @ClientName
		WHERE [Analysis_ID] = @Analysis_ID
				--AND [StartDateTime] = @StartDateTime
				AND [EscapedStepIns] = @EscapedStepIns
				AND [EscapedByEmployeeID_ID] = @EscapedByEmployeeID_ID
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[GC_Data]
						([WorkcellID]
						,[MESCustomer_ID]
						,[Customer_ID]
						
						,[EscapedByEmployeeID_ID]
						,[EscapedDate]
						,[ShiftID]
						
						,[EscapedStationID]
						,[Defect_ID]
						,[DefectText]
						,[CRD]
						,[Description]
						,[DetectedByEmployeeID_ID]
						,[DetectedStationID]
						
						,[Analysis_ID]
						,[SerialNumber]
						,[ChildSerialNumber]
						,[DetectedStepIns]
						,[DetectedWindowsUserID]
						,[CRDStepIns]
						,[StartDateTime]
						
						,[EscapedStepIns]
						,[EscapedWindowsUserID]
						
						,[IsMESAutoLinked]
						,[LastUpdated]
						,[LastUpdatedBy]
						,[Route]
						,[FailureLabel]
						,[ClientName])
		VALUES(@WorkcellID
				   ,@MESCustomer_ID
				   ,@Customer_ID
				   
				   ,@EscapedByEmployeeID_ID
				   ,@EscapedDate
				   ,@ShiftID
				   
				   ,@EscapedStationID
				   ,@Defect_ID
				   ,@DefectText
				   ,@DefectLocation
				   ,'' -- [Description]
				   
				   ,@DetectedByEmployeeID_ID
				   ,@DetectedStationID
				   
				   ,@Analysis_ID
				   ,@SerialNumber
				   ,@ChildSerialNumber
				   ,@StepIns -- Detected
				   ,@WindowsUserID -- Detected
				   ,@CRDStepIns
				   ,@StartDateTime
				   
				   ,@EscapedStepIns
				   ,@EscapedWindowsUserID
				   
				   ,1 --
				   ,GETDATE()
				   ,-1
				   ,@Route
				   ,@FailureLabel
				   ,@ClientName)
	END
END


