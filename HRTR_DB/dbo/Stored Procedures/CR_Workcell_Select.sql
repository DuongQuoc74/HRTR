CREATE PROC [dbo].[CR_Workcell_Select] @WorkcellID int
AS
SELECT [WorkcellID]
  ,[WorkcellCode]
  ,[WorkcellName]
  ,[MESCustomer_ID]
  ,[IsAppliedCCS]
  ,[IsActive]
  ,[LastUpdated]
  ,[LastUpdatedBy]
FROM [dbo].[CR_Workcell] WITH (NOLOCK)
WHERE [WorkcellID]=@WorkcellID


