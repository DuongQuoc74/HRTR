CREATE PROC [dbo].[TrainingRecord_NotificationEmail] 
(
	@NoOfDays	int
)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (	SELECT 1
				FROM	[dbo].[TrainingRecord_V] H WITH (NOLOCK) 
											INNER JOIN [dbo].[HR_Employee] A WITH (NOLOCK) ON H.[EmployeeID]=A.[EmployeeID]
				WHERE	A.[IsActive] = 1 AND A.[PositionID] = 1 -- DL only
						AND DATEDIFF(DAY, DATEADD(DAY, -@NoOfDays, H.[ExpDate]), GETDATE()) = 0
						AND H.[ExpDate] IS NOT NULL
				)
	BEGIN
		DECLARE @EmailSubject		nvarchar(255)
				, @EmailBody		nvarchar(max)
				, @EmailQuery						nvarchar(max)
				, @Emailfrom_address				varchar(max)
				, @Emailreply_to					varchar(max)
				, @recipientslist					nvarchar(max)
				, @Emailblind_copy_recipients		varchar(max)
				, @HRTRLink							nvarchar(255)
		SELECT TOP 1 @Emailfrom_address = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'HRTRfrom_address'
		
		SELECT TOP 1 @Emailreply_to = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'HRTRreply_to'

		SELECT  @recipientslist = COALESCE(@recipientslist + ';', '')
										+ A.[Email]
		FROM (SELECT DISTINCT A.[Email]
		FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK) 
					INNER JOIN [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK) ON A.[UserProfileID] = B.[UserProfileID]
		WHERE	B.[PermissionRoleID] IN (1, 2, 3) -- Trainer + Trainer Leader + Line Manager
				AND A.[IsActive] = 1
				AND B.[IsActive] = 1
				AND [dbo].[ufn_IsValidEmail] (A.[Email]) = 1
				) A
				
		IF @recipientslist = ''
		BEGIN
			SELECT TOP 1 @recipientslist = [ConfigurationValue]
			FROM [dbo].[SY_Configuration] WITH (NOLOCK)
			WHERE [ConfigurationName] = 'HRTRDefaultMail'
		END
		SELECT TOP 1 @Emailblind_copy_recipients = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'HRTRblind_copy_recipients'
		
		--PRINT @recipientslist
		SET @EmailQuery = N'SELECT A.[EmployeeID]
			  ,A.[EmployeeName]
			  ,B.[DepartmentName]
			  ,C.[OperatorGroupName]
			  ,A.[JobTitle]
			  ,E.[PositionName]
			  ,G.[WorkcellName]
			  ,A.[Supervisor]
			  ,H.[Trainer]
			  ,H.[Score] 
			  ,H.[CourseName]
			  ,H.[CourseGroupName]
			  ,H.[TrainingGroupName]
			  ,H.[ProductName]
			  ,H.[CertDate]
			  ,H.[ExpDate]
		FROM	[HRTR].[dbo].[HR_Employee] A WITH (NOLOCK) INNER JOIN [HRTR].[dbo].[SY_Department] B WITH (NOLOCK) ON A.[DepartmentID] = B.[DepartmentID] 
									INNER JOIN [HRTR].[dbo].[CR_OperatorGroup] C WITH (NOLOCK) ON A.[OperatorGroupID] = C.[OperatorGroupID] 
									INNER JOIN [HRTR].[dbo].[CR_Position] E WITH (NOLOCK) ON A.[PositionID] = E.[PositionID] 
									INNER JOIN [HRTR].[dbo].[CR_Workcell] G WITH (NOLOCK) ON A.[WorkcellID] = G.[WorkcellID] 
									INNER JOIN [HRTR].[dbo].[TrainingRecord_V] H WITH (NOLOCK) ON H.[EmployeeID]=A.[EmployeeID]
		WHERE	A.[IsActive] = 1 AND A.[PositionID] = 1
				AND DATEDIFF(DAY, DATEADD(DAY, -' + CONVERT(NVARCHAR, @NoOfDays) + N', H.[ExpDate]), GETDATE()) = 0
				AND H.[ExpDate] IS NOT NULL'
		--PRINT @EmailQuery	
		SELECT TOP 1 @HRTRLink = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'HRTRLink'
		
		SET @EmailSubject = N'HR Training Record - Expired in ' + CONVERT(NVARCHAR, @NoOfDays) + N' day(s)'
		SET @EmailBody = N'<table><tr><td>Dear All, </td></tr><tr><td></td></tr><tr><td></td></tr><tr><td></td></tr><tr><td>Attched file is the list of training record(s) which will be expired in ' + CONVERT(NVARCHAR, @NoOfDays)  + N' day(s).</td></tr>' +
						'<tr><td>Please log in to HR Training Record system to view the detail.</td></tr>
						<tr><td>Should you have any questions, please feel free to contact HR Training.</td></tr>
						<tr><td>' + @HRTRLink + N'</td></tr>
						<tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
						<tr><td>This is automated email notification. Please do not reply. Thank you.</td></tr></table>'
		EXEC [msdb].[dbo].[sp_send_dbmail]
		--@recipients=N'nhien_nguyen3@jabil.com;',
		@recipients = @recipientslist,
		--@blind_copy_recipients = @Emailblind_copy_recipients,
		@body = @EmailBody,
		@body_format = 'HTML',
		@sensitivity = 'Normal', 
		@importance = 'High', 
		@subject =@EmailSubject,
		@query = @EmailQuery,
		@attach_query_result_as_file = 1,
		@query_result_separator = '			',
		@query_result_width = 4000,
		@query_attachment_filename = 'TrainingRecords.csv',
		@from_address = @Emailfrom_address,
		@reply_to = @Emailreply_to--,
		--@profile_name ='HCMEmailSystem'
		;
		
	END
END