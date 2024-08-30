CREATE PROC [dbo].[CR_Product_Search] 
(
	@ProductName				varchar(100) = ''
	, @TrainingGroupID			int = -1
	, @TrainingGroupIDList		nvarchar(1000) = ''
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT	A.[ProductID]
			, A.[ProductName]
			, A.[TrainingGroupID]
			, B.[TrainingGroupName]
			, C.[UserName] As [LastUpdatedByUserName]
			, A.[LastUpdated]
	FROM	[dbo].[CR_Product] A WITH (NOLOCK) 
			INNER JOIN [dbo].[CR_TrainingGroup] B WITH (NOLOCK) ON A.[TrainingGroupID]= B.[TrainingGroupID]
	        LEFT JOIN [dbo].[SC_UserProfile] C WITH (NOLOCK) ON A.[LastUpdatedBy] = C.[UserProfileID]'
	
	SET @Query2 = N''
	IF @ProductName != ''
		SET @Query2 = @Query2 + N' AND A.[ProductName] = @ProductName'
	IF @TrainingGroupIDList != ''
		SET @Query2 = @Query2 + N' AND A.[TrainingGroupID] IN (SELECT [Items] AS [TrainingGroupID] FROM [dbo].[Split](@TrainingGroupIDList, '';''))' 

	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)										
	SET @Query = @Query + @Query2
			
	SET @ParmDef = '@ProductName varchar(100)
					, @TrainingGroupID int
					, @TrainingGroupIDList nvarchar(1000)'
					
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @ProductName
								, @TrainingGroupID
								, @TrainingGroupIDList
								
END



