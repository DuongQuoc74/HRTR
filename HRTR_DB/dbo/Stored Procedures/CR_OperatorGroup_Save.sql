CREATE PROC [dbo].[CR_OperatorGroup_Save] @OperatorGroupID int, @OperatorGroupName varchar(100), 
	@LastUpdatedBy int
AS
BEGIN
	--DECLARE @UserID int
	--SET @UserID = [dbo].[ufn_GetUserID_By_UserName](@UserName)
	IF EXISTS (SELECT TOP 1 1 FROM [dbo].[CR_OperatorGroup] WHERE [OperatorGroupID]=@OperatorGroupID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_OperatorGroup] SET [OperatorGroupName]=@OperatorGroupName,
					[LastUpdated]=GETDATE(),
					[LastUpdatedBy]=@LastUpdatedBy
		WHERE [OperatorGroupID]=@OperatorGroupID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_OperatorGroup] ([OperatorGroupName], [LastUpdated], [LastUpdatedBy])
		VALUES (@OperatorGroupName, GETDATE(), @LastUpdatedBy)
		SET @OperatorGroupID=SCOPE_IDENTITY()
	END

	EXEC [dbo].[CR_OperatorGroup_Select] @OperatorGroupID
END

