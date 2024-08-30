CREATE PROC [dbo].[CR_Position_Save] @PositionID int, @PositionName varchar(50), 
	@UserName varchar(50)=''
	, @LastUpdatedBy	int = 0	
AS
BEGIN
	DECLARE @UserID int
	SET @UserID = [dbo].[ufn_GetUserID_By_UserName](@UserName)
	IF EXISTS (SELECT 1 FROM [dbo].[CR_Position] WHERE [PositionID]=@PositionID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_Position] SET [PositionName]=@PositionName,
					[LastUpdated]=GETDATE(),
					[LastUpdatedBy]=@UserID
		WHERE [PositionID]=@PositionID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_Position] ([PositionName], [LastUpdated], [LastUpdatedBy])
		VALUES (@PositionName, GETDATE(), @UserID)
		SET @PositionID=SCOPE_IDENTITY()
	END
	EXEC [dbo].[CR_Position_Select] @PositionID

END


