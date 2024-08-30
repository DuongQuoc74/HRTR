CREATE PROC [dbo].[CR_Product_Delete] @ProductID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[CR_Product] WHERE [ProductID]=@ProductID



