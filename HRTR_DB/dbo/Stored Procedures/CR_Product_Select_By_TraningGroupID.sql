CREATE PROC [dbo].[CR_Product_Select_By_TraningGroupID] 
(
	@TrainingGroupID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	[ProductID]
			,[ProductName]
			,[TrainingGroupID] 
	FROM [dbo].[CR_Product] WITH (NOLOCK)
	--WHERE [TrainingGroupID]=@TrainingGroupID
END


