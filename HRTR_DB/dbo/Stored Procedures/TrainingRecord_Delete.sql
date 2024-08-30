CREATE PROC [dbo].[TrainingRecord_Delete] 
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
		   ,[CertifiedLevelID]
           ,[ExpDate]
           ,[Score]
           ,[OJT]
           ,[IsActive]
           ,[Comments]
           ,[LastUpdated]
           ,[LastUpdatedBy])
	SELECT [TrainingRecordID]
		  ,[EmployeeID_ID]
		  ,[EmployeeID]
		  ,[ProductID]
		  ,[Trainer]
		  ,[CourseID]
		  ,[CertDate]
		  ,[CertifiedLevelID]
		  ,[ExpDate]
		  ,[Score]
		  ,[OJT]
          ,(CASE
				WHEN CertifiedLevelID = 3 THEN 0
				ELSE IsActive
						END) AS [IsActive]
          ,[Comments]
		  ,GETDATE()
		  ,@LastUpdatedBy
	FROM [dbo].[TrainingRecord] WITH (NOLOCK)
	WHERE [TrainingRecordID] = @TrainingRecordID

	DELETE 
	FROM	[dbo].[TrainingRecord] 
	WHERE	[TrainingRecordID] = @TrainingRecordID
END