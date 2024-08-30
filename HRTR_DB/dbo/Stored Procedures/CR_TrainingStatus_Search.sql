CREATE PROC [dbo].[CR_TrainingStatus_Search]
AS
BEGIN
	SELECT [TrainingStatusID]
		  ,[TrainingStatusName] 
	FROM [dbo].[CR_TrainingStatus] WITH (NOLOCK)
END



