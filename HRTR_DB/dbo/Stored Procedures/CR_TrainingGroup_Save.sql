CREATE PROC [dbo].[CR_TrainingGroup_Save] 
(
	@TrainingGroupID int, 
	@TrainingGroupName varchar(50), 
	@IsActive bit,
	@LastUpdatedBy	int
)
AS
BEGIN
	SET NOCOUNT ON
	SET @TrainingGroupName = LTRIM(RTRIM(@TrainingGroupName))
	IF EXISTS (SELECT 1
	FROM [dbo].[CR_TrainingGroup]  WITH (NOLOCK)
	WHERE [TrainingGroupID]=@TrainingGroupID)
	BEGIN
		--update existing record
		UPDATE [dbo].[CR_TrainingGroup] 
		SET [TrainingGroupName]=@TrainingGroupName,
			[IsActive]=@IsActive,
			[LastUpdated]=GETDATE(),
			[LastUpdatedBy]=@LastUpdatedBy
		WHERE [TrainingGroupID]=@TrainingGroupID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_TrainingGroup] ([TrainingGroupName], [IsActive], [LastUpdated], [LastUpdatedBy])
		VALUES (@TrainingGroupName, @IsActive, GETDATE(), @LastUpdatedBy)
		SET @TrainingGroupID=SCOPE_IDENTITY()
	END
	EXECUTE[dbo].[CR_TrainingGroup_Select] @TrainingGroupID

END

