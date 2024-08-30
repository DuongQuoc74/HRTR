









CREATE VIEW [dbo].[GC_Data_V1]
AS

	SELECT [GC_DataID]
      ,[WorkcellID]
      ,[MESCustomer_ID]
      ,[Customer_ID]
      ,[EscapedDate]
      ,[ShiftID]
      ,[EscapedByEmployeeID_ID] AS [EmployeeID_ID]
      ,[EscapedStationID]
      ,[Defect_ID]
      ,[DefectText]
      --,[CRD]
      ,[dbo].[ufn_CRD]([CRD]) AS [CRD]
      ,[Description]
      ,[DetectedByEmployeeID_ID]
      ,[DetectedStationID]
      ,[Analysis_ID]
      ,[SerialNumber]
      ,[DetectedStepIns]
      ,[DetectedWindowsUserID]
      ,[CRDStepIns]
      ,[StartDateTime]
      ,[EscapedStepIns]
      ,[EscapedWindowsUserID]
      ,[IsMESAutoLinked]
      ,[LastUpdated]
      ,[LastUpdatedBy]
	  ,1 AS [GrapeChartTypeID]
	FROM [dbo].[GC_Data] WITH (NOLOCK)
  
	UNION
	
	SELECT [GC_DataID]
      ,[WorkcellID]
      ,[MESCustomer_ID]
      ,[Customer_ID]
      ,[EscapedDate]
      ,[ShiftID]
      --,[EscapedByEmployeeID_ID]
      ,[DetectedByEmployeeID_ID]  AS [EmployeeID_ID]
      ,[EscapedStationID]
      ,[Defect_ID]
      ,[DefectText]
      --,[CRD]
      ,[dbo].[ufn_CRD]([CRD]) AS [CRD]
      ,[Description]
      ,[DetectedByEmployeeID_ID] 
      ,[DetectedStationID]
      ,[Analysis_ID]
      ,[SerialNumber]
      ,[DetectedStepIns]
      ,[DetectedWindowsUserID]
      ,[CRDStepIns]
      ,[StartDateTime]
      ,[EscapedStepIns]
      ,[EscapedWindowsUserID]
      ,[IsMESAutoLinked]
      ,[LastUpdated]
      ,[LastUpdatedBy]
	  ,2 AS [GrapeChartTypeID]
	FROM [dbo].[GC_Data] WITH (NOLOCK)









