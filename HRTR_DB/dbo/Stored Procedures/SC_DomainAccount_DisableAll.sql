CREATE PROC [dbo].[SC_DomainAccount_DisableAll] 
AS
BEGIN
	SET NOCOUNT ON
	UPDATE [dbo].[SC_DomainAccount]
	SET		[AccountIsDisabled] = 'TRUE'
			,[PasswordStatus] = ''
			  ,[LastUpdated] = GETDATE()
			  ,[LastUpdatedBy] = -1
END

