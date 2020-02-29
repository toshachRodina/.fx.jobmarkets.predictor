/*
=======================================================================================================================================================================================================
SUBJECT		 : Stored Procedure - generic stored proc which takes in a number of variables and then runs a specific mssql stored procedure
OBJECT TYPE	 : STORED PROCEDURE
OBJECT NAME	 : ltn.dbo.sp_call_sql_script
CREATED BY	 : Harold Delaney
CREATED ON	 : 20160822
SOURCE		 : 
PREPERATION	 : 
REMARKS		 : 1) primarily for use with SSIS packages - easy call to stored procedure and parameter passing
			   2)
			   3)
 
=======================================================================================================================================================================================================

exec [dbo].sp_call_sql_script @p_env = 'PROD' ,@p_task_nme = 'CREATE_F_DTL_LABOUR_FORCE_STATUS_M' ,@p_pkg_nme = 'LTN_PKG_LABOUR_FORCE_STATUS_M'

*/


USE [ltn]
--use [master]
--USE [ltnfx]
GO

IF OBJECT_ID('[dbo].sp_call_sql_script') IS NULL -- Check if SP Exists
 EXEC('CREATE PROCEDURE [dbo].sp_call_sql_script AS SET NOCOUNT ON;') -- Create dummy/empty SP
GO


ALTER PROCEDURE [dbo].sp_call_sql_script -- Alter the SP Always
(
 @p_env                   nvarchar (10) 
,@p_task_nme              nvarchar (100) 
,@p_pkg_nme               nvarchar (100)
) 
AS

BEGIN

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

--raiserror ('START pi_sp_call_sql_script',0,0);

    declare @l_tbl_nme as nvarchar (50);
    declare @l_sp_call as nvarchar (50);
    
    set @l_tbl_nme = replace(@p_task_nme,'_SQL','') ;
    set @l_sp_call = @l_tbl_nme ;


    --Display what we're running
    raiserror (@l_sp_call, 0, 0) ;

    exec @l_sp_call @p_env = @p_env
	             , @p_task_nme = @p_task_nme
			   , @p_pkg_nme = @p_pkg_nme


--raiserror ('END pi_sp_call_sql_script',0,0);

end
