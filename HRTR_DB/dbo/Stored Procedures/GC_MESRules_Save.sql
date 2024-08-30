CREATE PROC [dbo].[GC_MESRules_Save] 
(
	@GC_MESRulesID				int, 
	@MESCustomer_ID				int, 
	@DetectedStepIns			nvarchar(50), 
	@Defect_ID					int,
	@CRD						nvarchar(27), 
	@EscapedStepIns				nvarchar(50), 
	@IsActive					bit, 
	@LastUpdatedBy				int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF EXISTS (SELECT 1
				FROM [dbo].[GC_MESRules] WITH (NOLOCK) 
				WHERE [GC_MESRulesID]=@GC_MESRulesID)
	BEGIN
		--update existing record
		UPDATE	[dbo].[GC_MESRules] 
		SET		[MESCustomer_ID]=@MESCustomer_ID
				,[DetectedStepIns]=@DetectedStepIns
				,[Defect_ID]=@Defect_ID
				,[CRD]=@CRD
				,[EscapedStepIns]=@EscapedStepIns
				,[IsActive]=@IsActive
				,[LastUpdated]=GETDATE()
				,[LastUpdatedBy]=@LastUpdatedBy
		WHERE [GC_MESRulesID]=@GC_MESRulesID
		
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[GC_MESRules] ([MESCustomer_ID]
		, [DetectedStepIns]
		, [Defect_ID]
		, [CRD]
		, [EscapedStepIns]
		
		
		, [IsActive]
		, [LastUpdated], [LastUpdatedBy])
		VALUES ( @MESCustomer_ID
		, @DetectedStepIns
		, @Defect_ID
		, @CRD
		, @EscapedStepIns
		, @IsActive -- Default value
		, GETDATE(), @LastUpdatedBy)
		SET @GC_MESRulesID=SCOPE_IDENTITY()
		
	END
	
	EXEC [dbo].[GC_MESRules_Select] @GC_MESRulesID
END

