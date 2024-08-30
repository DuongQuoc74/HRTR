CREATE PROC [dbo].[GC_BlockLogs_Block_All] 
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE		@CurrentDate						datetime
				, @Aging							int
				, @CreatedDate						datetime
				
	SET @Aging = 2	-- more than 3 days, block
		
	SET @CurrentDate = GETDATE()
	--SET @CurrentDate = '2016-03-08 07:00:01.000'
	SET @CreatedDate = DATEADD(DAY, -@Aging, [dbo].[ufn_GC_CreatedDate](@CurrentDate))
	--PRINT @CreatedDate
	--SELECT *
	--FROM	[dbo].[GC_BlockLogs]
	--WHERE	[CreatedDate] < @CreatedDate
	--		AND [IsBlocked] = 0
	--		AND [IsConfirmed] = 0
	--RETURN
	
	UPDATE	[dbo].[GC_BlockLogs]
	SET		[IsBlocked] = 1
			, [BlockedDate] = GETDATE()
			, [LastUpdated] = GETDATE()
			--, [LastUpdatedBy] = @LastUpdatedBy
	WHERE	[CreatedDate] < @CreatedDate
			AND [IsBlocked] = 0
			AND [IsConfirmed] = 0
			
			
	
END

