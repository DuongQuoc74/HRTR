-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetCompanyID_By_CompanyCode]
(
	@v_CompanyCode			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	TOP 1 @R = [CompanyID]
	FROM	[dbo].[CR_Company] WITH (NOLOCK)
	WHERE	[CompanyCode] = @v_CompanyCode
			
	RETURN @R

END
