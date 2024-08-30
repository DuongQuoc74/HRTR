CREATE PROC [dbo].[CR_CertifiedLevel_Search]
AS
BEGIN
	SET NOCOUNT ON
	SELECT [CertifiedLevelID]
		  ,[CertifiedLevelName] 
	FROM [dbo].[CR_CertifiedLevel] WITH (NOLOCK)
END


