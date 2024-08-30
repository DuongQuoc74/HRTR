CREATE PROCEDURE [dbo].[TrainingRecord_Import]
(
	@LastUpdatedBy INT
)
AS
	BEGIN
		SET NOCOUNT ON

		MERGE [dbo].[TrainingRecord] AS T
		USING
		(
			SELECT DISTINCT
				[EmployeeID],
				[ProductID],
				[Trainer],
				[CourseID],
				[CertDate],
				[ExpDate],
				[Score],
				[CertifiedLevelID],
				[EmployeeID_ID],
				[OJT],
				[IsActive],
				[Comments]
			FROM [dbo].[TrainingRecordTemp] WITH(NOLOCK)
			WHERE
                [LastUpdatedBy] = @LastUpdatedBy
                AND [IsActive] = 1
                AND [IsValid] = 1
		) AS S
            ON
            (
                T.[EmployeeID_ID] = S.[EmployeeID_ID]
                AND T.[CourseID] = S.[CourseID]
                AND T.[CertDate] = S.[CertDate] 
                AND T.[ProductID] = S.[ProductID]
            )
			WHEN NOT MATCHED THEN
			    INSERT
                (
                    [EmployeeID],
                    [ProductID],
                    [Trainer],
                    [CourseID],
                    [CertDate],
                    [ExpDate],
                    [Score],
                    [CertifiedLevelID],
                    [EmployeeID_ID],
                    [OJT],
                    [IsActive],
                    [Comments],
                    [LastUpdated],
                    [LastUpdatedBy]
                )
                VALUES
                (
                    S.[EmployeeID],
                    S.[ProductID],
                    S.[Trainer],
                    S.[CourseID],
                    S.[CertDate],
                    S.[ExpDate],
                    S.[Score],
                    S.[CertifiedLevelID],
                    S.[EmployeeID_ID],
                    S.[OJT],
                    S.[IsActive],
                    S.[Comments],
                    GETDATE(), --S.[LastUpdated]
                    @LastUpdatedBy
		        )   --S.[LastUpdatedBy])

			WHEN MATCHED THEN
                UPDATE
                SET
                    T.[ProductID] = S.[ProductID],
                    T.[Trainer] = S.[Trainer],
                    T.[ExpDate] = S.[ExpDate],
                    T.[Score] = S.[Score],
                    T.[CertifiedLevelID] = S.[CertifiedLevelID],
                    T.[OJT] = S.[OJT],
                    T.[IsActive] = S.[IsActive],
                    T.[Comments] = S.[Comments],
                    T.[LastUpdated] = GETDATE(),
                    T.[LastUpdatedBy] = @LastUpdatedBy
        ; --LoanNguyen 20171218

		MERGE [dbo].[TrainingRecord] AS T
		USING
		(
			SELECT DISTINCT
				[EmployeeID],
				[ProductID],
				[Trainer],
				[CourseID],
				[CertDate],
				[ExpDate],
				[Score],
				[CertifiedLevelID],
				[EmployeeID_ID],
				[OJT],
				[IsActive],
				[Comments]
			FROM [dbo].[TrainingRecordTemp] WITH(NOLOCK)
			WHERE
                [LastUpdatedBy] = @LastUpdatedBy
				AND [CertDate] IS NOT NULL
				AND ISNULL([Score],'0.0') <> '0.0'
				AND [Trainer] IS NOT NULL
                AND [IsActive] = 0
                AND [IsValid] = 1
		) AS S
		    ON
            (
                T.[EmployeeID_ID] = S.[EmployeeID_ID]
                AND T.[CourseID] = S.[CourseID]
                AND T.[CertDate] = S.[CertDate] 
                AND T.[ProductID] = S.[ProductID]
            )
			WHEN NOT MATCHED THEN
			    INSERT (
                    [EmployeeID],
                    [ProductID],
                    [CourseID],
                    [EmployeeID_ID],
                    [OJT],
                    [IsActive],
                    [Comments],
                    [LastUpdated],
                    [LastUpdatedBy]
					
                )
                VALUES  (
                    S.[EmployeeID],
                    S.[ProductID],
                    S.[CourseID],
                    S.[EmployeeID_ID],
                    S.[OJT],
                    S.[IsActive],
                    S.[Comments],
                    GETDATE(), --S.[LastUpdated]
                    @LastUpdatedBy
					)
            WHEN MATCHED THEN
                UPDATE
                SET
                    T.[ProductID] = S.[ProductID],
                    T.[OJT] = S.[OJT],
                    T.[IsActive] = S.[IsActive],
                    T.[Comments] = S.[Comments],
                    T.[LastUpdated] = GETDATE(),
                    T.[LastUpdatedBy] = @LastUpdatedBy

        ;   -- Terminal Merge statement

		--thien 30/7/2020
		MERGE [dbo].[TrainingRecord] AS T
		USING
		(
			SELECT DISTINCT
				[EmployeeID],
				[ProductID],
				[Trainer],
				[CourseID],
				[CertDate],
				[ExpDate],
				[Score],
				[CertifiedLevelID],
				[EmployeeID_ID],
				[OJT],
				[IsActive],
				[Comments]
			FROM [dbo].[TrainingRecordTemp] WITH(NOLOCK)
			WHERE
                [LastUpdatedBy] = @LastUpdatedBy
				AND [CertDate] IS NULL
				AND ISNULL([Score],'0.0') = '0.0'
				AND [Trainer] IS NULL
                AND [IsActive] = 0
                AND [IsValid] = 1
		) AS S
		    ON
            (
                T.[EmployeeID_ID] = S.[EmployeeID_ID]
                AND T.[CourseID] = S.[CourseID]
                AND T.[ProductID] = S.[ProductID]
            )
            WHEN MATCHED THEN
                UPDATE
                SET
                    T.[IsActive] = 0,
                    T.[Comments] = S.[Comments],
                    T.[LastUpdated] = GETDATE(),
                    T.[LastUpdatedBy] = @LastUpdatedBy
