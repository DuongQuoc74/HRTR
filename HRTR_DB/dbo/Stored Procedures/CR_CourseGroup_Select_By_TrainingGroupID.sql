CREATE PROC [dbo].[CR_CourseGroup_Select_By_TrainingGroupID] 
(
	@TrainingGroupID int
	, @IsActive		int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT DISTINCT A.[CourseGroupID]
		  ,A.[CourseGroupName]
		  ,A.[ExpiredInMonths]
		  ,B.[TrainingGroupID]
	FROM	[dbo].[CR_CourseGroup] A RIGHT OUTER JOIN [dbo].[CR_Course] B ON A.[CourseGroupID] = B.[CourseGroupID]
	WHERE	B.[TrainingGroupID] = @TrainingGroupID'
	SET @Query2 = ''
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' AND A.[IsActive] = @IsActive'
	IF @Query2 != ''
		SET @Query = @Query + @Query2
	SET @ParmDef = '@TrainingGroupID int, @IsActive		int'
					
	EXEC sp_executesql @Query, @ParmDef
								, @TrainingGroupID
								, @IsActive
END


