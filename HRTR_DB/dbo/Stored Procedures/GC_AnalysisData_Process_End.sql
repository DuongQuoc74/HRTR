CREATE PROC [dbo].[GC_AnalysisData_Process_End]
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE
	FROM	A
	FROM	[dbo].[GC_AnalysisData] A WITH (NOLOCK) 
			INNER JOIN [dbo].[GC_AnalysisData_Processing] B WITH (NOLOCK) ON A.[Analysis_ID] = B.[Analysis_ID]
	WHERE	B.[GC_ProcessStatusID] IS NOT NULL
	
	INSERT INTO [dbo].[GC_AnalysisData]
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
		,[CRDStepIns]
		,[GC_ProcessStatusID]
		,[ReviewDate]
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
		,A.[CRDStepIns]
		,A.[GC_ProcessStatusID]
		,A.[ReviewDate]
		,A.[IsChildProcess]
		,A.[Route]
		,A.[Route_ID]
		,A.[FailureLabel]
		,GETDATE() AS [LastUpdated]
		,-1 AS [LastUpdatedBy]
	FROM [dbo].[GC_AnalysisData_Processing] A WITH (NOLOCK)
	WHERE A.[GC_ProcessStatusID] IS NOT NULL
	

	DECLARE @tmpReviewDate AS TABLE
	(
		[No]			[int],
		[ReviewDate]	[datetime]
	)
	INSERT INTO @tmpReviewDate
	SELECT DISTINCT DENSE_RANK () OVER (ORDER BY [ReviewDate])
			, [ReviewDate]
	FROM [dbo].[GC_AnalysisData_Processing] A WITH (NOLOCK)
	WHERE [GC_ProcessStatusID] = 2 -- Successfully Processing
	
	-- Calculate Summary Data START
	DECLARE @TotalDays		int
			, @I			int
			, @ReviewDate	datetime
	SELECT TOP 1 @TotalDays = [No]
	FROM @tmpReviewDate
	ORDER BY [No] DESC
	SET @I = 1
	WHILE (@I <= @TotalDays)
	BEGIN
		SELECT TOP 1 @ReviewDate = [ReviewDate]
		FROM @tmpReviewDate
		WHERE [No] = @I
		EXECUTE [dbo].[GC_Daily_Calculate] @ReviewDate
		SET @I = @I + 1
	END
	
	-- Calculate Summary Data END
	
	
	DELETE A
	FROM [dbo].[GC_AnalysisData_Processing] A WITH (NOLOCK)
	WHERE [GC_ProcessStatusID] IS NOT NULL
	
END




