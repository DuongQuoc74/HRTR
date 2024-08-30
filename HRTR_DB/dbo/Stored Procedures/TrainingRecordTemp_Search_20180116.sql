
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TrainingRecordTemp_Search_20180116]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT  A.[EmployeeID_ID]
      ,A.[EmployeeID]
      ,ISNULL(E.[EmployeeName], '') AS [EmployeeName]
      ,A.[ProductID]
      ,A.[ProductName]
      ,A.[Trainer]
      ,A.[CourseID]
      ,A.[CourseName]
      ,A.[CourseGroupID]
      ,A.[CourseGroupName]
      ,A.[TrainingGroupID]
      ,A.[TrainingGroupName]
      ,A.[CertDate]
      ,A.[ExpDate]
      ,A.[Score]
      ,A.[CertifiedLevelID]
      ,A.[CertifiedLevelName]
      ,A.[OJT]
      ,A.[IsValid]
      ,A.[ErrorMessage]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
	FROM [dbo].[TrainingRecordTemp] A WITH (NOLOCK)
			LEFT OUTER JOIN [dbo].[HR_Employee] E WITH (NOLOCK) ON A.[EmployeeID_ID] = E.[EmployeeID_ID]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
   
END



