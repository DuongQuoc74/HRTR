CREATE PROC [dbo].[SY_MDItem_Save] 
(
	@MDItemID				int, 
	@MDTypeID				int, 
	@MDItemCode				varchar(50), 
	@Description			nvarchar(255), 
	@IsActive				bit,
	@LastUpdatedBy			int
)
AS
BEGIN
	IF EXISTS (SELECT	1
				FROM	[dbo].[SY_MDItem]  WITH (NOLOCK)
				WHERE	[MDItemID]=@MDItemID)
	BEGIN
		--update existing record
		UPDATE	[dbo].[SY_MDItem] 
		SET		[MDTypeID]=@MDTypeID, 
				[MDItemCode]=@MDItemCode, 
				[Description]=@Description, 
				[IsActive]=@IsActive,
				[LastUpdated]=GETDATE(),
				[LastUpdatedBy]=@LastUpdatedBy
		WHERE	[MDItemID]=@MDItemID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SY_MDItem] ([MDTypeID], [MDItemCode], [Description], [IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@MDTypeID, @MDItemCode, @Description, @IsActive, GETDATE(), @LastUpdatedBy)
		SET @MDItemID=SCOPE_IDENTITY()
	END

	EXEC [dbo].[SY_MDItem_Select] @MDItemID
END

