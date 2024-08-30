CREATE PROC [dbo].[GC_BlockLogs_Block_All_20160307] 
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE		@CurrentDate						datetime
				, @Aging							int
				, @CreatedDate						datetime
				
	SET @Aging = 3	-- more than 3 days, block
		
	SET @CurrentDate = CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 120), 120)
	SET @CreatedDate = CONVERT(VARCHAR(10), @CurrentDate , 120)  + ' 00:00:00.000' 
	SET @CreatedDate = DATEADD(DAY, -@Aging, @CreatedDate)
	--PRINT @CreatedDate
	
	UPDATE	[dbo].[GC_BlockLogs]
	SET		[IsBlocked] = 1
			, [BlockedDate] = GETDATE()
			, [LastUpdated] = GETDATE()
			--, [LastUpdatedBy] = @LastUpdatedBy
	WHERE	[CreatedDate] <= @CreatedDate
			AND [IsBlocked] = 0
			AND [IsConfirmed] = 0
			
			
	
END

