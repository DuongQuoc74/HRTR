CREATE PROCEDURE [dbo].[HR_Employee_Verify_After_Loading]
(
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE	[dbo].[HR_EmployeeTemp]
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND ISNULL([EmployeeID], '') = ''
																		
	UPDATE	A
	SET		[OperatorGroupID] = B.[OperatorGroupID]
			,[CompanyID] = C.[CompanyID]
			,[DepartmentID] = D.[DepartmentID]
			,[PositionID] = E.[PositionID]
			,[WorkcellID] = G.[WorkcellID]
			--,[EmployeeID_ID] = EP.[EmployeeID_ID]
			--,[ErrorMessage] = ''
	FROM	[dbo].[HR_EmployeeTemp]  A LEFT OUTER JOIN [dbo].[CR_OperatorGroup] B ON A.[OperatorGroupName] = B.[OperatorGroupName]
								LEFT OUTER JOIN [dbo].[CR_Company] C ON A.[CompanyName] = C.[CompanyCode]
								LEFT OUTER JOIN [dbo].[SY_Department] D ON A.[DepartmentName] = D.[DepartmentName]
								LEFT OUTER JOIN [dbo].[CR_Position] E ON A.[PositionName]= E.[PositionName]
								LEFT OUTER JOIN [dbo].[CR_Workcell] G ON A.[WorkcellName]= G.[WorkcellName]
								--LEFT OUTER JOIN [dbo].[HR_Employee] EP ON EP.[EmployeeID]= A.[EmployeeID]
	WHERE  A.[LastUpdatedBy] = @LastUpdatedBy
	
	UPDATE	A
	SET	    [EmployeeID_ID] = B.[EmployeeID_ID]
			, [EmployeeIDSAP] = B.[EmployeeIDSAP]
			, [EmployeeName] = B.[EmployeeName]
			, [OperatorGroupID] = B.[OperatorGroupID]
			, [CompanyID] = B.[CompanyID]
			, [DepartmentID] = B.[DepartmentID]
			 ,[JobTitle] = B.[JobTitle]
			, [PositionID] = B.[PositionID]
			, [WorkcellID] = B.[WorkcellID]
			 ,[Supervisor] = B.[Supervisor]
	FROM	[dbo].[HR_EmployeeTemp] A WITH (NOLOCK) 
				INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID] = B.[EmployeeID]
	WHERE	A.[LastUpdatedBy] = @LastUpdatedBy	
	
	
	UPDATE	[dbo].[HR_EmployeeTemp]
	SET		[OperatorGroupID] = ISNULL([OperatorGroupID], 0)
			, [CompanyID] = ISNULL([CompanyID], 0)
			, [DepartmentID] = ISNULL([DepartmentID], 0)
			, [PositionID] = ISNULL([PositionID], 0)
			, [WorkcellID] = ISNULL([WorkcellID], 0)
			, [IsValid] = 1
			, [ErrorMessage] = ''
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
   
   	UPDATE	A
	SET		[ErrorMessage] = A.[ErrorMessage] + (CASE WHEN A.[OperatorGroupID] = 0
												THEN N'Invalid Operator Group. '
												ELSE N'' END)
											+ (CASE WHEN A.[CompanyID] = 0
												THEN N'Invalid Company. '
												ELSE N'' END)
											+ (CASE WHEN A.[DepartmentID] = 0
												THEN N'Invalid Department. '
												ELSE N'' END)
											+ (CASE WHEN A.[PositionID] = 0
												THEN N'Invalid Position. '
												ELSE N'' END)
											+ (CASE WHEN A.[WorkcellID] = 0
												THEN N'Invalid Workcell. '
												ELSE N'' END)
											+ (CASE WHEN A.[JoinedDate] IS NULL
												THEN N'Invalid Joined Date. '
												ELSE N'' END)
										
	FROM	[dbo].[HR_EmployeeTemp] A WITH (NOLOCK) 
	WHERE	A.[LastUpdatedBy] = @LastUpdatedBy
	
	UPDATE	A
	SET		[ErrorMessage] = A.[ErrorMessage] + N'User Name is assigned to Employee ID [' + B.[EmployeeID] + N']. '
	FROM	[dbo].[HR_EmployeeTemp] A WITH (NOLOCK) 
				INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[UserName] = B.[UserName]
																	AND A.[EmployeeID] != B.[EmployeeID]
	WHERE	A.[LastUpdatedBy] = @LastUpdatedBy	
	
	UPDATE	[dbo].[HR_EmployeeTemp]
	SET		[IsValid] = 0
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND [ErrorMessage] != ''
			
	UPDATE	[dbo].[HR_EmployeeTemp]
	SET		[IsActive] = 0
	WHERE	[LastUpdatedBy] = @LastUpdatedBy
			AND [ErrorMessage] != ''

END