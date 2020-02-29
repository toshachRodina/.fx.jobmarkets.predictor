/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. provide for more effecient matching - a string cleaning function to remove special charactera and normalize some values
OBJECT TYPE	 : function
OBJECT NAME     : fn_GetAlpha
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161027
SOURCE		 : sqlauthority [ http://stackoverflow.com/questions/13240298/remove-numbers-from-string-sql-server ]
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Miscellaneous Functions *****************************************************************

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_getalpha]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_getalpha]
GO

CREATE FUNCTION dbo.fn_getalpha
                (
                @stralphanumeric varchar(1000)
                )
RETURNS varchar(1000)
AS
     BEGIN

         DECLARE
                @keepvalues AS varchar(50);
         SET @keepvalues = '%[^a-z &,]%';
         WHILE PATINDEX(@keepvalues, @stralphanumeric) > 0
             SET @stralphanumeric = STUFF(@stralphanumeric, PATINDEX(@keepvalues, @stralphanumeric), 1, '');

         RETURN @stralphanumeric;
     END;

-- ****************** Miscellaneous Functions *****************************************************************

