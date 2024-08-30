CREATE PROC [dbo].[CR_Shift_Save] @ShiftID int, @ShiftCode varchar(5), @ShiftName varchar(100), 
	--@UserName varchar(50)=''
	@LastUpdatedBy	int = 0	
AS
BEGIN
	--DECLARE @UserID int
	--SET @UserID = [dbo].[ufn_GetUserID_By_UserName](@UserName)
	IF EXISTS (SELECT TOP 1 1 FROM [dbo].[CR_Shift] WITH (NOLOCK) WHERE [ShiftID]=@ShiftID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_Shift] SET [ShiftCode]=@ShiftCode, [ShiftName]=@ShiftName,
					[LastUpdated]=GETDATE(),
					[LastUpdatedBy]=@LastUpdatedBy
		WHERE [ShiftID]=@ShiftID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_Shift] ([ShiftCode], [ShiftName], [LastUpdated], [LastUpdatedBy])
		VALUES (@ShiftCode, @ShiftName, GETDATE(), @LastUpdatedBy)
		SET @ShiftID=SCOPE_IDENTITY()
	END
	EXEC [dbo].[CR_Shift_Select] @ShiftID
	
END

