/*
=======================================================================================================================================================================================================
SUBJECT		 : Function. Fuzzy Match / Grouping (Jaro Winkler)
OBJECT TYPE	 : function
OBJECT NAME  : [various]
CREATED BY	 : Harold Delaney
CREATED ON	 : 20160915
SOURCE		 : sqlservercentral [ http://www.sqlservercentral.com/articles/Fuzzy+Match/65702/ ]
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================
*/

-- ****************** Functions for Jaro **********************************************************************
if exists
          (
          select
                 *
          from
               sys.objects
          where object_id
                = OBJECT_ID(N'[dbo].[fn_GetCommonCharacters]')
                and type in(N'FN', N'IF', N'TF', N'FS', N'FT')
          )
    drop function
         [dbo].[fn_getcommoncharacters];
go
create function [dbo].fn_getcommoncharacters
                (
                @firstword   VARCHAR(MAX)
              , @secondword  VARCHAR(MAX)
              , @matchwindow INT
                )
returns VARCHAR(MAX)
as
     begin
         declare
                @commonchars VARCHAR(MAX);
         declare
                @copy VARCHAR(MAX);
         declare
                @char CHAR(1);
         declare
                @foundit BIT;
         declare
                @f1_len INT;
         declare
                @f2_len INT;
         declare
                @i INT;
         declare
                @j INT;
         declare
                @j_max INT;
         set @commonchars = '';
         if @firstword is not null
            and @secondword is not null
             begin
                 set @f1_len = LEN(@firstword);
                 set @f2_len = LEN(@secondword);
                 set @copy = @secondword;
                 set @i = 1;
                 while @i <
                       ( @f1_len
                         + 1 )
                     begin
                         set @char = SUBSTRING(@firstword, @i, 1);
                         set @foundit = 0;

                         -- Set J starting value
                         if @i
                            - @matchwindow
                            > 1
                             begin
                                 set @j = @i
                                          - @matchwindow;
                             end;
                         else
                             begin
                                 set @j = 1;
                             end;
                         -- Set J stopping value
                         if @i
                            + @matchwindow
                            <= @f2_len
                             begin
                                 set @j_max = @i
                                              + @matchwindow;
                             end;
                         else
                         if @f2_len
                            < @i
                              + @matchwindow
                             begin
                                 set @j_max = @f2_len;
                             end;
                         while @j <
                               ( @j_max
                                 + 1 )
                               and @foundit = 0
                             begin
                                 if SUBSTRING(@copy, @j, 1)
                                    = @char
                                     begin
                                         set @foundit = 1;
                                         set @commonchars = @commonchars
                                                            + @char;
                                         set @copy = STUFF(@copy, @j, 1, '#');
                                     end;
                                 set @j = @j
                                          + 1;
                             end;
                         set @i = @i
                                  + 1;
                     end;
             end;
         return @commonchars;
     end;
go
if exists
          (
          select
                 *
          from
               sys.objects
          where object_id
                = OBJECT_ID(N'[dbo].[fn_calculateMatchWindow]')
                and type in(N'FN', N'IF', N'TF', N'FS', N'FT')
          )
    drop function
         [dbo].[fn_calculatematchwindow];
go
create function [dbo].[fn_calculatematchwindow]
                (
                @s1_len INT
              , @s2_len INT
                )
returns INT
as
     begin
         declare
                @matchwindow INT;
         set @matchwindow = case
                                when @s1_len
                                     >= @s2_len
                                then
                                     ( @s1_len
                                       / 2 )
                                     - 1
                                else
                                     ( @s2_len
                                       / 2 )
                                     - 1
                            end;
         return @matchwindow;
     end;
go
if exists
          (
          select
                 *
          from
               sys.objects
          where object_id
                = OBJECT_ID(N'[dbo].[fn_calculateTranspositions]')
                and type in(N'FN', N'IF', N'TF', N'FS', N'FT')
          )
    drop function
         [dbo].[fn_calculatetranspositions];
go
create function [dbo].[fn_calculatetranspositions]
                (
                @s1_len INT
              , @str1   VARCHAR(MAX)
              , @str2   VARCHAR(MAX)
                )
returns INT
as
     begin
         declare
                @transpositions INT;
         declare
                @i INT;
         set @transpositions = 0;
         set @i = 0;
         while @i < @s1_len
             begin
                 if SUBSTRING(@str1, @i+1, 1)
                    <> SUBSTRING(@str2, @i+1, 1)
                     begin
                         set @transpositions = @transpositions
                                               + 1;
                     end;
                 set @i = @i
                          + 1;
             end;
         set @transpositions = @transpositions
                               / 2;
         return @transpositions;
     end;
go
if exists
          (
          select
                 *
          from
               sys.objects
          where object_id
                = OBJECT_ID(N'[dbo].[fn_calculateJaro]')
                and type in(N'FN', N'IF', N'TF', N'FS', N'FT')
          )
    drop function
         [dbo].[fn_calculatejaro];
