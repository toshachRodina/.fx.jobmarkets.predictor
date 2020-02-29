/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. returns a quasi code for a multiword string (a type of unique key for a phrase_
OBJECT TYPE	 : function
OBJECT NAME     : fn_uniquestringcode
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170104
SOURCE		 : 
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Miscellaneous Functions *****************************************************************

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_uniquestringcode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_uniquestringcode]
GO

CREATE FUNCTION dbo.[fn_uniquestringcode]
                (
                 @string varchar(max) -- Variable for string
			 ,@number_of_letters int -- number of first letters in string to return (eg. ('HAPPY DAYS',3) returns HAPDAY
                )
RETURNS varchar(max)

     BEGIN
         DECLARE
                @xml xml;
         DECLARE
                @firstletter varchar(max);
         DECLARE
                @delimiter varchar(5);

         SET @delimiter = ' ';
         SET @xml = CAST(
                         ('<a>'+REPLACE(@string, @delimiter, '</a><a>')+'</a>'
                         ) AS xml);

         WITH cte
              AS (SELECT a.value( '.', 'varchar(max)' ) AS [column]
                         FROM
                              @xml.nodes( 'a' ) AS fn(a))
              SELECT @firstletter = STUFF(
                     (
                         SELECT ''+RIGHT([column], @number_of_letters)
                                FROM
                                     cte
                                FOR xml PATH('')
                     ), 1, 0, '');

         RETURN
               (@firstletter
               );
     END;
GO