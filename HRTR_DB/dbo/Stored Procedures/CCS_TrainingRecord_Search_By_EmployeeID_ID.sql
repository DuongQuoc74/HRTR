-- 2017-10-10: CHG0064373, PR 21300 HRTR Enhancement for Awareness Reports (HCM)
-- Remove courses which are configured as Orientation in HRTR system from CCS.
CREATE PROC [dbo].[CCS_TrainingRecord_Search_By_EmployeeID_ID] 
(
	@EmployeeID_ID int
)
AS
BEGIN
	SET NOCOUNT ON	
	
	SELECT [TrainingGroupName] AS [Training Group]
			  ,[CourseGroupName] AS [Course Group]
			  ,[CourseName] AS [Course Name]
			  ,[CertDate] AS [Certified Date]
			  ,[ExpDate] AS [Expried Date]
			  ,[Score]
			  ,[Trainer]
			  ,[OJT] AS [On Job Training]
			  ,(CASE WHEN [ExpDate] IS NULL THEN 'No' 
					WHEN ([ExpDate] > GETDATE()) THEN 'No' 
					ELSE 'Yes' END) AS [Expired]
	FROM [dbo].[TrainingRecord_V1] A WITH (NOLOCK)
	WHERE A.[EmployeeID_ID] = @EmployeeID_ID
		AND A.[IsOrientation] = 0
	ORDER BY [Expired]
			
END


