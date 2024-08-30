-- daily at 08:15 AM, compare last logon in table CCS_AuthenticationLog
-- TrainingRecordID not yet expired, EmployeeID_ID still active
-- example: current date = 08:15AM 06-Sep-2016, REMOVE TIME => current date = 06-Sep-2016 12:00 AM, NumberOfCriticalDays = 1
-- last logon date 
-- * before 05-Sep-2016 12:00 AM, insert
-- * after 05-Sep-2016 12:00 AM, no action
CREATE PROC [dbo].[TR_BlockLogs_Process] 
AS
BEGIN
	SET NOCOUNT ON
	RETURN
	DECLARE @CurrentDate datetime = GETDATE()
	SET @CurrentDate = CONVERT(varchar(10), @CurrentDate , 120)
	--PRINT @CurrentDate
	SELECT A.[EmployeeID_ID]
		,A.[TrainingRecordID]
		,ISNULL(C.[LastLogonDate], A.[CertDate]) AS [LastLogonDate]
		,A.[NumberOfCriticalDays]
	INTO #tmp
	FROM [dbo].[TrainingRecord_V1] A WITH (NOLOCK)
		INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
		LEFT OUTER JOIN (SELECT A.[EmployeeID_ID]
							,A.[CourseID]
							,MAX(A.[LoginTime]) AS [LastLogonDate]
						FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)
						GROUP BY  A.[EmployeeID_ID]
							,A.[CourseID]) C ON A.[EmployeeID_ID] = C.[EmployeeID_ID] AND A.[CourseID] = C.[CourseID]
	WHERE A.[ExpDate] >= GETDATE() -- chua expired
	  AND ISNULL(C.[LastLogonDate], A.[CertDate])  <= @CurrentDate - A.[NumberOfCriticalDays]
	  AND A.[IsCritical] = 1
	  AND B.[IsActive] = 1
	
	INSERT INTO [dbo].[TR_BlockLogs]
           ([EmployeeID_ID]
           ,[TrainingRecordID]
           ,[LastLogonDate]
           ,[IsConfirmed]
           ,[ConfirmedBy]
           ,[ConfirmedDate]
           ,[CreatedDate]
           ,[Comments]
           ,[LastUpdated]
           ,[LastUpdatedBy])
	 SELECT A.[EmployeeID_ID]
			   ,A.[TrainingRecordID]
			   ,A.[LastLogonDate]
			   ,0 AS [IsConfirmed]
			   ,NULL AS [ConfirmedBy]
			   ,NULL AS [ConfirmedDate]
			   ,GETDATE() AS [CreatedDate]
			   ,'' AS [Comments]
			   ,GETDATE() AS [LastUpdated]
			   ,-1 AS [LastUpdatedBy]
	 FROM #tmp A
	 WHERE NOT EXISTS (SELECT 1
	 FROM [dbo].[TR_BlockLogs] B WITH (NOLOCK)
	 WHERE B.[EmployeeID_ID] = B.[EmployeeID_ID]
			AND B.[TrainingRecordID] = A.[TrainingRecordID]
			AND B.[LastLogonDate] = A.[LastLogonDate])

	DROP TABLE #tmp
	
END


