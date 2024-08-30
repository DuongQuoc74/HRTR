CREATE PROC [dbo].[QM_Defects_Search] 
(
	@IsIncludeAll	int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@Query						nvarchar(max)
				
	SET @Query = N'SELECT  [Defect_ID]
			,[Defect]
			,[DefectCategory_ID]
			,[Active]
			,[UserID_ID]
			,[LastUpdated]
			,[RequiresRework]
			,[DefectText]
	FROM	[dbo].[QM_Defects_V] WITH (NOLOCK)
	WHERE [Active] = 1'
	IF @IsIncludeAll = 1
		SET @Query = @Query + N' OR [Defect_ID] = -1'
	EXEC sp_executesql @Query
	
	--WHERE	(
	--			([Active] = 1 AND (@IsIncludeAll = 0 OR @IsIncludeAll = -1))
	--			OR (([Active] = 1 OR [Defect_ID] = -1) AND (@IsIncludeAll = 1))
	--		)
	--		AND [Defect_ID] <> 0

	----ORDER BY [Defect_ID]
	--		--, [DefectText]
END

