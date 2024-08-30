CREATE PROC [dbo].[CR_CourseGroup_Search] 
(
	@CourseGroupName varchar(50), 
	@IsActive	int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT A.[CourseGroupID], A.[CourseGroupName], A.[ExpiredInMonths], A.[IsActive],
						  A.[LastUpdated], B.[UserName] As [LastUpdatedByUserName]
				   FROM	[dbo].[CR_CourseGroup] A WITH (NOLOCK) LEFT JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]'
	SET @Query2 = N''
	IF @CourseGroupName != ''
		SET @Query2 = @Query2 + N' AND A.[CourseGroupName] LIKE ''%'' + @CourseGroupName + ''%'''
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' AND A.[IsActive] = @IsActive'
		
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
									
	SET @Query = @Query + @Query2 + N' ORDER BY A.[CourseGroupName]'

	SET @ParmDef = '@CourseGroupName	nvarchar(50)
					, @IsActive	int'
					
	EXEC sp_executesql @Query, @ParmDef
								, @CourseGroupName
								, @IsActive
											
	--SELECT A.[CourseGroupID], A.[CourseGroupName], A.[ExpiredInMonths]
	--FROM	[dbo].[CR_CourseGroup] A
	--WHERE	A.[CourseGroupName] LIKE + '%' + @CourseGroupName + '%'
END


