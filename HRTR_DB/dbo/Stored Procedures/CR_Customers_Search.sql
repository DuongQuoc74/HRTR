CREATE PROCEDURE [dbo].[CR_Customers_Search]
(
	@Customer	nvarchar(50),
	@IsActive	int = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT [Customer_ID]
      ,[Customer]
      ,[MESCustomer_ID]
      ,[IsActive]
      ,[LastUpdated]
      ,[LastUpdatedBy]
	FROM	[dbo].[CR_Customers] WITH (NOLOCK)
	'
	SET @Query2 = ''
	IF @Customer != ''
		SET @Query2 = @Query2 + N' WHERE [Customer] = @Customer'
	IF @IsActive != -1	
	BEGIN
		IF @Query2 = ''
			SET @Query2 = @Query2 + + N' WHERE [IsActive] = @IsActive'	
		ELSE
			SET @Query2 = @Query2 + + N' AND [IsActive] = @IsActive'	
	END
	SET @Query = @Query + @Query2
	SET @ParmDef = '@Customer	nvarchar(50),
					@IsActive	int'
	EXEC sp_executesql @Query, @ParmDef
								, @Customer
								, @IsActive
END


