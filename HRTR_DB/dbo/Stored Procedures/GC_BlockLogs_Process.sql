CREATE PROC [dbo].[GC_BlockLogs_Process] 
AS
BEGIN
	SET NOCOUNT ON
	-- Sync employee list from eDB to HRTR
	EXEC [dbo].[eDB_Sync]
	-- Process Data
	-- If current date <= 5, process current and previous month
	-- else process current month only
	DECLARE @Month				int, 
			@Year				int,
			@CurrentDate		datetime
	SET @CurrentDate = GETDATE()
	IF DAY(@CurrentDate) <= 5
	BEGIN
		SET @Month = MONTH(DATEADD(DAY, -6, @CurrentDate))
		SET @Year = YEAR(@CurrentDate)
		EXEC [dbo].[GC_BlockLogs_Process_All] @Month, @Year
	END
	SET @Month = MONTH(@CurrentDate)
	SET @Year = YEAR(@CurrentDate)
	EXEC [dbo].[GC_BlockLogs_Process_All] @Month, @Year

	-- Blocking
	EXEC [dbo].[GC_BlockLogs_Block_All] 
	---- Send Notification Email
	EXEC [dbo].[GC_BlockLogs_NotificationEmail_All] 
	
END

