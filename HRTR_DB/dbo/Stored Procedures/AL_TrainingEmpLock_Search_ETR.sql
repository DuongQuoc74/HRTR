-- 5: 1st remind, 4 <= days <= 7
-- 6: 2nd remind + logoff, 0 <= days <= 3
-- 7: 3rd remind + shutdown, days < 0
CREATE PROC [dbo].[AL_TrainingEmpLock_Search_ETR] 
(
	@IsDL	int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT A.[LockID]
		,A.[UserName]
		,A.[TrainingCodeID]
		,A.[DueDate]
		,A.[ExtendDay]
		,A.[ExtendFromDate]
		,A.[ExtendFromDate] + A.[ExtendDay] AS [ExtendToDate]
		,(CASE WHEN DATEDIFF(DAY, GETDATE(), A.[DueDate]) >= 4 THEN 5 
			WHEN DATEDIFF(DAY, GETDATE(), A.[DueDate]) >= 0 THEN 6
			ELSE 7 END) AS [RemindLevel]
		,DATEDIFF(DAY, GETDATE(), A.[DueDate]) AS [RemainDay]
	FROM [dbo].[AL_TrainingAutoLock] A WITH (NOLOCK)
	WHERE A.[LockID] = (SELECT TOP 1 B.[LockID]
						FROM [dbo].[AL_TrainingAutoLock] B WITH (NOLOCK)
						WHERE B.[UserName] = A.[UserName]
								AND B.[DueDate] <= DATEADD(DAY, 7, GETDATE())
								AND B.[CompleteDate] IS NULL
								AND B.[IsActive] = 1
								AND B.[IsDL] = 0
								AND B.[UserName] NOT IN ('', '#N/A', 'NguyenN28', 'NguyenT180', 'ThanhH1')
								--AND B.[UserName] = 'ThanhH1'
						ORDER BY B.[ExtendDay])

END


