CREATE PROC [dbo].[TrainingRecord_Reminder] 
AS
BEGIN
	SET NOCOUNT ON
	EXEC [dbo].[TrainingRecord_NotificationEmail] @NoOfDays = 60
	EXEC [dbo].[TrainingRecord_NotificationEmail] @NoOfDays = 30
	EXEC [dbo].[TrainingRecord_NotificationEmail] @NoOfDays = 7
	EXEC [dbo].[TrainingRecord_NotificationEmail] @NoOfDays = 3
	EXEC [dbo].[TrainingRecord_NotificationEmail] @NoOfDays = 1
END


