CREATE PROC [dbo].[SC_UserProfile_Save] 
(
	@UserProfileID			int, 
	@UserName				varchar(50), 
	@EmployeeID				varchar(20), 
	@FullName				nvarchar(100), 
	@Email					varchar(100), 
	@DepartmentID			int, 
	@ContactNo				varchar(50), 
	@IsActive				bit,
	@LastUpdatedBy			int
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IsDeleted			bit
			, @UserProfileIDC	int
	SELECT TOP 1 @UserProfileIDC = [UserProfileID]
				, @IsDeleted = ISNULL([IsDeleted], 0) 
	FROM	[dbo].[SC_UserProfile] WITH (NOLOCK)
	WHERE	[UserName] = @UserName
	ORDER BY [UserProfileID] DESC
	SET @IsDeleted = ISNULL(@IsDeleted, 0)
	IF @UserProfileIDC IS NOT NULL
		AND @UserProfileIDC != @UserProfileID
		AND @IsDeleted = 0
	BEGIN
		RAISERROR(N'Duplicate user name.', 16, 1)
		RETURN
	END
	IF @UserProfileIDC IS NOT NULL
		AND @IsDeleted = 1
	BEGIN
		SET @UserProfileID = @UserProfileIDC
	END
	IF EXISTS (SELECT 1 FROM [dbo].[SC_UserProfile] WITH (NOLOCK) WHERE [UserProfileID] = @UserProfileID)
	BEGIN
		--update existing record
		UPDATE [dbo].[SC_UserProfile] 
		SET		[UserName] = @UserName, 
				[EmployeeID] = @EmployeeID, 
				[FullName] = @FullName, 
				[Email] = @Email, 
				[DepartmentID] = @DepartmentID, 
				[ContactNo] = @ContactNo, 
				[IsActive] = @IsActive,
				[IsDeleted]=0,
				[LastUpdated]=GETDATE(),
				[LastUpdatedBy] = @LastUpdatedBy
		WHERE [UserProfileID] = @UserProfileID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SC_UserProfile] ([UserName], [EmployeeID], [FullName], [Email], [DepartmentID], [ContactNo], [IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@UserName, @EmployeeID, @FullName, @Email, @DepartmentID, @ContactNo, @IsActive, GETDATE(), @LastUpdatedBy)
		SET @UserProfileID = SCOPE_IDENTITY()
	END
	EXEC [dbo].[SC_UserProfile_Select] @UserProfileID, @UserName
END
