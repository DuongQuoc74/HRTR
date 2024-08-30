CREATE PROC [dbo].[GC_Data_Select] 
(
	@GC_DataID int
)
AS
BEGIN
	SELECT A.[GC_DataID]
	,A.[Customer_ID]
	,A.[MESCustomer_ID]
	,A.[EscapedDate]
	,A.[ShiftID]
	,A.[EscapedByEmployeeID_ID]
	,B.[EmployeeID] AS [EscapedByEmployeeID]
	,A.[EscapedStationID]
	,A.[Defect_ID]
	,A.[DefectText]
	,A.[CRD]
	,A.[Description]
	,A.[DetectedByEmployeeID_ID]
	,C.[EmployeeID] AS [DetectedByEmployeeID]
	,A.[DetectedStationID]
	,A.[Analysis_ID]
	,A.[SerialNumber]
	,A.[DetectedStepIns]
	,A.[DetectedWindowsUserID]
	,A.[CRDStepIns]
	,A.[StartDateTime]
	,A.[EscapedStepIns]
	,A.[EscapedWindowsUserID]
	,A.[IsMESAutoLinked]
	,A.[LastUpdated]
	,A.[LastUpdatedBy]
	FROM [dbo].[GC_Data] A WITH (NOLOCK) INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EscapedByEmployeeID_ID] = B.[EmployeeID_ID]
	INNER JOIN [dbo].[HR_Employee] C WITH (NOLOCK) ON A.[DetectedByEmployeeID_ID] = C.[EmployeeID_ID]
	WHERE [GC_DataID] = @GC_DataID
END

