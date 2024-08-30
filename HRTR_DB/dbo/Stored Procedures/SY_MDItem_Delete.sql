CREATE PROC [dbo].[SY_MDItem_Delete] 
(
	@MDItemID int,
	@LastUpdatedBy int
)
AS
BEGIN
	SET NOCOUNT ON	
	INSERT INTO [dbo].[SY_MDItemH]
           ([MDItemID]
           ,[MDTypeID]
           ,[MDItemCode]
           ,[Description]
           ,[IsActive]
           ,[LastUpdated]
           ,[LastUpdatedBy])
    SELECT [MDItemID]
      ,[MDTypeID]
      ,[MDItemCode]
      ,[Description]
      ,[IsActive]
      ,GETDATE()
      ,@LastUpdatedBy
	FROM [dbo].[SY_MDItem] WITH (NOLOCK)
  	WHERE	[MDItemID]=@MDItemID
  	
	DELETE 
	FROM	[dbo].[SY_MDItem] 
	WHERE	[MDItemID]=@MDItemID
END

