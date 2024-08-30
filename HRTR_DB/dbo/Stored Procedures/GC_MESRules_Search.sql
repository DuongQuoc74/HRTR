CREATE PROC [dbo].[GC_MESRules_Search] 
(
	@MESCustomer_ID				int, 
	@DetectedStepIns			nvarchar(50), 
	@DefectText					nvarchar(50), 
	@CRD						nvarchar(27), 
	@EscapedStepIns				nvarchar(50), 
	@IsActive					int -- 0: Inactive, 1: Active, -1: All
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	A.[GC_MESRulesID]
			
			,A.[MESCustomer_ID]
			,A.[DetectedStepIns]
			,A.[Defect_ID]
			
			,A.[CRD]
			,A.[EscapedStepIns]
			,A.[IsActive]
			,A.[LastUpdated]
			,A.[LastUpdatedBy]
			
			,C.[WorkcellName]
			,B.[DefectText]
			
	FROM [dbo].[GC_MESRules] A WITH (NOLOCK) INNER JOIN [dbo].[QM_Defects_V] B WITH (NOLOCK) ON A.[Defect_ID] = B.[Defect_ID]
													INNER JOIN [dbo].[Workcell] C WITH (NOLOCK) ON A.[MESCustomer_ID] = C.[MESCustomer_ID]
	WHERE	(A.[MESCustomer_ID] = @MESCustomer_ID OR @MESCustomer_ID = 0)
			AND A.[DetectedStepIns] LIKE + '%' + @DetectedStepIns + '%'
			AND B.[DefectText] LIKE + '%' + @DefectText + '%'
			AND A.[CRD] LIKE + '%' + @CRD + '%'
			AND A.[EscapedStepIns] LIKE + '%' + @EscapedStepIns + '%'
			AND 
			(
				(ISNULL(A.[IsActive],0)=0 AND @IsActive = 0)
				OR (ISNULL(A.[IsActive],0)=1 AND @IsActive = 1)
				OR @IsActive = -1
			)
END

