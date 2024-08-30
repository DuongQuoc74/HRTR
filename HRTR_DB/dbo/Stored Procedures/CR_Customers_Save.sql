CREATE PROC [dbo].[CR_Customers_Save] 
(
	@Customer_ID		int, 
	@Customer			nvarchar(50), 
	@MESCustomer_ID		int, 
	@IsActive			bit,
	@LastUpdatedBy		int
)
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 
				FROM [dbo].[CR_Customers] WITH (NOLOCK) 
				WHERE [Customer_ID]=@Customer_ID
				)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_Customers] 
		SET		[Customer]=@Customer, 
				[MESCustomer_ID]=@MESCustomer_ID, 
				[IsActive]=@IsActive,
				[LastUpdated]=GETDATE(),
				[LastUpdatedBy]=@LastUpdatedBy
		WHERE [Customer_ID]=@Customer_ID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_Customers] ([Customer],  [MESCustomer_ID],[IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@Customer, @MESCustomer_ID, @IsActive, GETDATE(), @LastUpdatedBy)
		SET @Customer_ID=SCOPE_IDENTITY()
	END
	EXEC [dbo].[CR_Customers_Select] @Customer_ID, @MESCustomer_ID
END


