CREATE PROC [dbo].[SY_Department_Search]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT A.[DepartmentID]
		  ,A.[DepartmentCode]
		  ,A.[DepartmentName] 
		  ,B.[UserName] AS [LastUpdatedByUserName]
		  ,A.[LastUpdated]
	FROM [dbo].[SY_Department] A WITH (NOLOCK) 
			LEFT JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]
END
