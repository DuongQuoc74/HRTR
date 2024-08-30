CREATE PROC [dbo].[SY_MDType_Delete] 
(
	@MDTypeID		int,
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE 
	FROM	[dbo].[SY_MDType] 
	WHERE	[MDTypeID]=@MDTypeID
END

