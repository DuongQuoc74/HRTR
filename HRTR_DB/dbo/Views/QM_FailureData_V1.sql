
















CREATE VIEW [dbo].[QM_FailureData_V1]
AS
	
	SELECT DISTINCT A.[FailureData_ID], A.[DataLabel], A.[Comment]
	FROM [dbo].[QM_FailureData] A WITH (NOLOCK)
	WHERE A.[Customer_ID] = 4
		AND A.[FailureData_ID] = (SELECT TOP 1 B.[FailureData_ID]
									FROM [dbo].[QM_FailureData] B WITH (NOLOCK) 
									WHERE B.[Customer_ID] = A.[Customer_ID]
									AND B.[DataLabel] = A.[DataLabel])
										



