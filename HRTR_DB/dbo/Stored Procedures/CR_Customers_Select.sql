CREATE PROC [dbo].[CR_Customers_Select] 
(
	@Customer_ID				int,
	@MESCustomer_ID				int
)
AS
BEGIN
	SET NOCOUNT ON
	IF @Customer_ID = 0
	BEGIN
		SELECT TOP 1 @Customer_ID = [Customer_ID]
		FROM [dbo].[CR_Customers] WITH (NOLOCK)
		WHERE [MESCustomer_ID] = @MESCustomer_ID
		SET @Customer_ID = ISNULL(@Customer_ID, 0)
	END
	
	SELECT [Customer_ID]
      ,[Customer]
      ,[MESCustomer_ID]
      ,[IsActive]
      ,[LastUpdated]
      ,[LastUpdatedBy]
	  FROM [dbo].[CR_Customers] WITH (NOLOCK)
	  WHERE [Customer_ID] = @Customer_ID
END


