CREATE PROC [dbo].[CR_Course_Search_20160901] 
(
	@CourseName varchar(50), 
	@CourseGroupID int,
	@TrainingGroupID	int,
	@HasVA	int = -1,
	@IsCritical int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	A.[CourseID],  A.[CourseGroupID], A.[TrainingGroupID],A.[CourseName], B.[CourseGroupName], C.[TrainingGroupName]
			, A.[ExpiredInMonths], A.[HasVA], A.[IsCritical], A.[NumberOfCriticalDays]
	FROM	[dbo].[CR_Course] A WITH (NOLOCK) 
				LEFT OUTER JOIN [dbo].[CR_CourseGroup] B WITH (NOLOCK) ON A.[CourseGroupID]=B.[CourseGroupID]
				LEFT OUTER JOIN [dbo].[CR_TrainingGroup] C WITH (NOLOCK) ON A.[TrainingGroupID]=C.[TrainingGroupID]
	WHERE	A.[CourseName] LIKE + '%' + @CourseName + '%'
			AND (A.[TrainingGroupID]=@TrainingGroupID OR @TrainingGroupID = 0 OR @TrainingGroupID IS NULL)
			AND (A.[CourseGroupID]=@CourseGroupID OR @CourseGroupID = 0 OR @CourseGroupID IS NULL)
			AND C.[IsActive] = 1
			AND 
			(
				(ISNULL(A.[HasVA],0)=0 AND @HasVA = 0)
				OR (ISNULL(A.[HasVA],0)=1 AND @HasVA = 1)
				OR @HasVA = -1
			)
			AND 
			(
				(ISNULL(A.[IsCritical],0)=0 AND @IsCritical = 0)
				OR (ISNULL(A.[IsCritical],0)=1 AND @IsCritical = 1)
				OR @IsCritical = -1
			)
			AND A.[IsActive] = 1
	ORDER BY C.[TrainingGroupName], B.[CourseGroupName], A.[CourseName]
END

