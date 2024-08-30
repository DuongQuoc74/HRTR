-- Insert employee info from eDB to table Employee
CREATE PROC [dbo].[eDB_Sync] 
AS
BEGIN
	SET NOCOUNT ON
	-- Employee Info START
	SELECT  A.[EmployeeID_ID]
			  ,A.[EmployeeID]
			  ,A.[EmployeeIDSAP]
			  ,A.[EmployeeName]
			  ,A.[OperatorGroupID]
			  ,A.[CompanyID]
			  ,A.[DepartmentCode]
			  ,0 AS [DepartmentID]
			  ,A.[JobTitle]
			  ,A.[PositionID]
			  ,A.[ShiftID]
			  ,A.[WorkcellCode]
			  ,0 AS [WorkcellID]
			  ,A.[Supervisor]
			  ,A.[IsActive]
			  ,A.[JoinedDate]
			  ,A.[UserName]
			  ,A.[IsSupervisor]
			  ,A.[Customer_ID]
			  ,A.[Email]
			  ,CAST(0 AS BIT) AS [IsValidUserName]
			  --,A.[LocalPositionID]
			  ,A.[WorkingStatusID]
			  ,A.[UserName] AS [eDBUserName]
			  ,A.[WDNo]
	INTO #tmpHR_Employee
	FROM [eDB].[dbo].[HRTR_HR_Employee_V] A WITH (NOLOCK)
	--WHERE A.[IsActive] = 1
	
	UPDATE A
	SET [IsValidUserName] = 1
	FROM #tmpHR_Employee A
		INNER JOIN [dbo].[SC_DomainAccount] B ON A.[UserName] = B.[UserName]
	
	UPDATE A
	SET [UserName] = ''
	FROM #tmpHR_Employee A
	WHERE [IsValidUserName] = 0
		
	UPDATE A
	SET [DepartmentID] = ISNULL(B.[DepartmentID], 0)
		, [WorkcellID] = ISNULL(C.[WorkcellID], 8) --default is GE workcell???????
	FROM #tmpHR_Employee A LEFT OUTER JOIN [dbo].[SY_Department] B WITH (NOLOCK) ON A.[DepartmentCode] = B.[eDBDepartmentCode]
							LEFT OUTER JOIN [dbo].[CR_Workcell] C WITH (NOLOCK) ON C.[eDBWorkcellCode] = A.[WorkcellCode]

	--De-active resigned user
	UPDATE A
	SET A.[IsActive] = 0
	FROM #tmpHR_Employee A
	WHERE A.[WorkingStatusID] = 7
	--			SELECT *
	--FROM #tmpHR_Employee
	--DROP TABLE #tmpHR_Employee

	--De-active training record when user change from DL to IL
	UPDATE A
	SET A.[IsActive] = 0, A.[Comments] = 'The user has changed from DL to IL'
	FROM [dbo].[TrainingRecord] A INNER JOIN #tmpHR_Employee B 
	ON A.EmployeeID = B.EmployeeID INNER JOIN HR_Employee C 
	ON B.EmployeeID = C.EmployeeID
	WHERE C.PositionID = 1 AND B.PositionID = 2

	UPDATE A
	SET [EmployeeIDSAP] = B.[EmployeeIDSAP]
			,[EmployeeName] = B.[EmployeeName]
			--,[OperatorGroupID] = 
			--,[CompanyID]
			,[DepartmentID] = B.[DepartmentID]
			,[JobTitle] = B.[JobTitle]
			,[PositionID] = B.[PositionID]
			--,[ShiftID]
			,[WorkcellID] = B.[WorkcellID]
			,[Supervisor] = B.[Supervisor]
			,[IsActive] = B.[IsActive]
			,[JoinedDate] = B.[JoinedDate]
			,[UserName] = (CASE WHEN A.[UserName] = '' THEN B.[UserName] ELSE A.[UserName] END)
			--,[IsSupervisor]
			--,[LastUpdated]
			--,[LastUpdatedBy]
			--,[Customer_ID]
			,[Email] = B.[Email]
			,[WorkingStatusID] = B.[WorkingStatusID]
			,[eDBUserName] = B.[eDBUserName]
			,[WDNo] = B.[WDNo]
			--,[IsValidUserName] = (CASE WHEN A.[IsValidUserName] = 1 THEN A.[IsValidUserName] ELSE B.[IsValidUserName] END)
			--,[SupervisorID] = 0 --B.[SupervisorID]
			--,[LocalPositionID] = B.[LocalPositionID]
	FROM [dbo].[HR_Employee] A WITH (NOLOCK) INNER JOIN #tmpHR_Employee B WITH (NOLOCK) ON A.[EmployeeID] = B.[EmployeeID]
	

	INSERT INTO [dbo].[HR_Employee]([EmployeeID]
      ,[EmployeeIDSAP]
      ,[EmployeeName]
      ,[OperatorGroupID]
      ,[CompanyID]
      ,[DepartmentID]
      ,[JobTitle]
      ,[PositionID]
      ,[ShiftID]
      ,[WorkcellID]
      ,[Supervisor]
      ,[IsActive]
      ,[JoinedDate]
      ,[UserName]
      ,[IsSupervisor]
      ,[LastUpdated]
      ,[LastUpdatedBy]
      ,[Customer_ID]
      ,[Email]
      ,[IsValidUserName]
      ,[WorkingStatusID]
	  ,[eDBUserName]
	  ,[WDNo]
      --,[SupervisorID]
      --,[LocalPositionID]
      )
	SELECT A.[EmployeeID]
      ,A.[EmployeeIDSAP]
      ,A.[EmployeeName]
      ,A.[OperatorGroupID]
      ,A.[CompanyID]
      ,A.[DepartmentID]
      ,A.[JobTitle]
      ,A.[PositionID]
      ,A.[ShiftID]
      ,A.[WorkcellID]
      ,A.[Supervisor]
      ,A.[IsActive]
      ,A.[JoinedDate]
      ,A.[UserName]
      ,A.[IsSupervisor]
      ,GETDATE() AS [LastUpdated]
      ,-1 AS [LastUpdatedBy]
      ,A.[Customer_ID]
      ,A.[Email]
      ,A.[IsValidUserName]
      ,A.[WorkingStatusID]
	  ,A.[eDBUserName] AS [eDBUserName]
	  ,A.[WDNo]
      --,0 AS [SupervisorID]
      --,A.[LocalPositionID]
	FROM  #tmpHR_Employee A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1
						FROM [dbo].[HR_Employee] B WITH (NOLOCK)
						WHERE B.[EmployeeID] = A.[EmployeeID])
    DROP TABLE #tmpHR_Employee
    
	-- Customer_ID
	UPDATE A
	SET [Customer_ID] = B.[Customer_ID]
	FROM [dbo].[HR_Employee] A WITH (NOLOCK)
		INNER JOIN [dbo].[GC_Customers] B WITH (NOLOCK) ON A.[WorkcellID] = B.[WorkcellID]
	-- Employee Info END

	-- Employee Picture START
	CREATE TABLE #tmpHR_EmployeePicture
	(
		[EmployeeID] [nvarchar](20) NOT NULL,
		[EmployeePicture] [image] NOT NULL
	)
	INSERT INTO #tmpHR_EmployeePicture
	SELECT [EmployeeID]
           ,[EmployeePicture]
	FROM [eDB].[dbo].[HR_EmployeePicture] A WITH (NOLOCK)

	UPDATE A
	SET [EmployeePicture] = B.[EmployeePicture]
			, [LastUpdated] = GETDATE()
			, [LastUpdatedBy] = -1
	FROM [dbo].[HR_EmployeePicture] A WITH (NOLOCK)
			INNER JOIN #tmpHR_EmployeePicture B ON A.[EmployeeID] = B.[EmployeeID]
	INSERT INTO [dbo].[HR_EmployeePicture]
           ([EmployeeID]
           ,[EmployeePicture]
           ,[LastUpdated]
           ,[LastUpdatedBy]
           ,[PictureFile])
    SELECT [EmployeeID]
           ,[EmployeePicture]
           ,GETDATE() AS [LastUpdated]
           ,-1 AS [LastUpdatedBy]
           ,'' AS [PictureFile]
	FROM #tmpHR_EmployeePicture A 
	WHERE NOT EXISTS (SELECT 1
						FROM [dbo].[HR_EmployeePicture] B WITH (NOLOCK)
						WHERE A.[EmployeeID] = B.[EmployeeID]
						)

	DROP TABLE #tmpHR_EmployeePicture
	-- Employee Picture END
	
END
