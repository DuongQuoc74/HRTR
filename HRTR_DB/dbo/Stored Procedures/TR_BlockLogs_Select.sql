CREATE PROC [dbo].[TR_BlockLogs_Select] 
(
	@TR_BlockLogsID				int
	
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT A.[TR_BlockLogsID]
      ,A.[EmployeeID_ID]
      ,A.[TrainingRecordID]
	  ,B.[CourseID]
      ,A.[LastLogonDate]
      ,A.[IsConfirmed]
      ,A.[ConfirmedBy]
      ,A.[ConfirmedDate]
      ,A.[CreatedDate]
      ,A.[Comments]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
	FROM [dbo].[TR_BlockLogs] A WITH (NOLOCK)
			INNER JOIN [dbo].[TrainingRecord] B WITH (NOLOCK) ON A.[TrainingRecordID] = B.[TrainingRecordID]
	WHERE A.[TR_BlockLogsID] = @TR_BlockLogsID
	 					
END


