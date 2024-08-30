CREATE PROC [dbo].[CR_EmployeeDocument_Select] @EmployeeDocID int
AS
SELECT E.[EmployeeDocID]
      ,E.[EmployeeID]
	  ,A.[EmployeeName]
      ,C.[CourseName]
	  ,C.[CourseGroupName]
	  ,C.[TrainingGroupName]
	  ,A.[WorkcellName]
	  ,S.[Name] AS StationName
      ,E.[DocumentNumber]
      ,E.[Revision]
FROM [dbo].[CR_EmployeeDocument] E
INNER JOIN [dbo].[HR_Employee_V] A WITH (NOLOCK) ON A.[EmployeeID_ID] = E.[EmployeeID_ID]
INNER JOIN [dbo].[CR_Course_V1] C WITH (NOLOCK) ON C.CourseID = E.CourseID
INNER JOIN [dbo].[CR_Station] S WITH (NOLOCK) ON S.Id = E.StationID
WHERE E.[EmployeeDocID]=@EmployeeDocID AND E.[Active]=1