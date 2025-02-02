CREATE PROCEDURE [dbo].[CR_EmployeeDocument_Save]
    @TRXml AS xml,
	@StationID AS int,
	@WorkcellID AS int,
	@CourseID AS int,
	@CerDateFrom AS date,
	@CerDateTo AS date,
	@DocumentNumber AS nvarchar(255),
	@Revision AS nvarchar(10),
	@CreatedBy AS nvarchar(10),
	@Active AS bit,
	@EmployeeDocID AS int
AS
BEGIN
	IF @Active = 0
	BEGIN
		UPDATE CR_EmployeeDocument
		SET Active = 0,
			LastUpdatedBy = @CreatedBy,
			LastUpdated= GETDATE()
		FROM CR_EmployeeDocument
		JOIN (
			SELECT T.c.value('.', 'INT') AS ID
			FROM @TRXml.nodes('/Root/Value') T(c)
		) AS IDs ON CR_EmployeeDocument.EmployeeDocID = IDs.ID;
	END
	ELSE IF @EmployeeDocID>0
	BEGIN
		UPDATE CR_EmployeeDocument
		SET DocumentNumber = @DocumentNumber,
			Revision = @Revision,
			LastUpdatedBy = @CreatedBy,
			LastUpdated= GETDATE()
		WHERE EmployeeDocID = @EmployeeDocID;
	END
	ELSE
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
		DECLARE @hdoc INT
		EXEC sp_xml_preparedocument @hdoc OUTPUT, @TRXml
		MERGE @TRSearch AS TR
		USING (
		SELECT *
		FROM OPENXML (@hdoc, '/Root/Value', 2)
		WITH (
			TrainingRecordID INT '.'
		)
		) AS S ON TR.TrainingRecordID = S.TrainingRecordID
		WHEN MATCHED THEN UPDATE SET TR.[Active] = 1
		WHEN NOT MATCHED BY SOURCE THEN UPDATE SET TR.[Active] = 0;

		EXEC sp_xml_removedocument @hdoc
		DELETE FROM @TRSearch WHERE Active=0

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
END