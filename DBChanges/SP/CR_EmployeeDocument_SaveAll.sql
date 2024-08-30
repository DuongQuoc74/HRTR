CREATE PROC [dbo].[CR_EmployeeDocument_SaveAll] 
(
	@StationID AS int,
	@WorkcellID AS int,
	@CourseID AS int,
	@CerDateFrom AS date,
	@CerDateTo AS date,
	@DocumentNumber AS nvarchar(255),
	@Revision AS nvarchar(10),
	@CreatedBy AS int
)
AS
BEGIN
	DECLARE @TRSearch AS TABLE (
	[TrainingRecordID] int
	,[EmployeeID_ID] int
	,[EmployeeID] nvarchar(20)
	,[EmployeeName] nvarchar(100)
	,[WorkcellID] [int]
	,[WorkcellName] nvarchar(100)
	,[CertDate] date
	,[CourseID] [int]
	,[CourseName] nvarchar(100)
	,[CourseGroupID] [int]
	,[CourseGroupName] nvarchar(100)
	,[TrainingGroupID] [int]
	,[TrainingGroupName] nvarchar(100)
	,[Active] bit DEFAULT 1
	)

	-- Search training records
	INSERT INTO @TRSearch
	EXEC [TrainingRecord_Search_Map_Doc]
				@WorkcellID = @WorkcellID,
				@StationID = @StationID,
				@CourseID = @CourseID,
				@DocumentNumber = @DocumentNumber,
				@Revision = @Revision,
				@CerDateFrom = @CerDateFrom,
				@CerDateTo = @CerDateTo

	--Insert Map
	DECLARE @Inserted AS TABLE (EmployeeID_ID int)
	INSERT INTO CR_EmployeeDocument (
		[EmployeeID]
		,[EmployeeID_ID]
		,[CourseID]
		,[StationID]
		,[WorkcellID]
		,[DocumentNumber]
		,[Revision]
		,[Active]
		,[Created]
		,[CreatedBy]
		,[LastUpdated]
		,[LastUpdatedBy])
	OUTPUT inserted.EmployeeID_ID INTO @Inserted
	SELECT	trid.EmployeeID,
			trid.EmployeeID_ID
			,@CourseID
			,@StationID
			,@WorkcellID
			,@DocumentNumber
			,@Revision
			,1
			,GETDATE() AS Created
			,@CreatedBy
			,NULL
			,NULL
	FROM (
		SELECT * FROM @TRSearch WHERE Active=1
	) trid
	WHERE NOT EXISTS (
		SELECT 1
		FROM CR_EmployeeDocument AS ce
		WHERE ce.EmployeeID_ID = trid.EmployeeID_ID
			AND ce.CourseID = @CourseID
			AND ce.WorkcellID = @WorkcellID
			AND ce.StationID = @StationID
			AND ce.DocumentNumber = @DocumentNumber
			AND ce.Revision = @Revision
			AND ce.Active = 1
	)

	DELETE FROM @TRSearch WHERE EmployeeID_ID IN (SELECT EmployeeID_ID FROM @Inserted)

	SELECT * FROM @TRSearch
END