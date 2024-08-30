CREATE PROC [dbo].[GC_AnalysisData_NotProcessed_ImportData]
AS
BEGIN
	SET NOCOUNT ON;
	--RETURN
	DELETE	A
	FROM	[dbo].[GC_AnalysisData_NotProcessed] A WITH (NOLOCK) 
			INNER JOIN [YIELDDASHBOARD].[dbo].[HCM_SSIS_eDashBoard_AnalysisData] B WITH (NOLOCK)
									ON A.[Analysis_ID] = B.[Analysis_ID]
				
	INSERT INTO [dbo].[GC_AnalysisData_NotProcessed]
		   ([Analysis_ID]
           ,[MESCustomer_ID]
           ,[Customer_ID]
           ,[WIP_ID]
           ,[Process_ID]
           ,[SerialNumber]
           ,[StepIns]
           ,[UserID]
           ,[WindowsUserID]
           ,[AnalysisDateTime]
           ,[DefectText]
           ,[DefectLocation]
           ,[Defect_ID]
           ,[Assembly_ID]
           ,[AssyNumber]
           ,[Revision]
           ,[IsChildProcess]
           ,[Route]
           ,[Route_ID]
           ,[FailureLabel]
		   ,[LastUpdated]
		   ,[LastUpdatedBy])
	SELECT DISTINCT A.[Analysis_ID]
           ,ISNULL(B.[MESCustomer_ID], 0) AS [MESCustomer_ID]
           ,ISNULL((CASE WHEN B.[Customer_ID] = 6 THEN 4 ELSE B.[Customer_ID] END), 0) AS [Customer_ID]
           ,A.[WIP_ID]
           ,A.[Process_ID]
           ,ISNULL(B.[SerialNumber], '') AS [SerialNumber]
           ,ISNULL(B.[StepIns], '') AS [StepIns]
           ,B.[UserID] -- User that found defect
           ,B.[WindowsUserID]-- User that found defect
           ,A.[AnalysisDateTime]
           ,A.[DefectText]
           ,A.[DefectLocation]
           ,A.[Defect_ID]
           ,ISNULL(B.[Assembly_ID], '') AS [Assembly_ID]
           ,B.[AssyNumber]
           ,B.[Revision]
           ,(CASE WHEN B.[MESCustomer_ID] = 8 THEN (CASE WHEN B.[AssyNumber] LIKE '%SMT%' THEN 0
           WHEN B.[AssyNumber] LIKE '%MI%' THEN 0
           ELSE 1 END)
           ELSE 0 END) --Neu la Adtran WO, neu la BB Model, xet IsChildBoard = 1
           ,B.[Route]
           ,0 AS [Route_ID]
           ,'' AS [FailureLabel]
           ,GETDATE() AS [LastUpdated]
           ,0 AS [LastUpdatedBy]
	FROM	[YIELDDASHBOARD].[dbo].[HCM_SSIS_eDashBoard_AnalysisData] A WITH (NOLOCK) 
			LEFT OUTER JOIN [YIELDDASHBOARD].[dbo].[eDashBoard_TestData] B WITH (NOLOCK) ON A.[WIP_ID] = B.[WIP_ID]
																					AND A.[Process_ID] = B.[Process_ID]
	WHERE A.[Analysis_ID] IS NOT NULL
			AND A.[Defect_ID] != 126 -- No Analysis
			AND A.[Defect_ID] != 216 -- NDF_DEBUG
			--AND [AnalysisStatus] = 'C' -- Confirmed
			--AND A.[Analysis_ID] NOT IN (8632933)
	UPDATE A
	SET		[FailureLabel] = ISNULL(B.[FailureLabel], B.[DataLabel])
	FROM	[dbo].[GC_AnalysisData_NotProcessed] A WITH (NOLOCK)
				LEFT OUTER JOIN [YIELDDASHBOARD].[dbo].[eDashBoard_AnalysisData] B WITH (NOLOCK) ON A.[Analysis_ID] = B.[Analysis_ID]				
		
	UPDATE	A
	SET		[Route_ID] = B.[Route_ID]
	FROM	[dbo].[GC_AnalysisData_NotProcessed] A WITH (NOLOCK)
			LEFT OUTER JOIN [dbo].[CR_Routes] B WITH (NOLOCK) ON A.[Route] = B.[Route]			
END
