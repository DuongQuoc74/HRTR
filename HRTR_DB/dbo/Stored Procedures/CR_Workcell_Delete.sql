CREATE PROC [dbo].[CR_Workcell_Delete] 
(
	@WorkcellID int,
	@LastUpdatedBy	int = -1	
)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (SELECT 1
				FROM [dbo].[HR_Employee] WITH (NOLOCK)
				WHERE [WorkcellID] = @WorkcellID
				)
	BEGIN
		RAISERROR(N'This workcell is used. You can not delete it.', 16, 1)
		RETURN
	END
	DELETE 
	FROM	[dbo].[CR_Workcell] 
	WHERE	[WorkcellID]=@WorkcellID
END


