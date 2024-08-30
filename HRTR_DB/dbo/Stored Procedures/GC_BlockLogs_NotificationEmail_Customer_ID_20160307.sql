CREATE PROC [dbo].[GC_BlockLogs_NotificationEmail_Customer_ID_20160307] 
(
	@Customer_ID			int
	, @NotificationTime		int -- 1st, 2nd, 3rd
)
AS
BEGIN
	SET NOCOUNT ON
	 --From 1 to end of each month
	DECLARE		--@EscapedDateFrom		datetime
				--, @EscapedDateTo		datetime
				--, 
				@EmailBody			nvarchar(max)
				, @EmailSubject			nvarchar(100)
				
				, @Emailfrom_address				varchar(max)
				, @Emailreply_to					varchar(max)
				, @recipientslist					nvarchar(max)
				, @Emailblind_copy_recipients		varchar(max)
				, @Emailcopy_recipients				varchar(max)
				, @Customer							nvarchar(50)
				, @eGrapeChartGC_BlockLogsLink			nvarchar(255)
				, @CurrentDate						datetime
				, @EscalationTimeText				nvarchar(10)
				, @Aging							int
				, @StartDate						datetime
				, @EndDate							datetime
				
	IF @NotificationTime = 1
		SET @Aging = 0
	ELSE IF @NotificationTime = 2
		SET @Aging = 1
	ELSE 
		SET @Aging = 2	
	
	SET @CurrentDate = GETDATE()
	SET @CurrentDate = CONVERT(DATETIME, CONVERT(VARCHAR(10), @CurrentDate, 120), 120)
	
	--- Validate CreatedDate of GC_BlockLogs records
	SET @EndDate = CONVERT(VARCHAR(10), @CurrentDate , 120)  + ' 00:00:00.000' 
	SET @EndDate = DATEADD(DAY, -@Aging, @EndDate)
	SET @StartDate = DATEADD(DAY, -1, @EndDate)
	IF @NotificationTime = 1 -- 1st, calculate until sending email time
		SET @EndDate = GETDATE()
	--PRINT 'A'
	--PRINT @Aging
	--PRINT @StartDate
	--PRINT @EndDate
	--PRINT 'B'
	--RETURN
	-- Period, example: 01.Oct to 31.Oct
	--SET @EscapedDateFrom = [dbo].[ufn_FromDate](MONTH(DATEADD(DAY, -5, @CurrentDate)), YEAR(@CurrentDate))
	--SET @EscapedDateFrom = CONVERT(VARCHAR(10), @EscapedDateFrom , 120)  + ' 00:00:00.000' 
	--SET @EscapedDateTo = DATEADD(DAY, -1, DATEADD(MONTH, 1, @EscapedDateFrom)) + ' 23:59:59.998' 
	
	SELECT ROW_NUMBER() OVER (ORDER BY A.[TotalRedGrapes] DESC, B.[EmployeeName]) AS [No.]
		, CS.[Customer]
		, B.[EmployeeID]
		, B.[EmployeeName]
		, A.[StartDate]
		, A.[EndDate]
		, A.[CreatedDate]
		, DATEDIFF(DAY, A.[CreatedDate], @CurrentDate) AS [Aging]
		, A.[TotalRedGrapes]
	INTO #tmpGC_Data
	FROM [dbo].[GC_BlockLogs] A WITH (NOLOCK)
			INNER JOIN [dbo].[HR_Employee] B WITH (NOLOCK) ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
			INNER JOIN [dbo].[GC_Customers] CS WITH (NOLOCK) ON CS.[Customer_ID] = A.[Customer_ID]
	WHERE A.[CreatedDate] BETWEEN @StartDate AND @EndDate
			AND A.[Customer_ID] = @Customer_ID
			AND A.[IsConfirmed] = 0
			AND B.[IsActive] = 1
	ORDER BY A.[TotalRedGrapes] DESC
			, B.[EmployeeName]
			
	--SELECT *
	--FROM #tmpGC_Data
	--DROP TABLE #tmpGC_Data
	--RETURN
	
	IF EXISTS (SELECT 1
				FROM #tmpGC_Data WITH (NOLOCK)
				)
	BEGIN
		-- PRINT
		
		SET @EscalationTimeText = [dbo].[ufn_ConvertNumberToString](@NotificationTime)
		
		SELECT TOP 1 @eGrapeChartGC_BlockLogsLink = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartGC_BlockLogsLink'
		SET @eGrapeChartGC_BlockLogsLink = ISNULL(@eGrapeChartGC_BlockLogsLink, '')
				+ N'?cf=0&cs=' + CONVERT(NVARCHAR(5), @Customer_ID) 
				+ N'&f=' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(10), @StartDate, 120), ' ', ''), ':', ''), '-', '') 
				+ N'&t=' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(10), @EndDate, 120), ' ', ''), ':', ''), '-', '') 
		
		SELECT TOP 1 @Customer = [Customer]
		FROM [dbo].[GC_Customers] WITH (NOLOCK)
		WHERE [Customer_ID] = @Customer_ID
		
		SET @EmailSubject = N'e Grape Chart - '  + CONVERT(NVARCHAR(11), @CurrentDate, 106) 
							+ N' - ' + @Customer
							+ N' - ' + @EscalationTimeText + N' Notification - Ho Chi Minh Site'
							
		SET @EmailBody = N'<p><div style="color: blue;">Chào Các bạn,</div>Dear All,<br><br>' + 
		N'<div style="color: blue;">Dưới đây là danh sách e Grape Chart (Thoát lỗi) vượt quá 3 trái nho đỏ đến ' 
		+ LOWER([dbo].[ufn_FormatDateVN](@CurrentDate)) + N' chưa hoàn thành ôn tập lại kiến thức kiểm lỗi.</div>'
		+ N'Listed below are e Grape Chart (Escapees) over 3 red grapes summary until ' 
		+ CONVERT(NVARCHAR(11), @CurrentDate, 106) + N' has not been refreshed.<br><br>'
		+ N'<div style="color: blue;">Xin vui lòng liên hệ với Line Trainers & Trainers để ôn tập lại kiến thức kiểm lỗi cho nhân viên đó trước thời hạn hết hạn.</div>'
		+ N'Kindly contact with Line Trainers & Trainers to conduct refresher course for these employees before overdue.<br>'
		
		SET @EmailBody = @EmailBody +	N'<table cellspacing="1" cellpadding="2" style="color:#333333;border-collapse: collapse; width: 900px;font-size: 0.9em;" border="2">' +
										N'<tr><th>No.</th><th>Workcell</th><th>Employee ID</th><th>Employee Name</th><th>Created Date</th><th>Aging</th><th>Start Date</th><th>End Date</th><th>Total Red Grapes</th></tr>'
		SET @EmailBody = @EmailBody +	CAST ( ( SELECT td = CONVERT(NVARCHAR, [No.]), ''
														  ,td = [Customer], ''
														  ,td = [EmployeeID], ''
														  ,td = [EmployeeName], ''
														  ,td = CONVERT(NVARCHAR(11), [CreatedDate], 106), ''
														  ,td = CONVERT(NVARCHAR(11), [Aging]) + ' day(s)', ''
														  ,td = CONVERT(NVARCHAR(11), [StartDate], 106), ''
														  ,td = CONVERT(NVARCHAR(11), [EndDate], 106), ''
														  ,td = CONVERT(NVARCHAR, [TotalRedGrapes])
												FROM	#tmpGC_Data WITH (NOLOCK)
												ORDER BY [No.]
														  FOR XML PATH('tr'), TYPE 
												) AS NVARCHAR(MAX))
		SET @EmailBody = @EmailBody + N'</table><br>'
		SET @EmailBody = @EmailBody + 
		+ N'<div style="color: blue;">Để biết thêm chi tiết, xin vui lòng mở <a href="' + @eGrapeChartGC_BlockLogsLink 
		+ N'?nt=' + CONVERT(NVARCHAR(10), @NotificationTime)
		+ N'">liên kết</a>.</div>'
		+ N'For further details, please follow <a href="' + @eGrapeChartGC_BlockLogsLink 
		+ N'?nt=' + CONVERT(NVARCHAR(10), @NotificationTime)
		+ N'">link</a>.<br>'
		SET @EmailBody = @EmailBody + 
		N'<br>'
		SET @EmailBody = @EmailBody + 
		N'<div style="color: blue;"><strong><i>Chú ý:</i></strong><br>' 
		+ N'* Nhắc nhở lần 1 trong thời gian: 1 ngày.<br>'
		+ N'* Báo cáo vượt cấp lần 1 trong thời gian: 1 ngày nếu bạn không hoàn thành khóa học ôn tập kiến thức kiểm từ email nhắc nhở lần 1.<br>'
		+ N'* Báo cáo vượt cấp lần 2 trong thời gian: 2 ngày nếu bạn không hoàn thành khóa học ôn tập kiến thức kiểm từ email nhắc nhở lần 1 và khóa tên đăng nhập (MES, CCS, ...).</div>'
		+ N'<strong><i>Notes:</i></strong><br>' 
		+ N'* 1st notification duration: 1 day.<br>'
		+ N'* 1st escalation duration: 1 day if refresh training not complete within 1 day from 1st notification.<br>'
		+ N'* 2nd escalation duration: 1 day if refresh training not complete within 2 day from 1st notification and block user.<br><br>'
		SET @EmailBody = @EmailBody + 
		N'<div style="color: blue;"><i>Nếu bạn không muốn nhận email này nữa, xin vui lòng liên hệ với bộ phận Đào tạo để hủy đăng kí. Đây là email nhắc nhở tự động. Xin vui lòng không trả lời trực tiếp. Cám ơn.</i></div>'
		+ N'<i>If you dont want to receive this email anymore, please contact Training team to unsubscribe. This is automated email notification. Please do not reply. Thank you.</i></p>'
		
	
		SELECT TOP 1 @Emailfrom_address = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartfrom_address'
		
		SELECT TOP 1 @Emailreply_to = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartreply_to'
		
		--SELECT  @recipientslist = COALESCE(@recipientslist + ';', '')
		--								+	 A.[Email]
		--FROM	[dbo].[SC_UserProfile] A WITH (NOLOCK) 
		--			INNER JOIN [dbo].[SC_UserProfilePermissionRole] B WITH (NOLOCK) ON A.[UserProfileID] = B.[UserProfileID]
		--WHERE	B.[PermissionRoleID] IN (1, 3, 7)-- Trainer, Mfg + WCM
		--		AND A.[IsActive] = 1
		--		AND B.[IsActive] = 1
		--		AND [dbo].[ufn_IsValidEmail](A.[Email]) = 1
		
		IF @NotificationTime = 1 -- Trainer
		BEGIN
			SET @recipientslist = [dbo].[ufn_GetEmailList_Trainer] ()
								+ N';' + [dbo].[ufn_GetEmailList_LineTrainer](@Customer_ID)
		END
		ELSE IF @NotificationTime = 2 -- Trainer + Line Sup + Line Manager
		BEGIN
			SET @recipientslist = [dbo].[ufn_GetEmailList_Trainer] ()
								+ N';' + [dbo].[ufn_GetEmailList_LineTrainer](@Customer_ID)
								+ N';' + [dbo].[ufn_GetEmailList_LineSupervisor](@Customer_ID)
		END
		ELSE IF @NotificationTime = 3 -- Trainer + Line Sup + Line Manager + WC QE
		BEGIN
			SET @recipientslist = [dbo].[ufn_GetEmailList_Trainer] ()
								+ N';' + [dbo].[ufn_GetEmailList_LineTrainer](@Customer_ID)
								+ N';' + [dbo].[ufn_GetEmailList_LineSupervisor](@Customer_ID)
								+ N';' + [dbo].[ufn_GetEmailList_WCQE](@Customer_ID)
		END
				
		SET @recipientslist = ISNULL(@recipientslist, '')
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
		--RETURN
		SELECT TOP 1 @Emailcopy_recipients = [ConfigurationValue]
		FROM [dbo].[SY_Configuration] WITH (NOLOCK)
		WHERE [ConfigurationName] = 'eGrapeChartcopy_recipients'
		--PRINT @recipientslist
		--RETURN
		
		
		EXEC [msdb].[dbo].[sp_send_dbmail]
		@recipients = @recipientslist,
		--@recipients = 'Hung Le1 <hung_le1@jabil.com>;Le Thiphuonghai <le_thiphuonghai@jabil.com>',
		--@recipients = 'Nguyen Thuy An Nhien <nhien_nguyen3@jabil.com>',
		@copy_recipients = @Emailcopy_recipients,
		@blind_copy_recipients = @Emailblind_copy_recipients,
		@body = @EmailBody,
		@body_format = 'HTML',
		@sensitivity = 'Normal', 
		@importance = 'High', 
		@subject = @EmailSubject,
		@from_address = @Emailfrom_address,
		@reply_to = @Emailreply_to--,
		--@profile_name = 'HCMEmailSystem'
		;
	END
	
	DROP TABLE #tmpGC_Data
END

