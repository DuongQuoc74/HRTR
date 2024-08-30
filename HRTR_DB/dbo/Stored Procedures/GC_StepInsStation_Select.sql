CREATE PROC [dbo].[GC_StepInsStation_Select] 
(
	@GC_StepInsStationID		int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT	[GC_StepInsStationID]
			  ,[Customer_ID]
			  ,[StepIns]
			  ,[GC_StationID]
			  ,[MESCustomer_ID]
			  ,[Step_ID]
			  ,[IsActive]
			  ,[LastUpdated]
			  ,[LastUpdatedBy]
	FROM [dbo].[GC_StepInsStation] WITH (NOLOCK)
	WHERE [GC_StepInsStationID]=@GC_StepInsStationID
END
