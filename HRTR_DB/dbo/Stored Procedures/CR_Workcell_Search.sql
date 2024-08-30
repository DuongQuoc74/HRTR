CREATE PROC [dbo].[CR_Workcell_Search]
(
	@IsMESWorkcell	int = -1-- 0: Not MES Workcell, 1: MES Workcell, -1: All
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE		@ParmDef						nvarchar(4000)
				, @Query						nvarchar(max)
				, @Query2						nvarchar(max)
	SET @Query = N'SELECT A.[WorkcellID]
	  ,A.[WorkcellCode]
	  ,A.[WorkcellName]
	  ,A.[MESCustomer_ID]
	  ,A.[IsAppliedCCS]
	  ,A.[IsActive]
	  ,A.[LastUpdated]
	  ,B.[UserName] As [LastUpdatedByUserName]
	FROM	[dbo].[CR_Workcell] A WITH (NOLOCK) LEFT JOIN [dbo].[SC_UserProfile] B WITH (NOLOCK) ON A.[LastUpdatedBy] = B.[UserProfileID]'
	SET @Query2 = N''
	IF @IsMESWorkcell = 1
		SET @Query2 = @Query2 + N' WHERE A.[MESCustomer_ID] != 0'
	ELSE IF @IsMESWorkcell = 0
		SET @Query2 = @Query2 + N' WHERE A.[MESCustomer_ID] = 0'
	
	IF @Query2 != ''
		SET @Query2 = N' WHERE ' + RIGHT(@Query2, LEN(@Query2) - 4)										
	SET @Query = @Query + @Query2
	SET @ParmDef = '@IsMESWorkcell	int'
					
	--PRINT @Query
	EXEC sp_executesql @Query, @ParmDef
								, @IsMESWorkcell
END

