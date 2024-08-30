CREATE PROCEDURE [dbo].[JEMS_DataSync]

AS
BEGIN

	SET NOCOUNT ON;	
	-- Defect START
	DECLARE @QM_Defects AS TABLE(
						[Defect_ID] [int] NOT NULL,
						[Defect] [int] NOT NULL,
						[DefectCategory_ID] [int] NOT NULL,
						[Active] [bit] NOT NULL,
						[UserID_ID] [int] NOT NULL,
						[LastUpdated] [datetime] NOT NULL,
						[RequiresRework] [bit] NOT NULL,
						[DefectText] [nvarchar](200) NULL
						)
	INSERT INTO @QM_Defects
	SELECT A.[Defect_ID]
		  ,A.[Defect]
		  ,A.[DefectCategory_ID]
		  ,A.[Active]
		  ,A.[UserID_ID]
		  ,A.[LastUpdated]
		  ,A.[RequiresRework]
		  ,B.[Translation] AS [DefectText]
	FROM [VNHCMM0MSSQLV1A].[JEMS].[dbo].[QM_Defects] A WITH (NOLOCK) 
	INNER JOIN [VNHCMM0MSSQLV1A].[JEMS].[dbo].[CR_Text] B WITH (NOLOCK) ON A.[Defect] = B.[Text_ID]
	
	UPDATE A
	SET [DefectText] = B.[DefectText]
		, [Active] = B.[Active]
	FROM [dbo].[QM_Defects] A WITH (NOLOCK) INNER JOIN @QM_Defects B ON B.[Defect_ID] = A.[Defect_ID]
	
	INSERT INTO [dbo].[QM_Defects]
	([Defect_ID]
      ,[Defect]
      ,[DefectCategory_ID]
      ,[Active]
      ,[UserID_ID]
      ,[LastUpdated]
      ,[RequiresRework]
      ,[DefectText]
      ,[DefextTextVN])
	SELECT A.[Defect_ID]
		  ,A.[Defect]
		  ,A.[DefectCategory_ID]
		  ,A.[Active]
		  ,A.[UserID_ID]
		  ,A.[LastUpdated]
		  ,A.[RequiresRework]
		  ,A.[DefectText]
		  ,A.[DefectText] AS [DefextTextVN]
	FROM	@QM_Defects A
	WHERE	NOT EXISTS (SELECT 1
						FROM [dbo].[QM_Defects] B WITH (NOLOCK)
						WHERE B.[Defect_ID] = A.[Defect_ID])
	-- Defect END
	
	-- Route START
	DECLARE @Route AS TABLE
	(
		[Route_ID]			[int],
		[Route]				[nvarchar](200)
	)
	INSERT INTO @Route
	SELECT	a1.[Route_ID], 
			tp.[Translation] AS [Route]
	FROM	[VNHCMM0MSSQLV1A].[JEMS].[dbo].[CR_Routes] a1 WITH (NOLOCK)
			INNER JOIN [VNHCMM0MSSQLV1A].[JEMS].[dbo].[CR_Text] tp WITH (NOLOCK) ON tp.[Text_ID] = a1.[Route]
	UPDATE B
	SET [Route] = A.[Route]
		--,[LastUpdated] = GETDATE()
  --      ,[LastUpdatedBy] = -1 
	FROM @Route A INNER JOIN [dbo].[CR_Routes] B WITH (NOLOCK) ON B.[Route_ID] = A.[Route_ID]
	
	INSERT INTO [dbo].[CR_Routes]
           ([Route_ID]
           ,[Route]
           ,[Customer_ID]
           ,[MESCustomer_ID]
           ,[IsBOXBUILD]
           ,[IsPCBA]
           ,[IsBASE]
           ,[IsRMA]
           ,[IsActive]
           ,[LastUpdated]
           ,[LastUpdatedBy])
     SELECT A.[Route_ID]
           ,A.[Route]
           ,0 AS [Customer_ID]
           ,0 AS [MESCustomer_ID]
           ,0 AS [IsBOXBUILD]
           ,0 AS [IsPCBA]
           ,0 AS [IsBASE]
           ,0 AS [IsRMA]
           ,0 AS [IsActive]
           ,GETDATE() AS [LastUpdated]
           ,-1 AS [LastUpdatedBy]
     FROM @Route A
			 WHERE NOT EXISTS (SELECT 1
								 FROM [dbo].[CR_Routes] B WITH (NOLOCK)
								 WHERE B.[Route_ID] = A.[Route_ID])
	-- Route END
	
	-- QM_FailureData START
	DECLARE @QM_FailureData AS TABLE
	(
		[FailureData_ID]		[int],
		[Customer_ID]			[int],
		[DataLabel]				[nvarchar](100),
		[Step_ID]				[int],
		[Comment]				[nvarchar](300)
	)
	INSERT INTO @QM_FailureData
	SELECT	A.[FailureData_ID]
		   ,A.[Customer_ID]
		   ,A.[DataLabel]
		   ,A.[Step_ID]
		   ,A.[Comment]
	FROM	[VNHCMM0MSSQLV1A].[JEMS].[dbo].[QM_FailureData] A WITH (NOLOCK)
	UPDATE B
	SET [Customer_ID] = A.[Customer_ID]
		, [DataLabel] = A.[DataLabel]
		, [Step_ID] = A.[Step_ID]
		, [Comment] = A.[Comment]
	FROM @QM_FailureData A INNER JOIN [dbo].[QM_FailureData] B WITH (NOLOCK) ON B.[FailureData_ID] = A.[FailureData_ID]
	INSERT INTO [dbo].[QM_FailureData]
		   ([FailureData_ID]
		   ,[Customer_ID]
		   ,[DataLabel]
		   ,[Step_ID]
		   ,[Comment]
		   ,[LastUpdated]
		   ,[LastUpdatedBy])
	SELECT	A.[FailureData_ID]
		   ,A.[Customer_ID]
		   ,A.[DataLabel]
		   ,A.[Step_ID]
		   ,A.[Comment]
		   ,GETDATE() AS[LastUpdated]
		   ,-1 AS [LastUpdatedBy]
	FROM @QM_FailureData A
	WHERE NOT EXISTS (SELECT 1
		FROM  [dbo].[QM_FailureData] B WITH (NOLOCK)
		WHERE B.[FailureData_ID] = A.[FailureData_ID]
		)
	-- QM_FailureData END
END