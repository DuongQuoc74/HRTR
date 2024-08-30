CREATE PROC [dbo].[SC_Logon_Select] 
(
	@LogonID int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [LogonID]
      ,[AuthenticationTypeID]
      ,[AuthenticationName]
      ,[EmployeeID_ID]
      ,[UserProfileID]
      ,[PCName]
	  ,[IPAddress]
      ,[ApplicationID]
      ,[SystemKindID]
	  ,[PageName]
      ,[LastUpdated]
      ,[LastUpdatedBy]
  FROM [dbo].[SC_Logon] WITH (NOLOCK)
  WHERE [LogonID] = @LogonID
END


