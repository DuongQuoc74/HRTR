
CREATE PROC [dbo].[CR_WorkingStatus_Search] 
(
	@WorkingStatusCode		nvarchar(10),
	@WorkingStatusName		nvarchar(100)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT [WorkingStatusID]
	,[WorkingStatusCode]
			  ,[WorkingStatusName]
			  ,[LastUpdated]
			  ,[LastUpdatedBy]
			FROM [dbo].[CR_WorkingStatus] WITH (NOLOCK)'
			
	SET @Query2 = N''
	IF @WorkingStatusCode != ''
		SET @Query2 = @Query2 + N' AND [WorkingStatusCode] = @WorkingStatusCode'
	IF @WorkingStatusName != ''
		SET @Query2 = @Query2 + N' AND [WorkingStatusName] LIKE ''%'' + @WorkingStatusName + ''%'''
	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)										
	SET @Query = @Query + @Query2
	
	SET @ParmDef = '@WorkingStatusCode	nvarchar(10)
					, @WorkingStatusName	nvarchar(100)'
					
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @WorkingStatusCode
								, @WorkingStatusName
END



