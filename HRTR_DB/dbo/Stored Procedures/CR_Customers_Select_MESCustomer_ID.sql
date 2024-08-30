CREATE PROC [dbo].[CR_Customers_Select_MESCustomer_ID] 
(
	@Customer_ID				int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	[MESCustomer_ID]
	FROM	[dbo].[CR_Customers] WITH (NOLOCK)
	WHERE	[Customer_ID] = @Customer_ID
END


