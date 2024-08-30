CREATE PROC [dbo].[SC_UserProfile_Select] 
(
	@UserProfileID	int,
	@UserName		varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	IF @UserProfileID = 0
	BEGIN
		SELECT TOP 1 @UserProfileID = A.[UserProfileID]
		FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK) 
		WHERE	A.[UserName] = @UserName
	END
	SET @UserProfileID = ISNULL(@UserProfileID, 0)
	IF @UserProfileID != 0
	BEGIN
		SELECT A.[UserProfileID]
			  ,A.[UserName]
			  ,A.[EmployeeID]
			  ,A.[FullName]
			  ,A.[Email]
			  ,A.[DepartmentID]
			  ,A.[ContactNo]
			  ,A.[IsActive]
		FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK)
		WHERE	A.[UserProfileID] = @UserProfileID
				AND A.[IsDeleted] = 0
	END
	ELSE
	BEGIN
		SELECT 0 AS [UserProfileID]
			  ,@UserName AS [UserName]
			  ,'' AS [EmployeeID]
			  ,'' AS [FullName]
			  ,'' AS [Email]
			  ,0 AS [DepartmentID]
			  ,'' AS [ContactNo]
			  ,1 AS [IsActive]
	END
END

