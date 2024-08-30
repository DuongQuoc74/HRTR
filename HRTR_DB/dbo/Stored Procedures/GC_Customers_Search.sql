CREATE PROC [dbo].[GC_Customers_Search] 
AS
BEGIN
	SELECT [Customer_ID]
	  ,[Customer]
	  ,[MESCustomer_ID]
	  ,[LastUpdated]
	  ,[LastUpdatedBy]
	FROM [dbo].[GC_Customers] WITH (NOLOCK)
END
