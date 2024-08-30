
CREATE PROC [dbo].[SC_Logon_Save_InPage] 
(
	@AuthenticationName					nvarchar(50)
	, @UserProfileID					int
	, @PageName							nvarchar(255) = ''
	, @LastUpdatedBy					int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @AuthenticationTypeID int = 1
			, @EmployeeID_ID int = -1
			, @PCName nvarchar(50) = ''
			, @IPAddress varchar(50) = ''
			, @ApplicationID int = 1
			, @SystemKindID int = 1
	
	INSERT INTO [dbo].[SC_Logon]
           ([AuthenticationTypeID]
      ,[AuthenticationName]
      ,[EmployeeID_ID]
      ,[UserProfileID]
      ,[PCName]
      ,[IPAddress]
      ,[ApplicationID]
      ,[SystemKindID]
      ,[PageName]
      ,[LastUpdated]
      ,[LastUpdatedBy])
        VALUES(@AuthenticationTypeID
           ,@AuthenticationName
           ,@EmployeeID_ID
           ,@UserProfileID
           ,@PCName
		   ,@IPAddress
           ,@ApplicationID
           ,@SystemKindID
		   ,@PageName
           ,GETDATE()
           ,@LastUpdatedBy)
	IF @UserProfileID NOT IN (0, -1)
	BEGIN
		UPDATE [dbo].[SC_UserProfile]
		SET [LastLoggedOn] = GETDATE()
		WHERE [UserProfileID] = @UserProfileID
	END
END



