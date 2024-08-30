CREATE PROC [dbo].[GC_Summary_Run]
(
	@GC_Month				int,
	@GC_Year				int
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @FromDate					datetime
			, @ToDate					datetime
	SET @FromDate = [dbo].[ufn_FromDate](@GC_Month, @GC_Year)
	SET @ToDate = [dbo].[ufn_ToDate](@GC_Month, @GC_Year)
	
	CREATE TABLE #tmpGC_Summary(
		[EmployeeID_ID] [int] NOT NULL,
		[GrapeChartTypeID] [int] NOT NULL,
		[CG_Month] [int] NOT NULL,
		[CG_Year] [int] NOT NULL,
		[TotalDefect] [int] NULL,
		[DefectText] [nvarchar](max) NULL
	)
	INSERT INTO #tmpGC_Summary
	SELECT	  A.[EmployeeID_ID]
			  , 1 AS [GrapeChartTypeID] -- Defect Maker
			  , DATEPART(MM, A.[ReviewDate]) AS [CG_Month]
			  , DATEPART(YEAR, A.[ReviewDate]) AS [CG_Year]
			  , COUNT(DISTINCT A.[Analysis_ID]) AS [TotalDefect]
			  , [dbo].[ufn_GetDefectText_By_EmployeeID_ID] (A.[EmployeeID_ID], @FromDate, @ToDate) AS [DefectText]
	FROM	[dbo].[GrapeChart] A WITH (NOLOCK)
	WHERE		A.[ReviewDate] BETWEEN @FromDate AND @ToDate
	GROUP BY A.[EmployeeID_ID]
			, DATEPART(MM, A.[ReviewDate])
			, DATEPART(YEAR, A.[ReviewDate])
			
	INSERT INTO #tmpGC_Summary
	SELECT	  A.[DetectedBy] AS [EmployeeID_ID]
			  , 2 AS [GrapeChartTypeID] -- Defect Finder
			  , DATEPART(MM, A.[ReviewDate]) AS [CG_Month]
			  , DATEPART(YEAR, A.[ReviewDate]) AS [CG_Month]
			  , COUNT(DISTINCT A.[Analysis_ID]) AS [TotalDefect]
			  , [dbo].[ufn_GetDefectText_By_EmployeeID_ID] (A.[DetectedBy], @FromDate, @ToDate) AS [DefectText]
	FROM	[dbo].[GrapeChart] A WITH (NOLOCK)
	WHERE		A.[ReviewDate] BETWEEN @FromDate AND @ToDate
	GROUP BY A.[DetectedBy]
			, DATEPART(MM, A.[ReviewDate])
			, DATEPART(YEAR, A.[ReviewDate])
	
	UPDATE B
	SET [TotalDefect] = A.[TotalDefect]
		, [DefectText] = A.[DefectText]
		, [LastUpdated] = GETDATE()
		, [LastUpdatedBy] = 0
	FROM #tmpGC_Summary A INNER JOIN [dbo].[GC_Summary] B WITH (NOLOCK)
							ON B.[EmployeeID_ID] = A.[EmployeeID_ID]
								AND B.[GrapeChartTypeID] = A.[GrapeChartTypeID]
								AND B.[CG_Month] = A.[CG_Month]
								AND B.[CG_Year] = A.[CG_Year]
							
	INSERT INTO [dbo].[GC_Summary]
           ([EmployeeID_ID]
           ,[GrapeChartTypeID]
           ,[CG_Month]
           ,[CG_Year]
           ,[TotalDefect]
           ,[DefectText]
           ,[LastUpdated]
           ,[LastUpdatedBy])
     SELECT A.[EmployeeID_ID]
           ,A.[GrapeChartTypeID]
           ,A.[CG_Month]
           ,A.[CG_Year]
           ,A.[TotalDefect]
           ,A.[DefectText]
           ,GETDATE() AS [LastUpdated]
           ,0 AS [LastUpdatedBy]
     FROM #tmpGC_Summary A
     WHERE NOT EXISTS (SELECT 1
						FROM [dbo].[GC_Summary] B WITH (NOLOCK)
						WHERE B.[EmployeeID_ID] = A.[EmployeeID_ID]
							AND B.[GrapeChartTypeID] = A.[GrapeChartTypeID]
							AND B.[CG_Month] = A.[CG_Month]
							AND B.[CG_Year] = A.[CG_Year]
						)
				
END




