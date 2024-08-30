-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetDefectText_By_EmployeeID_ID_ReviewDate]
(
	
	@EmployeeID_ID int,
	@ReviewDate	datetime
)
RETURNS nvarchar(4000)
AS
BEGIN

	DECLARE @R	nvarchar(4000)
	
	SELECT  @R = COALESCE(@R + ', ', '')
				+	 B.[DefectText]
	FROM	(SELECT DISTINCT (CASE WHEN A.[Customer_ID] = 5 AND ISNULL(C.[Comment], '') <> '' THEN C.[Comment]
								ELSE B.[DefectText] END) AS [DefectText]
			FROM	[dbo].[GrapeChart] A WITH (NOLOCK) 
					INNER JOIN [dbo].[QM_Defects] B WITH (NOLOCK) ON A.[Defect_ID] = B.[Defect_ID]
					LEFT OUTER JOIN [dbo].[QM_FailureData_V1] C WITH (NOLOCK) ON A.[FailureLabel] = C.[DataLabel]
			WHERE	A.[EmployeeID_ID] = @EmployeeID_ID
					AND A.[ReviewDate] = @ReviewDate
			) B
			
	RETURN ISNULL(@R, '')

END
