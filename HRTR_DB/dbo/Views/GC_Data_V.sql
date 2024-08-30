
















CREATE VIEW [dbo].[GC_Data_V]
AS
	SELECT A.[GC_DataID]
	  ,A.[WorkcellID]
	  ,A.[MESCustomer_ID]
	  ,A.[Customer_ID]
	  ,A.[EscapedDate]
	  --,DATEPART(WW, A.[EscapedDate]) AS A.[Week]
	  ,[dbo].[ufn_GC_Week_By_DateTime](A.[EscapedDate]) AS [Week]
	  --,DATEPART(MONTH, A.[EscapedDate]) AS A.[Month]
	  ,[dbo].[ufn_GC_Month_By_DateTime](A.[EscapedDate]) AS [Month]
	  ,A.[ShiftID]
	  ,A.[EscapedByEmployeeID_ID]
	  ,A.[EscapedStationID]
	  ,A.[Defect_ID]
	  ,A.[DefectText]
	  --,A.[CRD]
	  ,[dbo].[ufn_CRD](A.[CRD]) AS [CRD]
	  ,A.[Description]
	  ,A.[DetectedByEmployeeID_ID]
	  ,A.[DetectedStationID]
	  ,A.[Analysis_ID]
	  ,A.[SerialNumber]
	  ,A.[ChildSerialNumber]
	  ,A.[DetectedStepIns]
	  ,A.[DetectedWindowsUserID]
	  ,A.[CRDStepIns]
	  ,A.[StartDateTime]
	  ,A.[EscapedStepIns]
	  ,A.[EscapedWindowsUserID]
	  ,A.[IsMESAutoLinked]
	  ,A.[LastUpdated]
	  ,A.[LastUpdatedBy]
	  ,A.[Route]
      ,ISNULL(A.[FailureLabel], B.[Comment]) AS [FailureLabel]
      ,B.[Comment] AS [FailureDetails]
      ,A.[ClientName]
	FROM [dbo].[GC_Data] A WITH (NOLOCK) 
			LEFT OUTER JOIN [dbo].[QM_FailureData_V1] B ON A.[FailureLabel] = B.[DataLabel]







