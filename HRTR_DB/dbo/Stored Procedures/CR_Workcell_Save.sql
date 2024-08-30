CREATE PROC [dbo].[CR_Workcell_Save] 
(
	@WorkcellID				int
	, @WorkcellCode			varchar(10)
	, @WorkcellName			varchar(50)
	, @LastUpdatedBy		int = -1	
)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS (SELECT 1 
				FROM [dbo].[CR_Workcell] WITH (NOLOCK) 
				WHERE [WorkcellID]=@WorkcellID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_Workcell] 
		SET [WorkcellCode]=@WorkcellCode
			,[WorkcellName]=@WorkcellName,
			[LastUpdated]=GETDATE(),
			[LastUpdatedBy]=@LastUpdatedBy
		WHERE [WorkcellID]=@WorkcellID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_Workcell] ([WorkcellCode], [WorkcellName] 
		  ,[MESCustomer_ID]
		  ,[IsAppliedCCS]
		  ,[IsActive]
		  ,[LastUpdated], [LastUpdatedBy])
		VALUES (@WorkcellCode, @WorkcellName
		, 0
		, 1
		, 1
		, GETDATE(), @LastUpdatedBy)
		SET @WorkcellID=SCOPE_IDENTITY()
	END
	EXEC [dbo].[CR_Workcell_Select] @WorkcellID
	
END

