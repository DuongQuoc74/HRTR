CREATE PROC [dbo].[SC_Logon_Save] 
(
	@LogonID							int
	, @AuthenticationTypeID				int
	, @AuthenticationName				nvarchar(50)
	, @EmployeeID_ID					int = 0
	, @UserProfileID					int
	, @PCName							nvarchar(50)
	, @IPAddress						varchar(50) = ''
	, @ApplicationID					int
	, @SystemKindID						int = 0
	, @PageName							nvarchar(255) = ''
	, @LastUpdatedBy					int
)
AS
BEGIN
	SET NOCOUNT ON
	--IF EXISTS (	SELECT 1
	--			FROM [dbo].[SC_Logon] WITH (NOLOCK)
	--			WHERE [LogonID] = @LogonID)
	--BEGIN
	--	UPDATE [dbo].[SC_Logon]
	--	SET [AuthenticationTypeID] = @AuthenticationTypeID
	--	  ,[AuthenticationName] = @AuthenticationName
	--	  ,[EmployeeID_ID] = @EmployeeID_ID
	--	  ,[UserProfileID] = @LastUpdatedBy
	--	  ,[PCName] = @PCName
	--	  ,[IPAddress] = @IPAddress
	--	  ,[ApplicationID] = @ApplicationID
	--	  ,[SystemKindID] = @SystemKindID
	--	  ,[PageName] = @PageName
	--	  ,[LastUpdated] = GETDATE()
	--	  ,[LastUpdatedBy] = @LastUpdatedBy
	--	WHERE [LogonID] = @LogonID
	--END
	--ELSE
	--BEGIN
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
		SET @LogonID = SCOPE_IDENTITY()
	--END
	IF @UserProfileID NOT IN (0, -1)
	BEGIN
		UPDATE [dbo].[SC_UserProfile]
		SET [LastLoggedOn] = GETDATE()
		WHERE [UserProfileID] = @UserProfileID
	END
	EXEC [dbo].[SC_Logon_Select] @LogonID
END


