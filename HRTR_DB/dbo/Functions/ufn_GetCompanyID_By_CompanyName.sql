-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[ufn_GetCompanyID_By_CompanyName] 
(
	@v_CompanyName			varchar(50)
)
RETURNS INT
AS
BEGIN

	DECLARE @R	INT
	
	SELECT	@R = [CompanyID]
	FROM	[dbo].[CR_Company]
	WHERE	[CompanyName] = @v_CompanyName
			
	RETURN @R

END
