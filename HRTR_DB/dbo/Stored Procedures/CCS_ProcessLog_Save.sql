
CREATE PROC [dbo].[CCS_ProcessLog_Save]
(
	 @CCS_AuthenticationLogID		int
	 , @ProcessName					varchar(50)
	 , @DomainName					varchar(50)
	 , @UserName					varchar(50)
	 , @CurrentProcessID			int
	 , @ProcessOwner				varchar(50)
	 , @ProcessID					int
)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO [dbo].[CCS_ProcessLog]
           ([CCS_AuthenticationLogID]
           ,[ProcessName]
           ,[DomainName]
           ,[UserName]
           ,[CurrentProcessID]
           ,[ProcessOwner]
           ,[ProcessID]
           ,[LastUpdated]
           ,[LastUpdatedBy])
     VALUES
           (@CCS_AuthenticationLogID
           ,@ProcessName
           ,@DomainName
           ,@UserName
           ,@CurrentProcessID
           ,@ProcessOwner
           ,@ProcessID
           ,GETDATE()
           ,-1
		   )
END


