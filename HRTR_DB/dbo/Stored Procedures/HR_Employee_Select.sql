CREATE PROC [dbo].[HR_Employee_Select] 
(
	@EmployeeID_ID	int
)
AS
BEGIN
	SET NOCOUNT ON
	--IF @EmployeeID_ID = 0
	--BEGIN
	--	SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
	--	FROM [dbo].[HR_Employee] WITH (NOLOCK)
	--	WHERE [EmployeeID]=@EmployeeID
	--END
	--SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, 0)
	--IF @EmployeeID_ID <> 0
	--BEGIN
	SELECT A.[EmployeeID_ID]
		  ,A.[EmployeeID]
		  ,A.[EmployeeIDSAP]
		  ,A.[WDNo]
		  ,A.[EmployeeName]
		  ,A.[OperatorGroupID]
		  --,C.[OperatorGroupName]
		  ,A.[CompanyID]
		  --,D.[CompanyName]
		  ,A.[DepartmentID]
		  --,B.[DepartmentName]
		  ,A.[JobTitle]
		  ,A.[PositionID]
		  --,E.[PositionName]
		  --,A.[ShiftID]
		  --,F.[ShiftName]
		  ,A.[WorkcellID]
		  --,G.[WorkcellName]
		  ,A.[Supervisor]
		  ,A.[IsActive]
		  ,A.[IsSupervisor]
		  ,A.[JoinedDate]
		  ,A.[UserName]
		  ,A.[WorkingStatusID]
	FROM	[dbo].[HR_Employee] A WITH (NOLOCK) --LEFT OUTER JOIN [dbo].[Department] B WITH (NOLOCK) ON A.[DepartmentID] = B.[DepartmentID] 
								--LEFT OUTER JOIN [dbo].[CR_OperatorGroup] C WITH (NOLOCK) ON A.[OperatorGroupID] = C.[OperatorGroupID] 
								--LEFT OUTER JOIN [dbo].[CR_Company] D WITH (NOLOCK) ON A.[CompanyID] = D.[CompanyID] 
								--LEFT OUTER JOIN [dbo].[CR_Position] E WITH (NOLOCK) ON A.[PositionID] = E.[PositionID] 
								--LEFT OUTER JOIN [dbo].[CR_Shift] F WITH (NOLOCK) ON A.[ShiftID] = F.[ShiftID] 
								--LEFT OUTER JOIN [dbo].[Workcell] G WITH (NOLOCK) ON A.[WorkcellID] = G.[WorkcellID] 
	WHERE A.[EmployeeID_ID] = @EmployeeID_ID
	--END
	--ELSE
	--BEGIN
	--	SELECT A.[EmployeeID_ID]
	--		  ,A.[EmployeeID]
	--		  ,A.[EmployeeName]
	--		  ,A.[OperatorGroupID]
	--		  --,C.[OperatorGroupName]
	--		  ,A.[CompanyID]
	--		  --,D.[CompanyName]
	--		  ,A.[DepartmentID]
	--		  --,B.[DepartmentName]
	--		  ,A.[JobTitle]
	--		  ,A.[PositionID]
	--		  --,E.[PositionName]
	--		  ,A.[ShiftID]
	--		  --,F.[ShiftName]
	--		  ,A.[WorkcellID]
	--		  --,G.[WorkcellName]
	--		  ,A.[Supervisor]
	--		  ,A.[IsActive]
	--		  ,A.[JoinedDate]
	--		  ,A.[UserName]
	--	FROM	[dbo].[HR_Employee] A WITH (NOLOCK) --LEFT OUTER JOIN [dbo].[Department] B WITH (NOLOCK) ON A.[DepartmentID] = B.[DepartmentID] 
	--								--LEFT OUTER JOIN [dbo].[CR_OperatorGroup] C WITH (NOLOCK) ON A.[OperatorGroupID] = C.[OperatorGroupID] 
	--								--LEFT OUTER JOIN [dbo].[CR_Company] D WITH (NOLOCK) ON A.[CompanyID] = D.[CompanyID] 
	--								--LEFT OUTER JOIN [dbo].[CR_Position] E WITH (NOLOCK) ON A.[PositionID] = E.[PositionID] 
	--								--LEFT OUTER JOIN [dbo].[CR_Shift] F WITH (NOLOCK) ON A.[ShiftID] = F.[ShiftID] 
	--								--LEFT OUTER JOIN [dbo].[Workcell] G WITH (NOLOCK) ON A.[WorkcellID] = G.[WorkcellID] 
	--	WHERE A.[EmployeeID]=@EmployeeID
	--END
END


