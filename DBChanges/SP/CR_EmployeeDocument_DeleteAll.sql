CREATE PROC [dbo].[CR_EmployeeDocument_DeleteAll] 
(
	@StationID AS int,
	@WorkcellID AS int,
	@CourseID AS int,
	@CourseGroupID AS int,
	@TrainingGroupID AS int,
	@DocumentNumber AS nvarchar(255),
	@Revision AS nvarchar(10),
	@UpdatedBy AS int
)
AS
BEGIN
	DECLARE @DocsSearch AS TABLE([EmployeeDocID] int
		,[EmployeeID_ID] nvarchar(100)
		,[EmployeeID] nvarchar(100)
		,[EmployeeName] nvarchar(100)
		,[WorkcellName] nvarchar(100)
		,StationName nvarchar(100)
		,[CourseName] nvarchar(100)
		,[CourseGroupName] nvarchar(100)
		,[TrainingGroupName] nvarchar(100)
		,[DocumentNumber] nvarchar(255)
		,[Revision] nvarchar(10)
		,[Created] date
		,[CreatedByFullName] nvarchar(100)
	)
	INSERT INTO @DocsSearch
	EXEC CR_EmployeeDocument_Search
		@StationID = @StationID,
		@WorkcellID = @WorkcellID,
		@CourseID = @CourseID,
		@CourseGroupID = @CourseGroupID,
		@TrainingGroupID = @TrainingGroupID,
		@DocumentNumber = @DocumentNumber,
		@Revision = @Revision

	UPDATE CR_EmployeeDocument
	SET Active = 0,
		LastUpdatedBy = @UpdatedBy,
		LastUpdated= GETDATE()
	WHERE EmployeeDocID IN (SELECT EmployeeDocID FROM @DocsSearch)
END