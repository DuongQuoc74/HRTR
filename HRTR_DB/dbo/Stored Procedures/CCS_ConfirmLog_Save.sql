CREATE PROC [dbo].[CCS_ConfirmLog_Save]
(
	 @CCS_AuthenticationLogID		int,
	 @IsUnderStand					bit,
	 @DocumentID					uniqueidentifier
)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO [dbo].[CCS_ConfirmLog]
           ([CCS_AuthenticationLogID]
           ,[DocumentID]
           ,[IsUnderstand]
           
           ,[LastUpdated]
           ,[LastUpdatedBy])
	VALUES 
			(
				@CCS_AuthenticationLogID
				, @DocumentID
				, @IsUnderStand
				
				, GETDATE()
				, -1
			)
			
   UPDATE	[dbo].[CCS_AuthenticationLog]
   SET		[IsUnderstand] = @IsUnderStand
			,[DocumentID] = @DocumentID
   WHERE [CCS_AuthenticationLogID] = @CCS_AuthenticationLogID


END

