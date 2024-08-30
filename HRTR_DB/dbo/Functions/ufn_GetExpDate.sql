-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetExpDate]
(
	@CertDate			datetime,
	@ExpiredInMonthsC	int, -- Course
	@ExpiredInMonthsCG	int -- Course Group
	
)
RETURNS datetime
AS
BEGIN

	DECLARE @R	datetime
	SET @ExpiredInMonthsC = ISNULL(@ExpiredInMonthsC, 0)
	SET @ExpiredInMonthsCG = ISNULL(@ExpiredInMonthsCG, 0)
	IF @ExpiredInMonthsC = 0
	BEGIN
		IF @ExpiredInMonthsCG = 0
		BEGIN
			SET @R = NULL
		END
		ELSE
		BEGIN
			SET @R = DATEADD(MM, @ExpiredInMonthsCG, @CertDate)
		END
	END
	ELSE
	BEGIN
		SET @R = DATEADD(MM, @ExpiredInMonthsC, @CertDate)
	END

	RETURN @R
END
