-- ****************** Miscellaneous Functions *****************************************************************
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_SplitString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_SplitString]
GO

CREATE Function [dbo].[fn_SplitString](@p_delim varchar(20) = ' ', @p_string varchar(max), @p_idx int) 
RETURNS VARCHAR(MAX) as 
    BEGIN
          DECLARE @ix int,
                      @pos int,
                    @rt varchar(max)

          DECLARE @tb TABLE (Val varchar(max), id int identity(1,1))

          SET @ix = 1
          SET @pos = 1


          WHILE @ix <= LEN(@p_string) + 1 BEGIN

                SET @ix = CHARINDEX(@p_delim, @p_string, @ix)

                IF @ix = 0
                      SET @ix = LEN(@p_string)
                ELSE
                      SET @ix = @ix - 1

                INSERT INTO @tb
                SELECT SUBSTRING(@p_string, @pos, @ix - @pos + 1)

                SET @ix = @ix + 2
                SET @pos = @ix
          END

          SELECT @Rt = Val FROM @Tb WHERE id = @p_idx
          RETURN @Rt     
    END
GO
-- ****************** Miscellaneous Functions *****************************************************************
