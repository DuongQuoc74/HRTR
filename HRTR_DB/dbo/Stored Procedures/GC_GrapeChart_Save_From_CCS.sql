CREATE PROC [dbo].[GC_GrapeChart_Save_From_CCS] 
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
	@AnalysisDateTime			datetime,
	@Defect_ID					int,
	@DefectText					nvarchar(200),
	@DefectLocation				nvarchar(27),
	@EscapedStepIns				nvarchar(50),
	@EscapedWindowsUserID		nvarchar(20),
	@EscapedStationID			int,
	@EscapedByEmployeeID_ID		int,
	@Route						nvarchar(50),
	@FailureLabel				nvarchar(100),
	@ClientName					varchar(150)
)
AS
BEGIN
	SET NOCOUNT ON
	--RETURN
	DECLARE @EscapedDate			datetime
			, @ShiftID				int
			, @DetectedByEmployeeID_ID			int
			, @DetectedStationID	int
			, @WorkcellID			int
			, @ChildSerialNumber	nvarchar(50) = ''
	SELECT TOP 1 @WorkcellID = 	[WorkcellID]
	FROM [dbo].[CR_Workcell] WITH (NOLOCK)
	WHERE [MESCustomer_ID] = @MESCustomer_ID
	IF @Customer_ID = 0
		SET @Customer_ID = @MESCustomer_ID
	
	SET @DetectedByEmployeeID_ID = [dbo].[ufn_GetEmployeeID_ID_By_UserName](@WindowsUserID)
	SET @DetectedStationID = [dbo].[ufn_GetGC_StationID_By_StepIns](@Customer_ID, @StepIns)

	-- Temporary solution
	IF --@MESCustomer_ID IN (10, 11) -- GE, L+G
		--AND 
		@Defect_ID = 185 OR @Defect_ID = 98 -- Electrically defective OR Firmware problem
	BEGIN
		RETURN
	END
	IF @StartDateTime IS NULL
		SET @StartDateTime = @AnalysisDateTime
		
	SET @ShiftID = [dbo].[ufn_GetShiftID_By_DateTime](@StartDateTime)
	IF DATEPART(HH, @StartDateTime) < 6
	BEGIN
		SET @EscapedDate = CONVERT(VARCHAR(10), DATEADD(DAY, -1, @StartDateTime), 120)
	END
	ELSE
	BEGIN
		SET @EscapedDate = CONVERT(VARCHAR(10), @StartDateTime, 120)
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
	IF @EscapedByEmployeeID_ID  = -1
	BEGIN
		--PRINT 'AAAAAAAAAAA'
		SELECT TOP 1 @EscapedByEmployeeID_ID = [EscapedByEmployeeID_ID]
		FROM [dbo].[GC_MESRulesFailureLabel] WITH (NOLOCK)
		WHERE [GC_StationID] = @DetectedStationID
				AND [FailureLabel] = @FailureLabel
	END
	SET @EscapedByEmployeeID_ID = ISNULL(@EscapedByEmployeeID_ID, -1)
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
				,[Route] = @Route
				,[FailureLabel] = @FailureLabel
				,[ClientName] = @ClientName
				,[IsMESAutoLinked] = 1 -- 
				,[LastUpdated] = GETDATE()
				,[LastUpdatedBy] = -1
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
						,[Route]
						,[FailureLabel]
						,[ClientName]
						,[IsMESAutoLinked]
						,[LastUpdated]
						,[LastUpdatedBy])
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

					,@Route
					,@FailureLabel
					,@ClientName

					,1 --
					,GETDATE()
					,-1)
	END
END


