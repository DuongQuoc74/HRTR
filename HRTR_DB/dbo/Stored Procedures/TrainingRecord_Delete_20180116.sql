CREATE PROC [dbo].[TrainingRecord_Delete_20180116] 
(
	@TrainingRecordID int,
	@LastUpdatedBy	int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO [dbo].[TrainingRecordH]
           ([TrainingRecordID]
           ,[EmployeeID_ID]
           ,[EmployeeID]
           ,[ProductID]
           ,[Trainer]
           ,[CourseID]
           ,[CertDate]
           ,[ExpDate]
           ,[Score]
           ,[OJT]
           ,[LastUpdated]
           ,[LastUpdatedBy])
	SELECT [TrainingRecordID]
		  ,[EmployeeID_ID]
		  ,[EmployeeID]
		  ,[ProductID]
		  ,[Trainer]
		  ,[CourseID]
		  ,[CertDate]
		  ,[ExpDate]
		  ,[Score]
		  ,[OJT]
		  ,GETDATE()
		  ,@LastUpdatedBy
	FROM [dbo].[TrainingRecord] WITH (NOLOCK)
	WHERE [TrainingRecordID] = @TrainingRecordID


	DELETE 
	FROM	[dbo].[TrainingRecord] 
	WHERE	[TrainingRecordID] = @TrainingRecordID
END

