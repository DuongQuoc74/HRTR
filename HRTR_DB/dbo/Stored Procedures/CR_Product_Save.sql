CREATE PROC [dbo].[CR_Product_Save] @ProductID int, @ProductName varchar(100), @TrainingGroupID int, 
	--@UserName varchar(50)=''
	 @LastUpdatedBy	int = 0	
AS
BEGIN
	--DECLARE @UserID int
	--SET @UserID = [dbo].[ufn_GetUserID_By_UserName](@UserName)
	IF EXISTS (SELECT 1 FROM [dbo].[CR_Product] WITH (NOLOCK)
	WHERE [ProductID]=@ProductID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_Product] SET [ProductName]=@ProductName, [TrainingGroupID]=@TrainingGroupID,
					[LastUpdated]=GETDATE(),
					[LastUpdatedBy]=@LastUpdatedBy
		WHERE [ProductID]=@ProductID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_Product] ([ProductName], [TrainingGroupID], [LastUpdated], [LastUpdatedBy])
		VALUES (@ProductName, @TrainingGroupID, GETDATE(), @LastUpdatedBy)
		SET @ProductID=SCOPE_IDENTITY()
	END
	EXEC [dbo].[CR_Product_Select] @ProductID

END


