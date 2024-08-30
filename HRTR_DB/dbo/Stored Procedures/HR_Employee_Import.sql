CREATE PROC [dbo].[HR_Employee_Import] 
(
	@LastUpdatedBy	int
)
AS
BEGIN

	MERGE [dbo].[HR_Employee] AS T
	USING (SELECT DISTINCT [EmployeeID_ID]
					  ,[EmployeeID]
					  ,[EmployeeName]
					  ,[OperatorGroupID]
					  ,[CompanyID]
					  ,[DepartmentID]
					  ,[JobTitle]
					  ,[PositionID]
					  --,[ShiftID]
					  ,[WorkcellID]
					  ,ISNULL([Supervisor], '') AS [Supervisor]
					  ,[IsActive]
					  ,[LastUpdated]
					  ,[LastUpdatedBy]
					  ,[JoinedDate]
					  ,ISNULL([UserName], '') AS [UserName]
		  FROM	[dbo].[HR_EmployeeTemp] WITH (NOLOCK)
		  WHERE	[LastUpdatedBy] = @LastUpdatedBy
				AND ISNULL([IsValid], 0) = 1) AS S
	ON (T.[EmployeeID_ID] = S.[EmployeeID_ID]) 
	WHEN NOT MATCHED 
		THEN INSERT ([EmployeeID]
           ,[EmployeeName]
           ,[OperatorGroupID]
           ,[CompanyID]
           ,[DepartmentID]
           ,[JobTitle]
           ,[PositionID]
           --,[ShiftID]
           ,[WorkcellID]
           ,[Supervisor]
           ,[IsActive]
           ,[LastUpdated]
           ,[LastUpdatedBy]
           ,[JoinedDate]
           ,[UserName])
		VALUES (S.[EmployeeID], ISNULL(S.[EmployeeName],''), ISNULL(S.[OperatorGroupID],0), ISNULL(S.[CompanyID],0)
		, S.[DepartmentID], ISNULL(S.[JobTitle], ''), S.[PositionID]--, S.[ShiftID]
		, S.[WorkcellID], ISNULL(S.[Supervisor], ''), S.[IsActive]
		, GETDATE(), @LastUpdatedBy, S.[JoinedDate], S.[UserName])
	WHEN MATCHED 
		THEN UPDATE SET T.[EmployeeName]=ISNULL(S.[EmployeeName],''),
						--T.[OperatorGroupID]=ISNULL(S.[OperatorGroupID],0), 
						--T.[CompanyID]=ISNULL(S.[CompanyID],0), 
						--T.[DepartmentID]=S.[DepartmentID], 
						--T.[JobTitle]=ISNULL(S.[JobTitle],''), 
						--T.[PositionID]=S.[PositionID], 
						----T.[ShiftID]=S.[ShiftID], 
						--T.[WorkcellID]=S.[WorkcellID],
						--T.[Supervisor]=ISNULL(S.[Supervisor], ''), 
						T.[IsActive]=S.[IsActive],
						
						--T.[JoinedDate]=S.[JoinedDate],
						T.[UserName]=S.[UserName],
						
						T.[LastUpdated]=GETDATE(),
						T.[LastUpdatedBy]=@LastUpdatedBy;
END