go
create function [dbo].[fn_calculatejaro]
                (
                @str1 VARCHAR(MAX)
              , @str2 VARCHAR(MAX)
                )
returns FLOAT
as
     begin
         declare
                @common1 VARCHAR(MAX);
         declare
                @common2 VARCHAR(MAX);
         declare
                @common1_len INT;
         declare
                @common2_len INT;
         declare
                @s1_len INT;
         declare
                @s2_len INT;
         declare
                @transpose_cnt INT;
         declare
                @match_window INT;
         declare
                @jaro_distance FLOAT;
         set @transpose_cnt = 0;
         set @match_window = 0;
         set @jaro_distance = 0;
         set @s1_len = LEN(@str1);
         set @s2_len = LEN(@str2);
         set @match_window = dbo.fn_calculatematchwindow
             (@s1_len, @s2_len
             );
         set @common1 = dbo.fn_getcommoncharacters
             (@str1, @str2, @match_window
             );
         set @common1_len = LEN(@common1);
         if @common1_len = 0
            or @common1 is null
             begin
                 return 0;
             end;
         set @common2 = dbo.fn_getcommoncharacters
             (@str2, @str1, @match_window
             );
         set @common2_len = LEN(@common2);
         if @common1_len
            <> @common2_len
            or @common2 is null
             begin
                 return 0;
             end;
         set @transpose_cnt = dbo.[fn_calculatetranspositions]
             (@common1_len, @common1, @common2
             );
         set @jaro_distance = @common1_len
                              /
             ( 3.0
               * @s1_len )
                              + @common1_len
                              /
             ( 3.0
               * @s2_len )
                              +
             ( @common1_len
               - @transpose_cnt )
                              /
             ( 3.0
               * @common1_len );
         return @jaro_distance;
     end;
go
-- ****************** Functions for Jaro **********************************************************************
-- ****************** Functions for Jaro-Winkler ***************************************************************
if exists
          (
          select
                 *
          from
               sys.objects
          where object_id
                = OBJECT_ID(N'[dbo].[fn_calculatePrefixLength]')
                and type in(N'FN', N'IF', N'TF', N'FS', N'FT')
          )
    drop function
         [dbo].[fn_calculateprefixlength];
go
create function [dbo].[fn_calculateprefixlength]
                (
                @firstword  VARCHAR(MAX)
              , @secondword VARCHAR(MAX)
                )
returns INT
as
     begin
         declare
                @f1_len INT;
         declare
                @f2_len INT;
         declare
                @minprefixtestlength INT;
         declare
                @i INT;
         declare
                @n INT;
         declare
                @foundit BIT;
         set @minprefixtestlength = 4;
         if @firstword is not null
            and @secondword is not null
             begin
                 set @f1_len = LEN(@firstword);
                 set @f2_len = LEN(@secondword);
                 set @i = 0;
                 set @foundit = 0;
                 set @n = case
                              when @minprefixtestlength
                                   < @f1_len
                                   and @minprefixtestlength
                                       < @f2_len
                              then @minprefixtestlength
                              when @f1_len
                                   < @f2_len
                                   and @f1_len
                                       < @minprefixtestlength
                              then @f1_len
                              else @f2_len
                          end;
                 while @i < @n
                       and @foundit = 0
                     begin
                         if SUBSTRING(@firstword, @i+1, 1)
                            <> SUBSTRING(@secondword, @i+1, 1)
                             begin
                                 set @minprefixtestlength = @i;
                                 set @foundit = 1;
                             end;
                         set @i = @i
                                  + 1;
                     end;
             end;
         return @minprefixtestlength;
     end;
go
if exists
          (
          select
                 *
          from
               sys.objects
          where object_id
                = OBJECT_ID(N'[dbo].[fn_calculateJaroWinkler]')
                and type in(N'FN', N'IF', N'TF', N'FS', N'FT')
          )
    drop function
         [dbo].[fn_calculatejarowinkler];
go
create function [dbo].[fn_calculatejarowinkler]
                (
                @str1 VARCHAR(MAX)
              , @str2 VARCHAR(MAX)
                )
returns FLOAT
as
     begin
         declare
                @jaro_distance FLOAT;
         declare
                @jaro_winkler_distance FLOAT;
         declare
                @prefixlength INT;
         declare
                @prefixscalefactor FLOAT;
         set @prefixscalefactor = 0.1; --Constant = .1

         set @jaro_distance = dbo.fn_calculatejaro
             (@str1, @str2
             );
         set @prefixlength = dbo.fn_calculateprefixlength
             (@str1, @str2
             );
         set @jaro_winkler_distance = @jaro_distance
                                      +
             (
             ( @prefixlength
               * @prefixscalefactor )
             *
             ( 1.0
               - @jaro_distance ) );
         return @jaro_winkler_distance;
     end;
go
-- ****************** Functions for Jaro-Winkler ***************************************************************