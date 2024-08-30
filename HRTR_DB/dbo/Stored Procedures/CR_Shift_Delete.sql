CREATE PROC [dbo].[CR_Shift_Delete] @ShiftID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[CR_Shift] WHERE [ShiftID]=@ShiftID


