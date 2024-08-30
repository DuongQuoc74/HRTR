
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TrainingRecord_Import_20180116]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	MERGE [dbo].[TrainingRecord] AS T
	USING (SELECT DISTINCT [EmployeeID]
				  ,[ProductID]
				  ,[Trainer]
				  ,[CourseID]
				  ,[CertDate]
				  ,[ExpDate]
				  ,[Score]
				  ,[CertifiedLevelID]
				  ,[EmployeeID_ID]
				  ,[OJT]
			FROM	[dbo].[TrainingRecordTemp] WITH (NOLOCK)
			WHERE	[LastUpdatedBy] = @LastUpdatedBy
					AND [IsValid] = 1) AS S
	ON (T.[EmployeeID_ID] = S.[EmployeeID_ID] 
			AND T.[CourseID] = S.[CourseID]
			AND T.[CertDate] = S.[CertDate]
			AND T.[ProductID] = S.[ProductID]
			) 
	WHEN NOT MATCHED 
		THEN INSERT ([EmployeeID]
				,[ProductID]
				,[Trainer]
				,[CourseID]
				,[CertDate]
				,[ExpDate]
				,[Score]
				,[CertifiedLevelID]
				,[EmployeeID_ID]
				,[OJT]
				,[LastUpdated]
				,[LastUpdatedBy])
		VALUES (S.[EmployeeID]
			,S.[ProductID]
			,S.[Trainer]
			,S.[CourseID]
			,S.[CertDate]
			,S.[ExpDate]
			,S.[Score]
			,S.[CertifiedLevelID]
			,S.[EmployeeID_ID]
			,S.[OJT]
			,GETDATE() --S.[LastUpdated]
			,@LastUpdatedBy)--S.[LastUpdatedBy])
	WHEN MATCHED 
		THEN UPDATE SET T.[ProductID] = S.[ProductID]
			, T.[Trainer] = S.[Trainer]
			, T.[ExpDate] = S.[ExpDate]
			, T.[Score] = S.[Score]
			, T.[CertifiedLevelID] = S.[CertifiedLevelID]
			, T.[OJT] = S.[OJT]
			, T.[LastUpdated] = GETDATE()
			, T.[LastUpdatedBy] = @LastUpdatedBy;
   
END



