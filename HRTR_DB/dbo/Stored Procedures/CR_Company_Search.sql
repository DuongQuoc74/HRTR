CREATE PROC [dbo].[CR_Company_Search]
AS
BEGIN
	SELECT [CompanyID]
		  ,[CompanyName] 
	FROM [dbo].[CR_Company] WITH (NOLOCK)
END


