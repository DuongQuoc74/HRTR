/********************************************************************
	[proc] TrainingRecordTemp_Verify_Before_Loading
    	Remove all Training records in table TrainingRecordTemp

 	Log
    	---------- --:-- Init
    	2020-05-28 10:30 Update Stored procedure and format

********************************************************************/
CREATE PROCEDURE [dbo].[TrainingRecordTemp_Verify_Before_Loading]
(
	@LastUpdatedBy	int
)
AS
	BEGIN
		SET NOCOUNT ON

		DELETE FROM	[dbo].[TrainingRecordTemp]
		WHERE [LastUpdatedBy] = @LastUpdatedBy

	END



