CREATE PROC [dbo].[CR_Shift_Select] @ShiftID int
AS
SELECT [ShiftID], [ShiftCode], [ShiftName] FROM [dbo].[CR_Shift] WHERE [ShiftID]=@ShiftID


