CREATE PROC [dbo].[AL_TrainingEmpLock_Select] 
(
	@LockID	int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [LockID]
      ,[EmployeeID]
      ,[EmployeeIDSAP]
      ,[UserName]
      ,[EmployeeName]
      ,[TrainingCodeID]
      ,[Description]
      ,[DueDate]
      ,[ExtendDay]
      ,[ExtendFromDate]
      ,[CompleteDate]
      ,[IsActive]
  FROM [dbo].[AL_TrainingAutoLock] WITH (NOLOCK)
  WHERE [LockID] = @LockID
END

