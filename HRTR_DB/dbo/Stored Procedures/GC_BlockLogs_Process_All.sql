CREATE PROC [dbo].[GC_BlockLogs_Process_All] 
(
	@Month				int, 
	@Year				int,
	@LastUpdatedBy		int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	--DECLARE @CurrentDate		datetime
	--SET @CurrentDate = DATEADD(DAY, -5, GETDATE())
	--IF @Month IS NULL 
	--BEGIN
	--	SET @Month = MONTH(@CurrentDate)
	--END
	--IF @Year IS NULL 
	--BEGIN
	--	SET @Year = YEAR(@CurrentDate)
	--END
	
	DECLARE @Customer_ID		int
			, @Customer_IDO		int
	SELECT TOP 1 @Customer_ID = A.[Customer_ID]
	FROM [dbo].[GC_Customers] A WITH (NOLOCK)
	WHERE A.[Customer_ID] > 0
			AND A.[IsActive] = 1
			--AND A.[Customer_ID] = 10
	ORDER BY A.[Customer_ID]
	SET @Customer_ID = ISNULL(@Customer_ID, 0)
	WHILE @Customer_ID <> 0
	BEGIN	
		-- Do s.t
		--PRINT @Customer_ID
		-- Process for 1 customer
		EXECUTE [dbo].[GC_BlockLogs_Process_Customer_ID]  
				   @Customer_ID
				  ,@Month
				  ,@Year
				  ,@LastUpdatedBy

		-- Next employee
		SET @Customer_IDO = @Customer_ID
		SET @Customer_ID = 0
		SELECT TOP 1 @Customer_ID = [Customer_ID]
		FROM [dbo].[GC_Customers] A WITH (NOLOCK)
		WHERE [Customer_ID] > @Customer_IDO
				AND A.[IsActive] = 1
		SET @Customer_ID = ISNULL(@Customer_ID, 0)
	END
	
END

