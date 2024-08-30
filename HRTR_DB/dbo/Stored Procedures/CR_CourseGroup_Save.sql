CREATE PROC [dbo].[CR_CourseGroup_Save] 
(
	@CourseGroupID			int, 
	@CourseGroupName		varchar(100), 
	@ExpiredInMonths		int,
	@IsActive				bit,
	@LastUpdatedBy	int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	SET @CourseGroupName= LTRIM(RTRIM(@CourseGroupName))
	--DECLARE @UserID int
	--SET @UserID = [dbo].[ufn_GetUserID_By_UserName](@UserName)
	IF EXISTS (SELECT 1
			FROM [dbo].[CR_CourseGroup] WITH (NOLOCK)
			WHERE [CourseGroupID]=@CourseGroupID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_CourseGroup] 
		SET		[CourseGroupName]=@CourseGroupName
				, [ExpiredInMonths]=@ExpiredInMonths
				, [IsActive]=@IsActive
				, [LastUpdated]=GETDATE()
				, [LastUpdatedBy]=@LastUpdatedBy
		WHERE [CourseGroupID]=@CourseGroupID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_CourseGroup] ([CourseGroupName], [ExpiredInMonths], [IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@CourseGroupName, @ExpiredInMonths, @IsActive, GETDATE(), @LastUpdatedBy)
		SET @CourseGroupID=SCOPE_IDENTITY()
	END
	EXEC [dbo].[CR_CourseGroup_Select] @CourseGroupID

END

