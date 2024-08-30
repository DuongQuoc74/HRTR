CREATE PROC [dbo].[GC_Customers_Search_By_ProfileId] 
(
	@UserProfileID int
)
AS
BEGIN
	SELECT A.[Customer_ID]
	  ,[Customer]
	  ,[MESCustomer_ID]
	FROM [dbo].[GC_Customers] A WITH (NOLOCK)  INNER JOIN  [dbo].[SC_UserProfileCustomers] B WITH (NOLOCK) 
	ON A.[Customer_ID] = B.[Customer_ID]
	WHERE B.[UserProfileID] = @UserProfileID
			AND B.[IsActive] = 1
END