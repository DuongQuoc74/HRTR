CREATE PROC [dbo].[GC_BlockLogs_Process_Customer_ID] 
(
	@Customer_ID		int,
	@Month				int, 
	@Year				int,
	@LastUpdatedBy		int = -1
)
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @StartDate			datetime
			, @EndDate			datetime
			, @EmployeeID_ID	int	
			, @EmployeeID_IDO	int	
	--		, @CurrentDate		datetime
	--SET @CurrentDate = DATEADD(DAY, -5, GETDATE())
	--IF @Month IS NULL 
	--BEGIN
	--	SET @Month = MONTH(@CurrentDate)
	--END
	--IF @Year IS NULL 
	--BEGIN
	--	SET @Year = YEAR(@CurrentDate)
	--END
	-- Get @StartDate and @EndDate
	SET @StartDate = [dbo].[ufn_FromDate](@Month, @Year) -- From 01.Month.Year
	SET @StartDate = CONVERT(VARCHAR(10), @StartDate , 120) + ' 00:00:00.000' 
	SET @EndDate = DATEADD(DAY, -1, DATEADD(MONTH, 1, @StartDate)) + ' 23:59:59.998' 
	--SET @EndDate = GETDATE()
	
	SELECT TOP 1 @EmployeeID_ID = A.[EmployeeID_ID]
	FROM [dbo].[HR_Employee] A WITH (NOLOCK)
	WHERE A.[EmployeeID_ID] > 0
			AND A.[IsActive] = 1
	ORDER BY A.[EmployeeID_ID]
	SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, 0)
	WHILE @EmployeeID_ID <> 0
	BEGIN	
		-- Do s.t
		--PRINT @EmployeeID_ID
		-- Process for 1 employee
		EXECUTE [dbo].[GC_BlockLogs_Process_Employee_ID] 
				   @EmployeeID_ID
				  ,@StartDate
				  ,@Customer_ID
				  ,@EndDate
				  ,@LastUpdatedBy

		-- Next employee
		SET @EmployeeID_IDO = @EmployeeID_ID
		SET @EmployeeID_ID = 0
		SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
		FROM [dbo].[HR_Employee] A WITH (NOLOCK)
		WHERE [EmployeeID_ID] > @EmployeeID_IDO
				AND A.[IsActive] = 1
		ORDER BY A.[EmployeeID_ID]
		SET @EmployeeID_ID = ISNULL(@EmployeeID_ID, 0)
	END
	
END

