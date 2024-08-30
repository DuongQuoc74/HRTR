CREATE PROC [dbo].[GC_AnalysisData_Process_Start]
AS
BEGIN
	SET NOCOUNT ON;
	--IF NOT EXISTS (SELECT 1
	--				FROM [dbo].[GC_AnalysisData_Processing] WITH (NOLOCK)
	--				)
	--BEGIN
	INSERT INTO [dbo].[GC_AnalysisData_Processing]
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
	SELECT A.[Analysis_ID]
			,A.[MESCustomer_ID]
			,A.[Customer_ID]
			,A.[WIP_ID]
			,A.[Process_ID]
			,A.[SerialNumber]
			,A.[StepIns]

			,A.[UserID]
			,A.[WindowsUserID]
			,A.[AnalysisDateTime]
			,A.[DefectText]
			,A.[DefectLocation]
			,A.[Defect_ID]
			,A.[Assembly_ID]
			,A.[AssyNumber]
			,A.[Revision]
			,A.[IsChildProcess]
			,A.[Route]
			,A.[Route_ID]
			,A.[FailureLabel]
			,A.[LastUpdated] AS [LastUpdated]
			,-1 AS [LastUpdatedBy]
	FROM [dbo].[GC_AnalysisData_NotProcessed] A WITH (NOLOCK)
	
	
	DELETE B 
	FROM [dbo].[GC_AnalysisData_Processing] A WITH (NOLOCK) 
			INNER JOIN [dbo].[GC_AnalysisData_NotProcessed] B WITH (NOLOCK) ON A.[Analysis_ID] = B.[Analysis_ID]
--END

	SELECT TOP 2000 [Analysis_ID]
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
			  ,[CRDStepIns]
			  ,[GC_ProcessStatusID]
			  ,[IsChildProcess]
	FROM	[dbo].[GC_AnalysisData_Processing] WITH (NOLOCK)
	WHERE	[GC_ProcessStatusID] IS NULL
			AND [AnalysisDateTime] <= DATEADD(HH, -2, GETDATE()) -- Because get data from MES Reporting server, 1 hour delay data
	ORDER BY [LastUpdated] DESC
	
END




