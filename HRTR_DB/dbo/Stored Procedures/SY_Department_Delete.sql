CREATE PROC [dbo].[SY_Department_Delete] @DepartmentID int,
	@LastUpdatedBy	int = 0	
AS
DELETE FROM [dbo].[SY_Department] WHERE [DepartmentID]=@DepartmentID

