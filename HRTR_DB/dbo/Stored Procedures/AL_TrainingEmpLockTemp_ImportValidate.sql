-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AL_TrainingEmpLockTemp_ImportValidate]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE	[dbo].[AL_TrainingAutoLockTemp]
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND ISNULL([EmployeeID], '') = ''
			
	UPDATE	[dbo].[AL_TrainingAutoLockTemp]
	SET		[IsValid] = 1
			, [EmployeeIDSAP] = ISNULL([EmployeeIDSAP], '')
			, [WDNo] = ISNULL([WDNo], '')
			, [ExtendDay] = ISNULL([ExtendDay], 0)
			, [ErrorMessage] = N''
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
   					
	UPDATE	A
	SET		A.[ErrorMessage] = ( CASE WHEN A.[DueDate] IS NULL
										 THEN 'Invalid Due Date. '
										 ELSE ''
						END )
			+ ( CASE WHEN EXISTS ( SELECT 1
                                        FROM    [dbo].[AL_TrainingAutoLockTemp] B WITH (NOLOCK)
                                        WHERE   A.[ID] != B.[ID]
												AND A.[UserName] = B.[UserName]
												AND A.[TrainingCodeID] = B.[TrainingCodeID]
												AND B.[LastUpdatedBy] = @LastUpdatedBy)
                         THEN 'Duplicate User Name and Training Code ID. '
                         ELSE ''
						END )
             + ( CASE WHEN ( ISNUMERIC(A.[ExtendDay]) = 0 )
							 THEN 'Invalid Extend Day. '
							 ELSE ''
						END )
			 + ( CASE WHEN ( A.[ExtendDay] != 0 AND A.[ExtendFromDate] IS NULL ) 
							 THEN 'Missing Extend From Date. '
							 ELSE ''
						END )
			 + ( CASE WHEN ( A.[ExtendDay] = 0 AND A.[ExtendFromDate] IS NOT NULL ) 
							 THEN 'Missing Extend Day. '
							 ELSE ''
						END )
			 + ( CASE WHEN ( A.[ExtendDay] != 0 AND A.[ExtendFromDate] IS NOT NULL AND CONVERT(DATE, DATEADD(DAY, 3, A.[DueDate])) >= CONVERT(DATE, GETDATE()) ) 
				 THEN 'Due Date + 3 still not reached. No need extend. '
				 ELSE ''
						END )
			 + ( CASE WHEN ( A.[ExtendDay] != 0 AND A.[ExtendFromDate] IS NOT NULL AND CONVERT(DATE, A.[ExtendFromDate]) < CONVERT(DATE, GETDATE()) ) 
				 THEN 'Extend From Date must >= ToDay. '
				 ELSE ''
						END )
			 + ( CASE WHEN ( A.[ExtendDay] != 0 AND A.[ExtendFromDate] IS NOT NULL AND A.[CompleteDate] IS NOT NULL AND CONVERT(DATE, A.[CompleteDate]) < CONVERT(DATE, A.[ExtendFromDate]) ) 
				 THEN 'Complete Date must >= Extend From Date. '
				 ELSE ''
						END )
			 + ( CASE WHEN ( A.[ExtendDay] = 0 AND A.[ExtendFromDate] IS NULL AND A.[CompleteDate] IS NOT NULL AND CONVERT(DATE, A.[CompleteDate]) > CONVERT(DATE, DATEADD(DAY, 3, A.[DueDate])) ) 
				 THEN 'Complete Date must <= Due Date + 3. '
				 ELSE ''
						END )
            --+ ( CASE WHEN EXISTS ( SELECT 1
            --                            FROM    [dbo].[AL_TrainingAutoLock] B WITH (NOLOCK)
            --                            WHERE   A.[UserName] = B.[UserName]
												--AND A.[TrainingCodeID] = B.[TrainingCodeID]
												--AND B.[LastUpdatedBy] = @LastUpdatedBy)
            --             THEN '[UserName] and [CodeID] already existed. '
            --             ELSE ''
            --        END ) 
	FROM	[dbo].[AL_TrainingAutoLockTemp] A
    WHERE	A.[LastUpdatedBy] = @LastUpdatedBy

	UPDATE A
	SET [WDNo] = B.[WDNo]
	FROM [dbo].[AL_TrainingAutoLockTemp] A WITH (NOLOCK)
		INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID] = B.[EmployeeID]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy

	UPDATE A
	SET [WDNo] = B.[WDNo]
	FROM [dbo].[AL_TrainingAutoLockTemp] A WITH (NOLOCK)
		INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeIDSAP] = B.[EmployeeIDSAP] AND A.[EmployeeIDSAP] != ''
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
		AND A.[WDNo] = ''
   
	UPDATE A
	SET [WDNo] = B.[WDNo]
	FROM [dbo].[AL_TrainingAutoLockTemp] A WITH (NOLOCK)
		INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[UserName] = B.[UserName] AND A.[UserName] != ''
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
		AND A.[WDNo] = ''

	UPDATE	[dbo].[AL_TrainingAutoLockTemp]
	SET		[IsValid] = 0
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND [ErrorMessage] != ''
END

