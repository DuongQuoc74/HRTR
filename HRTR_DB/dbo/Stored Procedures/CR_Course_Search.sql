CREATE PROC [dbo].[CR_Course_Search] 
(
	@CourseName                 nvarchar(100) = ''
	, @CourseGroupID			int = 0
	, @TrainingGroupID			int = 0
	, @HasVA				    int = -1
	, @IsCritical				int = -1
	, @IsOrientation			int = -1
	, @CourseGroupIDList		nvarchar(1000) = ''
	, @IsActive				    int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT A.[CourseID], A.[CourseGroupID], A.[TrainingGroupID], A.[CourseName], B.[CourseGroupName], A.[NumberOfCriticalDays]
	                     ,C.[TrainingGroupName], A.[ExpiredInMonths], A.[MinPoint], A.[MaxPoint], A.[HasVA], A.[IsCritical], A.[IsActive], A.[IsOrientation], A.[EffectiveDate]
	                     ,A.[LastUpdated], D.[UserName] As [LastUpdatedByUserName]
	               FROM	[dbo].[CR_Course] A WITH (NOLOCK) 
				        LEFT OUTER JOIN [dbo].[CR_CourseGroup] B WITH (NOLOCK) ON A.[CourseGroupID] = B.[CourseGroupID]
				        LEFT OUTER JOIN [dbo].[CR_TrainingGroup] C WITH (NOLOCK) ON A.[TrainingGroupID] = C.[TrainingGroupID] 
				        LEFT JOIN [dbo].[SC_UserProfile] D WITH (NOLOCK) ON A.[LastUpdatedBy] = D.[UserProfileID]'
	SET @Query2 = N''
	IF @CourseName != ''
		SET @Query2 = @Query2 + N' AND A.[CourseName] LIKE ''%'' + @CourseName + ''%'''
	IF @CourseGroupID != 0
		SET @Query2 = @Query2 + N' AND A.[CourseGroupID] = @CourseGroupID'
	IF @TrainingGroupID != 0
		SET @Query2 = @Query2 + N' AND A.[TrainingGroupID] = @TrainingGroupID'
	IF @HasVA != -1
		SET @Query2 = @Query2 + N' AND A.[HasVA] = @HasVA'
	IF @IsCritical != -1
		SET @Query2 = @Query2 + N' AND A.[IsCritical] = @IsCritical'
	IF @IsOrientation != -1
		SET @Query2 = @Query2 + N' AND A.[IsOrientation] = @IsOrientation'
	IF @CourseGroupIDList != ''
		SET @Query2 = @Query2 + N' AND A.[CourseGroupID] IN (SELECT [Items] AS [CourseGroupID] FROM [dbo].[Split](@CourseGroupIDList, '';''))' 
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' AND A.[IsActive] = @IsActive'
		
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)
									
	SET @Query = @Query + @Query2 + N' ORDER BY A.[CourseName]'

	SET @ParmDef = '@CourseName                 nvarchar(100)
					, @CourseGroupID			int
					, @TrainingGroupID			int
					, @HasVA				    int
					, @IsCritical				int
					, @IsOrientation			int
					, @CourseGroupIDList		nvarchar(1000)
					, @IsActive				    int'
					
	EXEC sp_executesql @Query, @ParmDef
								, @CourseName
								, @CourseGroupID
								, @TrainingGroupID	
								, @HasVA
								, @IsCritical
								, @IsOrientation
								, @CourseGroupIDList
								, @IsActive
END
