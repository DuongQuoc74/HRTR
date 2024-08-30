CREATE PROC [dbo].[SY_Department_Save] 
(
	@DepartmentID int
	, @DepartmentCode varchar(5)
	, @DepartmentName varchar(100)
	--, @UserName varchar(50)=''
	, @LastUpdatedBy	int = 0	
)
AS
BEGIN
	--DECLARE @UserID int
	--SET @UserID = [dbo].[ufn_GetUserID_By_UserName](@UserName)
	IF EXISTS (SELECT 1 FROM [dbo].[SY_Department] WITH (NOLOCK)
	WHERE [DepartmentID]=@DepartmentID)
	BEGIN
		--update existing record
		UPDATE [dbo].[SY_Department] SET  [DepartmentCode]=@DepartmentCode, [DepartmentName]=@DepartmentName,
							[LastUpdated]=GETDATE(),
							[LastUpdatedBy]=@LastUpdatedBy
		WHERE [DepartmentID]=@DepartmentID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SY_Department] ([DepartmentCode], [DepartmentName], [LastUpdated], [LastUpdatedBy])
		VALUES (@DepartmentCode, @DepartmentName, GETDATE(), @LastUpdatedBy)
		SET @DepartmentID=SCOPE_IDENTITY()
		
	END
	EXEC [dbo].[SY_Department_Select] @DepartmentID

END
