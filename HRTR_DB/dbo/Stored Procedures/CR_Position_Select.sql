CREATE PROC [dbo].[CR_Position_Select] @PositionID int
AS
	SELECT [PositionID]
      ,[PositionName] 
      FROM [dbo].[CR_Position] WITH (NOLOCK)
      WHERE [PositionID]=@PositionID



