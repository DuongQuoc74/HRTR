CREATE PROC [dbo].[GC_Station_Search] 
(
	@StationName	nvarchar(255) = '', 
	@Customer_ID	int = 0,
	@IsWithUnknown	bit = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @ParmDef = N'@StationName	nvarchar(255), 
					@Customer_ID		int
					'			
					
	SET @Query = N'SELECT	A.[GC_StationID]
			, A.[StationName]
			, A.[Customer_ID]
			, B.[Customer]
	FROM	[dbo].[GC_Station] A WITH (NOLOCK), [dbo].[GC_Customers] B WITH (NOLOCK) 
	WHERE	A.[Customer_ID] = B.[Customer_ID]'
	
	IF @StationName != ''
		SET @Query = @Query + N' AND A.[StationName] = @StationName'
	IF @Customer_ID != 0
		SET @Query = @Query + N' AND A.[Customer_ID] = @Customer_ID' 
	
	SET @Query = @Query + N' AND A.[IsActive] = 1'	
	IF @IsWithUnknown = 1
		SET @Query = @Query + N' UNION SELECT	-1 AS [GC_StationID]
			, ''Unknown'' AS [StationName]
			, 0 AS [Customer_ID]
			, '''' AS [Customer]' 
	SET @Query = @Query + N' ORDER BY [StationName]'
	
	EXEC sp_executesql @Query, @ParmDef
								, @StationName
								, @Customer_ID
										
END

