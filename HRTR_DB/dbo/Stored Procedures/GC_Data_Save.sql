CREATE PROC [dbo].[GC_Data_Save] 
(
	@GC_DataID				int, 
	--@WorkcellID				int,
	@Customer_ID			int,
	@EscapedDate			datetime, 
	@ShiftID				int, 
	
	@EscapedByEmployeeID	nvarchar(10),
	@EscapedStationID		int, 
	
	@Defect_ID				int, 
	@DefectText				nvarchar(200), 
	@SerialNumber			nvarchar(50) = '',
	@CRD					nvarchar(255), 
	@Description			nvarchar(255), 
	
	
	
	@DetectedByEmployeeID	nvarchar(10),
	@DetectedStationID		int, 
	@LastUpdatedBy			int
)
AS
BEGIN
	SET NOCOUNT ON
	--RETURN
	DECLARE @EscapedByEmployeeID_ID		int,
			@DetectedByEmployeeID_ID	int
	SET @EscapedByEmployeeID_ID = [dbo].[ufn_GetEmployeeID_ID_By_EmployeeID](@EscapedByEmployeeID)
	SET @DetectedByEmployeeID_ID = [dbo].[ufn_GetEmployeeID_ID_By_EmployeeID](@DetectedByEmployeeID)
	
	SET @SerialNumber = UPPER(@SerialNumber)
	SET @CRD = UPPER(@CRD)
	
	IF EXISTS (SELECT 1
				FROM	[dbo].[GC_Data] WITH (NOLOCK)
				WHERE	[GC_DataID]=@GC_DataID)
	BEGIN
		--update existing record
		UPDATE [dbo].[GC_Data] 
		SET [Customer_ID] = @Customer_ID,
			[EscapedDate]=@EscapedDate, 
			[ShiftID]=@ShiftID, 
			
			[EscapedByEmployeeID_ID]=@EscapedByEmployeeID_ID, 
			[EscapedStationID]=@EscapedStationID, 
			
			[Defect_ID]=@Defect_ID, 
			[DefectText]=@DefectText, 
			[CRD]=@CRD, 
			[SerialNumber]=@SerialNumber, 
			[Description]=@Description, 
			
			[DetectedByEmployeeID_ID]=@DetectedByEmployeeID_ID, 
			[DetectedStationID]=@DetectedStationID, 
			
			[LastUpdated]=GETDATE(),
			[LastUpdatedBy]=@LastUpdatedBy
		WHERE [GC_DataID]=@GC_DataID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[GC_Data] (
		[Customer_ID]
      --,[MESCustomer_ID]
      ,[EscapedDate]
      ,[ShiftID]
      ,[EscapedByEmployeeID_ID]
      ,[EscapedStationID]
      ,[Defect_ID]
      ,[DefectText]
      ,[CRD]
      ,[Description]
      ,[DetectedByEmployeeID_ID]
      ,[DetectedStationID]
      --,[Analysis_ID]
      ,[SerialNumber]
      --,[StepIns]
      --,[WindowsUserID]
      --,[CRDStepIns]
      --,[StartDateTime]
      --,[EscapedStepIns]
      --,[EscapedWindowsUserID]
      --,[IsMESAutoLinked]
      ,[LastUpdated]
      ,[LastUpdatedBy])
		VALUES 
	  (
	  @Customer_ID
      --,@MESCustomer_ID
      ,@EscapedDate
      ,@ShiftID
      ,@EscapedByEmployeeID_ID
      ,@EscapedStationID
      ,@Defect_ID
      ,@DefectText
      ,@CRD
      ,@Description
      ,@DetectedByEmployeeID_ID
      ,@DetectedStationID
      --,@Analysis_ID
      ,@SerialNumber
      --,@StepIns
      --,@WindowsUserID
      --,@CRDStepIns
      --,@StartDateTime
      --,@EscapedStepIns
      --,@EscapedWindowsUserID
      --,@IsMESAutoLinked
      ,GETDATE()
      ,@LastUpdatedBy
      )
		SET @GC_DataID=SCOPE_IDENTITY()
	END
	
	IF @SerialNumber = ''
	BEGIN
		SET @SerialNumber = 'N/A' + CONVERT(VARCHAR, @GC_DataID)
			--update existing record
		UPDATE [dbo].[GC_Data] 
		SET [SerialNumber]=@SerialNumber,
			[LastUpdated]=GETDATE(),
			[LastUpdatedBy]=@LastUpdatedBy
		WHERE [GC_DataID]=@GC_DataID
	END
	
	EXEC [dbo].[GC_Data_Select] @GC_DataID

END


