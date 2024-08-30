CREATE PROC [dbo].[GC_StepInsStation_Delete] 
(
	@GC_StepInsStationID		int,
	@LastUpdatedBy				int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE
	FROM [dbo].[GC_StepInsStation]
	WHERE [GC_StepInsStationID]=@GC_StepInsStationID
END
