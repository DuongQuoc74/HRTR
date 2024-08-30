CREATE PROC [dbo].[SY_MDType_Select] 
(
	@MDTypeID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [MDTypeID]
		  ,[MDTypeName]
		  ,[IsActive]
		  ,[DefaultMDItemID]
		  ,[LastUpdated]
		  ,[LastUpdatedBy]
	FROM	[dbo].[SY_MDType] WITH (NOLOCK)
	WHERE	[MDTypeID]=@MDTypeID
END

