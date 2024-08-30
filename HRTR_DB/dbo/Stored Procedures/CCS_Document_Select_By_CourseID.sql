CREATE PROC [dbo].[CCS_Document_Select_By_CourseID] 
(
	@CourseID int

)
AS
BEGIN
	SET NOCOUNT ON
	SELECT ROW_NUMBER() OVER(ORDER BY B.[DocumentID]) AS [RowNo]
			,D.[FamilyName] AS [FamilyName]
			,B.[WorkcellID] AS [WorkcellID]
			,E.[StationName] AS [StationName]
			,B.[AssemblyNo] AS [AssemblyNo]
			,B.[DocumentID] AS [DocumentID]
			,B.[DocumentName] AS [DocumentName]
			,B.[Revision] AS [Revision]
			,B.[DocumentNo] AS [DocumentNo]
			,B.[DocumentDescription] AS [DocumentDescription]
			,C.[FolderPath] + '\' + B.[DocumentFile] AS [PathDocument]
	FROM [dbo].[CR_CourseStation] A WITH (NOLOCK) INNER JOIN [EDCC].[dbo].[Document] B WITH (NOLOCK) ON A.[StationID] = B.[StationID]
								 INNER JOIN [EDCC].[dbo].[Folder] C WITH (NOLOCK) ON B.[FolderID] = C.[FolderID]
								 LEFT JOIN [EDCC].[dbo].[Family] D WITH (NOLOCK) ON B.[FamilyID] = D.[FamilyID]
								 LEFT JOIN [EDCC].[dbo].[Station] E WITH (NOLOCK) ON B.[StationID] = E.[StationID]
	WHERE A.[CourseID] = @CourseID 
		  AND A.[IsActive] = 1
		  AND B.[DocumentType] IN (30, 40, 60) -- 20131219, Thi Ly, RITM0672932: Enable Document Type ID 30
		  AND B.[IsObsolete] = 0 
		  AND B.[DocumentStatusID] = 'CL'
		  
	
END


