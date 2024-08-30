CREATE PROC [dbo].[CR_TrainingGroup_Search]
(
	@IsActive int = -1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT A.[TrainingGroupID],A.[TrainingGroupName],A.[IsActive]
					      , B.[UserName] As [LastUpdatedByUserName]
					      , A.[LastUpdated]		
	               FROM [dbo].[CR_TrainingGroup] A WITH (NOLOCK) LEFT JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]'
	
	SET @Query2 = N''		        
	IF @IsActive != -1
		SET @Query2 = @Query2 + N' WHERE A.[IsActive] = @IsActive'
									
	SET @Query = @Query + @Query2 + N' ORDER BY A.[TrainingGroupName]'

	SET @ParmDef = '@IsActive	int'
					
	EXEC sp_executesql @Query, @ParmDef , @IsActive
END
