CREATE PROC [dbo].[SY_MDType_Search]
(
	@IsActive		int = 1
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
	SET @Query = N'SELECT [MDTypeID]
		  ,[MDTypeName]
		  ,[IsActive]
		  ,[LastUpdated]
		  ,[LastUpdatedBy]
	FROM	[dbo].[SY_MDType]  WITH (NOLOCK)'
	IF @IsActive != -1
		SET @Query = @Query + N' WHERE [IsActive] = @IsActive'
	SET @ParmDef = '@IsActive			int'
					
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @IsActive
								
END

