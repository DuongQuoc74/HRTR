CREATE PROC [dbo].[GC_Data_Delete] 
(
	@GC_DataID int,
	@LastUpdatedBy	int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO [dbo].[GC_DataH]
	   ([GC_DataID]
      ,[WorkcellID]
      ,[MESCustomer_ID]
      ,[Customer_ID]
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
	SELECT [GC_DataID]
      ,[WorkcellID]
      ,[MESCustomer_ID]
      ,[Customer_ID]
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
      ,GETDATE() AS [LastUpdated]
	   ,@LastUpdatedBy AS [LastUpdatedBy]
      ,[Route]
      ,[FailureLabel]
      ,[ClientName]
	  
	FROM [dbo].[GC_Data] WITH (NOLOCK)
	WHERE [GC_DataID] = @GC_DataID

	DELETE
	FROM [dbo].[GC_Data]
	WHERE [GC_DataID] = @GC_DataID

END

