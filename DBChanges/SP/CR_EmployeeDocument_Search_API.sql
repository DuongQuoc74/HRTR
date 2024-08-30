CREATE PROCEDURE [dbo].[CR_EmployeeDocument_Search_API]
	@EmployeeID_ID AS int,
	@StationID AS int,
	@WorkcellID AS int,
	@CourseID AS int
AS
BEGIN
	DECLARE @EmployeeDoc AS TABLE (
				EmployeeDocID int
				, DocumentNumber nvarchar(255)
				, Revision nvarchar(10)
				, ExpDate date)

	INSERT INTO @EmployeeDoc
	SELECT E.[EmployeeDocID]
		, E.[DocumentNumber]
		, E.[Revision]
		, TR.[ExpDate]
	FROM [dbo].[CR_EmployeeDocument] E WITH (NOLOCK)
	INNER JOIN [dbo].[TrainingRecord_V] TR WITH (NOLOCK) ON TR.EmployeeID_ID = E.EmployeeID_ID AND TR.CourseID = E.CourseID
	WHERE E.[EmployeeID_ID] = @EmployeeID_ID AND E.[WorkcellID] = @WorkcellID AND E.[CourseID] = @CourseID AND E.[Active] = 1 AND TR.IsActive = 1
		AND (@StationID IS NULL OR E.[StationID] = @StationID)
	ORDER BY TR.ExpDate DESC

	DECLARE @row_count INT;
	SELECT @row_count = COUNT(*) FROM @EmployeeDoc
	IF @row_count=0
	BEGIN
		INSERT INTO @EmployeeDoc
		SELECT TOP 1 0 AS EmployeeDocID,
				'###' AS DocumentNumber,
				'###' AS Revision,
				trv.ExpDate
		FROM TrainingRecord_V trv
		INNER JOIN HR_Employee_V hrv ON trv.EmployeeID_ID = hrv.EmployeeID_ID
		INNER JOIN CR_CourseStation cs ON cs.CourseID = trv.CourseID
		INNER JOIN CR_Station s ON s.WorkcellID = hrv.WorkcellID AND s.Id = cs.StationID
		WHERE trv.CourseID = @CourseID AND trv.EmployeeID_ID = @EmployeeID_ID AND hrv.WorkcellID = @WorkcellID
			AND (@StationID IS NULL OR s.Id = @StationID)
		ORDER BY trv.CertDate Desc
				
		SELECT * FROM @EmployeeDoc
	END
	ELSE
	BEGIN
		SELECT DocumentNumber, Revision, MAX(ExpDate) as ExpDate
		FROM @EmployeeDoc		
		GROUP BY DocumentNumber, Revision
	END
END