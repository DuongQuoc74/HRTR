-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetTrainingRecord_Experience_20170209]
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
			, @Found					bit = 1

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
	IF @ExpMonths <= 0
		SET @ExpMonths = 1
	SET @R = 'EXP: ' + CONVERT(NVARCHAR(20), @ExpMonths) + N' MTH(S)'
	SET @R = ''
	--PRINT @R
	RETURN ISNULL(@R, '')

END