;

		UPDATE A
		SET
			[CertifiedLevelID] = (CASE
									  WHEN C.[IsOrientation] = 1 THEN 4
									  ELSE 5
								  END)
		FROM
            [dbo].[TrainingRecord] A WITH(NOLOCK)
            INNER JOIN
            (
			    SELECT DISTINCT
				    [CourseID],
				    [EmployeeID_ID],
				    [ProductID] --LoanNguyen 20180105
			    FROM [dbo].[TrainingRecordTemp] WITH(NOLOCK)
			    WHERE
                    [LastUpdatedBy] = @LastUpdatedBy
				    AND [IsValid] = 1
		    ) B
                ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
                AND A.[CourseID] = B.[CourseID]
                AND A.[ProductID] = B.[ProductID] --LoanNguyen 20180105
                AND A.[OJT] = 0
                --AND A.[IsActive] = 1  --ThienNguyen6339 20200805
            INNER JOIN [dbo].[CR_Course] C WITH(NOLOCK) ON A.[CourseID] = C.[CourseID]

		UPDATE A
		SET
			[CertifiedLevelID] = (CASE
									  WHEN C.[IsOrientation] = 1 THEN 1
									  ELSE 2
								  END)
		FROM
            [dbo].[TrainingRecord] A WITH(NOLOCK)
            INNER JOIN
            (
                SELECT DISTINCT
                    [CourseID],
                    [EmployeeID_ID],
                    [ProductID] --LoanNguyen 20180105
                FROM [dbo].[TrainingRecordTemp] WITH(NOLOCK)
                WHERE
                    [LastUpdatedBy] = @LastUpdatedBy
                    AND [IsValid] = 1
            ) B
                ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
                AND A.[CourseID] = B.[CourseID]
                AND A.[ProductID] = B.[ProductID] --LoanNguyen 20180105
                AND A.[OJT] = 0
                --AND A.[IsActive] = 1  -- ThienNguyen6339 20200805
                AND A.[CertDate] =
                    (
                        SELECT TOP 1 D.[CertDate]
                        FROM [dbo].[TrainingRecord] D WITH(NOLOCK)
                        WHERE
                            D.[EmployeeID_ID] = A.[EmployeeID_ID]
                            AND D.[CourseID] = A.[CourseID]
                            AND D.[ProductID] = A.[ProductID] --LoanNguyen 20180109
                            AND D.[OJT] = 0
                           -- AND D.[IsActive] = 1 --LoanNguyen 20180105  -- ThienNguyen6339 20200805
                        ORDER BY D.[CertDate]
                    )
            INNER JOIN [dbo].[CR_Course] C WITH(NOLOCK) ON A.[CourseID] = C.[CourseID]

		--Update Level to Failed for case score < minpoint
			UPDATE A
		SET
			[CertifiedLevelID] = 3
			,[Comments] = 'Failed Certification'
			,[ExpDate] = NULL
		FROM
            [dbo].[TrainingRecord] A WITH(NOLOCK)
            INNER JOIN
            (
			    SELECT DISTINCT
				    [CourseID],
				    [EmployeeID_ID],
				    [ProductID]
			    FROM [dbo].[TrainingRecordTemp] WITH(NOLOCK)
			    WHERE
                    [LastUpdatedBy] = @LastUpdatedBy
				    AND [IsValid] = 1
		    ) B
                ON A.[EmployeeID_ID] = B.[EmployeeID_ID]
                AND A.[CourseID] = B.[CourseID]
                AND A.[ProductID] = B.[ProductID]
                AND A.[OJT] = 0
            INNER JOIN [dbo].[CR_Course] C WITH(NOLOCK) ON A.[CourseID] = C.[CourseID]
			WHERE A.Score < C.MinPoint
	END