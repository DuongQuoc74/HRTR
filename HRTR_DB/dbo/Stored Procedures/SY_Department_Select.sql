CREATE PROC [dbo].[SY_Department_Select] @DepartmentID int
AS
SELECT [DepartmentID]
      ,[DepartmentCode]
      ,[DepartmentName] 
      FROM [dbo].[SY_Department] WITH (NOLOCK)
      WHERE [DepartmentID]=@DepartmentID

