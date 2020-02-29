/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. provide for more effecient matching - a string cleaning function to remove special charactera and normalize some values
OBJECT TYPE	 : function
OBJECT NAME     : fn_GetNumeric
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161018
SOURCE		 : sqlauthority [ http://blog.sqlauthority.com/2008/10/14/sql-server-get-numeric-value-from-alpha-numeric-string-udf-for-get-numeric-numbers-only/ ]
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Miscellaneous Functions *****************************************************************
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_getnumeric]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_getnumeric]
GO

CREATE FUNCTION dbo.fn_getnumeric
                (
                @stralphanumeric varchar(256)
                )
RETURNS varchar(256)
AS
     BEGIN
         DECLARE
                @intalpha int;
         SET @intalpha = PATINDEX('%[^0-9]%', @stralphanumeric);
    BEGIN
        WHILE @intalpha > 0
            BEGIN
                SET @stralphanumeric = STUFF(@stralphanumeric, @intalpha, 1, '');
                SET @intalpha = PATINDEX('%[^0-9]%', @stralphanumeric);
            END;
    END;
         RETURN ISNULL(@stralphanumeric, 0);
     END;
GO

-- ****************** Miscellaneous Functions *****************************************************************