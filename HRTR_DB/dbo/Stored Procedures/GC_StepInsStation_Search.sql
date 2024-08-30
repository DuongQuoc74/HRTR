CREATE PROC [dbo].[GC_StepInsStation_Search] 
(
	@Customer_ID				int, 
	@StepIns					nvarchar(50), 
	@StationName				nvarchar(50), 
	@IsActive					int -- 0: Inactive, 1: Active, -1: All
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	A.[GC_StepInsStationID]
			,A.[Customer_ID]
			,A.[StepIns]
			,A.[GC_StationID]
			,A.[MESCustomer_ID]
			,A.[Step_ID]
			,A.[IsActive]
			,A.[LastUpdated]
			,A.[LastUpdatedBy]
			
			,C.[Customer]
			,B.[StationName]
			
	FROM [dbo].[GC_StepInsStation] A WITH (NOLOCK) INNER JOIN [dbo].[GC_Station] B WITH (NOLOCK) ON A.[GC_StationID] = B.[GC_StationID]
												INNER JOIN [dbo].[GC_Customers] C WITH (NOLOCK) ON A.[Customer_ID] = C.[Customer_ID]
	WHERE	(A.[Customer_ID] = @Customer_ID OR @Customer_ID = 0)
			AND A.[StepIns] LIKE + '%' + @StepIns + '%'
			AND B.[StationName] LIKE + '%' + @StationName + '%'
			AND 
			(
				(ISNULL(A.[IsActive],0)=0 AND @IsActive = 0)
				OR (ISNULL(A.[IsActive],0)=1 AND @IsActive = 1)
				OR @IsActive = -1
			)
END
