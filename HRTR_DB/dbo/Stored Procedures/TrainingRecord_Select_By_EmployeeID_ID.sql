CREATE PROC [dbo].[TrainingRecord_Select_By_EmployeeID_ID]
(	
	@EmployeeID_ID			int,
	@IsActive_Course		bit,
	@TrainingGroup			nvarchar(500) =  null,
	@CourseGroup			nvarchar(500) =  null,
	@Course					nvarchar(500) =  null
)
AS
BEGIN
	SET NOCOUNT ON
	
	
	SELECT 
		A.[TrainingRecordID]
		,A.[EmployeeID_ID]
		,E.[EmployeeID]
		,E.[EmployeeName]
		,A.[ProductID]
		,(SELECT ProductName FROM CR_Product where ProductID = A.[ProductID])  AS "ProductName"
		,A.[Trainer]
		,A.[CourseID]
		,A.[CertDate]
		,(CASE WHEN A.[OJT] = 1 THEN A.[ExpDate] ELSE [dbo].[ufn_GetExpDate](A.[CertDate], B.[ExpiredInMonths], B.[ExpiredInMonths]) END) AS [ExpDate]
		,A.[Score] 
		,A.[CertifiedLevelID]
		,C.[CertifiedLevelName]
		,ISNULL(A.[OJT], 0) AS [OJT]
		,B.[CourseName]
		,B.[CourseGroupID]
		,B.[CourseGroupName]
		,B.[TrainingGroupID]
		,B.[TrainingGroupName]
		,A.[IsActive]
		,A.[Comments]
	FROM	[dbo].[TrainingRecord] A WITH (NOLOCK) 
		INNER JOIN [dbo].[HR_Employee] E WITH (NOLOCK) ON A.[EmployeeID_ID] = E.[EmployeeID_ID]
		INNER JOIN [dbo].[CR_Course_V1] B WITH (NOLOCK) ON A.[CourseID] = B.[CourseID]
		LEFT OUTER JOIN [dbo].[CR_CertifiedLevel] C WITH (NOLOCK) ON C.[CertifiedLevelID] = A.[CertifiedLevelID]
	WHERE	A.[EmployeeID_ID] = @EmployeeID_ID
	AND ( 
			(@IsActive_Course=1 AND B.[IsActive] = 1)
		OR
			(@IsActive_Course=0 AND B.[IsActive] = 0)
	)
	AND  (@TrainingGroup is null OR @TrainingGroup='' OR B.TrainingGroupName like '%' + @TrainingGroup+'%')
	AND  (@CourseGroup is null OR @CourseGroup='' OR B.CourseGroupName like '%' + @CourseGroup+'%')
	AND  (@Course is null OR @Course='' OR B.CourseName like '%' + @Course+'%')
	 ORDER BY CASE
         WHEN A.[CertifiedLevelID] = 5 then 1
         WHEN A.[CertifiedLevelID] = 2 then 2 
         WHEN A.[CertifiedLevelID] = 6 then 3
         WHEN A.[CertifiedLevelID] = 4 then 4
         WHEN A.[CertifiedLevelID] = 1 then 5
         END  ASC, A.[CertDate] DESC
	
END