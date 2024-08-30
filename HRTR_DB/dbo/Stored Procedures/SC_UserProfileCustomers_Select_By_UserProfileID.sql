CREATE PROC [dbo].[SC_UserProfileCustomers_Select_By_UserProfileID] 
(
	@UserProfileID int
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [UserProfileID]
		  ,[Customer_ID] 
	FROM	 [dbo].[SC_UserProfileCustomers]  WITH (NOLOCK)
	WHERE	[UserProfileID] = @UserProfileID
			AND [IsActive] = 1
			
END

