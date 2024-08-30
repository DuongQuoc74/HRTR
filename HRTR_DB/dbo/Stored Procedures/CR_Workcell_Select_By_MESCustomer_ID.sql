CREATE PROC [dbo].[CR_Workcell_Select_By_MESCustomer_ID] 
(
	@MESCustomer_ID		int
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT [WorkcellID]
	  ,[WorkcellCode]
	  ,[WorkcellName]
	  ,[MESCustomer_ID]
	  ,[IsAppliedCCS]
	  ,[IsActive]
	  ,[LastUpdated]
	  ,[LastUpdatedBy]
	FROM [dbo].[CR_Workcell] WITH (NOLOCK)
	WHERE [MESCustomer_ID]=@MESCustomer_ID
END

