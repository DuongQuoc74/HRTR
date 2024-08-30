CREATE PROC [dbo].[CR_Company_Select]
(
	@CompanyID	int
)
AS
BEGIN
	SELECT [CompanyID]
		  ,[CompanyName] 
	FROM [dbo].[CR_Company] WITH (NOLOCK)
	WHERE [CompanyID]=@CompanyID
END

