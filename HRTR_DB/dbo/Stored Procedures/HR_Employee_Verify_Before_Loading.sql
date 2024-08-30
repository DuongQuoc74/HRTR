-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[HR_Employee_Verify_Before_Loading]
(
	@LastUpdatedBy	int = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE
	FROM	[dbo].[HR_EmployeeTemp]
   
END


