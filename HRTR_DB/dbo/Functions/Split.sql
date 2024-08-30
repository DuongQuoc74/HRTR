CREATE FUNCTION [dbo].[Split]
(
	@String		nvarchar(max), 
	@Delimiter	char(1)
)       
RETURNS @SplitTable TABLE ([OrderNo] int, [Items] nvarchar(4000))       
AS       
BEGIN      
	SET @String = LTRIM(RTRIM(@String)) 
    DECLARE @Idx		int,
			@OrderNo	int,
			@Slice		nvarchar(4000)    
      
    SELECT @Idx = 1       
	IF LEN(@String) < 1 or @String IS NULL RETURN       
    SET @OrderNo = 1
    WHILE @Idx != 0       
    BEGIN       
        SET @Idx = CHARINDEX(@Delimiter,@String)       
        IF @Idx!=0       
            SET @Slice = LEFT(@String, @Idx - 1)       
        ELSE       
            SET @Slice = @String       
          
        IF(LEN(@Slice)>0)  AND NOT EXISTS (SELECT 1
										FROM @SplitTable
										WHERE [Items] = @Slice)
		BEGIN						
            INSERT INTO @SplitTable([OrderNo], [Items]) 
            VALUES(@OrderNo, @Slice) 
            SET @OrderNo = @OrderNo + 1   
        END     
  
        SET @String = RIGHT(@String, LEN(@String) - @Idx)    
        
        IF LEN(@String) = 0 
			BREAK       
    END   
RETURN       
END
