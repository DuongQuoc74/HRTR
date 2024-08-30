CREATE PROC [dbo].[GC_StepInsStation_Save] 
(
	@GC_StepInsStationID		int, 
	@MESCustomer_ID				int, 
	@Customer_ID				int, 
	@Step_ID					int, 
	@StepIns					nvarchar(50), 
	@GC_StationID					int,
	@IsActive					bit, 
	@LastUpdatedBy				int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF EXISTS (SELECT 1
				FROM [dbo].[GC_StepInsStation] WITH (NOLOCK) 
				WHERE [GC_StepInsStationID]=@GC_StepInsStationID)
	BEGIN
		--update existing record
		UPDATE	[dbo].[GC_StepInsStation] 
		SET		[MESCustomer_ID]=@MESCustomer_ID
				,[Customer_ID]=@Customer_ID
				,[Step_ID]=@Step_ID
				,[StepIns]=@StepIns
				,[GC_StationID]=@GC_StationID
				,[IsActive]=@IsActive
				,[LastUpdated]=GETDATE()
				,[LastUpdatedBy]=@LastUpdatedBy
		WHERE [GC_StepInsStationID]=@GC_StepInsStationID
		
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[GC_StepInsStation] ([MESCustomer_ID]
		, [Customer_ID]
		, [Step_ID]
		, [StepIns]
		, [GC_StationID]
		, [IsActive]
		, [LastUpdated]
		, [LastUpdatedBy])
		VALUES ( @MESCustomer_ID
		, @Customer_ID
		, @Step_ID
		, @StepIns
		, @GC_StationID
		, @IsActive -- Default value
		, GETDATE()
		, @LastUpdatedBy)
		SET @GC_StepInsStationID=SCOPE_IDENTITY()
		
	END
	
	EXEC [dbo].[GC_StepInsStation_Select] @GC_StepInsStationID
END
