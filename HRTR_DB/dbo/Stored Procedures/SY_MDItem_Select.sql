CREATE PROC [dbo].[SY_MDItem_Select] 
(
	@MDItemID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [MDItemID]
		  ,[MDTypeID]
		  ,[MDItemCode]
		  ,[Description]
		  ,[IsActive]
		  ,[LastUpdated]
		  ,[LastUpdatedBy]
	FROM	[dbo].[SY_MDItem]  WITH (NOLOCK)
	WHERE	[MDItemID] = @MDItemID
END

