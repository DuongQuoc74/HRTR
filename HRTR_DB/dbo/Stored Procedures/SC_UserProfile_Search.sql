CREATE PROC [dbo].[SC_UserProfile_Search] 
(
	@UserName			varchar(50), 
	@EmployeeID			varchar(20), 
	@FullName			varchar(100), 
	@Email				varchar(100), 
	@DepartmentID		int, 
	@ContactNo			varchar(50), 
	@IsActive			int,
	@PermissionRoleID	int,
	@Customer_ID		int,
	@Filter				varchar(255)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
	SET @Query = N'SELECT A.[UserProfileID]
		  ,A.[UserName]
		  ,A.[EmployeeID]
		  ,A.[FullName]
		  ,A.[Email]
		  ,A.[DepartmentID]
		  ,A.[ContactNo]
		  ,A.[IsActive]
		  ,B.[DepartmentName]
	FROM [dbo].[SC_UserProfile] A WITH (NOLOCK), [dbo].[SY_Department] B WITH (NOLOCK) 
	WHERE A.[DepartmentID] = B.[DepartmentID]'
	
	IF @Filter != ''
		SET @Query = @Query + N' AND (
									A.[UserName] LIKE + ''%'' + @Filter + ''%''
									OR A.[EmployeeID] LIKE + ''%'' + @Filter + ''%''
									OR A.[FullName] LIKE + ''%'' + @Filter + ''%''
									OR A.[Email] LIKE + ''%'' + @Filter + ''%''
									OR A.[ContactNo] LIKE + ''%'' +  @Filter + ''%''
								)'		
	IF @UserName != ''
		SET @Query = @Query + N' AND A.[UserName] LIKE ''%'' + @UserName + ''%'''
	IF @EmployeeID != ''
		SET @Query = @Query + N' AND A.[EmployeeID] LIKE ''%'' + @EmployeeID + ''%'''
	IF @FullName != ''
		SET @Query = @Query + N' AND A.[FullName] LIKE ''%'' + @FullName + ''%'''
	IF @Email != ''
		SET @Query = @Query + N' AND A.[Email] LIKE ''%'' + @Email + ''%'''
	IF @DepartmentID != 0
		SET @Query = @Query + N' AND A.[DepartmentID] =  @DepartmentID' 
	IF @ContactNo != ''
		SET @Query = @Query + N' AND A.[ContactNo] LIKE ''%'' + @ContactNo + ''%'''
	IF @IsActive != -1
		SET @Query = @Query + N' AND A.[IsActive] = @IsActive'
	IF @PermissionRoleID != 0
		SET @Query = @Query + N' AND EXISTS (	SELECT 1
												FROM	[dbo].[SC_UserProfilePermissionRole] C WITH (NOLOCK)
												WHERE	C.[PermissionRoleID] = @PermissionRoleID
														AND C.[UserProfileID] = A.[UserProfileID]
														AND ISNULL(C.[IsActive], 0) = 1)'
	IF @Customer_ID != 0
		SET @Query = @Query + N' AND EXISTS (	SELECT 1
												FROM	[dbo].[SC_UserProfileCustomers] C WITH (NOLOCK)
												WHERE	C.[Customer_ID] = @Customer_ID
														AND C.[UserProfileID] = A.[UserProfileID]
														AND ISNULL(C.[IsActive], 0) = 1)'
														
	SET @Query = @Query + N' AND ISNULL(A.[IsDeleted], 0) = 0 ORDER BY A.[UserName]'													

	SET @ParmDef = '@UserName			varchar(50), 
					@EmployeeID			varchar(20), 
					@FullName			varchar(100), 
					@Email				varchar(100), 
					@DepartmentID		int, 
					@ContactNo			varchar(50), 
					@IsActive			int,
					@PermissionRoleID	int,
					@Customer_ID		int,
					@Filter				varchar(255)'
					
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @UserName
								, @EmployeeID
								, @FullName
								, @Email
								, @DepartmentID 
								, @ContactNo
								, @IsActive
								, @PermissionRoleID
								, @Customer_ID
								, @Filter
END

