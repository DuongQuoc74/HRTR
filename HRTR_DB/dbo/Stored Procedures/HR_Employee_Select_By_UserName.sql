CREATE PROC [dbo].[HR_Employee_Select_By_UserName] 
(
	@UserName varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @EmployeeID_ID int
	SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
	FROM [dbo].[HR_Employee] WITH (NOLOCK)
	WHERE [UserName] = @UserName AND @UserName != ''
	
	EXEC [dbo].[HR_Employee_Select] @EmployeeID_ID
	--SELECT A.[EmployeeID_ID]
	--	  ,A.[EmployeeID]
	--	  ,A.[EmployeeIDSAP]
	--	  ,A.[EmployeeName]
	--	  ,A.[OperatorGroupID]
	--	  --,C.[OperatorGroupName]
	--	  ,A.[CompanyID]
	--	  --,D.[CompanyName]
	--	  ,A.[DepartmentID]
	--	  --,B.[DepartmentName]
	--	  ,A.[JobTitle]
	--	  ,A.[PositionID]
	--	  --,E.[PositionName]
	--	  ,A.[ShiftID]
	--	  --,F.[ShiftName]
	--	  ,A.[WorkcellID]
	--	  --,G.[WorkcellName]
	--	  ,A.[Supervisor]
	--	  ,A.[IsActive]
	--	  ,A.[IsSupervisor]
	--	  ,A.[JoinedDate]
	--	  ,A.[UserName]
	--FROM	[dbo].[HR_Employee] A WITH (NOLOCK)
	--WHERE A.[UserName] = @UserName

END


