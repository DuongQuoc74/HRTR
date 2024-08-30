CREATE PROC [dbo].[CR_CourseStation_Save] 
(
	@CourseStationID int, 
	@CourseID				int, 
	@StationID				int,
	--@Active					bit, 
	@LastUpdatedBy			int = 0	
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF EXISTS (SELECT 1
				FROM [dbo].[CR_CourseStation] WITH (NOLOCK) 
				WHERE [CourseID]=@CourseID
						AND [StationID]=@StationID)
	BEGIN
		--update existing record
		--UPDATE	[dbo].[CR_CourseStation] 
		--SET		[CourseID]=@CourseID
		--		,[StationID]=@StationID
		--		--,[Active]=@Active
		--		,[LastUpdated]=GETDATE()
		--		,[LastUpdatedBy]=@LastUpdatedBy
		--WHERE [CourseStationID]=@CourseStationID
		SELECT TOP 1 @CourseStationID = [CourseStationID]
		FROM [dbo].[CR_CourseStation] WITH (NOLOCK) 
		WHERE [CourseID]=@CourseID
				AND [StationID]=@StationID
	END
	ELSE
	BEGIN
		--insert new record
		INSERT INTO [dbo].[CR_CourseStation] ([CourseID], [StationID]
		, [IsActive]
		, [LastUpdated], [LastUpdatedBy])
		VALUES ( @CourseID, @StationID
		, 1 -- Default value
		, GETDATE(), @LastUpdatedBy)
		SET @CourseStationID=SCOPE_IDENTITY()
		
	END
	
	EXEC [dbo].[CR_CourseStation_Select] @CourseStationID
END

