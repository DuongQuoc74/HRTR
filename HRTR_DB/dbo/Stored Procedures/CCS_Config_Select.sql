CREATE PROC [dbo].[CCS_Config_Select]

AS
BEGIN
	SET NOCOUNT ON
	SELECT [ConfigID]
      ,[ConfigName]
      ,[ConfigValue]
	FROM [dbo].[CCS_Config] WITH (NOLOCK)
	ORDER BY [ConfigID]
END


