CREATE PROC [dbo].[CR_Product_Select] @ProductID int
AS
SELECT [ProductID]
      ,[ProductName]
      ,[TrainingGroupID] FROM [dbo].[CR_Product] WHERE [ProductID]=@ProductID



