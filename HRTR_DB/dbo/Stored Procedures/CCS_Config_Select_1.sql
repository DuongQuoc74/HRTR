-- 2018-01-01: in used, do not remove
CREATE PROC [dbo].[CCS_Config_Select_1]
(
	@ConfigName		varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [ConfigID]
      ,[ConfigName]
      ,[ConfigValue]
	FROM [dbo].[CCS_Config] WITH (NOLOCK)
	WHERE [ConfigName] = @ConfigName
END



