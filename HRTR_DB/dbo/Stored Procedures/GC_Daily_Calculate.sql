CREATE PROC [dbo].[GC_Daily_Calculate]
(
	@EscapedDate	datetime
)
AS
BEGIN
	SET NOCOUNT ON;
	
	CREATE TABLE #tmpGC_Daily_EmployeeID_ID(
		[EmployeeID_ID] [int] NOT NULL,
		[GrapeChartTypeID] [int] NOT NULL,
		[EscapedDate] [datetime] NOT NULL,
		[TotalDefect] [int] NULL,
		[DefectText] [nvarchar](max) NULL
	)
	INSERT INTO #tmpGC_Daily_EmployeeID_ID
	SELECT	  A.[EscapedByEmployeeID_ID] AS [EmployeeID_ID]
			  , 1 AS [GrapeChartTypeID] -- Defect Maker
			  , A.[EscapedDate] AS [EscapedDate]
			  , COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
			  , [dbo].[ufn_GetDefectText_By_EmployeeID_ID] (A.[EscapedByEmployeeID_ID], A.[EscapedDate], A.[EscapedDate]) AS [DefectText]
	FROM	[dbo].[GC_Data] A WITH (NOLOCK)
	WHERE		A.[EscapedDate] = @EscapedDate
	GROUP BY A.[EscapedByEmployeeID_ID]
			, A.[EscapedDate]
			
	INSERT INTO #tmpGC_Daily_EmployeeID_ID
	
	SELECT	  A.[DetectedByEmployeeID_ID] AS [EmployeeID_ID]
			  , 2 AS [GrapeChartTypeID] -- Defect Finder
			  , A.[EscapedDate] AS[EscapedDate]
			  , COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
			  , [dbo].[ufn_GetDefectText_By_EmployeeID_ID] (A.[DetectedByEmployeeID_ID], A.[EscapedDate], A.[EscapedDate]) AS [DefectText]
	FROM	[dbo].[GC_Data] A WITH (NOLOCK)
	WHERE		A.[EscapedDate] = @EscapedDate
	GROUP BY A.[DetectedByEmployeeID_ID]
			, A.[EscapedDate]
	
	DELETE
	FROM [dbo].[GC_Daily_EmployeeID_ID]
	WHERE [EscapedDate] = @EscapedDate
	
	INSERT INTO [dbo].[GC_Daily_EmployeeID_ID]
           ([EmployeeID_ID]
           ,[GrapeChartTypeID]
           ,[EscapedDate]
           ,[TotalDefect]
           ,[DefectText]
           ,[LastUpdated]
           ,[LastUpdatedBy])
	SELECT A.[EmployeeID_ID]
           ,A.[GrapeChartTypeID]
           ,A.[EscapedDate]
           ,A.[TotalDefect]
           ,A.[DefectText]
           ,GETDATE() AS [LastUpdated]
           ,0 AS [LastUpdatedBy]
	FROM #tmpGC_Daily_EmployeeID_ID A
	DROP TABLE #tmpGC_Daily_EmployeeID_ID
				
END




