



















CREATE VIEW [dbo].[CCS_AuthenticationLog_V1]
AS
	SELECT A.[CCS_AuthenticationLogID]
	,A.[UserName]
	,B.[EmployeeIDSAP]
	,A.[ClientName]
	,A.[TerminalName]
	,A.[LoginTime]
	,A.[LogoffTime]
	,A.[IsSupervisor]
	,A.[IsCCS]
	,A.[CourseID]
	,A.[IsUnderstand]
	,A.[DocumentID]
	
	,A.[LastUpdated]
	,A.[LastUpdatedBy]
	,A.[IsForcedLogoff]
	,A.[SupervisorUserName]

	,A.[EmployeeID_ID]
	FROM [dbo].[CCS_AuthenticationLog] A WITH (NOLOCK)
	INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
	--ORDER BY A.[CCS_AuthenticationLogID] DESC




