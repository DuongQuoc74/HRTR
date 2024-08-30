CREATE PROC [dbo].[GC_Customers_Select] 
(
	@Customer_ID int
)
AS
BEGIN
	SELECT [Customer_ID]
	  ,[Customer]
	  ,[MESCustomer_ID]
	  ,[LastUpdated]
	  ,[LastUpdatedBy]
	FROM [dbo].[GC_Customers] WITH (NOLOCK)
	WHERE [Customer_ID] = @Customer_ID
END
