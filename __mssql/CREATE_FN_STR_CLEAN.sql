/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. provide for more effecient matching - a string cleaning function to remove special charactera and normalize some values
OBJECT TYPE	 : function
OBJECT NAME  : fn_StrClean
CREATED BY	 : Harold Delaney
CREATED ON	 : 20160915
SOURCE		 : sqlservercentral [ http://www.sqlservercentral.com/articles/Fuzzy+Match/65702/ ]
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Miscellaneous Functions *****************************************************************
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_StrClean]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_StrClean]
GO

CREATE Function [dbo].[fn_StrClean](@p_str1 VARCHAR(MAX)) 
RETURNS VARCHAR(MAX) as 
BEGIN 
 DECLARE @ret_value VARCHAR(MAX)
 SET @ret_value = @p_str1
 SET @ret_value = ltrim(rtrim(REPLACE(@ret_value, '.', '')))
 SET @ret_value = ltrim(rtrim(REPLACE(@ret_value, ',', ''))) 
 SET @ret_value = ltrim(rtrim(REPLACE(@ret_value, '-', ''))) 
 SET @ret_value = ltrim(rtrim(REPLACE(@ret_value, ';', ''))) 
 SET @ret_value = ltrim(rtrim(REPLACE(@ret_value, ':', ''))) 
 SET @ret_value = ltrim(rtrim(REPLACE(@ret_value, '  ', ' '))) 
 
 RETURN @ret_value
END
GO
-- ****************** Miscellaneous Functions *****************************************************************
