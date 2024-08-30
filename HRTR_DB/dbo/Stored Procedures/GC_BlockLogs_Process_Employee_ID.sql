CREATE PROC [dbo].[GC_BlockLogs_Process_Employee_ID] 
(
	@EmployeeID_ID		int,
	@StartDate			datetime, -- ex: 01-Oct-2015 06:00:00.000
	@Customer_ID		int,
	@EndDate			datetime,
	@LastUpdatedBy		int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	--PRINT '@Customer_ID'
	--	PRINT @Customer_ID
		
	DECLARE @TotalRedGrapes			int
			, @StartDateO			datetime
			, @ConfirmedDate		datetime
	SELECT TOP 1 @StartDateO = [StartDate]
	FROM [dbo].[GC_BlockLogs] WITH (NOLOCK)
	WHERE	[EmployeeID_ID] = @EmployeeID_ID
			AND [Customer_ID] = @Customer_ID
			AND [StartDate] < @StartDate
			AND [IsConfirmed] = 0
	IF @StartDateO IS NOT NULL
	BEGIN
		SET @StartDate = @StartDateO
	END	
	-- Get latest ConfirmedDate that must be greater than @StartDate
	SELECT	TOP 1 @ConfirmedDate = A.[ConfirmedDate]
	FROM	[dbo].[GC_BlockLogs] A WITH (NOLOCK)
	WHERE	A.[EmployeeID_ID] = @EmployeeID_ID
			AND A.[Customer_ID] = @Customer_ID
			AND A.[ConfirmedDate] > @StartDate
			AND A.[IsConfirmed] = 1
			AND NOT EXISTS (SELECT 1
						FROM	[dbo].[GC_BlockLogs] B WITH (NOLOCK)
						WHERE B.[EmployeeID_ID] = A.[EmployeeID_ID]
								AND B.[Customer_ID] = A.[Customer_ID]
								AND B.[StartDate] < A.[ConfirmedDate]
								AND B.[IsConfirmed] = 0
						)
	ORDER BY A.[ConfirmedDate] DESC
	-- Reset @StartDate if old record has been confirmed
	IF @ConfirmedDate IS NOT NULL
	BEGIN
		SET @StartDate = DATEADD(DAY, 1, CONVERT(VARCHAR(10), @ConfirmedDate , 120)) + ' 00:00:00.000'
	END
	
	SELECT @TotalRedGrapes = COUNT(A.[EscapedDate])
	FROM (SELECT	A.[Customer_ID]
				,A.[EscapedDate]
				,A.[EscapedByEmployeeID_ID] AS [EmployeeID_ID]
				,COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
		FROM	[dbo].[GC_Data] A WITH (NOLOCK) 
		WHERE 	A.[EscapedDate] BETWEEN @StartDate AND @EndDate
					AND A.[EscapedByEmployeeID_ID] = @EmployeeID_ID -- for escapees
					AND A.[Customer_ID] = @Customer_ID
		GROUP BY	A.[Customer_ID]
					,A.[EscapedDate]
					,A.[EscapedByEmployeeID_ID] -- for escapees
				) A
	WHERE A.[TotalDefect] > 3 -- Count red grapes
	SET @TotalRedGrapes = ISNULL(@TotalRedGrapes, 0)
	--IF @EmployeeID_ID = 1370
	--BEGIN
	--PRINT '@StartDate'
	--PRINT @StartDate
	--PRINT '@EndDate'
	--PRINT @EndDate
	--PRINT '@Customer_ID'
	--PRINT @Customer_ID
	--PRINT '@EmployeeID_ID'
	--PRINT @EmployeeID_ID
	--PRINT @TotalRedGrapes
	--END
	
	IF @TotalRedGrapes > 3 -- more than 3 red grapes
	BEGIN
		
		--PRINT '@Customer_ID'
		--PRINT @Customer_ID
		--PRINT '@EmployeeID_ID'
		--PRINT @EmployeeID_ID
		--PRINT @TotalRedGrapes
		
		IF EXISTS (SELECT 1
					FROM	[dbo].[GC_BlockLogs] WITH (NOLOCK)
					WHERE	[EmployeeID_ID] = @EmployeeID_ID
							AND [StartDate] = @StartDate
							AND [Customer_ID] = @Customer_ID
							AND [IsConfirmed] = 0
					)
		BEGIN
			UPDATE	[dbo].[GC_BlockLogs]
			SET		[EndDate] = @EndDate
					,[TotalRedGrapes] = @TotalRedGrapes
					--,[IsConfirmed] = <IsConfirmed, bit,>
					--,[ConfirmedBy] = <ConfirmedBy, int,>
					--,[ConfirmedDate] = <ConfirmedDate, datetime,>
					,[LastUpdated] = GETDATE()
					,[LastUpdatedBy] = @LastUpdatedBy
			WHERE	[EmployeeID_ID] = @EmployeeID_ID
					AND [StartDate] = @StartDate
					AND [Customer_ID] = @Customer_ID
					AND [IsConfirmed] = 0
		END
		ELSE
		BEGIN
			INSERT INTO [dbo].[GC_BlockLogs]
			   ([EmployeeID_ID]
			   ,[StartDate]
			   ,[Customer_ID]
			   ,[EndDate]
			   ,[TotalRedGrapes]
			   ,[IsBlocked]
			   ,[IsConfirmed]
			   ,[ConfirmedBy]
			   ,[ConfirmedDate]
			   ,[CreatedDate]
			   ,[LastUpdated]
			   ,[LastUpdatedBy])
		 VALUES
			   (@EmployeeID_ID
			   ,@StartDate
			   ,@Customer_ID
			   ,@EndDate
			   ,@TotalRedGrapes
			   ,0 -- [IsBlocked]
			   ,0 -- [IsConfirmed]
			   ,NULL -- [ConfirmedBy]
			   ,NULL -- [ConfirmedDate]
			   ,GETDATE() -- [CreatedDate]
			   ,GETDATE()
			   ,@LastUpdatedBy)
		END
	END
END

