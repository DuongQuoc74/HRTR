CREATE PROC [dbo].[GC_BlockLogs_NotificationEmail_All] 
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Customer_ID				int
			, @Customer_IDO				int
			, @NotificationTime			int
	SELECT TOP 1 @Customer_ID = A.[Customer_ID]
	FROM [dbo].[GC_Customers] A WITH (NOLOCK)
	WHERE A.[Customer_ID] > 0
			AND A.[IsActive] = 1
	ORDER BY A.[Customer_ID]
	SET @Customer_ID = ISNULL(@Customer_ID, 0)
	WHILE @Customer_ID <> 0
	BEGIN	
		-- Do s.t
		--PRINT @Customer_ID
		-- Process for 1 customer
		SET @NotificationTime = 1 
		EXECUTE [dbo].[GC_BlockLogs_NotificationEmail_Customer_ID]  
				   @Customer_ID
				  ,@NotificationTime
		SET @NotificationTime = 2
		EXECUTE [dbo].[GC_BlockLogs_NotificationEmail_Customer_ID]  
				   @Customer_ID
				  ,@NotificationTime
		SET @NotificationTime = 3
		EXECUTE [dbo].[GC_BlockLogs_NotificationEmail_Customer_ID]  
				   @Customer_ID
				  ,@NotificationTime
				  
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

