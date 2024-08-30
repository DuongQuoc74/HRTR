CREATE PROC [dbo].[AL_TrainingEmpLock_Delete] 
(
	@LockID		int
)
AS
BEGIN
	DELETE 
	FROM [dbo].[AL_TrainingAutoLock] 
	WHERE LockID = @LockID
END

