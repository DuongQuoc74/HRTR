
CREATE PROC [dbo].[AL_TrainingEmpLock_Import] 
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON;
	MERGE [dbo].[AL_TrainingAutoLock] AS T
	USING (SELECT [EmployeeID], [WDNo]
			   ,[EmployeeIDSAP]
			   ,[UserName]
			   ,[EmployeeName]
			   ,[TrainingCodeID]
			   ,[Description]
			   ,[DueDate]
			   ,[ExtendDay]
			   ,[ExtendFromDate]
			   ,[CompleteDate]
			   ,[IsDL]
           FROM [dbo].[AL_TrainingAutoLockTemp] A WITH (NOLOCK)
		   WHERE	A.[LastUpdatedBy] = @LastUpdatedBy
					AND ISNULL(A.[IsValid], 0) = 1
				) AS S
	ON (T.[UserName] = S.[UserName] AND T.[TrainingCodeID] = S.[TrainingCodeID] AND T.[IsDL] = S.[IsDL]) 
	WHEN NOT MATCHED 
		THEN INSERT ([EmployeeID], [WDNo]
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
           ,[LastUpdated]
           ,[LastUpdatedBy]
           ,[IsDL])
		VALUES (S.[EmployeeID], S.[WDNo], S.[EmployeeIDSAP], S.[UserName], S.[EmployeeName], S.[TrainingCodeID]
				, S.[Description], S.[DueDate], 0, NULL, NULL, 1, GETDATE(), @LastUpdatedBy, S.IsDL)
	WHEN MATCHED 
		THEN UPDATE SET T.[EmployeeID] = S.[EmployeeID],
						T.[WDNo] = S.[WDNo],
						T.[EmployeeIDSAP] = S.[EmployeeIDSAP],
						T.[EmployeeName] = S.[EmployeeName],
						T.[Description] = S.[Description], 
						T.[DueDate] = S.[DueDate],
						T.[ExtendDay] = S.[ExtendDay],
						T.[ExtendFromDate] = S.[ExtendFromDate],
						T.[CompleteDate] = S.[CompleteDate],
						T.[LastUpdated] = GETDATE(),
						T.[LastUpdatedBy] = @LastUpdatedBy,
						T.[IsDL] = S.[IsDL];
END


