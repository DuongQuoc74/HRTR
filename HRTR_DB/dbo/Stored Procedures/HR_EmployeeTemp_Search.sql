-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[HR_EmployeeTemp_Search]
(
	@LastUpdatedBy	int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT A.[EmployeeID]
		  ,'' AS [EmployeeIDSAP]
		  ,A.[EmployeeName]
		  ,A.[JoinedDate]
		  ,B.[OperatorGroupName]
		  ,A.[OperatorGroupID]
		  ,A.[CompanyID]
		  ,C.[CompanyName]
		  ,A.[DepartmentID]
		  ,D.[DepartmentName]
		  ,A.[JobTitle]
		  ,A.[PositionID]
		  ,E.[PositionName]
		  --,A.[ShiftID]
		  ,F.[ShiftName]
		  ,A.[WorkcellID]
		  ,G.[WorkcellName]
		  ,A.[Supervisor]
		  ,A.[IsActive]
		  ,A.[IsValid]
		  ,A.[UserName]
		  ,A.[WorkingStatusID]
		  ,WS.[WorkingStatusName]
		  ,A.[ErrorMessage]
		  ,A.[LastUpdated]
		  ,A.[LastUpdatedBy]
	FROM	[dbo].[HR_EmployeeTemp] A WITH (NOLOCK) LEFT OUTER JOIN [dbo].[CR_OperatorGroup] B WITH (NOLOCK) ON A.[OperatorGroupID] = B.[OperatorGroupID]
								LEFT OUTER JOIN [dbo].[CR_Company] C WITH (NOLOCK) ON A.[CompanyID] = C.[CompanyID]
								LEFT OUTER JOIN [dbo].[SY_Department] D WITH (NOLOCK) ON A.[DepartmentID] = D.[DepartmentID]
								LEFT OUTER JOIN [dbo].[CR_Position] E WITH (NOLOCK) ON A.[PositionID]= E.[PositionID]
								LEFT OUTER JOIN [dbo].[CR_Shift] F WITH (NOLOCK) ON A.[ShiftID]= F.[ShiftID]
								LEFT OUTER JOIN [dbo].[CR_Workcell] G WITH (NOLOCK) ON A.[WorkcellID]= G.[WorkcellID]
								LEFT OUTER JOIN [dbo].[CR_WorkingStatus] WS WITH (NOLOCK) ON WS.[WorkingStatusID] = A.[WorkingStatusID]
	WHERE A.[LastUpdatedBy] = @LastUpdatedBy
   
END


