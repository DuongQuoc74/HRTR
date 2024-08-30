CREATE PROC [dbo].[CR_Position_Delete] @PositionID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[CR_Position] WHERE [PositionID]=@PositionID



