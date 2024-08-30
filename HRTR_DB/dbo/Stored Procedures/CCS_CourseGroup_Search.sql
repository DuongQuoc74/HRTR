CREATE PROC [dbo].[CCS_CourseGroup_Search] 
(
	@CourseGroupName varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	A.[CourseGroupID], A.[CourseGroupName], A.[ExpiredInMonths]
	FROM	[dbo].[CR_CourseGroup] A WITH (NOLOCK)
	WHERE	A.[CourseGroupName] LIKE + '%' + @CourseGroupName + '%'
			AND A.[IsActive] = 1
END


