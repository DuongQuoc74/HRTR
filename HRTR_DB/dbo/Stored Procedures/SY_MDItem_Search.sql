CREATE PROC [dbo].[SY_MDItem_Search] 
(
	@MDTypeID		int, 
	@MDItemCode		varchar(100), 
	@Description	nvarchar(255), 
	@IsActive		int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				
				
	SET @Query = N'SELECT A.[MDItemID]
		  ,A.[MDTypeID]
		  ,A.[MDItemCode]
		  ,A.[Description]
		  ,A.[IsActive]
		  ,B.[MDTypeName]
		  ,A.[LastUpdated]
		  ,A.[LastUpdatedBy]
	FROM	[dbo].[SY_MDItem] A WITH (NOLOCK)
			INNER JOIN [dbo].[SY_MDType] B WITH (NOLOCK) ON A.[MDTypeID] = B.[MDTypeID]
	WHERE	A.[MDTypeID]=@MDTypeID'
	IF @MDItemCode != ''
		SET @Query = @Query + N' AND A.[MDItemCode] LIKE ''%'' + @MDItemCode + ''%'''
	IF @Description != ''
		SET @Query = @Query + N' AND A.[Description] LIKE ''%'' + @Description + ''%'''
	IF @IsActive != -1	
		SET @Query = @Query + + N' AND A.[IsActive] = @IsActive'	
		
	SET @ParmDef = '@MDTypeID		int, 
					@MDItemCode		varchar(100), 
					@Description	varchar(255), 
					@IsActive		int'
	EXEC sp_executesql @Query, @ParmDef
								, @MDTypeID
								, @MDItemCode
								, @Description
								, @IsActive
								
END

