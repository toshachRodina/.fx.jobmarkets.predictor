/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. provide for more effecient matching - a string cleaning function to remove special charactera and normalize some values
OBJECT TYPE	 : function
OBJECT NAME     : fn_CleanString
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161030
SOURCE		 : sqlauthority [ http://iso30-sql.blogspot.com.au/2010/10/remove-non-printable-unicode-characters.html ]
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Miscellaneous Functions *****************************************************************

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_cleanstring]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_cleanstring]
GO

set ansi_nulls on
go
set quoted_identifier on
go

CREATE FUNCTION dbo.fn_cleanstring
                (
                @stralphanumeric varchar(max)
                )
RETURNS varchar(max)
AS
     BEGIN
         DECLARE
                @iptr AS int;
         SET @iptr = PATINDEX('%[^ -~0-9A-Z]%', @stralphanumeric COLLATE latin1_general_bin);
         WHILE @iptr > 0
             BEGIN
                 SET @stralphanumeric = REPLACE(@stralphanumeric COLLATE latin1_general_bin, SUBSTRING(@stralphanumeric, @iptr, 1), '');
                 SET @iptr = PATINDEX('%[^ -~0-9A-Z]%', @stralphanumeric COLLATE latin1_general_bin);
             END;
         RETURN @stralphanumeric;
     END;

-- ****************** Miscellaneous Functions *****************************************************************