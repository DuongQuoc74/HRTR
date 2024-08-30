CREATE PROC [dbo].[CCS_HR_Employee_Select_IsSupervisor]
(
	@UserName varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	IF  EXISTS (SELECT 1
				FROM [dbo].[HR_Employee] WITH (NOLOCK)
				WHERE [UserName] = @UserName
					AND [IsSupervisor] = 1)
	BEGIN
		SELECT 1
		RETURN 
	END
	ELSE 
	BEGIN 
		SELECT 0
		RETURN 
	END 
END

