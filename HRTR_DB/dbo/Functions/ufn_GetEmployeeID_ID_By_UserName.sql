-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetEmployeeID_ID_By_UserName]
(
	@UserName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	TOP 1 @R = [EmployeeID_ID]
	FROM	[dbo].[HR_Employee] WITH (NOLOCK)
	WHERE	[UserName] = @UserName
			AND ISNULL([UserName], '') != ''
			
	RETURN ISNULL(@R, -1)

END
