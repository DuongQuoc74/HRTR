-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AL_TrainingEmpLockTemp_Search]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT A.[EmployeeID]
	  ,A.[WDNo]
      ,A.[EmployeeIDSAP]
      ,A.[UserName]
      ,A.[EmployeeName]
      ,A.[TrainingCodeID]
      ,A.[Description]
      ,A.[DueDate]
      ,A.[ExtendDay]
      ,A.[ExtendFromDate]
      ,A.[CompleteDate]
      ,A.[IsValid]
      ,A.[ErrorMessage]
      ,A.[LastUpdated]
      ,A.[LastUpdatedBy]
	FROM	[dbo].[AL_TrainingAutoLockTemp] A WITH (NOLOCK)
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
		AND A.[EmployeeID] IS NOT NULL
END

