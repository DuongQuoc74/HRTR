
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TrainingRecordTemp_Verify_Before_Loading_20180116]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE
	FROM	[dbo].[TrainingRecordTemp]
	WHERE [LastUpdatedBy] = @LastUpdatedBy
   
END



