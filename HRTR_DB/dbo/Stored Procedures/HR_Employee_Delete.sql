CREATE PROC [dbo].[HR_Employee_Delete] 
(
	@EmployeeID_ID	int = 0,
	@LastUpdatedBy	int = -1	
)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (SELECT	1
				FROM	[dbo].[TrainingRecord] WITH (NOLOCK)
				WHERE	[EmployeeID_ID] = @EmployeeID_ID)
	BEGIN
		RAISERROR(N'This employee has training record(s), you can inactive only.', 16, 1)
		RETURN
	END
	ELSE IF EXISTS (SELECT	1
				FROM	[dbo].[GC_Data] WITH (NOLOCK)
				WHERE	[EscapedByEmployeeID_ID] = @EmployeeID_ID)
	BEGIN
		RAISERROR(N'This employee has e grape chart escapee(s), you can inactive only.', 16, 1)
		RETURN
	END
	ELSE IF EXISTS (SELECT	1
				FROM	[dbo].[GC_Data] WITH (NOLOCK)
				WHERE	[DetectedByEmployeeID_ID] = @EmployeeID_ID)
	BEGIN
		RAISERROR(N'This employee has e grape chart detection(s), you can inactive only.', 16, 1)
		RETURN
	END
	ELSE
	BEGIN
		DELETE 
		FROM [dbo].[HR_Employee] 
		WHERE [EmployeeID_ID]=@EmployeeID_ID
	END
END


