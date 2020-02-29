/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. loops through a string to return the first letter of each word in string
OBJECT TYPE	 : function
OBJECT NAME     : fn_GetFirstLetter
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170104
SOURCE		 : stackoverflow [ http://stackoverflow.com/questions/4865360/sql-to-pick-apart-a-string-of-a-persons-name-and-output-the-initials ]
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Miscellaneous Functions *****************************************************************

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_getlastletters]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_getlastletters]
GO

CREATE FUNCTION dbo.[fn_getlastletters]
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