-- 2018-01-01: Only IT MIM leaders can update
CREATE PROC [dbo].[CCS_Config_Save] 
(
	@ConfigName				varchar(50)
	, @ConfigValue			varchar(50)
	, @Comments				nvarchar(255)
	, @LastUpdatedBy		int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @UserName			varchar(50)
			, @ErrorMessage		nvarchar(255)
	SELECT TOP 1 @UserName = [UserName]
	FROM [dbo].[SC_UserProfile] WITH (NOLOCK)
	WHERE [UserProfileID] = @LastUpdatedBy
	IF @UserName NOT IN (SELECT [ConfigurationValue]
						FROM [dbo].[SY_Configuration] WITH (NOLOCK)
						WHERE [ConfigurationName] IN ('ITMIM1', 'ITMIM2', 'ITMIM3', 'ITMIM4'))
	BEGIN
		SET @ErrorMessage = N'Only IT MIM leaders has permission to update.'
		RAISERROR(@ErrorMessage, 16, 1)
		RETURN
	END
	IF EXISTS (SELECT	1
				FROM	[dbo].[CCS_Config] WITH (NOLOCK)
				WHERE	[ConfigName] = @ConfigName)
	BEGIN
		--update existing record
		UPDATE	[dbo].[CCS_Config] 
		SET		[ConfigValue] = @ConfigValue
				, [LastUpdated] = GETDATE()
				, [LastUpdatedBy] = @LastUpdatedBy
		WHERE	[ConfigName] = @ConfigName

		INSERT INTO [dbo].[CCS_ConfigLog]
           ([ConfigName]
           ,[ConfigValue]
           ,[Comments]
           ,[LastUpdatedBy]
           ,[LastUpdated])
		 VALUES
			   (@ConfigName
			   ,@ConfigValue
			   ,@Comments
			   ,@LastUpdatedBy
			   ,GETDATE())

	END
	EXEC [dbo].[CCS_Config_Select_1] @ConfigName
	
END

