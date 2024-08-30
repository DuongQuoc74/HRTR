CREATE PROC [dbo].[GC_AnalysisData_Processing_Finish]
(
	@Analysis_ID				int,
	@MESCustomer_ID				int, 
	@Assembly_ID				int, 
	@SerialNumber				nvarchar(60), 
	@AssyNumber					nvarchar(60),  
	@Revision					nvarchar(20),  
	@StepIns					nvarchar(50), 
	@UserID						nvarchar(20), 
	@WindowsUserID				nvarchar(20), 
	@CRDStepIns					nvarchar(50) = '',
	@GC_ProcessStatusID			int
)
AS
BEGIN
	SET NOCOUNT ON
	-- Finish 1 board
	UPDATE	[dbo].[GC_AnalysisData_Processing]
	SET		[MESCustomer_ID] = @MESCustomer_ID
				,[Assembly_ID] = @Assembly_ID
				,[SerialNumber] = @SerialNumber
				,[AssyNumber] = @AssyNumber
				,[Revision] = @Revision
				,[StepIns] = @StepIns
				,[UserID] = @UserID
				,[WindowsUserID] = @WindowsUserID
				,[CRDStepIns] = @CRDStepIns
				,[GC_ProcessStatusID] = @GC_ProcessStatusID
				,[ReviewDate] = (CASE WHEN DATEPART(HH, [AnalysisDateTime]) < 6 THEN CONVERT(VARCHAR(10), DATEADD(DAY, -1, [AnalysisDateTime]), 120)
				ELSE CONVERT(VARCHAR(10), [AnalysisDateTime], 120) END)
				,[LastUpdated] = GETDATE()
				,[LastUpdatedBy] = 0
	WHERE [Analysis_ID] = @Analysis_ID

END

