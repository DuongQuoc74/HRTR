CREATE PROC [dbo].[GC_Data_NotificationEmail] 
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@EscapedDateFrom		datetime
				, @EscapedDateTo		datetime
				, @EmailBody			nvarchar(max)
				, @EmailSubject			nvarchar(100)
				
				, @Emailfrom_address	varchar(max)
				, @Emailreply_to		varchar(max)
				--, @EmailDefaultMail		varchar(max)
				, @recipientslist					nvarchar(max)
				--, @Emailblind_copy_recipients		varchar(max)
				, @eGrapeChartGC_SummaryLink		nvarchar(255)
				, @FromDateE1						nvarchar(100)
				, @ToDateE1							nvarchar(100)
				, @CurrentDate						datetime
				, @CurrentDateS						nvarchar(11)
				--, @FromDate				datetime
				--, @ToDate				datetime
				--, @IsSent				bit
				--, @EscalationTime		nvarchar(10)
	SET @CurrentDate = CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 120), 120)
	SET @EscapedDateFrom = [dbo].[ufn_GetStartDate_By_WeekNo_Year](DATEPART(YEAR, @CurrentDate), DATEPART(WW, @CurrentDate))
	SET @EscapedDateFrom = CONVERT(VARCHAR(10), @EscapedDateFrom , 120)  + ' 06:00:00.000' 
	SET @EscapedDateFrom = DATEADD(DAY, -3, @EscapedDateFrom) -- Count from Friday
	SET @EscapedDateTo = DATEADD(DAY, 7, @EscapedDateFrom)
	--PRINT @EscapedDateFrom
	--PRINT @EscapedDateTo
	SET @FromDateE1 = REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(11), @EscapedDateFrom, 120), ' ', ''), ':', ''), '-', '') 
	SET @ToDateE1 = REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(11), @EscapedDateTo, 120), ' ', ''), ':', ''), '-', '') 
	SET @CurrentDateS = CONVERT(NVARCHAR(11), @EscapedDateTo, 106) -- dd MMM yyyy
	--SET @FromDate = @CurrentDate
	--SET @ToDate = DATEADD(DAY, 1, @FromDate)
	--SET @IsSent = 0
	--SET @EscalationTime = ''
	SELECT ROW_NUMBER() OVER (ORDER BY A.[Customer], A.[TotalDefect] DESC) AS [No.]
		, A.[Customer]
		, A.[EmployeeID]
		, A.[EmployeeName]
		, A.[TotalDefect]
	INTO #tmpGC_Data
	FROM (	SELECT	CS.[Customer]
				,B.[EmployeeID]
				,B.[EmployeeName]
				,COUNT(DISTINCT A.[SerialNumber]) AS [TotalDefect]
			FROM	[dbo].[GC_Data] A WITH (NOLOCK)	INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EscapedByEmployeeID_ID] = B.[EmployeeID_ID]
													INNER JOIN [dbo].[GC_Customers] CS WITH (NOLOCK) ON CS.[Customer_ID] = A.[Customer_ID]
			WHERE 	A.[EscapedDate] BETWEEN @EscapedDateFrom AND @EscapedDateTo
					AND A.[EscapedByEmployeeID_ID] > 0
					
					--AND A.[Customer_ID] <> 10 -- Temporay removed GE
					
			GROUP BY CS.[Customer]
				,A.[EscapedByEmployeeID_ID]
				,B.[EmployeeID]
				,B.[EmployeeName]
			HAVING COUNT(DISTINCT A.[SerialNumber]) >= 3
		) A
	ORDER BY A.[Customer], A.[TotalDefect] DESC
	
	IF EXISTS (SELECT 1
				FROM #tmpGC_Data WITH (NOLOCK)
				)
	BEGIN
		SELECT TOP 1 @eGrapeChartGC_SummaryLink = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartGC_SummaryLink'
		
		SET @EmailSubject = N'e Grape Chart - '  + CONVERT(NVARCHAR(24), @EscapedDateFrom, 113) 
							+ N' - ' + CONVERT(NVARCHAR(24), @EscapedDateTo, 113) 
							+ N' - Ho Chi Minh Site'
		SET @EmailBody = N'<p>Dear All,<br><br>' + 
		N'Listed below are e Grape Chart (Escapees) summary from ' 
		+ CONVERT(NVARCHAR(24), @EscapedDateFrom, 113)
		+ N' to ' + CONVERT(NVARCHAR(24), @EscapedDateTo, 113) + N'.<br>'
		
		SET @EmailBody = @EmailBody +	N'<table cellspacing="1" cellpadding="2" style="color:#333333;border-collapse: collapse; width: 600px;font-size: 0.9em;" border="2">' +
										N'<tr><th>No.</th><th>Workcell</th><th>Employee ID</th><th>Employee Name</th><th>Total Defects</th></tr>'
		SET @EmailBody = @EmailBody +	CAST ( ( SELECT td = CONVERT(NVARCHAR, [No.]), ''
														  ,td = [Customer], ''
														  ,td = [EmployeeID], ''
														  ,td = [EmployeeName], ''
														  ,td = CONVERT(NVARCHAR, [TotalDefect])
												FROM	#tmpGC_Data WITH (NOLOCK)
												ORDER BY [No.]
														  FOR XML PATH('tr'), TYPE 
												) AS NVARCHAR(MAX))
		SET @EmailBody = @EmailBody + N'</table><br>'
		SET @EmailBody = @EmailBody + 
		+ N'For further details, please follow <a href="' + @eGrapeChartGC_SummaryLink 
		+ N'?frm=' + @FromDateE1
		+ N'&to=' + @ToDateE1
		+ N'">link</a>.<br>'
		SET @EmailBody = @EmailBody + 
		N'<br>'
		SET @EmailBody = @EmailBody + 
		N'<i>Notes: If you dont want to receive this email anymore, please contact Training team to unsubscribe. This is automated email notification. Please do not reply. Thank you.</i></p>'
		
	
		SELECT TOP 1 @Emailfrom_address = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartfrom_address'
		
		SELECT TOP 1 @Emailreply_to = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartreply_to'
		
		SELECT  @recipientslist = COALESCE(@recipientslist + ';', '')
										+	 A.[Email]
										
		FROM (SELECT DISTINCT A.[Email]
		FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK) 
					INNER JOIN [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK) ON A.[UserProfileID] = B.[UserProfileID]
		WHERE	(B.[PermissionRoleID] IN (1, 2, 3) OR A.[DepartmentID] = 12) -- Trainer + Trainer Leader + Line Manager, QE (Dept)
				AND A.[IsActive] = 1
				AND B.[IsActive] = 1
				AND [dbo].[ufn_IsValidEmail] (A.[Email]) = 1
				) A
				
		SET @recipientslist = ISNULL(@recipientslist, '')
		IF @recipientslist = ''
		BEGIN
			SELECT TOP 1 @recipientslist = [ConfigurationValue]
			FROM [dbo].[SY_Configuration] WITH (NOLOCK)
			WHERE [ConfigurationName] = 'HRTRDefaultMail'
		END
	
		--SELECT TOP 1 @Emailblind_copy_recipients = [ConfigurationValue]
		--FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		--WHERE [ConfigurationName] = 'HRTRblind_copy_recipients'
		
		EXEC [msdb].[dbo].[sp_send_dbmail]
		@recipients = @recipientslist,
		--@recipients = 'Nguyen Thuy An Nhien <nhien_nguyen3@jabil.com>',
		--@copy_recipients='Nguyen Thuy An Nhien <nhien_nguyen3@jabil.com>',
		--@blind_copy_recipients = @Emailblind_copy_recipients,
		@body = @EmailBody,
		@body_format = 'HTML',
		@sensitivity = 'Normal', 
		@importance = 'High', 
		@subject = @EmailSubject,
		@from_address = @Emailfrom_address,
		@reply_to = @Emailreply_to--,
		--@profile_name ='HCMEmailSystem'
		;
	END
	
	DROP TABLE #tmpGC_Data
END