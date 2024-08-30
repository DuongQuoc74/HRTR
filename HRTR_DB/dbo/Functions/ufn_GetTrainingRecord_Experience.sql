-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetTrainingRecord_Experience]
(
	@EmployeeID_ID	int
	, @CourseID		int
	, @ResetMonths	int -- number of month need to reset the Experience
)
RETURNS NVARCHAR(50)
AS
BEGIN

	DECLARE @R					NVARCHAR(50) = ''
			--, @TrainingRecordID			int = 0
			--, @TrainingRecordIDNext		int = 0
			, @CertDate					date
			, @ExpDate					date
			, @CertDatePre				date
			, @ExpDatePre				date
			, @ExpMonths				int = 0
			, @ExpDays					int = 0
			, @Found					bit = 1
			, @WorkcellID						int

    SELECT @WorkcellID = ISNULL([WorkcellID], -1) 
	FROM [dbo].[HR_Employee] WITH (NOLOCK)
	WHERE [EmployeeID_ID] = @EmployeeID_ID

	-- Applied all except SG&A(6), SUPPORT(10), SURPLUS(11), PIONEER(18)
	IF @WorkcellID IN (6, 10, 11, 18)
	BEGIN
		SET @R = ''
		RETURN @R
	END

	SELECT TOP 1 @CertDate = [CertDate]
			, @ExpDate = [ExpDate]
	FROM [dbo].[TrainingRecord_V] WITH (NOLOCK)
	WHERE [EmployeeID_ID] = @EmployeeID_ID
		AND [CourseID] = @CourseID
		AND [IsActive] = 1 -- Valid record
	ORDER BY [CertDate] DESC
	IF @CertDate IS NULL -- No Cert
	BEGIN
		SET @R = ''
		RETURN @R
	END
	IF @ExpDate IS NULL -- No Expired
	BEGIN
		-- 1st record
		SELECT TOP 1 @CertDate = [CertDate]
		FROM [dbo].[TrainingRecord_V] WITH (NOLOCK)
		WHERE [EmployeeID_ID] = @EmployeeID_ID
			AND [CourseID] = @CourseID
			AND [IsActive] = 1 -- Valid record
		ORDER BY [CertDate]
	END
	ELSE
	BEGIN
		SELECT TOP 1 @CertDatePre = [CertDate]
				, @ExpDatePre = [ExpDate]
		FROM [dbo].[TrainingRecord_V] WITH (NOLOCK)
		WHERE [EmployeeID_ID] = @EmployeeID_ID
			AND [CourseID] = @CourseID
			AND [CertDate] < @CertDate
			AND [IsActive] = 1 -- Valid record
		ORDER BY [CertDate] DESC
	END

	IF @CertDatePre IS NULL
	BEGIN
		SET @ExpMonths = DATEDIFF(MONTH, @CertDate, GETDATE()) --+ 1
	END
	ELSE 
	BEGIN
		WHILE @Found = 1
		BEGIN
			IF DATEDIFF(MONTH, @ExpDatePre, @CertDate) <= @ExpMonths
			BEGIN
				SET @Found = 0
				SET @CertDate = @CertDatePre
				SELECT TOP 1 @CertDatePre = [CertDate]
						, @ExpDatePre = [ExpDate]
						, @Found = 1
				FROM [dbo].[TrainingRecord_V] WITH (NOLOCK)
				WHERE [EmployeeID_ID] = @EmployeeID_ID
					AND [CourseID] = @CourseID
					AND [CertDate] < @CertDate
					AND [IsActive] = 1 -- Valid record
				ORDER BY [CertDate] DESC
				IF @Found = 0
				BEGIN
					BREAK;
				END
			END
			ELSE
			BEGIN
				BREAK;
			END
			--PRINT 'A'
		END
		SET @ExpMonths = DATEDIFF(MONTH, @CertDate, GETDATE()) --+ 1
	END
	
	IF DATEDIFF(DAY, @CertDate, GETDATE()) <= 0
	BEGIN
		SET @R = 'EXP: 0M 0D'
		RETURN @R
	END
	
	SET @ExpDays = DATEPART(DAY, GETDATE()) - DATEPART(DAY, @CertDate)
	
	IF @ExpDays < 0
	BEGIN
		SET @ExpMonths = @ExpMonths - 1
		SET @ExpDays = DATEDIFF(DAY, DATEADD(MONTH, @ExpMonths, @CertDate), GETDATE())
	END

	SET @R = 'EXP: ' + CONVERT(NVARCHAR(20), @ExpMonths) + 'M ' + CONVERT(NVARCHAR(20), @ExpDays) + 'D'
	
	--PRINT @R
	RETURN ISNULL(@R, '')

END
