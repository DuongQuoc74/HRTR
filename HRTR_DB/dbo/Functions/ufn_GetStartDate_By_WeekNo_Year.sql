
CREATE FUNCTION [dbo].[ufn_GetStartDate_By_WeekNo_Year](
	
    @Year SMALLINT,
    @WeekNo TINYINT
  
)
RETURNS DATETIME
AS
BEGIN
    DECLARE @FirstMonday TINYINT
    DECLARE @Result DATETIME

    IF ISNULL(@WeekNo, 0)< 1 OR ISNULL(@Year, 0)<1900
    BEGIN
        SET @Result = NULL
    END
    ELSE
    BEGIN
        SET @FirstMonday = 1

        WHILE DATEPART(dw, CONVERT(DATETIME, '01/0' + CONVERT(VARCHAR ,@FirstMonday) + '/' + CONVERT(VARCHAR, @Year)))<>2
        BEGIN
            SET @FirstMonday = @FirstMonday + 1
        END

        SET @Result=CONVERT(DATETIME, '01/0' + CONVERT(VARCHAR, @FirstMonday) + '/' + CONVERT(VARCHAR, @Year))
        SET @Result=DATEADD(d,(@WeekNo-2)*7, @Result)

        IF DATEPART(yyyy,@Result)<>@Year
        BEGIN
            SET @Result= NULL
        END
    END
    RETURN @Result
END
