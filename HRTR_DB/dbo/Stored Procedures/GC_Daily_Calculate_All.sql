CREATE PROCEDURE [dbo].[GC_Daily_Calculate_All]
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @FromDate	datetime
			, @ToDate		datetime
			, @I			int
	SET @FromDate = [dbo].[ufn_FromDate] (DATEPART(MONTH, GETDATE()), DATEPART(YEAR, GETDATE()))
	SET @ToDate = DATEADD(DAY, -1, DATEADD(MONTH, 1, @FromDate))
			--, @I			int
	SET @I = 1
	DECLARE @tmpReviewDate AS TABLE
	(
		[No]			[int],
		[ReviewDate]	[datetime]
	)
	WHILE @FromDate <= @ToDate
	BEGIN
		INSERT INTO @tmpReviewDate
		VALUES (@I, @FromDate)
		SET @FromDate = DATEADD(DAY, 1, @FromDate)
		SET @I = @I + 1
	END
	-- Calculate Summary Data START
	DECLARE @TotalDays		int
			--, @I			int
			, @ReviewDate	datetime
	SELECT TOP 1 @TotalDays = [No]
	FROM @tmpReviewDate
	ORDER BY [No] DESC
	--PRINT @TotalDays
	SET @I = 1
	WHILE (@I <= @TotalDays)
	BEGIN
		SELECT TOP 1 @ReviewDate = [ReviewDate]
		FROM @tmpReviewDate
		WHERE [No] = @I
		EXECUTE [dbo].[GC_Daily_Calculate] @ReviewDate
		SET @I = @I + 1
		--PRINT 'A'
	END
END

