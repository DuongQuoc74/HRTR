CREATE PROC [dbo].[GC_MESRules_Select_By_Customer_ID_DetectedStepIns_CRDStepIns_20170710] 
(
	@Customer_ID		int,
	@DetectedStepIns	nvarchar(50),
	@Defect_ID			int = 0,
	@CRD				nvarchar(27) = '',
	@CRDStepIns			nvarchar(50)
	
)
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #tmp
	(
		[EscapedStepIns]	nvarchar(50)
	)
	IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRules] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStepIns] = @DetectedStepIns
						AND [CRDStepIns] = @CRDStepIns
						AND [Defect_ID] = @Defect_ID
						AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'A'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStepIns]
		FROM [dbo].[GC_MESRules] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStepIns] = @DetectedStepIns
				AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
				AND [Defect_ID] = @Defect_ID
				AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRules] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStepIns] = @DetectedStepIns
						AND [CRDStepIns] = @CRDStepIns
						AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'B'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStepIns]
		FROM [dbo].[GC_MESRules] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStepIns] = @DetectedStepIns
				AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
				AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRules] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStepIns] = @DetectedStepIns
						AND [CRDStepIns] = @CRDStepIns
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'C'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStepIns]
		FROM [dbo].[GC_MESRules] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStepIns] = @DetectedStepIns
				AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRules] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStepIns] = @DetectedStepIns
						AND [CRDStepIns] = '[All]'
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'D'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStepIns]
		FROM [dbo].[GC_MESRules] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStepIns] = @DetectedStepIns
				AND [CRDStepIns] = '[All]'
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE
	BEGIN
	--PRINT 'E'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStepIns]
		FROM [dbo].[GC_MESRules] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStepIns] = @DetectedStepIns
				AND [CRDStepIns] = '[All]'
				AND [CRD] = '[All]'
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	SELECT [EscapedStepIns]
	FROM #tmp 
	WHERE [EscapedStepIns] NOT IN (SELECT	[EscapedStepIns]
									FROM	[dbo].[GC_MESRules] WITH (NOLOCK)
									WHERE  	[Customer_ID] = @Customer_ID
										AND ([DetectedStepIns] = @DetectedStepIns OR [DetectedStepIns] = '[All]')
										AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
										AND ([Defect_ID] = @Defect_ID OR [Defect_ID] = -1)
										AND ([CRD] = @CRD OR @CRD LIKE [CRD] + '/%' OR [CRD] = '[All]')
										AND [IsActive] = 1
										AND [IsExcluded] = 1
									)
	DROP TABLE #tmp
END

