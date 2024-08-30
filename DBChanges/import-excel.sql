-- Enable Ad Hoc Distributed Queries option on the SQL Server instance
sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

DECLARE @ExcelData AS TABLE (
	EmployeeID VARCHAR(50),
	EmployeeIDSAP VARCHAR(50),
	EmployeeName VARCHAR(50),
	WorkcellName VARCHAR(50),
	Station VARCHAR(50),
	CertDate date,
	IsExpired VARCHAR(50),
	Family VARCHAR(50),
	CourseName VARCHAR(50),
	CourseGroupName VARCHAR(50),
	TrainingGroupName VARCHAR(50),
	IsActive VARCHAR(50),
	DocumentNumber VARCHAR(50),
	Revision VARCHAR(50))

INSERT INTO @ExcelData
EXECUTE ('SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0;HDR=No;Database=E:\Khachhang\jabil\CCS control open VA\EmDoc.xlsx'', ''SELECT * FROM [Training Records$]'')');

DECLARE @EmployeeID VARCHAR(50);
DECLARE @EmployeeIDSAP VARCHAR(50);
DECLARE @EmployeeName VARCHAR(50);
DECLARE @WorkcellName VARCHAR(50);
DECLARE @Station VARCHAR(50);
DECLARE @CertDate date;
DECLARE @IsExpiredStr VARCHAR(50);
DECLARE @Family VARCHAR(50);
DECLARE @CourseName VARCHAR(50);
DECLARE @CourseGroupName VARCHAR(50);
DECLARE @TrainingGroupName VARCHAR(50);
DECLARE @IsActiveStr VARCHAR(50);
DECLARE @DocumentNumber VARCHAR(50);
DECLARE @Revision VARCHAR(50);

DECLARE ExcelCursor CURSOR
FOR SELECT EmployeeID,
			EmployeeIDSAP,
			EmployeeName,
			WorkcellName,
			Station,
			CertDate,
			IsExpired bit,
			Family,
			CourseName,
			CourseGroupName,
			TrainingGroupName,
			IsActive bit,
			DocumentNumber,
			Revision
FROM @ExcelData;

OPEN ExcelCursor;

FETCH NEXT FROM ExcelCursor INTO @EmployeeID, @EmployeeIDSAP, @EmployeeName, @WorkcellName, @Station, @CertDate, @IsExpiredStr, @Family, @CourseName, @CourseGroupName, @TrainingGroupName, @IsActiveStr, @DocumentNumber, @Revision;

WHILE @@FETCH_STATUS = 0
BEGIN

	DECLARE @IsExpired bit = 0;
	DECLARE @IsActive bit = 0;

	IF @IsExpiredStr = 'True'
	SET @IsExpired = 1;
	IF @IsActiveStr = 'True'
	SET @IsActive = 1;

	DECLARE @Inserted AS TABLE (EmployeeDocID int)

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
	OUTPUT inserted.EmployeeDocID INTO @Inserted
	SELECT TOP 1 @EmployeeID
			,trv.EmployeeID_ID
			,trv.CourseID
			,cs.StationID
			,hrv.WorkcellID
			,@DocumentNumber
			,@Revision
			,@IsActive
			,GETDATE() AS Created
			,0
			,NULL
			,NULL
	FROM TrainingRecord_V trv
	INNER JOIN TrainingRecord tr ON tr.TrainingRecordID = trv.TrainingRecordID
	INNER JOIN HR_Employee_V hrv ON hrv.EmployeeID_ID = trv.EmployeeID_ID
	INNER JOIN CR_CourseStation cs ON cs.CourseID = trv.CourseID
	INNER JOIN CR_Station s ON s.Id = cs.StationID AND s.WorkcellID = hrv.WorkcellID
	WHERE trv.EmployeeID = @EmployeeID
		AND UPPER(hrv.WorkcellName) = UPPER(@WorkcellName)
		AND trv.CertDate = @CertDate
		AND UPPER(trv.CourseName) = UPPER(@CourseName)
		AND UPPER(trv.CourseGroupName) = UPPER(@CourseGroupName)
		AND UPPER(trv.TrainingGroupName) = UPPER(@TrainingGroupName)
		AND trv.IsActive = @IsActive
		AND UPPER(s.Name) = UPPER(@Station)
		AND NOT EXISTS (
			SELECT 1
			FROM CR_EmployeeDocument AS ce
			WHERE ce.EmployeeID_ID = trv.EmployeeID_ID
				AND ce.CourseID = trv.CourseID
				AND ce.WorkcellID = hrv.WorkcellID
				AND ce.StationID = cs.StationID
				AND ce.DocumentNumber = @DocumentNumber
				AND ce.Revision = @Revision
				AND ce.Active = 1
		)

	-- Fetch the next row from the cursor
	FETCH NEXT FROM ExcelCursor INTO @EmployeeID, @EmployeeIDSAP, @EmployeeName, @WorkcellName, @Station, @CertDate, @IsExpiredStr, @Family, @CourseName, @CourseGroupName, @TrainingGroupName, @IsActiveStr, @DocumentNumber, @Revision;
END
CLOSE ExcelCursor; DEALLOCATE ExcelCursor;
SELECT EmployeeDocID FROM @Inserted