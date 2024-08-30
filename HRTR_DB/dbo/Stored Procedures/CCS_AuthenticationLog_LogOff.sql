-- From CCS V1.0.0.3
CREATE PROC [dbo].[CCS_AuthenticationLog_LogOff] 
(
	
	@CCS_AuthenticationLogID		int
	, @IsForcedLogoff				bit = 0
	
)
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE	[dbo].[CCS_AuthenticationLog]
	SET		[LogoffTime] = GETDATE()
			, [IsForcedLogoff] = @IsForcedLogoff
	WHERE	[CCS_AuthenticationLogID] = @CCS_AuthenticationLogID

END


