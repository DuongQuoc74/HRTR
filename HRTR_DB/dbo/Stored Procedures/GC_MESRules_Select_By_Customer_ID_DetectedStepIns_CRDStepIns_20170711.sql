--find escaped step ins
CREATE PROC [dbo].[GC_MESRules_Select_By_Customer_ID_DetectedStepIns_CRDStepIns_20170711] 
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
	DECLARE @MESCustomer_ID			int
			, @DetectedStationID	int
	SELECT TOP 1 @MESCustomer_ID = [MESCustomer_ID]
	FROM [dbo].[GC_Customers] WITH (NOLOCK)
	WHERE [Customer_ID] = @Customer_ID
	-- from @DetectedStepIns => @DetectedStationID
	SET @DetectedStationID = [dbo].[ufn_GC_StepInsStation_Find_GC_StationID](@Customer_ID, @DetectedStepIns, @MESCustomer_ID)

	CREATE TABLE #tmp
	(
		[EscapedStationID]	int
	)

	IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStationID] = @DetectedStationID
						AND [CRDStepIns] = @CRDStepIns
						AND [Defect_ID] = @Defect_ID
						AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'A'
		INSERT INTO #tmp
		SELECT DISTINCT [EscapedStationID]
		FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStationID] = @DetectedStationID
				AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
				AND [Defect_ID] = @Defect_ID
				AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStationID] = @DetectedStationID
						AND [CRDStepIns] = @CRDStepIns
						AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'B'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStationID]
		FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStationID] = @DetectedStationID
				AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
				AND ([CRD] = @CRD  OR [CRD] LIKE @CRD + '/%')
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStationID] = @DetectedStationID
						AND [CRDStepIns] = @CRDStepIns
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'C'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStationID]
		FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStationID] = @DetectedStationID
				AND ([CRDStepIns] = @CRDStepIns OR [CRDStepIns] = '[All]')
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
				WHERE [Customer_ID] = @Customer_ID
						AND [DetectedStationID] = @DetectedStationID
						AND [CRDStepIns] = '[All]'
						AND [IsActive] = 1
						AND [IsExcluded] = 0
	)
	BEGIN
	--PRINT 'D'
		INSERT INTO #tmp
		SELECT	DISTINCT [EscapedStationID]
		FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStationID] = @DetectedStationID
				AND [CRDStepIns] = '[All]'
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	ELSE
	BEGIN
	--PRINT 'E'
		INSERT INTO #tmp
		SELECT DISTINCT [EscapedStationID]
		FROM [dbo].[GC_MESRulesStation] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
				AND [DetectedStationID] = @DetectedStationID
				AND [CRDStepIns] = '[All]'
				AND [CRD] = '[All]'
				AND [IsActive] = 1
				AND [IsExcluded] = 0
	END
	SELECT C.[StepIns]
	FROM #tmp A WITH (NOLOCK) INNER JOIN [dbo].[GC_StepInsStation] C WITH (NOLOCK) ON A.[EscapedStationID] = C.[GC_StationID]
	WHERE C.[Customer_ID] = @Customer_ID
			AND A.[EscapedStationID] NOT IN (SELECT B.[EscapedStationID]
									FROM	[dbo].[GC_MESRulesStation] B WITH (NOLOCK)
									WHERE  	B.[Customer_ID] = @Customer_ID
										AND (B.[DetectedStationID] = @DetectedStationID OR B.[DetectedStationID] = -1)
										AND (B.[CRDStepIns] = @CRDStepIns OR B.[CRDStepIns] = '[All]')
										AND (B.[Defect_ID] = @Defect_ID OR B.[Defect_ID] = -1)
										AND (B.[CRD] = @CRD OR @CRD LIKE B.[CRD] + '/%' OR B.[CRD] = '[All]')
										AND B.[IsActive] = 1
										AND B.[IsExcluded] = 1
									)
	DROP TABLE #tmp
END

