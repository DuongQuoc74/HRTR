CREATE PROC [dbo].[SY_MDType_Save] 
(
	@MDTypeID		int, 
	@MDTypeName		varchar(50), 
	@IsActive		bit,
	@LastUpdatedBy	int
)
AS
BEGIN
	IF EXISTS (SELECT 1 
				FROM	[dbo].[SY_MDType] WITH (NOLOCK) 
				WHERE	[MDTypeID]=@MDTypeID)
	BEGIN
		--update existing record
		UPDATE	[dbo].[SY_MDType] 
		SET		[MDTypeName]=@MDTypeName, 
				[IsActive]=@IsActive,
				[LastUpdated]=GETDATE(),
				[LastUpdatedBy]=@LastUpdatedBy
		WHERE	[MDTypeID]=@MDTypeID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[SY_MDType] ([MDTypeID], [MDTypeName], [IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@MDTypeID, @MDTypeName, @IsActive, GETDATE(), @LastUpdatedBy)
		
	END
	EXEC [dbo].[SY_MDType_Select] @MDTypeID

END

