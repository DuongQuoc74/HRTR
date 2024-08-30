CREATE PROC [dbo].[TrainingRecord_InactiveExpiredOJTCourses] 
AS
BEGIN
	SET NOCOUNT ON
	--OJT
	UPDATE [dbo].[TrainingRecord]
	SET [IsActive] = 0
	   ,[Comments] = N'Inactivate expired OJT courses.'
	   ,[LastUpdated] = GETDATE()
	   ,[LastUpdatedBy] = -1
	WHERE  [ExpDate] < GETDATE()
			AND [OJT] = 1
			AND [IsActive] = 1
	
END

