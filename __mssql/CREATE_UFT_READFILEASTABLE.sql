/*
=======================================================================================================================================================================================================
SUBJECT		 : reads data from system text file as table
OBJECT TYPE	 : FUNCTION
OBJECT NAME	 : dbo.uft_ReadFileAsTable
CREATED BY	 : Harold Delaney
CREATED ON	 : 20171123
SOURCE		 : 
PREPERATION	 : 
REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================

exec uft_ReadFileAsTable 'TEST AGAIN' , 'D:\Sync\__lanoitan_docs\@db_bak\','sqlbak.log'
*/

USE LTN
--USE [ltnfx]
GO

IF OBJECT_ID('[dbo].uft_ReadFileAsTable') IS NOT NULL -- Check if SP Exists
 EXEC('DROP function [dbo].uft_ReadFileAsTable') -- DROP IF FUNCTION EXISTS
GO

create FUNCTION [dbo].uft_ReadFileAsTable
(
@Path VARCHAR(255),
@Filename VARCHAR(100)
)
RETURNS 
@File TABLE
(
[LineNo] int identity(1,1), 
line varchar(8000)) 

AS
BEGIN


DECLARE @objfilesystem   int
      , @objtextstream   int
      , @objerrorobject  int
      , @strerrormessage varchar(1000)
      , @command         varchar(1000)
      , @hr              int
      , @string          varchar(8000)
      , @yesorno         int;

SELECT @strerrormessage = 'opening the File System Object';

EXECUTE @hr = SP_OACREATE 'Scripting.FileSystemObject'
                        , @objfilesystem OUT;

IF @hr = 0
   BEGIN
      SELECT @objerrorobject = @objfilesystem
           , @strerrormessage = 'Opening file "'+@path+'\'+@filename+'"'
           , @command = @path+'\'+@filename
   END;

IF @hr = 0
   BEGIN
      EXECUTE @hr = SP_OAMETHOD @objfilesystem
                              , 'OpenTextFile'
                              , @objtextstream OUT
                              , @command
                              , 1
                              , FALSE
                              , 0--for reading, FormatASCII
   END;

WHILE @hr = 0
   BEGIN
      IF @hr = 0
         BEGIN
            SELECT @objerrorobject = @objtextstream
                 , @strerrormessage = 'finding out if there is more to read in "'+@filename+'"'
         END;
      IF @hr = 0
         BEGIN
            EXECUTE @hr = SP_OAGETPROPERTY @objtextstream
                                         , 'AtEndOfStream'
                                         , @yesorno OUTPUT
         END;

      IF @yesorno <> 0
         BEGIN
            BREAK
         END;
      IF @hr = 0
         BEGIN
            SELECT @objerrorobject = @objtextstream
                 , @strerrormessage = 'reading from the output file "'+@filename+'"'
         END;
      IF @hr = 0
         BEGIN
            EXECUTE @hr = SP_OAMETHOD @objtextstream
                                    , 'Readline'
                                    , @string OUTPUT
         END;
      INSERT INTO @file ( LINE )
      SELECT @string;
   END;
   
IF @hr = 0
   BEGIN
      SELECT @objerrorobject = @objtextstream
           , @strerrormessage = 'closing the output file "'+@filename+'"'
   END;

IF @hr = 0
   BEGIN
      EXECUTE @hr = SP_OAMETHOD @objtextstream
                              , 'Close'
   END;

IF @hr <> 0
   BEGIN
      DECLARE @source      varchar(255)
            , @description varchar(255)
            , @helpfile    varchar(255)
            , @helpid      int;

      EXECUTE SP_OAGETERRORINFO @objerrorobject
                              , @source OUTPUT
                              , @description OUTPUT
                              , @helpfile OUTPUT
                              , @helpid OUTPUT;
      SELECT @strerrormessage = 'Error whilst '+coalesce(@strerrormessage, 'doing something')+', '+coalesce(@description, '');
      INSERT INTO @file ( LINE )
      SELECT @strerrormessage;
   END;

EXECUTE  sp_OADestroy @objTextStream
	-- Fill the table variable with the rows for your result set
	
RETURN 
END
