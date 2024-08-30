






CREATE VIEW [dbo].[HR_Employee_V]
AS
SELECT A.[EmployeeID_ID]
		,A.[EmployeeID]
		,A.[EmployeeIDSAP]
		,A.[WDNo]
		,A.[EmployeeName]
		,(A.[EmployeeID] + N' - ' + A.[EmployeeName]) AS [EmployeeIDName]
		,A.[OperatorGroupID]
		,C.[OperatorGroupName]
		,A.[CompanyID]
		,D.[CompanyName]
		,A.[DepartmentID]
		,B.[DepartmentName]
		,A.[JobTitle]
		,A.[PositionID]
		,E.[PositionName]
		,A.[WorkcellID]
		,G.[WorkcellName]
		,A.[Supervisor]
		,A.[IsActive]
		,A.[IsSupervisor]
		,A.[JoinedDate]
		,A.[UserName]
		,A.[LastUpdated]
		,A.[LastUpdatedBy]
		,WS.[WorkingStatusID]
		,WS.[WorkingStatusCode]
		,WS.[WorkingStatusName]
		,WS.[IsContract]
		,WS.[IsWorking]
	FROM	[dbo].[HR_Employee] A WITH (NOLOCK) LEFT OUTER JOIN [dbo].[SY_Department] B WITH (NOLOCK) ON A.[DepartmentID] = B.[DepartmentID] 
								LEFT OUTER JOIN [dbo].[CR_OperatorGroup] C WITH (NOLOCK) ON A.[OperatorGroupID] = C.[OperatorGroupID] 
								LEFT OUTER JOIN [dbo].[CR_Company] D WITH (NOLOCK) ON A.[CompanyID] = D.[CompanyID] 
								LEFT OUTER JOIN [dbo].[CR_Position] E WITH (NOLOCK) ON A.[PositionID] = E.[PositionID] 
								LEFT OUTER JOIN [dbo].[CR_Workcell] G WITH (NOLOCK) ON A.[WorkcellID] = G.[WorkcellID] 
								LEFT OUTER JOIN [dbo].[CR_WorkingStatus] WS WITH (NOLOCK) ON WS.[WorkingStatusID] = A.[WorkingStatusID]






