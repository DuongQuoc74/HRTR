

CREATE VIEW [dbo].[SY_Department_V]
AS
	SELECT [DepartmentID]
	  ,[DepartmentCode]
	  ,[DepartmentName]
	  ,[LastUpdated]
	  ,[LastUpdatedBy]
	FROM [dbo].[SY_Department] WITH (NOLOCK)


