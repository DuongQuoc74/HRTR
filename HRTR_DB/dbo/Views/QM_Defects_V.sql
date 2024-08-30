





CREATE VIEW [dbo].[QM_Defects_V]
AS
	SELECT [Defect_ID]
	  ,[Defect]
	  ,[DefectCategory_ID]
	  ,[Active]
	  ,[UserID_ID]
	  ,[LastUpdated]
	  ,[RequiresRework]
	  --,(CONVERT(VARCHAR, [Defect_ID]) + '. ' + 
	  --,[DefectText] + ' - ' + ISNULL([DefextTextVN], 'Không dùng') AS [DefectText]
	  ,[DefectText] + ' - ' + ISNULL([DefextTextVN], [DefectText]) AS [DefectText]
	  --,[DefextTextVN]
	  ,ISNULL([DefextTextVN], [DefectText]) AS [DefextTextVN]
	FROM [dbo].[QM_Defects] WITH (NOLOCK)




