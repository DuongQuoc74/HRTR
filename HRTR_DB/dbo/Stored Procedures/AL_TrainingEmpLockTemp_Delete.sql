-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AL_TrainingEmpLockTemp_Delete]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE
	FROM	[dbo].[AL_TrainingAutoLockTemp]
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
END

