CREATE PROC [dbo].[HR_Employee_Select_By_EmployeeID] 
(
	@EmployeeID varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @EmployeeID_ID int
	SELECT TOP 1 @EmployeeID_ID = [EmployeeID_ID]
	FROM [dbo].[HR_Employee] WITH (NOLOCK)
	WHERE [EmployeeID] = @EmployeeID AND @EmployeeID != ''
	
	EXEC [dbo].[HR_Employee_Select] @EmployeeID_ID

END


