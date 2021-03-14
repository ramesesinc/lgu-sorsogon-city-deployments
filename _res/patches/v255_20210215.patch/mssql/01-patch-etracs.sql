
/*==================================
** V2.5.04.030
==================================*/
if not exists(select * from sys_rulegroup where name = 'AFTER-SUMMARY' and ruleset = 'landassessment')
begin 
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER-SUMMARY', 'landassessment', 'After Summary Computation', '105');
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER-SUMMARY', 'bldgassessment', 'After Summary Computation', '105');
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER-SUMMARY', 'machassessment', 'After Summary Computation', '105');
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER-SUMMARY', 'miscassessment', 'After Summary Computation', '105');
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER-SUMMARY', 'planttreeassessment', 'After Summary Computation', '105');
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('MUASSESSLEVEL', 'machassessment', 'Actual Use Assess Level Computation', '50');
  INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('MUASSESSEDVALUE', 'machassessment', 'Actual Use Assessed Value Computation', '55');

end 
go 


UPDATE sys_rulegroup SET name='INITIAL', ruleset='machassessment', title='Initial Computation', sortorder='0' WHERE (name='INITIAL') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='BASEMARKETVALUE', ruleset='machassessment', title='Machine Base Market Value Computation', sortorder='5' WHERE (name='BASEMARKETVALUE') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='AFTER-BASEMARKETVALUE', ruleset='machassessment', title='After Machine Base Market Value Computation', sortorder='10' WHERE (name='AFTER-BASEMARKETVALUE') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='DEPRECIATION', ruleset='machassessment', title='Machine Depreciation Computation', sortorder='11' WHERE (name='DEPRECIATION') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='AFTER-DEPRECIATION', ruleset='machassessment', title='After Machine Depreciation Computation', sortorder='12' WHERE (name='AFTER-DEPRECIATION') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='MARKETVALUE', ruleset='machassessment', title='Machine Market Value Computation', sortorder='25' WHERE (name='MARKETVALUE') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='AFTER-MARKETVALUE', ruleset='machassessment', title='After Machine Market Value Computation', sortorder='30' WHERE (name='AFTER-MARKETVALUE') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='ASSESSLEVEL', ruleset='machassessment', title='Machine Assess Level Computation', sortorder='35' WHERE (name='ASSESSLEVEL') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='AFTER-ASSESSLEVEL', ruleset='machassessment', title='After Machine Assess Level Computation', sortorder='36' WHERE (name='AFTER-ASSESSLEVEL') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='ASSESSEDVALUE', ruleset='machassessment', title='Machine Assessed Value Computation', sortorder='40' WHERE (name='ASSESSEDVALUE') AND (ruleset='machassessment')
go 
UPDATE sys_rulegroup SET name='AFTER-ASSESSEDVALUE', ruleset='machassessment', title='After Machine Assessed Value Computation', sortorder='45' WHERE (name='AFTER-ASSESSEDVALUE') AND (ruleset='machassessment')
go 



IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'info' AND Object_ID = Object_ID(N'rpt_redflag'))
begin 
	alter table rpt_redflag add info text
end 
go 


IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'addlinfo' AND Object_ID = Object_ID(N'bldguse'))
BEGIN
    alter table bldguse add addlinfo varchar(255)
END
go 

IF NOT EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'provrecommender_objid' AND Object_ID = Object_ID(N'faas_signatory'))
BEGIN
  alter table faas_signatory add provrecommender_objid varchar(50);
  alter table faas_signatory add provrecommender_name  varchar(100);
  alter table faas_signatory add provrecommender_title varchar(50);
  alter table faas_signatory add provrecommender_dtsigned  datetime;
  alter table faas_signatory add provrecommender_taskid  varchar(50);
end 
go 

if exists(SELECT * FROM sys.indexes 
					WHERE name='ix_subdividedland_newtdno' AND object_id = OBJECT_ID('subdividedland'))
begin 
	drop index subdividedland.ix_subdividedland_newtdno
end  
go 


if exists(SELECT * FROM sys.indexes 
					WHERE name='ix_subdividedland_administrator_name' AND object_id = OBJECT_ID('subdividedland'))
begin 
	drop index subdividedland.ix_subdividedland_administrator_name
end 


if exists(SELECT * FROM sys.indexes 
					WHERE name='fk_subdividedland_newrpu' AND object_id = OBJECT_ID('subdividedland'))
begin 
	drop index subdividedland.fk_subdividedland_newrpu
end  
go 


if exists(SELECT * FROM sys.indexes 
					WHERE name='fk_subdividedland_faas' AND object_id = OBJECT_ID('subdividedland'))
begin 
	drop index subdividedland.fk_subdividedland_faas
end  
go 


IF EXISTS (SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK__subdivide__newrp__587208C1]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[subdividedland]'))
BEGIN
	alter table subdividedland drop constraint FK__subdivide__newrp__587208C1
END
go  


IF EXISTS (SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK__subdivide__newrp__587208C1]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[subdividedland]'))
BEGIN
	alter table subdividedland drop constraint FK__subdivide__newrp__587208C1
END
go  

IF EXISTS (SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK__subdivide__newfa__5689C04F]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[subdividedland]'))
BEGIN
	alter table subdividedland drop constraint FK__subdivide__newfa__5689C04F
END
go  

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'itemno' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column itemno varchar(10) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtdno' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newtdno  varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newutdno' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newutdno varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtitletype' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newtitletype varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtitleno' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newtitleno varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtitledate' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newtitledate varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'areasqm' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column areasqm  decimal(16,6) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'areaha' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column areaha decimal(16,6) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'memoranda' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column memoranda  varchar(500)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administrator_objid' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column administrator_objid  varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administrator_name' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column administrator_name varchar(200)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administrator_address' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column administrator_address  varchar(200)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'taxpayer_objid' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column taxpayer_objid varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'taxpayer_name' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column taxpayer_name  varchar(200)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'taxpayer_address' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column taxpayer_address varchar(200)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'owner_name' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column owner_name varchar(200)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'owner_address' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column owner_address  varchar(200)  null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newrpuid' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newrpuid varchar(50) null
END 

go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newfaasid' AND Object_ID = Object_ID(N'subdividedland'))
BEGIN
  alter table subdividedland alter column newfaasid  varchar(50) null
END 
go 


 

if exists(SELECT * FROM sys.indexes 
					WHERE name='txntype_objid' AND object_id = OBJECT_ID('consolidation'))
begin 
	drop index consolidation.txntype_objid
end  
go 

if exists(SELECT * FROM sys.indexes 
					WHERE name='ix_consolidation_newtdno' AND object_id = OBJECT_ID('consolidation'))
begin 
	drop index consolidation.ix_consolidation_newtdno
end  
go 

if exists(SELECT * FROM sys.indexes 
					WHERE name='fk_consolidation_newrp' AND object_id = OBJECT_ID('consolidation'))
begin 
	drop index consolidation.fk_consolidation_newrp
end  
go 

IF EXISTS (SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID('FK__consolida__newrp__07970BFE') 
             AND parent_object_id = OBJECT_ID('consolidation'))
BEGIN
	alter table consolidation drop constraint FK__consolida__newrp__07970BFE
END
go  


if exists(SELECT * FROM sys.indexes 
					WHERE name='fk_consolidation_newrpu' AND object_id = OBJECT_ID('consolidation'))
begin 
	drop index consolidation.fk_consolidation_newrpu
end  
go 

IF EXISTS (SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID('FK__consolida__newrp__088B3037') 
             AND parent_object_id = OBJECT_ID('consolidation'))
BEGIN
	alter table consolidation drop constraint FK__consolida__newrp__088B3037
END
go  



if exists(SELECT * FROM sys.indexes 
					WHERE name='fk_consolidation_newfaas' AND object_id = OBJECT_ID('consolidation'))
begin 
	drop index consolidation.fk_consolidation_newfaas
end  
go 

IF EXISTS (SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID('FK__consolida__newfa__06A2E7C5') 
             AND parent_object_id = OBJECT_ID('consolidation'))
BEGIN
	alter table consolidation drop constraint FK__consolida__newfa__06A2E7C5
END
go  



IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'txndate' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column txndate datetime null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'txntype_objid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column txntype_objid varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'autonumber' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column autonumber  integer null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'effectivityyear' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column effectivityyear integer null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'effectivityqtr' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column effectivityqtr  integer null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtdno' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newtdno varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newutdno' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newutdno  varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtitletype' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newtitletype  varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtitleno' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newtitleno  varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newtitledate' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newtitledate  varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'memoranda' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column memoranda text null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'lguid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column lguid varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'lgutype' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column lgutype varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newrpid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newrpid varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newrpuid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newrpuid  varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'newfaasid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column newfaasid varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'taxpayer_objid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column taxpayer_objid  varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'taxpayer_name' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column taxpayer_name text null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'taxpayer_address' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column taxpayer_address  varchar(200) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'owner_name' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column owner_name  text null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'owner_address' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column owner_address varchar(200) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administrator_objid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column administrator_objid varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administrator_name' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column administrator_name  varchar(500) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administrator_address' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column administrator_address varchar(200) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administratorid' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column administratorid varchar(50) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administratorname' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column administratorname varchar(500) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'administratoraddress' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column administratoraddress  varchar(200) null
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'signatories' AND Object_ID = Object_ID(N'consolidation'))
BEGIN
  alter table consolidation alter column signatories varchar(500) null
END
go 

/* v2.5.04.030b */

/* DROP DEFAULT CONSTRAINT */
IF OBJECT_ID (N'dbo.ufn_getDropDefaultConstraintStatement', N'FN') IS NOT NULL
    DROP FUNCTION dbo.ufn_getDropDefaultConstraintStatement
GO

CREATE FUNCTION dbo.ufn_getDropDefaultConstraintStatement (@table_name varchar(100), @col_name varchar(100))
RETURNS varchar(1000)
WITH EXECUTE AS CALLER
AS
BEGIN
  declare @Command  nvarchar(1000)

  select @Command = 'ALTER TABLE ' + @table_name + ' drop constraint ' + d.name
   from sys.tables t   
    join    sys.default_constraints d       
     on d.parent_object_id = t.object_id  
    join    sys.columns c      
     on c.object_id = t.object_id      
      and c.column_id = d.parent_column_id
   where t.name = @table_name
    and c.name = @col_name
  return @command 
END
GO


IF EXISTS(SELECT * FROM sys.indexes 
      WHERE name='ix_rptledger_statebrgy' AND object_id = OBJECT_ID('rptledger '))
BEGIN 
  drop index rptledger.ix_rptledger_statebrgy
end 



IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'firstqtrpaidontime' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column firstqtrpaidontime int null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'qtrlypaymentavailed' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column qtrlypaymentavailed int null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'qtrlypaymentpaidontime' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column qtrlypaymentpaidontime int null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'lastitemyear' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column lastitemyear int null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'lastreceiptid' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column lastreceiptid varchar(50)  null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'advancebill' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column advancebill int null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'lastbilledyear' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column lastbilledyear int null 
END
go 
IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'lastbilledqtr' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column lastbilledqtr int null 
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialbasic' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  declare @command varchar(1000)
  set @command = dbo.ufn_getDropDefaultConstraintStatement('rptledger', 'partialbasic')
  if @command is not null 
  begin 
    print '-> ' + @command 
    execute(@command);
  end 
  alter table rptledger alter column partialbasic decimal(16,2) null;
END
go 


IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialbasicint' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  declare @command varchar(1000)
  set @command = dbo.ufn_getDropDefaultConstraintStatement('rptledger', 'partialbasicint')
  if @command is not null 
  begin 
    execute(@command)
  end 
  alter table rptledger alter column partialbasicint decimal(16,2) null
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialbasicdisc' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  declare @command varchar(1000)
  set @command = dbo.ufn_getDropDefaultConstraintStatement('rptledger', 'partialbasicdisc')
  if @command is not null 
  begin 
    execute(@command)
  end 
  alter table rptledger alter column partialbasicdisc decimal(16,2) null
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialsef' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  declare @command varchar(1000)
  set @command = dbo.ufn_getDropDefaultConstraintStatement('rptledger', 'partialsef')
  if @command is not null 
  begin 
    execute(@command)
  end 
  alter table rptledger alter column partialsef decimal(16,2) null
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialsefint' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  declare @command varchar(1000)
  set @command = dbo.ufn_getDropDefaultConstraintStatement('rptledger', 'partialsefint')
  if @command is not null 
  begin 
    execute(@command)
  end 
  alter table rptledger alter column partialsefint decimal(16,2) null
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialsefdisc' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  declare @command varchar(1000)
  set @command = dbo.ufn_getDropDefaultConstraintStatement('rptledger', 'partialsefdisc')
  if @command is not null 
  begin 
    execute(@command)
  end 
  alter table rptledger alter column partialsefdisc decimal(16,2) null
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialledyear' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column partialledyear int null
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'partialledqtr' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger alter column partialledqtr int null 
END
go 


IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'updateflag' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger add updateflag varchar(50)
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'forcerecalcbill' AND Object_ID = Object_ID(N'rptledger'))
BEGIN
  alter table rptledger add forcerecalcbill int
END
go 



update rptledger set 
    nextbilldate = null, forcerecalcbill = 0, updateflag = objid 
where forcerecalcbill is null
go 


IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basic' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basic decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicpaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicpaid decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicint' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicint  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicintpaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicintpaid  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicdisc' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicdisc decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicdisctaken' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicdisctaken  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicidle' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicidle decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicidlepaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicidlepaid decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicidledisc' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicidledisc decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicidledisctaken' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicidledisctaken  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicidleint' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicidleint  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'basicidleintpaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add basicidleintpaid  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'sef' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add sef decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'sefpaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add sefpaid decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'sefint' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add sefint  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'sefintpaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add sefintpaid  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'sefdisc' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add sefdisc decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'sefdisctaken' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add sefdisctaken  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'firecode' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add firecode  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'firecodepaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add firecodepaid  decimal(16,2) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'revperiod' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add revperiod varchar(50) null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'qtrly' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add qtrly integer null
END
go 

IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'fullypaid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem add fullypaid integer null
END
go 



update rptledgeritem set 
  fullypaid = paid,
  basic = 0.0,
  basicpaid = 0.0,
  basicint = 0.0,
  basicintpaid = 0.0,
  basicdisc = 0.0,
  basicdisctaken = 0.0,
  basicidle = 0.0,
  basicidlepaid = 0.0,
  basicidledisc = 0.0,
  basicidledisctaken = 0.0,
  basicidleint = 0.0,
  basicidleintpaid = 0.0,
  sef = 0.0,
  sefpaid = 0.0,
  sefint = 0.0,
  sefintpaid = 0.0,
  sefdisc = 0.0,
  sefdisctaken = 0.0,
  firecode = 0.0,
  firecodepaid = 0.0
where basic is null;



IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'paidqtr' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem drop column paidqtr
END
go 

IF EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'paid' AND Object_ID = Object_ID(N'rptledgeritem'))
BEGIN
  alter table rptledgeritem drop column paid
END
go 



IF  EXISTS (SELECT * FROM sys.objects 
            WHERE object_id = OBJECT_ID('rptledgeritem_qtrly') AND type in ('U'))
BEGIN
  drop table rptledgeritem_qtrly
END
go 


create table rptledgeritem_qtrly (
  objid varchar(50) not null,
  parentid varchar(50) not null,
  rptledgerid varchar(50) not null,
  basicav decimal(16,2) not null,
  sefav decimal(16,2) not null,
  av decimal(16,2) not null,
  year integer not null,
  qtr integer not null,
  basic decimal(16,2) not null,
  basicpaid decimal(16,2) not null,
  basicint decimal(16,2) not null,
  basicintpaid decimal(16,2) not null,
  basicdisc decimal(16,2) not null,
  basicdisctaken decimal(16,2) not null,
  basicidle decimal(16,2) not null,
  basicidlepaid decimal(16,2) not null,
  basicidledisc decimal(16,2) not null,
  basicidledisctaken decimal(16,2) not null,
  basicidleint decimal(16,2) not null,
  basicidleintpaid decimal(16,2) not null,
  sef decimal(16,2) not null,
  sefpaid decimal(16,2) not null,
  sefint decimal(16,2) not null,
  sefintpaid decimal(16,2) not null,
  sefdisc decimal(16,2) not null,
  sefdisctaken decimal(16,2) not null,
  firecode decimal(16,2) not null,
  firecodepaid decimal(16,2) not null,
  revperiod varchar(50) default null,
  partialled integer not null,
  fullypaid integer not null,
  primary key  (objid)
)
go 

  
create index FK_rptledgeritemqtrly_rptledgeritem on rptledgeritem_qtrly(parentid)
go 

create index FK_rptledgeritemqtrly_rptledger on rptledgeritem_qtrly(rptledgerid)
go 

create index ix_rptledgeritemqtrly_year on rptledgeritem_qtrly(year)
go 


alter table rptledgeritem_qtrly 
  add constraint FK_rptledgeritemqtrly_rptledger 
  foreign key (rptledgerid) references rptledger (objid)
go 

alter table rptledgeritem_qtrly 
  add constraint FK_rptledgeritemqtrly_rptledgeritem 
  foreign key (parentid) references rptledgeritem (objid)
go 




IF not EXISTS(SELECT * FROM sys.columns 
            WHERE Name = N'rptledgeritemqtrlyid' AND Object_ID = Object_ID(N'cashreceiptitem_rpt_online'))
BEGIN
  alter table cashreceiptitem_rpt_online add rptledgeritemqtrlyid varchar(50)
END
go 


IF not EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID('FK_cashreceiptitem_rpt_online_rptledgeritemqtrly') 
             AND parent_object_id = OBJECT_ID('cashreceiptitem_rpt_online'))
BEGIN
  alter table cashreceiptitem_rpt_online 
    add constraint FK_cashreceiptitem_rpt_online_rptledgeritemqtrly foreign key(rptledgeritemqtrlyid)
    references rptledgeritem_qtrly(objid)

END
go 


IF EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID('rptbill_ledger_account') AND type in (N'U'))

BEGIN
  DROP TABLE rptbill_ledger_account;
  DROP TABLE rptbill_ledger_item;
  DROP TABLE rptbill_ledger;
END
go 


IF not EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID('rptbill_ledger') AND type in (N'U'))
begin 

  CREATE TABLE rptbill_ledger (
    rptledgerid varchar(50) NOT NULL default '',
    billid varchar(50) NOT NULL default '',
    updateflag varchar(50),
    PRIMARY KEY  (rptledgerid,billid)
  );

  create index ix_rptbill_ledgter_rptbillid on  rptbill_ledger(billid);
  create index ix_rptbill_ledgter_rptledgerid on  rptbill_ledger(rptledgerid);

  alter table rptbill_ledger 
  add CONSTRAINT FK_rptbillledger_rptledger 
  FOREIGN KEY (rptledgerid) REFERENCES rptledger (objid);

  alter table rptbill_ledger 
  add CONSTRAINT FK_rptbillledger_rptbill 
  FOREIGN KEY (billid) REFERENCES rptbill(objid);

end
go 


IF not EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID('rptbill_ledger_account') AND type in (N'U'))
begin 

  CREATE TABLE rptbill_ledger_account (
    objid varchar(50) NOT NULL,
    billid varchar(50) NOT NULL,
    rptledgerid varchar(50) NOT NULL,
    revperiod varchar(25) NOT NULL,
    revtype varchar(25) NOT NULL,
    item_objid varchar(50) NOT NULL,
    amount decimal(16,4) NOT NULL,
    sharetype varchar(25) NOT NULL,
    discount decimal(16,4) default NULL,
    PRIMARY KEY  (objid)
  );


  create index ix_rptbill_ledger_account_rptledger on rptbill_ledger_account(rptledgerid);
  create index ix_rptbillledgeraccount_revenueitem on rptbill_ledger_account(item_objid);
  create index FK_rptbillledgeraccount_rptbill on rptbill_ledger_account(billid);


  alter table rptbill_ledger_account 
  add CONSTRAINT FK_rptbillledgeraccount_rptbill 
  FOREIGN KEY (billid) REFERENCES rptbill (objid);

  alter table rptbill_ledger_account 
  add CONSTRAINT rptbill_ledger_account_ibfk_1 
  FOREIGN KEY (item_objid) REFERENCES itemaccount (objid);


  alter table rptbill_ledger_account 
  add CONSTRAINT rptbill_ledger_account_ibfk_2 
  FOREIGN KEY (rptledgerid) REFERENCES rptledger (objid);

end 
go 


IF not EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID('rptbill_ledger_item') AND type in (N'U'))
begin 
  CREATE TABLE rptbill_ledger_item (
    objid varchar(75) NOT NULL,
    billid varchar(50) NOT NULL,
    rptledgerid varchar(50) NOT NULL,
    rptledgeritemid varchar(50) NULL,
    rptledgeritemqtrlyid varchar(50) NULL,
    rptledgerfaasid varchar(50) NOT NULL,
    av decimal(16,2) default NULL,
    basicav decimal(16,2) default NULL,
    sefav decimal(16,2) default NULL,
    year integer NOT NULL,
    qtr integer NOT NULL,
    basic decimal(16,2) NOT NULL,
    basicint decimal(16,2) NOT NULL,
    basicdisc decimal(16,2) NOT NULL,
    sef decimal(16,2) NOT NULL,
    sefint decimal(16,2) NOT NULL,
    sefdisc decimal(16,2) NOT NULL,
    firecode decimal(10,2) default NULL,
    revperiod varchar(25) default NULL,
    basicnet decimal(16,2) default NULL,
    sefnet decimal(16,2) default NULL,
    total decimal(16,2) default NULL,
    partialled integer NOT NULL,
    basicidle decimal(16,2) default NULL,
    basicidledisc decimal(16,2) default NULL,
    basicidleint decimal(16,2) default NULL,
    taxdifference integer default NULL,
    PRIMARY KEY  (objid)  
  );

  create index FK_rptbillledgeritem_rptledger on rptbill_ledger_item(rptledgerid);
  create index FK_rptbillledgeritem_rptledgerfaas on rptbill_ledger_item(rptledgerfaasid);
  create index FK_rptbillledgeritem_rptledgeritem on rptbill_ledger_item(rptledgeritemid);
  create index FK_rptbillledgeritem_rptledgeritemqtrly on rptbill_ledger_item(rptledgeritemqtrlyid);
  create index FK_rptbillledgeritem_rptbill on rptbill_ledger_item(billid);

  alter table rptbill_ledger_item
  add CONSTRAINT FK_rptbillledgeritem_rptbill 
  FOREIGN KEY (billid) REFERENCES rptbill (objid);

  alter table rptbill_ledger_item
  add CONSTRAINT FK_rptbillledgeritem_rptledger 
  FOREIGN KEY (rptledgerid) REFERENCES rptledger (objid);

  alter table rptbill_ledger_item
  add CONSTRAINT FK_rptbillledgeritem_rptledgerfaas 
  FOREIGN KEY (rptledgerfaasid) REFERENCES rptledgerfaas (objid);

  alter table rptbill_ledger_item
  add CONSTRAINT FK_rptbillledgeritem_rptledgeritem 
  FOREIGN KEY (rptledgeritemid) REFERENCES rptledgeritem(objid);

  alter table rptbill_ledger_item
  add CONSTRAINT FK_rptbillledgeritem_rptledgeritemqtrly 
  FOREIGN KEY (rptledgeritemqtrlyid) REFERENCES rptledgeritem_qtrly (objid);


end 
go 


if not exists(select * from sys_usergroup_permission where objid = 'LANDTAX.ADMIN-add_new_ledger_faas')
begin 
  INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('LANDTAX.ADMIN-add_new_ledger_faas', 'LANDTAX.ADMIN', 'rptledger', 'add_new_ledger_faas', 'Add New Ledger FAAS');
  INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('LANDTAX.ADMIN-change_faas_reference', 'LANDTAX.ADMIN', 'rptledger', 'change_faas_reference', 'Change FAAS Reference');
  INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('LANDTAX.ADMIN-fix_ledger_faas', 'LANDTAX.ADMIN', 'rptledger', 'fix_ledger_faas', 'Fix Ledger FAAS');
end 
go 




/* DROP DEFAULT CONSTRAINT */
IF OBJECT_ID (N'dbo.ufn_getDropDefaultConstraintStatement', N'FN') IS NOT NULL
    DROP FUNCTION dbo.ufn_getDropDefaultConstraintStatement
GO

/* v2504031 */

/* CONSOLIDATOIN / SUBDIVISION SUPPORT */
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID('subdivision_consolidatedland') AND type in (N'U'))
BEGIN
  drop table subdivision_consolidatedland 
END
go 



IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID('subdivision_motherland') AND type in (N'U'))
BEGIN
  drop table subdivision_motherland
END
go 



CREATE TABLE subdivision_motherland (
  objid varchar(50) NOT NULL,
  subdivisionid varchar(50) NOT NULL,
  landfaasid varchar(50) NOT NULL,
  rpuid varchar(50) NOT NULL,
  rpid varchar(50) NOT NULL,
  PRIMARY KEY  (objid),
  CONSTRAINT FK_subdivision_motherland_faas FOREIGN KEY (landfaasid) REFERENCES faas (objid),
  CONSTRAINT FK_subdivison_motherland_subdivision FOREIGN KEY (subdivisionid) REFERENCES subdivision (objid)
) 
go

create index FK_consolidatedland_faas on subdivision_motherland(landfaasid)
go 
create index FK_consolidatedland_subdivision on subdivision_motherland(subdivisionid)
go 
   



alter table subdivision alter column motherfaasid varchar(50) null
go 



alter table faas alter column prevav varchar(200) null
go 
alter table faas alter column prevmv varchar(200) null
go 
alter table faas alter column prevareaha varchar(200) null
go 
alter table faas alter column prevareasqm varchar(200) null
go 



insert  into subdivision_motherland(
  objid,
  subdivisionid,
  landfaasid,
  rpuid,
  rpid
)
select 
  s.objid,
  s.objid as subdivisionid,
  s.motherfaasid as landfaasid,
  f.rpuid,
  f.realpropertyid as rpid
from subdivision s 
  inner join faas f on s.motherfaasid = f.objid
go 



/* v2.5.04.032 */
INSERT INTO faas_txntype (objid, name, newledger, newrpu, newrealproperty, displaycode, allowEditOwner, checkbalance, allowEditPin, allowEditPinInfo, allowEditAppraisal, opener) VALUES ('CA', 'Change Administrator', '0', '0', '0', 'DP', '0', '1', '0', '0', '1', NULL)
go 


CREATE TABLE cancelledfaas_task (
  objid varchar(50) NOT NULL primary key,
  refid varchar(50) NOT NULL,
  parentprocessid varchar(50) NULL,
  state varchar(50) NULL,
  startdate datetime  NULL,
  enddate datetime  NULL,
  assignee_objid varchar(50)  NULL,
  assignee_name varchar(100)  NULL,
  assignee_title varchar(80)  NULL,
  actor_objid varchar(50)  NULL,
  actor_name varchar(100)  NULL,
  actor_title varchar(80)  NULL,
  message varchar(255)  NULL,
  signature text
)
go 

create index ix_refid  on cancelledfaas_task(refid)
go

alter table cancelledfaas_task 
  add CONSTRAINT FK_cancelledfaas_task_cancelledfaas 
	FOREIGN KEY (refid) REFERENCES cancelledfaas (objid)
go 


create table cancelledfaas_signatory (
  objid varchar(50) not null,
  taxmapper_objid varchar(50) null,
  taxmapper_name varchar(100) null,
  taxmapper_title varchar(50) null,
  taxmapper_dtsigned datetime null,
  taxmapper_taskid varchar(50) null,
  taxmapperchief_objid varchar(50) null,
  taxmapperchief_name varchar(100) null,
  taxmapperchief_title varchar(50) null,
  taxmapperchief_dtsigned datetime null,
  taxmapperchief_taskid varchar(50) null,
  appraiser_objid varchar(50) null,
  appraiser_name varchar(150) null,
  appraiser_title varchar(50) null,
  appraiser_dtsigned datetime null,
  appraiser_taskid varchar(50) null,
  appraiserchief_objid varchar(50) null,
  appraiserchief_name varchar(100) null,
  appraiserchief_title varchar(50) null,
  appraiserchief_dtsigned datetime null,
  appraiserchief_taskid varchar(50) null,
  recommender_objid varchar(50) null,
  recommender_name varchar(100) null,
  recommender_title varchar(50) null,
  recommender_dtsigned datetime null,
  recommender_taskid varchar(50) null,
  provtaxmapper_objid varchar(50) null,
  provtaxmapper_name varchar(100) null,
  provtaxmapper_title varchar(50) null,
  provtaxmapper_dtsigned datetime null,
  provtaxmapper_taskid varchar(50) null,
  provtaxmapperchief_objid varchar(50) null,
  provtaxmapperchief_name varchar(100) null,
  provtaxmapperchief_title varchar(50) null,
  provtaxmapperchief_dtsigned datetime null,
  provtaxmapperchief_taskid varchar(50) null,
  provappraiser_objid varchar(50) null,
  provappraiser_name varchar(100) null,
  provappraiser_title varchar(50) null,
  provappraiser_dtsigned datetime null,
  provappraiser_taskid varchar(50) null,
  provappraiserchief_objid varchar(50) null,
  provappraiserchief_name varchar(100) null,
  provappraiserchief_title varchar(50) null,
  provappraiserchief_dtsigned datetime null,
  provappraiserchief_taskid varchar(50) null,
  approver_objid varchar(50) null,
  approver_name varchar(100) null,
  approver_title varchar(50) null,
  approver_dtsigned datetime null,
  approver_taskid varchar(50) null,
  provapprover_objid varchar(50) null,
  provapprover_name varchar(100) null,
  provapprover_title varchar(50) null,
  provapprover_dtsigned datetime null,
  provapprover_taskid varchar(50) null,
  provrecommender_objid varchar(50) null,
  provrecommender_name varchar(100) null,
  provrecommender_title varchar(50) null,
  provrecommender_dtsigned datetime null,
  provrecommender_taskid varchar(50) null,
  primary key  (objid)
) 
go 


alter table cancelledfaas_signatory 
  add constraint FK_cancelledfaas_signatory_cancelled_faas 
  foreign key (objid) references cancelledfaas (objid)
go 


alter table cancelledfaas alter column reason_objid varchar(50) null
go 

alter table cancelledfaas alter column remarks text null
go 


alter table cancelledfaas add [online] int null
go 

update cancelledfaas set [online] = 0 where [online] is null
go 

alter table cancelledfaas add lguid varchar(50)
go 
alter table cancelledfaas add lasttaxyear int
go 


delete from sys_wf_transition where processname = 'cancelledfaas';
delete from sys_wf_node where processname = 'cancelledfaas';

INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('start', 'cancelledfaas', 'Start', 'start', '1', NULL, 'RPT', NULL);
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-receiver', 'cancelledfaas', 'Assign Receiver', 'state', '2', '0', 'RPT', 'RECEIVER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('receiver', 'cancelledfaas', 'Review and Verification', 'state', '5', NULL, 'RPT', 'RECEIVER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-examiner', 'cancelledfaas', 'For Examination', 'state', '10', NULL, 'RPT', 'EXAMINER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('examiner', 'cancelledfaas', 'Examination', 'state', '15', NULL, 'RPT', 'EXAMINER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-taxmapper', 'cancelledfaas', 'For Taxmapping', 'state', '20', NULL, 'RPT', 'TAXMAPPER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('taxmapper', 'cancelledfaas', 'Taxmapping', 'state', '25', NULL, 'RPT', 'TAXMAPPER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-provtaxmapperchief', 'cancelledfaas', 'For Taxmapping Approval', 'state', '25', '0', 'RPT', 'TAXMAPPER_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-taxmapping-approval', 'cancelledfaas', 'For Taxmapper Chief Approval', 'state', '30', NULL, 'RPT', 'TAXMAPPER_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('provtaxmapperchief', 'cancelledfaas', 'Taxmapping Chief Approval', 'state', '35', NULL, 'RPT', 'TAXMAPPER_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('taxmapper_chief', 'cancelledfaas', 'Taxmapping Approval', 'state', '35', NULL, 'RPT', 'TAXMAPPER_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-appraiser', 'cancelledfaas', 'For Appraisal', 'state', '40', NULL, 'RPT', 'APPRAISER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('appraiser', 'cancelledfaas', 'Appraisal', 'state', '45', NULL, 'RPT', 'APPRAISER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-appraisal-chief', 'cancelledfaas', 'For Appraisal Chief Approval', 'state', '50', NULL, 'RPT', 'APPRAISAL_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('appraiser_chief', 'cancelledfaas', 'Appraisal Chief Approval', 'state', '55', NULL, 'RPT', 'APPRAISAL_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('provappraiserchief', 'cancelledfaas', 'Appraisal Chief Approval', 'state', '55', NULL, 'RPT', 'APPRAISAL_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-recommender', 'cancelledfaas', 'For Recommending Approval', 'state', '70', NULL, 'RPT', 'RECOMMENDER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-provrecommender', 'cancelledfaas', 'For Recommending Approval', 'state', '71', NULL, 'RPT', 'RECOMMENDER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('recommender', 'cancelledfaas', 'Recommending Approval', 'state', '75', NULL, 'RPT', 'RECOMMENDER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('provrecommender', 'cancelledfaas', 'Recommending Approval', 'state', '76', NULL, 'RPT', 'RECOMMENDER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-approver', 'cancelledfaas', 'For Assessor Approval', 'state', '80', NULL, 'RPT', 'APPROVER,ASSESSOR');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('approver', 'cancelledfaas', 'Assessor Approval', 'state', '85', NULL, 'RPT', 'APPROVER,ASSESSOR');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-provtaxmapper', 'cancelledfaas', 'For Taxmapping', 'state', '200', '0', 'RPT', 'TAXMAPPER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-provappraiserchief', 'cancelledfaas', 'For Appraisal Chief Approval', 'state', '201', '0', 'RPT', 'APPRAISAL_CHIEF');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('provtaxmapper', 'cancelledfaas', 'Taxmapping', 'state', '205', '0', 'RPT', 'TAXMAPPER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-provappraiser', 'cancelledfaas', 'For Appraisal', 'state', '210', '0', 'RPT', 'APPRAISER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('provappraiser', 'cancelledfaas', 'Appraisal', 'state', '215', '0', 'RPT', 'APPRAISER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-provapprover', 'cancelledfaas', 'For Provincial Assessor Approval', 'state', '220', '0', 'RPT', 'APPROVER');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('provapprover', 'cancelledfaas', 'Provincial Assessor Approval', 'state', '230', NULL, 'RPT', 'APPROVER,ASSESSOR');
INSERT INTO [sys_wf_node] ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('end', 'cancelledfaas', 'End', 'end', '1000', NULL, 'RPT', NULL);

INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('start', 'cancelledfaas', NULL, 'receiver', '1', NULL, NULL, NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('receiver', 'cancelledfaas', 'delete', 'end', '5', NULL, '[caption:''Delete'', confirm:''Delete record?'', closeonend:true]', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('receiver', 'cancelledfaas', 'submit', 'assign-taxmapper', '16', NULL, '[caption:''Submit for Taxmapping'', confirm:''Submit for taxmapping?'', messagehandler:''default'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('assign-taxmapper', 'cancelledfaas', NULL, 'taxmapper', '20', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('taxmapper', 'cancelledfaas', 'return_receiver', 'receiver', '25', NULL, '[caption:''Return to Receiver'',confirm:''Return to receiver?'',messagehandler:''default'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('taxmapper', 'cancelledfaas', 'submit', 'assign-recommender', '27', NULL, '[caption:''Submit for Recommending Approval'', confirm:''Submit?'', messagehandler:''rptmessage:create'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('assign-recommender', 'cancelledfaas', NULL, 'recommender', '70', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('recommender', 'cancelledfaas', 'return_appraiser', 'appraiser', '72', NULL, '[caption:''Return to Appraiser'',confirm:''Return to appraiser?'', messagehandler:''default'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('recommender', 'cancelledfaas', 'return_taxmapper', 'taxmapper', '73', NULL, '[caption:''Return to Taxmapper'',confirm:''Return to taxmapper?'', messagehandler:''default'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('recommender', 'cancelledfaas', 'submit_approver', 'assign-approver', '74', NULL, '[caption:''Submit for Assessor Approval'', confirm:''Submit to assessor approval?'', messagehandler:''default'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('recommender', 'cancelledfaas', 'submit_to_province', 'approver', '75', NULL, '[caption:''Submit to Province'', confirm:''Submit to Province?'', messagehandler:''rptmessage:create'']', NULL);
INSERT INTO [sys_wf_transition] ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission]) VALUES ('approver', 'cancelledfaas', 'approve', 'end', '110', NULL, '[caption:''Manually Approve'',confirm:''Manually approve cancellation?'', visible:false]', NULL);


alter table subdivision add mothertdnos varchar(1000)
go 
alter table subdivision add motherpins varchar(1000)
go 


create index ix_subdivision_mothertdnos on subdivision(mothertdnos)
go 
create index ix_subdivision_motherpins on subdivision(motherpins)
go 

update s set 
	s.mothertdnos = f.tdno,
	s.motherpins = f.fullpin
from subdivision s, subdivision_motherland sm, faas f  
where s.objid = sm.subdivisionid
  and sm.landfaasid = f.objid 
  and  1 = (select count(*) from subdivision_motherland 
			      where subdivisionid = s.objid )
go 



alter table rptledger add administrator_name varchar(150)
go 



create index ix_rptledger_administartorname on rptledger(administrator_name)
go 

update rl set 
	rl.administrator_name = f.administrator_name
from  rptledger rl, faas f
where rl.faasid = f.objid
go 

			      	

create table bldgrpu_assessment
(
	objid varchar(50) primary key,
	bldgrpuid varchar(50) not null,
	actualuse_objid varchar(50) not null, 
	marketvalue numeric(16,2) not null,
	assesslevel numeric(16,2) not null,
	assessedvalue numeric(16,2) not null
);

alter table bldgrpu_assessment 
	add constraint FK_bldgrpuassessment_rpu foreign key (bldgrpuid)
	references bldgrpu(objid);


alter table bldgrpu_assessment 
	add constraint FK_bldgrpuassessment_bldgassesslevel foreign key (actualuse_objid)
	references bldgassesslevel(objid);

create index ix_bldgrpuassessment_bldgrpuid on bldgrpu_assessment(bldgrpuid);
create index ix_bldgrpuassessment_actualuseid on bldgrpu_assessment(actualuse_objid);


alter table bldguse alter column  assesslevel numeric(16,2) null;
alter table bldguse alter column  assessedvalue numeric(16,2) null;


/* v2.5.04.032-03004 */
create table faas_list(
	objid varchar(50) primary key, 
	state varchar(30) not null, 
	rpuid varchar(50) not null, 
	realpropertyid varchar(50) not null, 
	datacapture int not null,
	ry int not null, 
	txntype_objid varchar(50) not null, 
	tdno varchar(25), 
	utdno varchar(25) not null, 
	prevtdno text, 
	displaypin varchar(35) not null, 
	pin varchar(35) not null, 
	taxpayer_objid varchar(50) , 
	owner_name text , 
	owner_address varchar(150) , 
	administrator_name varchar(150), 
	administrator_address varchar(150), 
	rputype varchar(10) not null, 
	barangayid varchar(50) not null, 
	barangay varchar(75) not null, 
	classification_objid varchar(50) , 
	classcode varchar(20), 
	cadastrallotno text, 
	blockno varchar(100), 
	surveyno varchar(255), 
	titleno varchar(50), 
	totalareaha decimal(16,6) not null , 
	totalareasqm decimal(16,6) not null, 
	totalmv decimal(16,2) not null, 
	totalav decimal(16,2) not null, 
	effectivityyear int not null, 
	effectivityqtr int not null, 
	cancelreason varchar(15), 
	cancelledbytdnos text, 
	lguid varchar(50) not null, 
	originlguid varchar(50) not null, 
	yearissued int,
	taskid varchar(50),
	taskstate varchar(50),
	assignee_objid varchar(50),
	trackingno varchar(20)
)
go 


create index ix_faaslist_state on faas_list(state)
go 
create index ix_faaslist_rpuid on faas_list(rpuid)
go 
create index ix_faaslist_realpropertyid on faas_list(realpropertyid)
go 
create index ix_faaslist_ry on faas_list(ry)
go 
create index ix_faaslist_tdno on faas_list(tdno)
go 
create index ix_faaslist_utdno on faas_list(utdno)
go 
create index ix_faaslist_pin on faas_list(pin)
go 
create index ix_faaslist_taxpayer_objid on faas_list(taxpayer_objid)
go 
create index ix_faaslist_administrator_name on faas_list(administrator_name)
go 
create index ix_faaslist_rputype on faas_list(rputype)
go 
create index ix_faaslist_barangayid on faas_list(barangayid)
go 
create index ix_faaslist_barangay on faas_list(barangay)
go 
create index ix_faaslist_classification_objid on faas_list(classification_objid)
go 
create index ix_faaslist_classcode on faas_list(classcode)
go 
create index ix_faaslist_blockno on faas_list(blockno)
go 
create index ix_faaslist_surveyno on faas_list(surveyno)
go 
create index ix_faaslist_titleno on faas_list(titleno)
go 
create index ix_faaslist_lguid on faas_list(lguid)
go 
create index ix_faaslist_originlguid on faas_list(originlguid)
go 
create index ix_faaslist_taskstate on faas_list(taskstate)
go 
create index ix_faaslist_trackingno on faas_list(trackingno)
go 
create index ix_faaslist_assigneeid on faas_list(assignee_objid)
go 




insert into faas_list(
	objid,
	state,
	datacapture,
	rpuid,
	realpropertyid,
	ry,
	txntype_objid,
	tdno,
	utdno,
	prevtdno,
	displaypin,
	pin,
	taxpayer_objid,
	owner_name,
	owner_address,
	administrator_name,
	administrator_address,
	rputype,
	barangayid,
	barangay,
	classification_objid,
	classcode,
	cadastrallotno,
	blockno,
	surveyno,
	titleno,
	totalareaha,
	totalareasqm,
	totalmv,
	totalav,
	effectivityyear,
	effectivityqtr,
	cancelreason,
	cancelledbytdnos,
	lguid,
	originlguid,
	yearissued,
	taskid,
	taskstate,
	assignee_objid,
	trackingno
)
select 
	f.objid,
	f.state,
	f.datacapture, 
	f.rpuid,
	f.realpropertyid,
	r.ry,
	f.txntype_objid,
	f.tdno,
	f.utdno,
	f.prevtdno,
	f.fullpin as displaypin,
	case when r.rputype = 'land' then rp.pin else concat(rp.pin, '-', r.suffix) end as pin,
	f.taxpayer_objid,
	f.owner_name,
	f.owner_address,
	f.administrator_name,
	f.administrator_address,
	r.rputype,
	rp.barangayid,
	(select name from barangay where objid = rp.barangayid) as barangay,
	r.classification_objid,
	pc.code as classcode,
	rp.cadastrallotno,
	rp.blockno,
	rp.surveyno,
	f.titleno,
	r.totalareaha,
	r.totalareasqm,
	r.totalmv,
	r.totalav,
	f.effectivityyear,
	f.effectivityqtr,
	f.cancelreason,
	f.cancelledbytdnos,
	f.lguid,
	f.originlguid,
	f.year as yearissued,
	(select top 1 objid from faas_task where refid = f.objid and enddate is null) as taskid,
	(select top 1 state from faas_task where refid = f.objid and enddate is null) as taskstate,
	(select top 1 assignee_objid from faas_task where refid = f.objid and enddate is null) as assignee_objid,
	(select trackingno from rpttracking where objid = f.objid) as trackingno
from faas f 
	inner join rpu r on f.rpuid = r.objid 
	inner join realproperty rp on f.realpropertyid = rp.objid 
	inner join propertyclassification pc on r.classification_objid = pc.objid 
where not exists(select * from faas_list where objid = f.objid);
go 



		
    /* v2.5.04.032-03005 */

alter table rpt_changeinfo add refid varchar(50)
go 

update rpt_changeinfo set refid = faasid where refid is null
go 



/* LEDGER RESTRICTION SUPPORT */
create table rptledger_restriction
(
	objid varchar(50) not null,
	parentid varchar(50) not null, 
	restrictionid varchar(50) not null,
	remarks varchar(150),
	primary key (objid)
)
GO 


alter table rptledger_restriction 
	add constraint FK_rptledger_restriction_rptledger 
	foreign key(parentid) references rptledger(objid)
GO 

create unique index ux_rptledger_restriction on rptledger_restriction(parentid, restrictionid)
GO 

/* v2.5.04.032-03006 */
alter table cancelledfaas add txnno varchar(25) null
go
create index ix_cancelledfaas_txnno on cancelledfaas(txnno)
go 



delete from sys_wf_transition where processname = 'cancelledfaas'
go 

INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('start', 'cancelledfaas', NULL, 'receiver', '1', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('receiver', 'cancelledfaas', 'delete', 'end', '5', NULL, '[caption:''Delete'', confirm:''Delete record?'', closeonend:true]', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('receiver', 'cancelledfaas', 'submit', 'assign-taxmapper', '16', NULL, '[caption:''Submit for Taxmapping'', confirm:''Submit for taxmapping?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('assign-taxmapper', 'cancelledfaas', NULL, 'taxmapper', '20', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('taxmapper', 'cancelledfaas', 'return_receiver', 'receiver', '25', NULL, '[caption:''Return to Receiver'',confirm:''Return to receiver?'',messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('taxmapper', 'cancelledfaas', 'submit', 'assign-recommender', '27', NULL, '[caption:''Submit for Recommending Approval'', confirm:''Submit?'', messagehandler:''rptmessage:create'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('assign-recommender', 'cancelledfaas', NULL, 'recommender', '70', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'return_appraiser', 'appraiser', '72', NULL, '[caption:''Return to Appraiser'',confirm:''Return to appraiser?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'return_taxmapper', 'taxmapper', '73', NULL, '[caption:''Return to Taxmapper'',confirm:''Return to taxmapper?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'submit_approver', 'assign-approver', '74', NULL, '[caption:''Submit for Assessor Approval'', confirm:''Submit to assessor approval?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'submit_to_province', 'approver', '75', NULL, '[caption:''Submit to Province'', confirm:''Submit to Province?'', messagehandler:''rptmessage:create'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('assign-approver', 'cancelledfaas', NULL, 'approver', '80', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('approver', 'cancelledfaas', 'approve', 'end', '110', NULL, '[caption:''Manually Approve'',confirm:''Manually approve cancellation?'', visible:false]', NULL)
go 



update fl set 
	fl.state = f.state,
	fl.tdno = f.tdno,
	fl.utdno = f.utdno, 
	fl.prevtdno = f.prevtdno, 
	fl.displaypin = f.fullpin, 
	fl.pin = case when r.rputype = 'land' then rp.pin else (rp.pin + '-' + convert(varchar(4),r.suffix)) end, 
	fl.taxpayer_objid = f.taxpayer_objid,
	fl.owner_name = f.owner_name,
	fl.owner_address = f.taxpayer_objid,
	fl.administrator_name = f.administrator_name,
	fl.administrator_address = f.administrator_address,
	fl.barangayid = b.objid, 
	fl.barangay = b.name, 
	fl.classification_objid = r.classification_objid,
	fl.classcode = pc.code, 
	fl.cadastrallotno = rp.cadastrallotno, 
	fl.blockno = rp.blockno,
	fl.surveyno = rp.surveyno,
	fl.titleno = f.titleno,
	fl.totalareaha = r.totalareaha,
	fl.totalareasqm = r.totalareasqm,
	fl.totalmv = r.totalmv,
	fl.totalav = r.totalav,
	fl.effectivityyear = f.effectivityyear,
	fl.effectivityqtr = f.effectivityqtr,
	fl.cancelreason = f.cancelreason,
	fl.cancelledbytdnos = f.cancelledbytdnos,
	fl.taskid = (select top 1 objid from faas_task where refid = f.objid and enddate is null) ,
	fl.taskstate = (select top 1 state from faas_task where refid = f.objid and enddate is null) ,
	fl.assignee_objid = (select top 1 assignee_objid from faas_task where refid = f.objid and enddate is null) ,
	fl.trackingno = (select top 1 trackingno from rpttracking where objid = f.objid) 
from faas_list fl, faas f, rpu r, propertyclassification pc, realproperty rp, barangay b 
where fl.objid = f.objid 
and f.rpuid = r.objid 
and f.realpropertyid = rp.objid 
and rp.barangayid = b.objid 
and r.classification_objid = pc.objid
go 



/* PUBLIC LAND */

alter table landrpu add publicland int
go 
update landrpu set publicland = 0 where publicland = null
go 

alter table faas_list add publicland int
go 
update faas_list set publicland = 0 where publicland = null
go 

create index ix_faaslist_publicland on faas_list(publicland)
go 

	

alter table rpt_redflag alter column message varchar(1000)
go 
alter table rpt_redflag alter column remarks varchar(1000)
go 
alter table rpt_redflag alter column info varchar(1500)
go 	


/* v2.5.04.032-03007 */
/**********************************************************
** ufn_getDropDefaultConstraintStatement
**********************************************************/
IF OBJECT_ID (N'dbo.ufn_getDropDefaultConstraintStatement', N'FN') IS NOT NULL
    DROP FUNCTION dbo.ufn_getDropDefaultConstraintStatement
GO

CREATE FUNCTION dbo.ufn_getDropDefaultConstraintStatement (@table_name varchar(100), @col_name varchar(100))
RETURNS varchar(1000)
WITH EXECUTE AS CALLER
AS
BEGIN
  declare @Command  varchar(1000)

  select @Command = 'ALTER TABLE ' + @table_name + ' drop constraint ' + d.name
   from sys.tables t   
    join    sys.default_constraints d       
     on d.parent_object_id = t.object_id  
    join    sys.columns c      
     on c.object_id = t.object_id      
      and c.column_id = d.parent_column_id
   where t.name = @table_name
    and c.name = @col_name
  return @command 
END
GO



/**********************************************************
** ufn_getForeignKeyDropStatement
**********************************************************/

IF OBJECT_ID (N'dbo.ufn_getForeignKeyDropStatement', N'FN') IS NOT NULL
    DROP FUNCTION dbo.ufn_getForeignKeyDropStatement
GO

CREATE FUNCTION dbo.ufn_getForeignKeyDropStatement(@table_name varchar(100), @col_name varchar(100)
)
RETURNS varchar(1000)
WITH EXECUTE AS CALLER
AS
BEGIN
	declare @command  varchar(1000)
	
	select @command = 'ALTER TABLE ' + @table_name + ' DROP CONSTRAINT ' + fk.name
	from sys.foreign_keys  fk, sys.foreign_key_columns fkc
	where fk.object_id = fkc.constraint_object_id
	 and fk.parent_object_id = OBJECT_ID(@table_name) 
	 and COL_NAME(fkc.parent_object_id, fkc.parent_column_id) = @col_name
	 
	return @command 
END
GO

declare @command varchar(1000)

set @command = dbo.ufn_getDropDefaultConstraintStatement('subdivisionaffectedrpu', 'prevfaasid')
if @command is not null execute(@command)

set @command = dbo.ufn_getForeignKeyDropStatement('subdivisionaffectedrpu', 'prevfaasid')
if @command is not null execute(@command)
GO 


alter table subdivisionaffectedrpu alter column prevfaasid varchar(50) null
GO 

alter table subdivisionaffectedrpu alter column prevtdno varchar(50) null
GO 

alter table subdivisionaffectedrpu alter column prevpin varchar(50) null
go 



/*===========================================*/
/* SUBDIVISION - CANCEL IMPROVEMENTS SUPPORT */
/*===========================================*/

create table subdivision_cancelledimprovement(
  objid varchar(50) not null,
  parentid varchar(50) not null,
  faasid varchar(50),
  remarks varchar(1000),
  primary key (objid)
)
go 

alter table subdivision_cancelledimprovement 
  add constraint FK_subdivision_cancelledimprovement_subdivision
  foreign key (parentid) references subdivision(objid)
go 

alter table subdivision_cancelledimprovement 
  add constraint FK_subdivision_cancelledimprovement_faas
  foreign key (faasid) references faas(objid)
go 



/*===========================================*/
/* MACHRPU - ADD BLDG REFERENCE  */
/*===========================================*/
alter table machrpu add bldgmaster_objid varchar(50)
go 



/*===========================================*/
/* STRUCTURE UPDATE */
/*===========================================*/
alter table structure add showinfaas int null
go 
update structure set showinfaas = 1 where showinfaas is null
go 



/*===========================================*/
/* STEWARDSHIP SUPPORT */
/*===========================================*/
alter table realproperty add stewardshipno varchar(3) 
go 
alter table faas add parentfaasid varchar(50) 
go 

INSERT INTO faas_txntype (objid, name, newledger, newrpu, newrealproperty, displaycode, allowEditOwner, checkbalance, allowEditPin, allowEditPinInfo, allowEditAppraisal, opener) 
VALUES ('ST', 'Stewardship', '1', '1', '1', 'DP', '1', '0', '0', '1', '1', '')
go 

INSERT INTO faas_txntype (objid, name, newledger, newrpu, newrealproperty, displaycode, allowEditOwner, checkbalance, allowEditPin, allowEditPinInfo, allowEditAppraisal, opener) 
VALUES ('STP', 'Stewardship', '0', '1', '1', 'DP', '0', '0', '0', '0', '1', '')
go 


create table faas_stewardship
(
  objid varchar(50),
  rpumasterid varchar(50) not null, 
  stewardrpumasterid varchar(50) not null,
  ry int not null, 
  stewardshipno int not null,
  primary key(objid)
) 
go 

create unique index ux_faas_stewardship on faas_stewardship(rpumasterid, stewardrpumasterid, ry, stewardshipno)
go 
create index ix_faas_stewardship_rpumasterid on faas_stewardship(rpumasterid)
go 
create index ix_faas_stewardship_stewardrpumasterid on faas_stewardship(stewardrpumasterid)
go 



/*=========================================================
* RESTRICTED PROPERTY
*=========================================================*/
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) 
VALUES ('LANDTAX.REPORT.restricted-property.generate', 'LANDTAX.REPORT', 'restricted-property', 'generate', 'Generate List of Restricted Properties')
go 


/* v2.5.04.032-03008 */

create table faas_restriction_type
(
	objid varchar(50),
	name varchar(100) not null,
	idx int not null,
	isother int not null,
	primary key(objid)
)
go 


INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('BOUNDARY_CONFLICT', 'Boundary Conflict', '4', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('BSP_GSP', 'BSP / GSP', '9', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('CARP', 'Under CARP', '1', '0')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('RED_AREAS', 'Red Areas', '3', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('RP_NIA', 'RP / NIA', '5', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('TELECOM', 'Telecom', '6', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('UNDER_LITIGATION', 'Under Litigation', '2', '0')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('UNDETERMINED', 'Undermined', '7', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('UNLOCATED_OWNER', 'Unlocated Owner', '8', '1')
go 
INSERT INTO faas_restriction_type (objid, name, idx, isother) VALUES ('RESTRICTED', 'Restricted', '9', '1')
go 


INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) 
VALUES ('RPT.REPORT-faas-titled-report-viewreport', 'RPT.REPORT', 'faas-titled-report', 'viewreport', 'View Report')
go 



alter table subdivision_cancelledimprovement add lasttaxyear int
go 
alter table subdivision_cancelledimprovement add lguid varchar(50)
go 
alter table subdivision_cancelledimprovement add reason_objid varchar(50)
go 



/* RPTLEDGER: add blockno info */
alter table rptledger add blockno varchar(50)
go 

create index ix_rptledger_blockno on rptledger(blockno)
go 

update rl set 
	rl.blockno = rp.blockno
from rptledger rl, faas f, realproperty rp
where rl.faasid = f.objid and f.realpropertyid = rp.objid
go 



/* PC and DT txn types */
INSERT INTO faas_txntype (objid, name, newledger, newrpu, newrealproperty, displaycode, allowEditOwner, checkbalance, allowEditPin, allowEditPinInfo, allowEditAppraisal, opener) VALUES ('PC', 'Physical Obsolence', '0', '1', '0', 'PC', '0', '0', '0', '0', '1', NULL)
go 
INSERT INTO faas_txntype (objid, name, newledger, newrpu, newrealproperty, displaycode, allowEditOwner, checkbalance, allowEditPin, allowEditPinInfo, allowEditAppraisal, opener) VALUES ('DT', 'Destruction of Property', '0', '1', '0', 'DT', '0', '0', '0', '0', '1', NULL)
go 




alter table faas_txntype add reconcileledger int 
GO 
update faas_txntype set reconcileledger = 1 where reconcileledger is null
go 

INSERT INTO faas_txntype (objid, name, newledger, newrpu, newrealproperty, displaycode, allowEditOwner, checkbalance, allowEditPin, allowEditPinInfo, allowEditAppraisal, opener, reconcileledger) VALUES ('UK', 'Unknown to Known', '1', '1', '1', 'DP', '1', '0', '0', '0', '1', NULL, '0')
go 
update faas_txntype set reconcileledger = 0 where objid = 'UK'
go 




/* CANCELLED FAAS */

alter table cancelledfaas add originlguid varchar(50)
go 

update cancelledfaas set originlguid = lguid where originlguid is null
go 


delete from sys_wf_transition where processname = 'cancelledfaas'
go 	

    
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('start', 'cancelledfaas', '', 'receiver', '1', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('receiver', 'cancelledfaas', 'delete', 'end', '5', NULL, '[caption:''Delete'', confirm:''Delete record?'', closeonend:true]', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('receiver', 'cancelledfaas', 'submit', 'assign-taxmapper', '16', NULL, '[caption:''Submit for Taxmapping'', confirm:''Submit for taxmapping?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('assign-taxmapper', 'cancelledfaas', '', 'taxmapper', '20', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('taxmapper', 'cancelledfaas', 'return_receiver', 'receiver', '25', NULL, '[caption:''Return to Receiver'',confirm:''Return to receiver?'',messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('taxmapper', 'cancelledfaas', 'submit', 'assign-recommender', '27', NULL, '[caption:''Submit for Recommending Approval'', confirm:''Submit?'', messagehandler:''rptmessage:create'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('assign-recommender', 'cancelledfaas', '', 'recommender', '70', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'return_receiver', 'receiver', '71', NULL, '[caption:''Return to Receiver'',confirm:''Return to receiver?'', messagehandler:''default'']', '')
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'return_appraiser', 'appraiser', '72', NULL, '[caption:''Return to Appraiser'',confirm:''Return to appraiser?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'return_taxmapper', 'taxmapper', '73', NULL, '[caption:''Return to Taxmapper'',confirm:''Return to taxmapper?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'submit_approver', 'assign-approver', '74', NULL, '[caption:''Submit for Assessor Approval'', confirm:''Submit to assessor approval?'', messagehandler:''default'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('recommender', 'cancelledfaas', 'submit_to_province', 'approver', '75', NULL, '[caption:''Submit to Province'', confirm:''Submit to Province?'', messagehandler:''rptmessage:create'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('assign-approver', 'cancelledfaas', '', 'approver', '80', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL)
go 
INSERT INTO sys_wf_transition (parentid, processname, action, [to], idx, eval, properties, permission) VALUES ('approver', 'cancelledfaas', 'approve', 'end', '110', NULL, '[caption:''Manually Approve'',confirm:''Manually approve cancellation?'']', NULL)
go 




update sys_wf_transition set action = '' where action is null
go 


alter table sys_wf_transition alter column action  varchar(50) not null
go 

-- recreate sys_wf_transition primary key
DECLARE @table nvarchar(512)
declare @sql nvarchar(MAX)

SELECT @table = N'sys_wf_transition'

SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.key_constraints
    WHERE [type] = 'PK'
    AND [parent_object_id] = OBJECT_ID(@table)

EXEC sp_executeSQL @sql
go 


alter table sys_wf_transition add primary key(processname, parentid, [action], [to])
go 



/* insert rptledger restrictions */
insert into rptledger_restriction(objid, parentid, restrictionid, remarks)
select distinct f.objid, rlf.rptledgerid, f.restrictionid, null 
from faas f 
    inner join rptledgerfaas rlf on f.objid = rlf.faasid 
where f.restrictionid is not null 
and not exists(select * from rptledger_restriction where parentid = rlf.rptledgerid and restrictionid = f.restrictionid)
go 


/* v2.5.04.032-03009 */

/*============================================
**
** RPT TRANSMITTAL UPDATES 
**
============================================*/
drop table rpttransmittal_item_data
go 
drop table rpttransmittal_item
go 
drop table rpttransmittal_log
go 
drop table rpttransmittal
go 


CREATE TABLE rpttransmittal (
  objid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  type varchar(15) NOT NULL,
  filetype varchar(50) not null,
  txnno varchar(15) NOT NULL,
  txndate datetime NOT NULL,
  lgu_objid varchar(50) NOT NULL,
  lgu_name varchar(50) NOT NULL,
  lgu_type varchar(50) NOT NULL,
  tolgu_objid varchar(50) NOT NULL,
  tolgu_name varchar(50) NOT NULL,
  tolgu_type varchar(50) NOT NULL,
  createdby_objid varchar(50) NOT NULL,
  createdby_name varchar(100) NOT NULL,
  createdby_title varchar(50) NOT NULL,
  remarks varchar(500) default NULL,
  PRIMARY KEY  (objid)
)
go 

create unique index ux_txnno on rpttransmittal (txnno)
go 

create index ix_state on rpttransmittal(state)
go
create index ix_createdby_name on rpttransmittal(createdby_name)
go 
create index ix_lguname on rpttransmittal(lgu_name)
go 


CREATE TABLE rpttransmittal_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  filetype varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  refno varchar(150) NOT NULL,
  message varchar(350),
  remarks varchar(350),
  status varchar(50), 
  disapprovedby_name varchar(150),
  PRIMARY KEY  (objid)
)
go 

create unique index ux_parentid_refid on rpttransmittal_item(parentid,refid)
go 

create index ix_refid on rpttransmittal_item(refid)
go 
create index fk_rpttransmittal_item_rpttransmittal on rpttransmittal_item(parentid) 
go 


alter table rpttransmittal_item 
add constraint fk_rpttransmittal_item_rpttransmittal 
foreign key (parentid) references rpttransmittal (objid)
go 


alter table rpt_changeinfo add redflagid varchar(50)
go 




/*=================================================================
*
* MACHINE TAXABILITY
* 
=================================================================*/

alter table machdetail add taxable int
go 
update machdetail set taxable = 1 where taxable is null
go 


/* v2.5.04.032-03010 */

/*===========================================
* CERTIFICATION UPDATE
*===========================================*/

alter table rptcertification add [year] int
go 
alter table rptcertification add [qtr] int
go 

  



/*===========================================
* SPECIFIC CLASS
*===========================================*/

CREATE TABLE landspecificclass (
  objid varchar(50) NOT NULL,
  state varchar(10) NOT NULL,
  code varchar(50) NOT NULL,
  name varchar(100) NOT NULL,
  PRIMARY KEY  (objid)
) 
go

create index ux_landspecificclass_state on landspecificclass(state) 
go 


insert into landspecificclass(
  objid, state, code, name 
)
select 
  objid, 'APPROVED', code, name 
from lcuvspecificclass
go 


alter table lcuvspecificclass add landspecificclass_objid varchar(50)
go 

create index ix_landspecificclass_objid on lcuvspecificclass(landspecificclass_objid )

go 

alter table lcuvspecificclass 
  add constraint fk_lcuvspecificclass_landspecificclass 
  foreign key(landspecificclass_objid ) references landspecificclass(objid)

 go 

update lcuvspecificclass set 
  landspecificclass_objid  = objid
where landspecificclass_objid is null
go 



alter table landdetail add landspecificclass_objid varchar(50)
go 

update landdetail set landspecificclass_objid = specificclass_objid where landspecificclass_objid is null
go 


alter table lcuvspecificclass drop column code
go 
alter table lcuvspecificclass drop column name
go 



/*====================================================
* SUPPORT BLDG ADDITIONAL ITEM SELECTIVE DEPRECIATION 
=====================================================*/

alter table bldgflooradditional add depreciate int
go 

update bldgflooradditional set depreciate = 1 where depreciate = 0
go 


alter table bldguse add adjfordepreciation decimal(16,2)
go 

update bldguse set adjfordepreciation = adjustment where adjfordepreciation is null
go 



/*====================================================
* SUPPORT BLDG USE TAXABILITY
=====================================================*/
alter table bldguse add taxable int
go 

update bldguse set taxable = 1 where taxable is null
go 


alter table rpu_assessment add taxable int
go 

update rpu_assessment set taxable = 1 where taxable is null
go 


/* v2.5.04.032-03011 */
alter table cashreceiptitem_rpt_online drop constraint FK_cashreceiptitem_rpt_online_rptledgeritemqtrly
go 



/* subdivision */
create index ix_rptbill_expirydate on rptbill(expirydate)
go 

alter table subdivisionaffectedrpu add isnew int
go 
update subdivisionaffectedrpu set isnew = 0 where isnew is null
go 


delete from rptbill_ledger_item where billid in (
	select objid from rptbill where expirydate < '2016-09-01'
)
go 

delete from rptbill_ledger_account where billid in (
	select objid from rptbill where expirydate < '2016-10-01'
)
go 


delete from rptbill_ledger where billid in (
	select objid from rptbill where expirydate < '2016-10-01'
)
go 

delete from rptbill where expirydate < '2016-10-01'
go 

/* v2.5.04.032-03012 */
INSERT INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('RPT.MANAGEMENT', 'MANAGEMENT', 'RPT', NULL, NULL, 'MANAGEMENT')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('PER-41ea09c:157ef7851c2:-7df4', 'RPT.MANAGEMENT', 'report', 'txn-monitoring', 'Transaction Monitoring')
go 

create index ix_realproperty_claimno on realproperty(claimno)
go 

create index ix_dtinspected on examiner_finding(dtinspected)
go



create index ix_assignee_objid on faas_task(assignee_objid)
go 
create index ix_assignee_objid on subdivision_task(assignee_objid)
go 
create index ix_assignee_objid on consolidation_task(assignee_objid)
go 
create index ix_assignee_objid on cancelledfaas_task(assignee_objid)
go 

alter table faas_txntype add allowannotated int
go 
update faas_txntype set allowannotated = 0 where allowannotated is null
go

INSERT INTO sys_var (name, value, description, datatype, category) VALUES ('faas_transaction_process_as_capture', '0', 'Allow processing of online transaction as data capture', 'checkbox', 'ASSESSOR')
go 




-- 254032-03013

create table memoranda_template
(
	objid varchar(50) primary key,
	code varchar(25) not null,
	template varchar(500) not null
)
go 


alter table rpu_assessment alter column classification_objid varchar(50)  null
go 
alter table rpu_assessment alter column actualuse_objid varchar(50)  null
go 

-- 254032-03014


INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-bldgkind-create', 'RPT.MASTER', 'bldgkind', 'create', 'Create Kind of Building')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-bldgkind-delete', 'RPT.MASTER', 'bldgkind', 'delete', 'Delete Kind of Building')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-bldgkind-edit', 'RPT.MASTER', 'bldgkind', 'edit', 'Edit Kind of Building')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-bldgkind-read', 'RPT.MASTER', 'bldgkind', 'read', 'Open Kind of Building')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-landspecificclass-delete', 'RPT.MASTER', 'landspecificclass', 'delete', 'Delete Land Specific Class')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-landspecificclass-create', 'RPT.MASTER', 'landspecificclass', 'create', 'Create Land Specific Class')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-landspecificclass-read', 'RPT.MASTER', 'landspecificclass', 'read', 'Open Land Specific Class')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-landspecificclass-edit', 'RPT.MASTER', 'landspecificclass', 'edit', 'Edit Land Specific Class')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-machine-create', 'RPT.MASTER', 'machine', 'create', 'Create Machine')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-machine-read', 'RPT.MASTER', 'machine', 'read', 'Open Machine')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-machine-edit', 'RPT.MASTER', 'machine', 'edit', 'Edit Machine')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-machine-delete', 'RPT.MASTER', 'machine', 'delete', 'Delete Machine')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-approve', 'RPT.MASTER', 'master', 'approve', 'Approve Memoranda Template')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-sync', 'RPT.MASTER', 'master', 'sync', 'Synchronize Master Files')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-import', 'RPT.MASTER', 'master', 'import', 'Import Master Files')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-disapprove', 'RPT.MASTER', 'master', 'disapprove', 'Disapprove Memoranda Template')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-viewlist', 'RPT.MASTER', 'master', 'viewlist', 'View Master Files')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-export', 'RPT.MASTER', 'master', 'export', 'Export Master Files')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-material-delete', 'RPT.MASTER', 'material', 'delete', 'Delete Material')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-material-edit', 'RPT.MASTER', 'material', 'edit', 'Edit Material')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-material-read', 'RPT.MASTER', 'material', 'read', 'Open Material')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-material-create', 'RPT.MASTER', 'material', 'create', 'Create Material')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-plant-read', 'RPT.MASTER', 'planttree', 'read', 'Open Plant/Tree')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-plant-edit', 'RPT.MASTER', 'planttree', 'edit', 'Edit Plant/Tree')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-exemptiontype-create', 'RPT.MASTER', 'exemptiontype', 'create', 'Create Exemption Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-exemptiontype-delete', 'RPT.MASTER', 'exemptiontype', 'delete', 'Delete Exemption Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-exemptiontype-edit', 'RPT.MASTER', 'exemptiontype', 'edit', 'Edit Exemption Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-exemptiontype-read', 'RPT.MASTER', 'exemptiontype', 'read', 'Open Exemption Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-rptparameter-create', 'RPT.MASTER', 'rptparameter', 'create', 'Create Parameter')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-rptparameter-delete', 'RPT.MASTER', 'rptparameter', 'delete', 'Delete Parameter')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-rptparameter-edit', 'RPT.MASTER', 'rptparameter', 'edit', 'Edit Parameter')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-rptparameter-read', 'RPT.MASTER', 'rptparameter', 'read', 'Open Parameter')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-classification-create', 'RPT.MASTER', 'propertyclassification', 'create', 'Create Property Classification')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-classification-delete', 'RPT.MASTER', 'propertyclassification', 'delete', 'Delete Property Classification')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-classification-edit', 'RPT.MASTER', 'propertyclassification', 'edit', 'Edit Property Classification')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-classification-read', 'RPT.MASTER', 'propertyclassification', 'read', 'Open Property Classification')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-structure-create', 'RPT.MASTER', 'structure', 'create', 'Create Structure')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-structure-delete', 'RPT.MASTER', 'structure', 'delete', 'Delete Structure')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-structure-edit', 'RPT.MASTER', 'structure', 'edit', 'Edit Structure')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-structure-read', 'RPT.MASTER', 'structure', 'read', 'Open Structure')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-requirementtype-create', 'RPT.MASTER', 'requirementtype', 'create', 'Create Requirement Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-requirementtype-delete', 'RPT.MASTER', 'requirementtype', 'delete', 'Delete Requirement Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-requirementtype-edit', 'RPT.MASTER', 'requirementtype', 'edit', 'Edit Requirement Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-requirementtype-read', 'RPT.MASTER', 'requirementtype', 'read', 'Open Requirement Type')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-faastxntype-edit', 'RPT.MASTER', 'faastxntype', 'edit', 'Edit Transaction Types')
go 
INSERT INTO sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('RPT.MASTER-faastxntype-read', 'RPT.MASTER', 'faastxntype', 'read', 'Open Transaction Types')
go 



-- RYSETTING UPDATES
alter table landrysetting add remarks varchar(200)
go

alter table bldgrysetting add remarks varchar(200)
go 
alter table bldgrysetting alter column predominant int null
go 
alter table bldgrysetting alter column depreciatecoreanditemseparately int null
go 
alter table bldgrysetting alter column computedepreciationbasedonschedule int null
go 
alter table bldgrysetting alter column straightdepreciation int null
go 
alter table bldgrysetting alter column calcbldgagebasedondtoccupied int null
go 

alter table machrysetting add remarks varchar(200)
go 
alter table machrysetting alter column residualrate decimal(10,2) null
go 


alter table planttreerysetting add remarks varchar(200)
go 
alter table planttreerysetting alter column applyagriadjustment int null
go 
alter table planttreeassesslevel add fixrate int 
go 
update planttreeassesslevel set fixrate = 1 where fixrate is null
go 
	
alter table miscrysetting add remarks varchar(200)
go 




create table faas_previous
(
	objid varchar(50) not null, 
	faasid varchar(50) not null,
	prevfaasid varchar(50) null,
	prevrpuid varchar(50) null,
	prevtdno varchar(1000) null,
	prevpin varchar(1000) null,
	prevowner text null,
	prevadministrator text null,
	prevav varchar(500) null,
	prevmv varchar(500) null,
	prevareasqm varchar(500)null,
	prevareaha varchar(500) null,
	preveffectivity varchar(25) null,
	primary key(objid)
)
go 

create index FK_faas_previous_faas on faas_previous(faasid)
go 
create index ix_faas_previous_tdno on faas_previous(prevtdno)
go 
create index ix_faas_previous_pin on faas_previous(prevpin)
go 

alter table faas_previous 
	add constraint FK_faas_previous_faas 
	foreign key(faasid) references faas(objid)
go 


insert into faas_previous(
	objid,
	faasid,
	prevfaasid,
	prevrpuid,
	prevtdno,
	prevpin,
	prevowner,
	prevadministrator,
	prevav,
	prevmv,
	prevareasqm,
	prevareaha,
	preveffectivity
)
select 
	objid,
	objid as faasid,
	null as prevfaasid,
	null as prevrpuid, 
	prevtdno,
	prevpin,
	prevowner,
	prevadministrator,
	prevav,
	prevmv,
	prevareasqm,
	prevareaha,
	preveffectivity
from faas f 
where datacapture =  1
go 


insert into faas_previous(
	objid,
	faasid,
	prevfaasid,
	prevrpuid,
	prevtdno,
	prevpin,
	prevowner,
	prevadministrator,
	prevav,
	prevmv,
	prevareasqm,
	prevareaha,
	preveffectivity
)
select 
	(f.objid + '-' + pf.tdno) as objid,
	f.objid as faasid,
	pf.objid as prevfaasid,
	pf.rpuid as prevrpuid, 
	pf.tdno as prevtdno,
	pf.fullpin as prevpin,
	pf.owner_name as prevowner,
	pf.administrator_name as prevadministrator,
	pr.totalav as prevav,
	pr.totalmv as prevmv,
	pr.totalareasqm as  prevareasqm,
	pr.totalareaha as prevareaha,
	pf.effectivityyear as preveffectivity
from faas f 
	inner join previousfaas p on f.objid = p.faasid 
	inner join faas pf on p.prevfaasid = pf.objid
	inner join rpu pr on pf.rpuid = pr.objid 
go 	


insert into faas_previous(
	objid,
	faasid,
	prevfaasid,
	prevrpuid,
	prevtdno,
	prevpin,
	prevowner,
	prevadministrator,
	prevav,
	prevmv,
	prevareasqm,
	prevareaha,
	preveffectivity
)
select 
	objid,
	objid as faasid,
	null as prevfaasid,
	null as prevrpuid, 
	prevtdno,
	prevpin,
	prevowner,
	prevadministrator,
	prevav,
	prevmv,
	prevareasqm,
	prevareaha,
	preveffectivity
from faas f 
where datacapture =  0
and not exists(select * from previousfaas where faasid = f.objid) 
and not exists(select * from faas_previous where faasid = f.objid) 
go 



CREATE TABLE batchgr_items_forrevision (
  objid varchar(50) NOT NULL,
  rpuid varchar(50) NOT NULL,
  realpropertyid varchar(50) NOT NULL,
  barangayid varchar(50) NOT NULL,
  rputype varchar(15) NOT NULL,
  tdno varchar(25) NOT NULL,
  fullpin varchar(30) NOT NULL,
	pin varchar(30) not null,
	suffix int not null,
  PRIMARY KEY (objid)
)
go 





CREATE TABLE batchgr_error (
  objid varchar(50) NOT NULL,
  newry integer NOT NULL,
  msg text,
  PRIMARY KEY (objid)
)
go 

-- 254032-03014a

CREATE TABLE rptledgeritem_qtrly_partial (
  objid varchar(50) NOT NULL,
  rptledgerid varchar(50) NOT NULL,
  year integer NOT NULL,
  qtr integer NOT NULL,
  basicpaid decimal(16,2) NOT NULL,
  basicintpaid decimal(16,2) NOT NULL,
  basicdisctaken decimal(16,2) NOT NULL,
  basicidlepaid decimal(16,2) NOT NULL,
  basicidleintpaid decimal(16,2) NOT NULL,
  basicidledisctaken decimal(16,2) NOT NULL,
  sefpaid decimal(16,2) NOT NULL,
  sefintpaid decimal(16,2) NOT NULL,
  sefdisctaken decimal(16,2) NOT NULL,
  firecodepaid decimal(16,2) NOT NULL,
  PRIMARY KEY (objid)
)
go 

create index FK_rptledgeritemqtrlypartial_rptledger on rptledgeritem_qtrly_partial(rptledgerid)
go 
  
alter table rptledgeritem_qtrly_partial
add CONSTRAINT FK_rptledgeritemqtrlypartial_rptledger 
FOREIGN KEY (rptledgerid) REFERENCES rptledger (objid)
go 



alter table faas drop column taxpayer_name
go 
alter table faas drop column taxpayer_address
go 



CREATE TABLE faas_restriction (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  ledger_objid varchar(50)  NULL,
  state varchar(25) NOT NULL,
  restrictiontype_objid varchar(50) NOT NULL,
  txndate date  NULL,
  remarks varchar(255) DEFAULT NULL,
  receipt_objid varchar(50) DEFAULT NULL,
  receipt_receiptno varchar(15) DEFAULT NULL,
  receipt_receiptdate datetime DEFAULT NULL,
  receipt_amount decimal(16,2) DEFAULT NULL,
  receipt_lastyearpaid integer DEFAULT NULL,
  receipt_lastqtrpaid integer DEFAULT NULL,
  createdby_objid varchar(50) DEFAULT NULL,
  createdby_name varchar(150) DEFAULT NULL,
  dtcreated datetime DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

alter table faas_restriction 
add  CONSTRAINT FK_faas_restriction_faas 
FOREIGN KEY (parent_objid) REFERENCES faas (objid)
go 



create index ix_parent_objid on faas_restriction(parent_objid)
go 
create index ix_ledger_objid on faas_restriction(ledger_objid)
go 
create index ix_state on faas_restriction(state)
go 
create index ix_receiptno on faas_restriction(receipt_receiptno)
go 
create index ix_txndate on faas_restriction(txndate)
go 
create index ix_restrictiontype_objid on faas_restriction(restrictiontype_objid)
go 


insert into faas_restriction(
  objid,
  parent_objid,
  ledger_objid,
  state,
  restrictiontype_objid,
  txndate,
  remarks,
  receipt_objid,
  receipt_receiptno,
  receipt_receiptdate,
  createdby_objid,
  createdby_name,
  dtcreated
)
select
  (rl.objid + rlr.restrictionid) as objid,
  rl.faasid as parent_objid,
  rl.objid as ledger_objid,
  'ACTIVE' as state,
  rlr.restrictionid as restrictiontype_objid,
  f.dtapproved as txndate,
  null as remarks,
  null as receipt_objid,
  null as receipt_receiptno,
  null as receipt_receiptdate,
  null as createdby_objid,
  null as createdby_name,
  null as dtcreated
from faas f 
  inner join rptledger rl on f.objid = rl.faasid 
  inner join rptledger_restriction rlr on rl.objid = rlr.parentid
go 



insert into faas_restriction(
  objid,
  parent_objid,
  ledger_objid,
  state,
  restrictiontype_objid,
  txndate,
  remarks,
  receipt_objid,
  receipt_receiptno,
  receipt_receiptdate,
  createdby_objid,
  createdby_name,
  dtcreated
)
select
  (f.objid + f.restrictionid) as objid,
  f.objid as parent_objid,
  (select distinct objid from rptledger where faasid = f.objid) as ledger_objid,
  'ACTIVE' as state,
  f.restrictionid as restrictiontype_objid,
  f.dtapproved as txndate,
  null as remarks,
  null as receipt_objid,
  null as receipt_receiptno,
  null as receipt_receiptdate,
  null as createdby_objid,
  null as createdby_name,
  null as dtcreated
from faas f 
where restrictionid is not null 
and not exists(select * from rptledger rl 
  inner join rptledger_restriction rlr on rl.objid = rlr.parentid
  where rl.faasid = f.objid 
   and f.restrictionid = rlr.restrictionid)
go 


INSERT INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('LANDTAX.RECORD', 'RECORD', 'LANDTAX', NULL, NULL, 'RECORD')
go 
INSERT INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('LANDTAX.RECORD_APPROVER', 'RECORD APPROVER', 'LANDTAX', NULL, NULL, 'RECORD_APPROVER')
go 



/* 254032-030145*/

drop table batchgrerror
go 
alter table batchgr_error add barangayid varchar(50)
go 
alter table batchgr_error add barangay varchar(100)
go 
alter table batchgr_error add tdno varchar(30)
go 


create view vw_batchgr_error 
as 
select 
	err.*,
	f.fullpin as fullpin, 
	rp.pin as pin,
	o.name as lguname 
from batchgr_error err 
inner join faas f on err.objid = f.objid 
inner join realproperty rp on f.realpropertyid = rp.objid 
inner join barangay b on rp.barangayid = b.objid 
inner join sys_org o on f.lguid = o.objid 
go 


CREATE TABLE rptledger_forprocess (
  objid varchar(255) NOT NULL,
  PRIMARY KEY (objid)
)
go 


alter table rptledgeritem alter column basicintpaid decimal(16,2) null
go 
alter table rptledgeritem alter column basicdisctaken decimal(16,2) null
go 
alter table rptledgeritem alter column basicidledisctaken decimal(16,2) null
go 
alter table rptledgeritem alter column basicidleintpaid decimal(16,2) null
go 
alter table rptledgeritem alter column sefintpaid decimal(16,2) null
go 
alter table rptledgeritem alter column sefdisctaken decimal(16,2) null
go 



alter table rptledgeritem_qtrly alter column basicintpaid decimal(16,2) null
go 
alter table rptledgeritem_qtrly alter column basicdisctaken decimal(16,2) null
go 
alter table rptledgeritem_qtrly alter column basicidledisctaken decimal(16,2) null
go 
alter table rptledgeritem_qtrly alter column basicidleintpaid decimal(16,2) null
go 
alter table rptledgeritem_qtrly alter column sefintpaid decimal(16,2) null
go 
alter table rptledgeritem_qtrly alter column sefdisctaken decimal(16,2) null
go 


drop table rptledgeritem_qtrly_partial
go 

create index ix_dtapproved on faas(dtapproved)
go 


alter table faas_restriction add rpumaster_objid varchar(50)
go 

update fr set 
	fr.rpumaster_objid = r.rpumasterid
from faas_restriction fr, faas f, rpu r	
where fr.parent_objid = f.objid 
and f.rpuid = r.objid 
and fr.rpumaster_objid is null
go 



alter table cancelledfaas add cancelledbytdnos varchar(500)
go 
alter table cancelledfaas add cancelledbypins varchar(500)
go 



alter table subdivision_cancelledimprovement add cancelledbytdnos varchar(500)
go 
alter table subdivision_cancelledimprovement add cancelledbypins varchar(500)
go 

/* 254032-03016*/
INSERT INTO rptparameter (objid, state, name, caption, description, paramtype, minvalue, maxvalue) VALUES ('DISTANCE_TO_AWR', 'APPROVED', 'DISTANCE_TO_AWR', 'DISTANCE TO AWR', '', 'decimal', '0', '0')
go 
INSERT INTO rptparameter (objid, state, name, caption, description, paramtype, minvalue, maxvalue) VALUES ('DISTANCE_TO_LTC', 'APPROVED', 'DISTANCE_TO_LTC', 'DISTANCE TO LTC', '', 'decimal', '0', '0')
go 


INSERT INTO sys_var (name, value, description, datatype, category) 
VALUES ('faas_land_auto_agricultural_adjustment', '0', 'Land RPU Auto Adjustment', 'checkbox', 'ASSESSOR')
go 


alter table landrpu add distanceawr decimal(16,2)
go 
alter table landrpu add distanceltc decimal(16,2)
go 

/* 254032-03017*/

drop table rptbill_ledger_account
go
drop table rptbill_ledger_item
go 
/* 254032-03018*/

alter table faasbacktax alter column tdno varchar(25) null
go 
/* 254032-03018*/

alter table faasbacktax alter column tdno varchar(25) null
go 



alter table landdetail alter column subclass_objid varchar(50) null
go 
alter table landdetail alter column specificclass_objid varchar(50) null
go 
alter table landdetail alter column actualuse_objid varchar(50) null
go 
alter table landdetail alter column landspecificclass_objid varchar(50) null
go 




/* RYSETTING ORDINANCE INFO */
alter table landrysetting add ordinanceno varchar(25)
go 
alter table landrysetting add ordinancedate date
go 


alter table bldgrysetting add ordinanceno varchar(25)
go 
alter table bldgrysetting add ordinancedate date
go 


alter table machrysetting add ordinanceno varchar(25)
go 
alter table machrysetting add ordinancedate date
go 


alter table miscrysetting add ordinanceno varchar(25)
go 
alter table miscrysetting add ordinancedate date
go 


alter table planttreerysetting add ordinanceno varchar(25)
go 
alter table planttreerysetting add ordinancedate date
go 


delete from sys_var where name in ('gr_ordinance_date','gr_ordinance_no')
go





drop TABLE bldgrpu_land
go 

create table bldgrpu_land (
  objid varchar(50) not null,
  rpu_objid varchar(50) not null,
  landfaas_objid varchar(50)not null,
  landrpumaster_objid varchar(50),
  primary key (objid)
)
go 


create index ix_bldgrpu_land_bldgrpuid on bldgrpu_land(rpu_objid)
go 
create index ix_bldgrpu_land_landfaasid on bldgrpu_land(landfaas_objid)
go 
create index ix_bldgrpu_land_landrpumasterid on bldgrpu_land(landrpumaster_objid)
go 


alter table bldgrpu_land 
  add constraint fk_bldgrpu_land_bldgrpu foreign key (rpu_objid) 
  references bldgrpu (objid)
go  

alter table bldgrpu_land 
  add constraint fk_bldgrpu_land_rpumaster foreign key (landrpumaster_objid) 
  references rpumaster (objid)
go 

alter table bldgrpu_land 
  add constraint fk_bldgrpu_land_landfaas foreign key (landfaas_objid) 
  references faas(objid)
go 




create table batchgr_log (
  objid varchar(50) not null,
  primary key (objid)
)
go 



alter table bldgrpu_structuraltype alter column bldgkindbucc_objid varchar(50) null
go 



alter table bldgadditionalitem add idx int
go 

update bldgadditionalitem set idx = 0 where idx is null
go 





/*================================================= 
*
*  PROVINCE-MUNI LEDGER SYNCHRONIZATION SUPPORT 
*
====================================================*/
CREATE TABLE rptledger_remote (
  objid varchar(50) NOT NULL,
  remote_objid varchar(50) NOT NULL,
  createdby_name varchar(255) NOT NULL,
  createdby_title varchar(100) DEFAULT NULL,
  dtcreated datetime NOT NULL,
  PRIMARY KEY (objid)
)
go 

alter table rptledger_remote 
add CONSTRAINT FK_rptledgerremote_rptledger FOREIGN KEY (objid) REFERENCES rptledger (objid)
go 



/*======================================
* AUTOMATIC MACH AV RECALC SUPPORT
=======================================*/
INSERT INTO rptparameter (objid, state, name, caption, description, paramtype, minvalue, maxvalue) 
VALUES ('TOTAL_VALUE', 'APPROVED', 'TOTAL_VALUE', 'TOTAL VALUE', '', 'decimal', '0', '0')
GO 



/* BATCH GR ADDITIONAL SUPPORT */
alter table batchgr_items_forrevision add section varchar(3)
go 
alter table batchgr_items_forrevision add classification_objid varchar(50)
go 

/* 254032-03018 */

alter table faasbacktax alter column tdno varchar(25) null
go 



/*===============================================================
* realty tax account mapping  update 
*==============================================================*/

create table landtax_lgu_account_mapping (
  objid varchar(50) not null,
  lgu_objid varchar(50) not null,
  revtype varchar(50) not null,
  revperiod varchar(50) not null,
  item_objid varchar(50) not null
) 
go 

create index ix_objid on landtax_lgu_account_mapping(objid)
go 
create index fk_landtaxlguaccountmapping_sysorg on landtax_lgu_account_mapping(lgu_objid)
go 
create index fk_landtaxlguaccountmapping_itemaccount on landtax_lgu_account_mapping(item_objid)
go 
create index ix_revtype on landtax_lgu_account_mapping(revtype)
go 


 alter table landtax_lgu_account_mapping 
    add constraint fk_landtaxlguaccountmapping_itemaccount 
    foreign key (item_objid) references itemaccount (objid)
   go 

 alter table landtax_lgu_account_mapping 
    add constraint fk_landtaxlguaccountmapping_sysorg 
    foreign key (lgu_objid) references sys_org (objid)
   go 


delete from sys_rulegroup where ruleset = 'rptbilling' and name in ('before-misc-comp','misc-comp')
go 




/*======================================================
* rptledger payment
*=====================================================*/ 
create proc usp_droptable(
	@tablename varchar(50)
)
as 
if (exists(select * from sysobjects where id = object_id(@tablename)))
begin 
	exec ('drop table ' + @tablename)
end 
go 

exec usp_droptable 'cashreceiptitem_rpt_noledger'
go 

exec usp_droptable 'cashreceiptitem_rpt'
go 

exec usp_droptable 'rptledger_payment_share'
go 

exec usp_droptable 'rptledger_payment_item'
go 

exec usp_droptable 'rptledger_payment'
go 



create table rptledger_payment (
  objid varchar(100) not null,
  rptledgerid varchar(50) not null,
  type varchar(20) not null,
  receiptid varchar(50) null,
  receiptno varchar(50) not null,
  receiptdate date not null,
  paidby_name text not null,
  paidby_address varchar(150) not null,
  postedby varchar(100) not null,
  postedbytitle varchar(50) not null,
  dtposted datetime not null,
  fromyear int not null,
  fromqtr int not null,
  toyear int not null,
  toqtr int not null,
  amount decimal(12,2) not null,
  collectingagency varchar(50) default null,
  voided int not null,
  primary key (objid)
) 
go 


create index fk_rptledger_payment_rptledger on rptledger_payment(rptledgerid)
go 
create index fk_rptledger_payment_cashreceipt on rptledger_payment(receiptid)
go 
create index ix_receiptno on rptledger_payment(receiptno)
go 

alter table rptledger_payment 
add constraint fk_rptledger_payment_cashreceipt foreign key (receiptid) references cashreceipt (objid)
go 

alter table rptledger_payment 
add constraint fk_rptledger_payment_rptledger foreign key (rptledgerid) references rptledger (objid)
go 


create table rptledger_payment_item (
  objid varchar(50) not null,
  parentid varchar(100) not null,
  rptledgerfaasid varchar(50) default null,
  rptledgeritemid varchar(50) default null,
  rptledgeritemqtrlyid varchar(50) default null,
  year int not null,
  qtr int not null,
  basic decimal(16,2) not null,
  basicint decimal(16,2) not null,
  basicdisc decimal(16,2) not null,
  basicidle decimal(16,2) not null,
  basicidledisc decimal(16,2) default null,
  basicidleint decimal(16,2) default null,
  sef decimal(16,2) not null,
  sefint decimal(16,2) not null,
  sefdisc decimal(16,2) not null,
  firecode decimal(10,2) default null,
  sh decimal(16,2) not null,
  shint decimal(16,2) not null,
  shdisc decimal(16,2) not null,
  total decimal(16,2) default null,
  revperiod varchar(25) default null,
  partialled int not null,
  primary key (objid)
) 
go 

create index fk_rptledger_payment_item_parentid on rptledger_payment_item(parentid)
go 
create index fk_rptledger_payment_item_rptledgerfaasid on rptledger_payment_item(rptledgerfaasid)
go 
create index ix_rptledgeritemid on rptledger_payment_item(rptledgeritemid)
go 
create index ix_rptledgeritemqtrlyid on rptledger_payment_item(rptledgeritemqtrlyid)
go 


alter table rptledger_payment_item 
  add constraint fk_rptledger_payment_item_parentid 
  foreign key (parentid) references rptledger_payment (objid)
 go 
alter table rptledger_payment_item 
  add constraint fk_rptledger_payment_item_rptledgerfaasid 
  foreign key (rptledgerfaasid) references rptledgerfaas (objid)
 go 


create table rptledger_payment_share (
  objid varchar(50) not null,
  parentid varchar(100) null,
  revperiod varchar(25) not null,
  revtype varchar(25) not null,
  item_objid varchar(50) not null,
  amount decimal(16,4) not null,
  sharetype varchar(25) not null,
  discount decimal(16,4) null,
  primary key (objid)
)
go 

alter table rptledger_payment_share
  add constraint fk_rptledger_payment_share_parentid foreign key (parentid) 
  references rptledger_payment(objid)
 go 

alter table rptledger_payment_share
  add constraint fk_rptledger_payment_share_itemaccount foreign key (item_objid) 
  references itemaccount(objid)
 go 

create index fk_parentid on rptledger_payment_share(parentid)
go 
create index fk_item_objid on rptledger_payment_share(item_objid)
go 



insert into rptledger_payment(
  objid,
  rptledgerid,
  type,
  receiptid,
  receiptno,
  receiptdate,
  paidby_name,
  paidby_address,
  postedby,
  postedbytitle,
  dtposted,
  fromyear,
  fromqtr,
  toyear,
  toqtr,
  amount,
  collectingagency,
  voided 
)
select 
  x.objid,
  x.rptledgerid,
  x.type,
  x.receiptid,
  x.receiptno,
  x.receiptdate,
  x.paidby_name,
  x.paidby_address,
  x.postedby,
  x.postedbytitle,
  x.dtposted,
  x.fromyear,
  (select min(qtr) from cashreceiptitem_rpt_online 
    where rptledgerid = x.rptledgerid and rptreceiptid = x.receiptid and year = x.fromyear) as fromqtr,
  x.toyear,
  (select max(qtr) from cashreceiptitem_rpt_online 
    where rptledgerid = x.rptledgerid and rptreceiptid = x.receiptid and year = x.toyear) as toqtr,
  x.amount,
  x.collectingagency,
  0 as voided
from (
  select
    (cro.rptledgerid + '-' + cr.objid) as objid,
    cro.rptledgerid,
    cr.txntype as type,
    cr.objid as receiptid,
    c.receiptno as receiptno,
    c.receiptdate as receiptdate,
    c.paidby as paidby_name,
    c.paidbyaddress as paidby_address,
    c.collector_name as postedby,
    c.collector_title as postedbytitle,
    c.txndate as dtposted,
    min(cro.year) as fromyear,
    max(cro.year) as toyear,
    sum(
      cro.basic + cro.basicint - cro.basicdisc + cro.sef + cro.sefint - cro.sefdisc + cro.firecode +
      cro.basicidle + cro.basicidleint - cro.basicidledisc
    ) as amount,
    null as collectingagency
  from cashreceipt_rpt cr 
  inner join cashreceipt c on cr.objid = c.objid 
  inner join cashreceiptitem_rpt_online cro on c.objid = cro.rptreceiptid
  left join cashreceipt_void cv on c.objid = cv.receiptid 
  where cv.objid is null 
  group by 
    cr.objid,
    cro.rptledgerid,
    cr.txntype,
    c.receiptno,
    c.receiptdate,
    c.paidby,
    c.paidbyaddress,
    c.collector_name,
    c.collector_title,
    c.txndate 
)x
go 


insert into rptledger_payment_item(
  objid,
  parentid,
  rptledgerfaasid,
  rptledgeritemid,
  rptledgeritemqtrlyid,
  year,
  qtr,
  basic,
  basicint,
  basicdisc,
  basicidle,
  basicidledisc,
  basicidleint,
  sef,
  sefint,
  sefdisc,
  firecode,
  sh,
  shint,
  shdisc,
  total,
  revperiod,
  partialled
)
select
  cro.objid,
  (cro.rptledgerid + '-' + cro.rptreceiptid) as parentid,
  cro.rptledgerfaasid,
  cro.rptledgeritemid,
  cro.rptledgeritemqtrlyid,
  cro.year,
  cro.qtr,
  cro.basic,
  cro.basicint,
  cro.basicdisc,
  cro.basicidle,
  cro.basicidledisc,
  cro.basicidleint,
  cro.sef,
  cro.sefint,
  cro.sefdisc,
  cro.firecode,
  0 as sh,
  0 as shint,
  0 as shdisc,
  cro.total,
  cro.revperiod,
  cro.partialled
from cashreceipt_rpt cr 
inner join cashreceipt c on cr.objid = c.objid 
inner join cashreceiptitem_rpt_online cro on c.objid = cro.rptreceiptid 
left join cashreceipt_void cv on c.objid = cv.receiptid 
where cv.objid is null 
go 





insert into rptledger_payment_share(
  objid,
  parentid,
  revperiod,
  revtype,
  item_objid,
  amount,
  sharetype,
  discount
)
select
  cra.objid,
  (cra.rptledgerid + '-' + cra.rptreceiptid) as parentid,
  cra.revperiod,
  cra.revtype,
  cra.item_objid,
  cra.amount,
  cra.sharetype,
  cra.discount
from cashreceipt_rpt cr 
inner join cashreceipt c on cr.objid = c.objid 
inner join cashreceiptitem_rpt_account cra on c.objid = cra.rptreceiptid 
left join cashreceipt_void cv on c.objid = cv.receiptid 
where cv.objid is null 
and exists (select * from rptledger_payment where objid = (cra.rptledgerid + '-' + cra.rptreceiptid))
go 




insert into rptledger_payment(
  objid,
  rptledgerid,
  type,
  receiptid,
  receiptno,
  receiptdate,
  paidby_name,
  paidby_address,
  postedby,
  postedbytitle,
  dtposted,
  fromyear,
  fromqtr,
  toyear,
  toqtr,
  amount,
  collectingagency,
  voided 
)
select 
  objid,
  rptledgerid,
  type,
  null as receiptid,
  refno as receiptno,
  refdate,
  paidby_name,
  paidby_address,
  postedby,
  postedbytitle,
  dtposted,
  fromyear,
  fromqtr,
  toyear,
  toqtr,
  (basic + basicint - basicdisc + sef + sefint - sefdisc + basicidle + firecode) as amount,
  collectingagency,
  0 as voided 
from rptledger_credit
go 


alter table rptledgeritem add sh decimal(16,2)
go 
alter table rptledgeritem add shdisc decimal(16,2)
go 
alter table rptledgeritem add shpaid decimal(16,2)
go 
alter table rptledgeritem add shint decimal(16,2)
go 

update rptledgeritem set 
    sh = 0, shdisc=0, shpaid = 0, shint = 0
where sh is null 
go 



alter table rptledgeritem_qtrly add sh decimal(16,2)
go 
alter table rptledgeritem_qtrly add shdisc decimal(16,2)
go 
alter table rptledgeritem_qtrly add shpaid decimal(16,2)
go 
alter table rptledgeritem_qtrly add shint decimal(16,2)
go 

update rptledgeritem_qtrly set 
    sh = 0, shdisc=0, shpaid = 0, shint = 0
where sh is null 
go 




alter table rptledger_compromise_item add sh decimal(16,2)
go 
alter table rptledger_compromise_item add shpaid decimal(16,2)
go 
alter table rptledger_compromise_item add shint decimal(16,2)
go 
alter table rptledger_compromise_item add shintpaid decimal(16,2)
go 

update rptledger_compromise_item set 
    sh = 0, shpaid = 0, shint = 0, shintpaid = 0
where sh is null 
go 


alter table rptledger_compromise_item_credit add sh decimal(16,2)
go 
alter table rptledger_compromise_item_credit add shint decimal(16,2)
go 

update rptledger_compromise_item_credit set 
    sh = 0, shint = 0
where sh is null
go 


drop proc usp_droptable
go 

/* 254032-03019 */

/*==================================================
*
*  CDU RATING SUPPORT 
*
=====================================================*/

alter table bldgrpu add cdurating varchar(15)
go 

alter table bldgtype add usecdu int
go 
update bldgtype set usecdu = 0 where usecdu is null
go 


alter table bldgtype_depreciation add excellent decimal(16,2)
go 
alter table bldgtype_depreciation add verygood decimal(16,2)
go 
alter table bldgtype_depreciation add good decimal(16,2)
go 
alter table bldgtype_depreciation add average decimal(16,2)
go 
alter table bldgtype_depreciation add fair decimal(16,2)
go 
alter table bldgtype_depreciation add poor decimal(16,2)
go 
alter table bldgtype_depreciation add verypoor decimal(16,2)
go 
alter table bldgtype_depreciation add unsound decimal(16,2)
go 


alter table batchgr_error drop column barangayid
go 
alter table batchgr_error drop column barangay
go 
alter table batchgr_error drop column tdno
go 

drop view vw_batchgr_error
go 

create view vw_batchgr_error 
as 
select 
    err.*,
		f.tdno,
    f.prevtdno, 
    f.fullpin as fullpin, 
    rp.pin as pin,
		b.name as barangay,
		o.name as lguname
from batchgr_error err 
inner join faas f on err.objid = f.objid 
inner join realproperty rp on f.realpropertyid = rp.objid 
inner join barangay b on rp.barangayid = b.objid 
inner join sys_org o on f.lguid = o.objid
go 






/*=============================================================
*
* SKETCH 
*
==============================================================*/
CREATE TABLE faas_sketch (
  objid varchar(50) NOT NULL DEFAULT '',
  drawing text NOT NULL,
  PRIMARY KEY (objid)
)
go 



create index FK_faas_sketch_faas  on faas_sketch(objid)
go 

alter table faas_sketch 
  add constraint FK_faas_sketch_faas foreign key(objid) 
  references faas(objid)
go   



  
/*=============================================================
*
* CUSTOM RPU SUFFIX SUPPORT
*
==============================================================*/  

CREATE TABLE rpu_type_suffix (
  objid varchar(50) NOT NULL,
  rputype varchar(20) NOT NULL,
  [from] int NOT NULL,
  [to] int NOT NULL,
  PRIMARY KEY (objid)
) 
go 


insert into rpu_type_suffix (
  objid, rputype, [from], [to]
)
select 'LAND', 'land', 0, 0
union 
select 'BLDG-1001-1999', 'bldg', 1001, 1999
union 
select 'MACH-2001-2999', 'mach', 2001, 2999
union 
select 'PLANTTREE-3001-6999', 'planttree', 3001, 6999
union 
select 'MISC-7001-7999', 'misc', 7001, 7999
go 





/*=============================================================
*
* MEMORANDA TEMPLATE UPDATE 
*
==============================================================*/  
alter table memoranda_template add fields text
go 

update memoranda_template set fields = '[]' where fields is null
go 

/* 254032-03019.01 */

/*==================================================
*
*  BATCH GR UPDATES
*
=====================================================*/
drop table batchgr_error
go 
drop table batchgr_items_forrevision
go 
drop table batchgr_log
go 
drop view vw_batchgr_error
go 

/* 254032-03019.02 */

/*==============================================
* EXAMINATION UPDATES
==============================================*/

alter table examiner_finding add inspectedby_objid varchar(50)
go 
alter table examiner_finding add inspectedby_name varchar(100)
go 
alter table examiner_finding add inspectedby_title varchar(50)
go 
alter table examiner_finding add doctype varchar(50)
go 

create index ix_examiner_finding_inspectedby_objid on examiner_finding(inspectedby_objid)
go 


update e set 
	e.inspectedby_objid = (select top 1 assignee_objid from faas_task where refid = f.objid and state = 'examiner' order by enddate desc),
	e.inspectedby_name = e.notedby,
	e.inspectedby_title = e.notedbytitle,
	e.doctype = 'faas'
from examiner_finding e, faas f
where e.parent_objid = f.objid
go 

update e set 
	e.inspectedby_objid = (select top 1 assignee_objid from subdivision_task where refid = s.objid and state = 'examiner' order by enddate desc),
	e.inspectedby_name = e.notedby,
	e.inspectedby_title = e.notedbytitle,
	e.doctype = 'subdivision'
from examiner_finding e, subdivision s	
where e.parent_objid = s.objid
go 

update e set 
	e.inspectedby_objid = (select top 1 assignee_objid from consolidation_task where refid = c.objid and state = 'examiner' order by enddate desc),
	e.inspectedby_name = e.notedby,
	e.inspectedby_title = e.notedbytitle,
	e.doctype = 'consolidation'
from  examiner_finding e, consolidation c	
where e.parent_objid = c.objid
go 

update e set 
	e.inspectedby_objid = (select top 1 assignee_objid from cancelledfaas_task where refid = c.objid and state = 'examiner' order by enddate desc),
	e.inspectedby_name = e.notedby,
	e.inspectedby_title = e.notedbytitle,
	e.doctype = 'cancelledfaas'
from examiner_finding e, cancelledfaas c	
where e.parent_objid = c.objid
go 




/*======================================================
*
*  TAX CLEARANCE UPDATE
*
======================================================*/

alter table rpttaxclearance add reporttype varchar(15)
GO 

update rpttaxclearance set reporttype = 'fullypaid' where reporttype is null
go 	



/*REVENUE PARENT ACCOUNTS  */

INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_ADVANCE', 'ACTIVE', '588-007', 'RPT BASIC ADVANCE', 'RPT BASIC ADVANCE', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_CURRENT', 'ACTIVE', '588-001', 'RPT BASIC CURRENT', 'RPT BASIC CURRENT', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASICINT_CURRENT', 'ACTIVE', '588-004', 'RPT BASIC PENALTY CURRENT', 'RPT BASIC PENALTY CURRENT', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_PREVIOUS', 'ACTIVE', '588-002', 'RPT BASIC PREVIOUS', 'RPT BASIC PREVIOUS', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASICINT_PREVIOUS', 'ACTIVE', '588-005', 'RPT BASIC PENALTY PREVIOUS', 'RPT BASIC PENALTY PREVIOUS', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_PRIOR', 'ACTIVE', '588-003', 'RPT BASIC PRIOR', 'RPT BASIC PRIOR', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASICINT_PRIOR', 'ACTIVE', '588-006', 'RPT BASIC PENALTY PRIOR', 'RPT BASIC PENALTY PRIOR', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go

INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEF_ADVANCE', 'ACTIVE', '455-050', 'RPT SEF ADVANCE', 'RPT SEF ADVANCE', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEF_CURRENT', 'ACTIVE', '455-050', 'RPT SEF CURRENT', 'RPT SEF CURRENT', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEFINT_CURRENT', 'ACTIVE', '455-050', 'RPT SEF PENALTY CURRENT', 'RPT SEF PENALTY CURRENT', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEF_PREVIOUS', 'ACTIVE', '455-050', 'RPT SEF PREVIOUS', 'RPT SEF PREVIOUS', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEFINT_PREVIOUS', 'ACTIVE', '455-050', 'RPT SEF PENALTY PREVIOUS', 'RPT SEF PENALTY PREVIOUS', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEF_PRIOR', 'ACTIVE', '455-050', 'RPT SEF PRIOR', 'RPT SEF PRIOR', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_SEFINT_PRIOR', 'ACTIVE', '455-050', 'RPT SEF PENALTY PRIOR', 'RPT SEF PENALTY PRIOR', 'REVENUE', 'SEF', '02', 'SEF', '0.00', 'ANY', NULL, NULL, NULL)
go




alter table itemaccount_tag add objid varchar(50)
go 

insert into itemaccount_tag (objid, acctid, tag)
select  'RPT_BASIC_ADVANCE' as objid, 'RPT_BASIC_ADVANCE' as acctid, 'rpt_basic_advance' as tag
union 
select  'RPT_BASIC_CURRENT' as objid, 'RPT_BASIC_CURRENT' as acctid, 'rpt_basic_current' as tag
union 
select  'RPT_BASICINT_CURRENT' as objid, 'RPT_BASICINT_CURRENT' as acctid, 'rpt_basicint_current' as tag
union 
select  'RPT_BASIC_PREVIOUS' as objid, 'RPT_BASIC_PREVIOUS' as acctid, 'rpt_basic_previous' as tag
union 
select  'RPT_BASICINT_PREVIOUS' as objid, 'RPT_BASICINT_PREVIOUS' as acctid, 'rpt_basicint_previous' as tag
union 
select  'RPT_BASIC_PRIOR' as objid, 'RPT_BASIC_PRIOR' as acctid, 'rpt_basic_prior' as tag
union 
select  'RPT_BASICINT_PRIOR' as objid, 'RPT_BASICINT_PRIOR' as acctid, 'rpt_basicint_prior' as tag
union 
select  'RPT_SEF_ADVANCE' as objid, 'RPT_SEF_ADVANCE' as acctid, 'rpt_sef_advance' as tag
union 
select  'RPT_SEF_CURRENT' as objid, 'RPT_SEF_CURRENT' as acctid, 'rpt_sef_current' as tag
union 
select  'RPT_SEFINT_CURRENT' as objid, 'RPT_SEFINT_CURRENT' as acctid, 'rpt_sefint_current' as tag
union 
select  'RPT_SEF_PREVIOUS' as objid, 'RPT_SEF_PREVIOUS' as acctid, 'rpt_sef_previous' as tag
union 
select  'RPT_SEFINT_PREVIOUS' as objid, 'RPT_SEFINT_PREVIOUS' as acctid, 'rpt_sefint_previous' as tag
union 
select  'RPT_SEF_PRIOR' as objid, 'RPT_SEF_PRIOR' as acctid, 'rpt_sef_prior' as tag
union 
select  'RPT_SEFINT_PRIOR' as objid, 'RPT_SEFINT_PRIOR' as acctid, 'rpt_sefint_prior' as tag
go


/* FIRE CODE */
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) 
VALUES ('RPT_FIRE_CODE', 'ACTIVE', '-', 'RPT FIRE CODE', 'RPT FIRE CODE', 'REVENUE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go

insert into itemaccount_tag (objid, acctid, tag)
select  'RPT_FIRE_CODE' as objid, 'RPT_FIRE_CODE' as acctid, 'rpt_firecode_current' as tag
go 




/* BARANGAY SHARE PAYABLE */

INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_ADVANCE_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC ADVANCE BARANGAY SHARE', 'RPT BASIC ADVANCE BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_CURRENT_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC CURRENT BARANGAY SHARE', 'RPT BASIC CURRENT BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASICINT_CURRENT_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC PENALTY CURRENT BARANGAY SHARE', 'RPT BASIC PENALTY CURRENT BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_PREVIOUS_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC PREVIOUS BARANGAY SHARE', 'RPT BASIC PREVIOUS BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASICINT_PREVIOUS_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC PENALTY PREVIOUS BARANGAY SHARE', 'RPT BASIC PENALTY PREVIOUS BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASIC_PRIOR_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC PRIOR BARANGAY SHARE', 'RPT BASIC PRIOR BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go
INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid) VALUES ('RPT_BASICINT_PRIOR_BRGY_SHARE', 'ACTIVE', '455-049', 'RPT BASIC PENALTY PRIOR BARANGAY SHARE', 'RPT BASIC PENALTY PRIOR BARANGAY SHARE', 'PAYABLE', 'GENERAL', '01', 'GENERAL', '0.00', 'ANY', NULL, NULL, NULL)
go



insert into itemaccount_tag (objid, acctid, tag)
select  'RPT_BASIC_ADVANCE_BRGY_SHARE' as objid, 'RPT_BASIC_ADVANCE_BRGY_SHARE' as acctid, 'rpt_basic_advance' as tag
union 
select  'RPT_BASIC_CURRENT_BRGY_SHARE' as objid, 'RPT_BASIC_CURRENT_BRGY_SHARE' as acctid, 'rpt_basic_current' as tag
union 
select  'RPT_BASICINT_CURRENT_BRGY_SHARE' as objid, 'RPT_BASICINT_CURRENT_BRGY_SHARE' as acctid, 'rpt_basicint_current' as tag
union 
select  'RPT_BASIC_PREVIOUS_BRGY_SHARE' as objid, 'RPT_BASIC_PREVIOUS_BRGY_SHARE' as acctid, 'rpt_basic_previous' as tag
union 
select  'RPT_BASICINT_PREVIOUS_BRGY_SHARE' as objid, 'RPT_BASICINT_PREVIOUS_BRGY_SHARE' as acctid, 'rpt_basicint_previous' as tag
union 
select  'RPT_BASIC_PRIOR_BRGY_SHARE' as objid, 'RPT_BASIC_PRIOR_BRGY_SHARE' as acctid, 'rpt_basic_prior' as tag
union 
select  'RPT_BASICINT_PRIOR_BRGY_SHARE' as objid, 'RPT_BASICINT_PRIOR_BRGY_SHARE' as acctid, 'rpt_basicint_prior' as tag
go





/*===============================================================
*
* SET PARENT OF BARANGAY ACCOUNTS
*
===============================================================*/

-- advance account 
update i set 
	i.parentid = 'RPT_BASIC_ADVANCE_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basicadvacct_objid = i.objid 
and m.barangayid = o.objid
go


-- current account
update i set 
	i.parentid = 'RPT_BASIC_CURRENT_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basiccurracct_objid = i.objid 
and m.barangayid = o.objid
go

-- current int account
update i set 
	i.parentid = 'RPT_BASICINT_CURRENT_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basiccurrintacct_objid = i.objid 
and m.barangayid = o.objid
go



-- prior account
update i set 
	i.parentid = 'RPT_BASIC_PRIOR_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basicprioracct_objid = i.objid 
and m.barangayid = o.objid
go

-- priorint account
update i set 
	i.parentid = 'RPT_BASICINT_PRIOR_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basicpriorintacct_objid = i.objid 
and m.barangayid = o.objid
go




-- previous account
update i set 
	i.parentid = 'RPT_BASIC_PREVIOUS_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basicprevacct_objid = i.objid 
and m.barangayid = o.objid
go



-- prevint account
update i set 
	i.parentid = 'RPT_BASICINT_PREVIOUS_BRGY_SHARE', 
	i.org_objid = m.barangayid,
	i.org_name = o.name 
from itemaccount i, brgy_taxaccount_mapping m, sys_org o
where m.basicprevintacct_objid = i.objid 
and m.barangayid = o.objid
go



/*============================================================
*
* 254032-03020
*
=============================================================*/
update cashreceiptitem_rpt_account set discount= 0 where discount is null
go 

alter table rptledger add lguid varchar(50)
go 

update rl set 
  rl.lguid = m.objid 
from rptledger rl, barangay b, sys_org m
where rl.barangayid = b.objid 
and b.parentid = m.objid 
and m.orgclass = 'municipality'
go 


update rl set 
  rl.lguid = c.objid
from rptledger rl, barangay b, sys_org d, sys_org c  
where rl.barangayid = b.objid 
and b.parentid = d.objid 
and d.parent_objid = c.objid 
and d.orgclass = 'district'
go 





create table rptpayment (
  objid varchar(100) not null,
  type varchar(50) default null,
  refid varchar(50) not null,
  reftype varchar(50) not null,
  receiptid varchar(50) default null,
  receiptno varchar(50) not null,
  receiptdate date not null,
  paidby_name text not null,
  paidby_address varchar(150) not null,
  postedby varchar(100) not null,
  postedbytitle varchar(50) not null,
  dtposted datetime not null,
  fromyear int not null,
  fromqtr int not null,
  toyear int not null,
  toqtr int not null,
  amount decimal(12,2) not null,
  collectingagency varchar(50) default null,
  voided int not null,
  primary key(objid)
)
go 

create index fk_rptpayment_cashreceipt on rptpayment(receiptid)
go 
create index ix_refid on rptpayment(refid)
go 
create index ix_receiptno on rptpayment(receiptno)
go 

alter table rptpayment 
  add constraint fk_rptpayment_cashreceipt 
  foreign key (receiptid) references cashreceipt (objid)
go 

  



create table rptpayment_item (
  objid varchar(50) not null,
  parentid varchar(100) not null,
  rptledgerfaasid varchar(50) default null,
  year int not null,
  qtr int default null,
  revtype varchar(50) not null,
  revperiod varchar(25) default null,
  amount decimal(16,2) not null,
  interest decimal(16,2) not null,
  discount decimal(16,2) not null,
  partialled int not null,
  priority int not null,
  primary key (objid)
)
go 

create index fk_rptpayment_item_parentid on rptpayment_item (parentid)
go   
create index fk_rptpayment_item_rptledgerfaasid on rptpayment_item (rptledgerfaasid)
go   

alter table rptpayment_item
  add constraint rptpayment_item_rptledgerfaas foreign key (rptledgerfaasid) 
  references rptledgerfaas (objid)
go   

alter table rptpayment_item
  add constraint rptpayment_item_rptpayment foreign key (parentid) 
  references rptpayment (objid)
go   





create table rptpayment_share (
  objid varchar(50) not null,
  parentid varchar(100) default null,
  revperiod varchar(25) not null,
  revtype varchar(25) not null,
  sharetype varchar(25) not null,
  item_objid varchar(50) not null,
  amount decimal(16,4) not null,
  discount decimal(16,4) default null,
  primary key (objid)
)
go 

create index fk_rptpayment_share_parentid on rptpayment_share(parentid)
go   
create index fk_rptpayment_share_item_objid on  rptpayment_share(item_objid)
go   

alter table rptpayment_share add constraint rptpayment_share_itemaccount 
  foreign key (item_objid) references itemaccount (objid)
go   

alter table rptpayment_share add constraint rptpayment_share_rptpayment 
  foreign key (parentid) references rptpayment (objid)
go   





insert into rptpayment(
  objid,
  type,
  refid,
  reftype,
  receiptid,
  receiptno,
  receiptdate,
  paidby_name,
  paidby_address,
  postedby,
  postedbytitle,
  dtposted,
  fromyear,
  fromqtr,
  toyear,
  toqtr,
  amount,
  collectingagency,
  voided
)
select
  objid,
  type, 
  rptledgerid as refid,
  'rptledger' as reftype,
  receiptid,
  receiptno,
  receiptdate,
  paidby_name,
  paidby_address,
  postedby,
  postedbytitle,
  dtposted,
  fromyear,
  fromqtr,
  toyear,
  toqtr,
  amount,
  collectingagency,
  voided
from rptledger_payment
go 


insert into rptpayment_item(
  objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  revtype,
  revperiod,
  amount,
  interest,
  discount,
  partialled,
  priority
)
select
  concat(objid, '-basic') as objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  'basic' as revtype,
  revperiod,
  basic as amount,
  basicint as interest,
  basicdisc as discount,
  partialled,
  10000 as priority
from rptledger_payment_item
go 





insert into rptpayment_item(
  objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  revtype,
  revperiod,
  amount,
  interest,
  discount,
  partialled,
  priority
)
select
  concat(objid, '-sef') as objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  'sef' as revtype,
  revperiod,
  sef as amount,
  sefint as interest,
  sefdisc as discount,
  partialled,
  10000 as priority
from rptledger_payment_item
go 


insert into rptpayment_item(
  objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  revtype,
  revperiod,
  amount,
  interest,
  discount,
  partialled,
  priority
)
select
  concat(objid, '-sh') as objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  'sh' as revtype,
  revperiod,
  sh as amount,
  shint as interest,
  shdisc as discount,
  partialled,
  100 as priority
from rptledger_payment_item
where sh > 0
go 




insert into rptpayment_item(
  objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  revtype,
  revperiod,
  amount,
  interest,
  discount,
  partialled,
  priority
)
select
  concat(objid, '-firecode') as objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  'firecode' as revtype,
  revperiod,
  firecode as amount,
  0 as interest,
  0 as discount,
  partialled,
  50 as priority
from rptledger_payment_item
where firecode > 0
go 



insert into rptpayment_item(
  objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  revtype,
  revperiod,
  amount,
  interest,
  discount,
  partialled,
  priority
)
select
  concat(objid, '-basicidle') as objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  'basicidle' as revtype,
  revperiod,
  basicidle as amount,
  basicidleint as interest,
  basicidledisc as discount,
  partialled,
  200 as priority
from rptledger_payment_item
where basicidle > 0
go 



update cashreceipt_rpt set txntype = 'online' where txntype = 'rptonline'
go 
update cashreceipt_rpt set txntype = 'manual' where txntype = 'rptmanual'
go 
update cashreceipt_rpt set txntype = 'compromise' where txntype = 'rptcompromise'
go 

update rptpayment set type = 'online' where type = 'rptonline'
go 
update rptpayment set type = 'manual' where type = 'rptmanual'
go 
update rptpayment set type = 'compromise' where type = 'rptcompromise'
go 


  
create table landtax_report_rptdelinquency (
  objid varchar(50) not null,
  rptledgerid varchar(50) not null,
  barangayid varchar(50) not null,
  year int not null,
  qtr int null,
  revtype varchar(50) not null,
  amount decimal(16,2) not null,
  interest decimal(16,2) not null,
  discount decimal(16,2) not null,
  dtgenerated datetime not null, 
  generatedby_name varchar(255) not null,
  generatedby_title varchar(100) not null,
  primary key (objid)
)
go 




create view vw_rptpayment_item_detail as
select
  objid,
  parentid,
  rptledgerfaasid,
  year,
  qtr,
  revperiod, 
  case when rpi.revtype = 'basic' then rpi.amount else 0 end as basic,
  case when rpi.revtype = 'basic' then rpi.interest else 0 end as basicint,
  case when rpi.revtype = 'basic' then rpi.discount else 0 end as basicdisc,
  case when rpi.revtype = 'basic' then rpi.interest - rpi.discount else 0 end as basicdp,
  case when rpi.revtype = 'basic' then rpi.amount + rpi.interest - rpi.discount else 0 end as basicnet,
  case when rpi.revtype = 'basicidle' then rpi.amount + rpi.interest - rpi.discount else 0 end as basicidle,
  case when rpi.revtype = 'basicidle' then rpi.interest else 0 end as basicidleint,
  case when rpi.revtype = 'basicidle' then rpi.discount else 0 end as basicidledisc,
  case when rpi.revtype = 'basicidle' then rpi.interest - rpi.discount else 0 end as basicidledp,
  case when rpi.revtype = 'sef' then rpi.amount else 0 end as sef,
  case when rpi.revtype = 'sef' then rpi.interest else 0 end as sefint,
  case when rpi.revtype = 'sef' then rpi.discount else 0 end as sefdisc,
  case when rpi.revtype = 'sef' then rpi.interest - rpi.discount else 0 end as sefdp,
  case when rpi.revtype = 'sef' then rpi.amount + rpi.interest - rpi.discount else 0 end as sefnet,
  case when rpi.revtype = 'firecode' then rpi.amount + rpi.interest - rpi.discount else 0 end as firecode,
  case when rpi.revtype = 'sh' then rpi.amount + rpi.interest - rpi.discount else 0 end as sh,
  case when rpi.revtype = 'sh' then rpi.interest else 0 end as shint,
  case when rpi.revtype = 'sh' then rpi.discount else 0 end as shdisc,
  case when rpi.revtype = 'sh' then rpi.interest - rpi.discount else 0 end as shdp,
  rpi.amount + rpi.interest - rpi.discount as amount,
  rpi.partialled as partialled 
from rptpayment_item rpi
go 




create view vw_rptpayment_item as
select 
    x.parentid,
    x.rptledgerfaasid,
    x.year,
    x.qtr,
    x.revperiod,
    sum(x.basic) as basic,
    sum(x.basicint) as basicint,
    sum(x.basicdisc) as basicdisc,
    sum(x.basicdp) as basicdp,
    sum(x.basicnet) as basicnet,
    sum(x.basicidle) as basicidle,
    sum(x.basicidleint) as basicidleint,
    sum(x.basicidledisc) as basicidledisc,
    sum(x.basicidledp) as basicidledp,
    sum(x.sef) as sef,
    sum(x.sefint) as sefint,
    sum(x.sefdisc) as sefdisc,
    sum(x.sefdp) as sefdp,
    sum(x.sefnet) as sefnet,
    sum(x.firecode) as firecode,
    sum(x.sh) as sh,
    sum(x.shint) as shint,
    sum(x.shdisc) as shdisc,
    sum(x.shdp) as shdp,
    sum(x.amount) as amount,
    max(x.partialled) as partialled
from vw_rptpayment_item_detail x
group by 
    x.parentid,
    x.rptledgerfaasid,
    x.year,
    x.qtr,
    x.revperiod
go 


create view vw_landtax_report_rptdelinquency_detail 
as
select
  objid,
  rptledgerid,
  barangayid,
  year,
  qtr,
  dtgenerated,
  generatedby_name,
  generatedby_title,
  case when revtype = 'basic' then amount else 0 end as basic,
  case when revtype = 'basic' then interest else 0 end as basicint,
  case when revtype = 'basic' then discount else 0 end as basicdisc,
  case when revtype = 'basic' then interest - discount else 0 end as basicdp,
  case when revtype = 'basic' then amount + interest - discount else 0 end as basicnet,
  case when revtype = 'basicidle' then amount else 0 end as basicidle,
  case when revtype = 'basicidle' then interest else 0 end as basicidleint,
  case when revtype = 'basicidle' then discount else 0 end as basicidledisc,
  case when revtype = 'basicidle' then interest - discount else 0 end as basicidledp,
  case when revtype = 'basicidle' then amount + interest - discount else 0 end as basicidlenet,
  case when revtype = 'sef' then amount else 0 end as sef,
  case when revtype = 'sef' then interest else 0 end as sefint,
  case when revtype = 'sef' then discount else 0 end as sefdisc,
  case when revtype = 'sef' then interest - discount else 0 end as sefdp,
  case when revtype = 'sef' then amount + interest - discount else 0 end as sefnet,
  case when revtype = 'firecode' then amount else 0 end as firecode,
  case when revtype = 'firecode' then interest else 0 end as firecodeint,
  case when revtype = 'firecode' then discount else 0 end as firecodedisc,
  case when revtype = 'firecode' then interest - discount else 0 end as firecodedp,
  case when revtype = 'firecode' then amount + interest - discount else 0 end as firecodenet,
  case when revtype = 'sh' then amount else 0 end as sh,
  case when revtype = 'sh' then interest else 0 end as shint,
  case when revtype = 'sh' then discount else 0 end as shdisc,
  case when revtype = 'sh' then interest - discount else 0 end as shdp,
  case when revtype = 'sh' then amount + interest - discount else 0 end as shnet,
  amount + interest - discount as total
from landtax_report_rptdelinquency
go 



create view vw_landtax_report_rptdelinquency
as
select
  rptledgerid,
  barangayid,
  year,
  qtr,
  dtgenerated,
  generatedby_name,
  generatedby_title,
  sum(basic) as basic,
  sum(basicint) as basicint,
  sum(basicdisc) as basicdisc,
  sum(basicdp) as basicdp,
  sum(basicnet) as basicnet,
  sum(basicidle) as basicidle,
  sum(basicidleint) as basicidleint,
  sum(basicidledisc) as basicidledisc,
  sum(basicidledp) as basicidledp,
  sum(basicidlenet) as basicidlenet,
  sum(sef) as sef,
  sum(sefint) as sefint,
  sum(sefdisc) as sefdisc,
  sum(sefdp) as sefdp,
  sum(sefnet) as sefnet,
  sum(firecode) as firecode,
  sum(firecodeint) as firecodeint,
  sum(firecodedisc) as firecodedisc,
  sum(firecodedp) as firecodedp,
  sum(firecodenet) as firecodenet,
  sum(sh) as sh,
  sum(shint) as shint,
  sum(shdisc) as shdisc,
  sum(shdp) as shdp,
  sum(shnet) as shnet,
  sum(total) as total
from vw_landtax_report_rptdelinquency_detail
group by 
  rptledgerid,
  barangayid,
  year,
  qtr,
  dtgenerated,
  generatedby_name,
  generatedby_title
go 




create table rptledger_item(
  objid varchar(50) not null,
  parentid varchar(50) not null,
  rptledgerfaasid varchar(50) default null,
  remarks varchar(100) default null,
  basicav decimal(16,2) not null,
  sefav decimal(16,2) not null,
  av decimal(16,2) not null,
  revtype varchar(50) not null,
  year int not null,
  amount decimal(16,2) not null,
  amtpaid decimal(16,2) not null,
  priority int not null,
  taxdifference int not null,
  system int not null,
  primary key (objid)
) 
go 

create index fk_rptledger_item_rptledger on rptledger_item (parentid)
go  

alter table rptledger_item 
  add constraint fk_rptledger_item_rptledger foreign key (parentid) 
  references rptledger (objid)
go 




insert into rptledger_item (
  objid,
  parentid,
  rptledgerfaasid,
  remarks,
  basicav,
  sefav,
  av,
  revtype,
  year,
  amount,
  amtpaid,
  priority,
  taxdifference,
  system
)
select 
  concat(rli.objid, '-basic') as objid,
  rli.rptledgerid as parentid,
  rli.rptledgerfaasid,
  rli.remarks,
  isnull(rli.basicav, rli.av),
  isnull(rli.sefav, rli.av),
  rli.av,
  'basic' as revtype,
  rli.year,
  rli.basic as amount,
  rli.basicpaid as amtpaid,
  10000 as priority,
  rli.taxdifference,
  0 as system
from rptledgeritem rli 
  inner join rptledger rl on rli.rptledgerid = rl.objid 
where rl.state = 'APPROVED' 
and rli.basic > 0 
and rli.basicpaid < rli.basic
go 




insert into rptledger_item (
  objid,
  parentid,
  rptledgerfaasid,
  remarks,
  basicav,
  sefav,
  av,
  revtype,
  year,
  amount,
  amtpaid,
  priority,
  taxdifference,
  system
)
select 
  concat(rli.objid, '-sef') as objid,
  rli.rptledgerid as parentid,
  rli.rptledgerfaasid,
  rli.remarks,
  isnull(rli.basicav, rli.av),
  isnull(rli.sefav, rli.av),
  rli.av,
  'sef' as revtype,
  rli.year,
  rli.sef as amount,
  rli.sefpaid as amtpaid,
  10000 as priority,
  rli.taxdifference,
  0 as system
from rptledgeritem rli 
  inner join rptledger rl on rli.rptledgerid = rl.objid 
where rl.state = 'APPROVED' 
and rli.sef > 0 
and rli.sefpaid < rli.sef
go 




insert into rptledger_item (
  objid,
  parentid,
  rptledgerfaasid,
  remarks,
  basicav,
  sefav,
  av,
  revtype,
  year,
  amount,
  amtpaid,
  priority,
  taxdifference,
  system
)
select 
  concat(rli.objid, '-firecode') as objid,
  rli.rptledgerid as parentid,
  rli.rptledgerfaasid,
  rli.remarks,
  isnull(rli.basicav, rli.av),
  isnull(rli.sefav, rli.av),
  rli.av,
  'firecode' as revtype,
  rli.year,
  rli.firecode as amount,
  rli.firecodepaid as amtpaid,
  1 as priority,
  rli.taxdifference,
  0 as system
from rptledgeritem rli 
  inner join rptledger rl on rli.rptledgerid = rl.objid 
where rl.state = 'APPROVED' 
and rli.firecode > 0 
and rli.firecodepaid < rli.firecode
go 



insert into rptledger_item (
  objid,
  parentid,
  rptledgerfaasid,
  remarks,
  basicav,
  sefav,
  av,
  revtype,
  year,
  amount,
  amtpaid,
  priority,
  taxdifference,
  system
)
select 
  concat(rli.objid, '-basicidle') as objid,
  rli.rptledgerid as parentid,
  rli.rptledgerfaasid,
  rli.remarks,
  isnull(rli.basicav, rli.av),
  isnull(rli.sefav, rli.av),
  rli.av,
  'basicidle' as revtype,
  rli.year,
  rli.basicidle as amount,
  rli.basicidlepaid as amtpaid,
  5 as priority,
  rli.taxdifference,
  0 as system
from rptledgeritem rli 
  inner join rptledger rl on rli.rptledgerid = rl.objid 
where rl.state = 'APPROVED' 
and rli.basicidle > 0 
and rli.basicidlepaid < rli.basicidle
go 


insert into rptledger_item (
  objid,
  parentid,
  rptledgerfaasid,
  remarks,
  basicav,
  sefav,
  av,
  revtype,
  year,
  amount,
  amtpaid,
  priority,
  taxdifference,
  system
)
select 
  concat(rli.objid, '-sh') as objid,
  rli.rptledgerid as parentid,
  rli.rptledgerfaasid,
  rli.remarks,
  isnull(rli.basicav, rli.av),
  isnull(rli.sefav, rli.av),
  rli.av,
  'sh' as revtype,
  rli.year,
  rli.sh as amount,
  rli.shpaid as amtpaid,
  10 as priority,
  rli.taxdifference,
  0 as system
from rptledgeritem rli 
  inner join rptledger rl on rli.rptledgerid = rl.objid 
where rl.state = 'APPROVED' 
and rli.sh > 0 
and rli.shpaid < rli.sh
go 





/*====================================================================================
*
* RPTLEDGER AND RPTBILLING RULE SUPPORT 
*
======================================================================================*/

declare @ruleset varchar(50)
select @ruleset = 'rptledger' 


delete from sys_rule_action_param where parentid in ( 
  select ra.objid 
  from sys_rule r, sys_rule_action ra 
  where r.ruleset=@ruleset and ra.parentid=r.objid 
)

delete from sys_rule_actiondef_param where parentid in ( 
  select ra.objid from sys_ruleset_actiondef rsa 
    inner join sys_rule_actiondef ra on ra.objid=rsa.actiondef 
  where rsa.ruleset=@ruleset
)

delete from sys_rule_actiondef where objid in ( 
  select actiondef from sys_ruleset_actiondef where ruleset=@ruleset 
)

delete from sys_rule_action where parentid in ( 
  select objid from sys_rule 
  where ruleset=@ruleset 
)

delete from sys_rule_condition_constraint where parentid in ( 
  select rc.objid 
  from sys_rule r, sys_rule_condition rc 
  where r.ruleset=@ruleset and rc.parentid=r.objid 
)

delete from sys_rule_condition_var where parentid in ( 
  select rc.objid 
  from sys_rule r, sys_rule_condition rc 
  where r.ruleset=@ruleset and rc.parentid=r.objid 
)

delete from sys_rule_condition where parentid in ( 
  select objid from sys_rule where ruleset=@ruleset 
)

delete from sys_rule_deployed where objid in ( 
  select objid from sys_rule where ruleset=@ruleset 
)

delete from sys_rule where ruleset=@ruleset 

delete from sys_ruleset_fact where ruleset=@ruleset

delete from sys_ruleset_actiondef where ruleset=@ruleset

delete from sys_rulegroup where ruleset=@ruleset 

delete from sys_ruleset where name=@ruleset 
go 


declare @ruleset varchar(50)
select @ruleset = 'rptbilling' 


delete from sys_rule_action_param where parentid in ( 
  select ra.objid 
  from sys_rule r, sys_rule_action ra 
  where r.ruleset=@ruleset and ra.parentid=r.objid 
)

delete from sys_rule_actiondef_param where parentid in ( 
  select ra.objid from sys_ruleset_actiondef rsa 
    inner join sys_rule_actiondef ra on ra.objid=rsa.actiondef 
  where rsa.ruleset=@ruleset
)

delete from sys_rule_actiondef where objid in ( 
  select actiondef from sys_ruleset_actiondef where ruleset=@ruleset 
)

delete from sys_rule_action where parentid in ( 
  select objid from sys_rule 
  where ruleset=@ruleset 
)

delete from sys_rule_condition_constraint where parentid in ( 
  select rc.objid 
  from sys_rule r, sys_rule_condition rc 
  where r.ruleset=@ruleset and rc.parentid=r.objid 
)

delete from sys_rule_condition_var where parentid in ( 
  select rc.objid 
  from sys_rule r, sys_rule_condition rc 
  where r.ruleset=@ruleset and rc.parentid=r.objid 
)

delete from sys_rule_condition where parentid in ( 
  select objid from sys_rule where ruleset=@ruleset 
)

delete from sys_rule_deployed where objid in ( 
  select objid from sys_rule where ruleset=@ruleset 
)

delete from sys_rule where ruleset=@ruleset 

delete from sys_ruleset_fact where ruleset=@ruleset

delete from sys_ruleset_actiondef where ruleset=@ruleset

delete from sys_rulegroup where ruleset=@ruleset 

delete from sys_ruleset where name=@ruleset 
go 





INSERT INTO sys_ruleset (name, title, packagename, domain, role, permission) VALUES ('rptbilling', 'RPT Billing Rules', 'rptbilling', 'LANDTAX', 'RULE_AUTHOR', NULL)
go 
INSERT INTO sys_ruleset (name, title, packagename, domain, role, permission) VALUES ('rptledger', 'Ledger Billing Rules', 'rptledger', 'LANDTAX', 'RULE_AUTHOR', NULL)
go 


INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('LEDGER_ITEM', 'rptledger', 'Ledger Item Posting', '1')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('TAX', 'rptledger', 'Tax Computation', '2')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER_TAX', 'rptledger', 'Post Tax Computation', '3')
go 


INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('INIT', 'rptbilling', 'Init', '0')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('DISCOUNT', 'rptbilling', 'Discount Computation', '9')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER_DISCOUNT', 'rptbilling', 'After Discount Computation', '10')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('PENALTY', 'rptbilling', 'Penalty Computation', '7')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER_PENALTY', 'rptbilling', 'After Penalty Computation', '8')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('BEFORE_SUMMARY', 'rptbilling', 'Before Summary ', '19')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('SUMMARY', 'rptbilling', 'Summary', '20')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('AFTER_SUMMARY', 'rptbilling', 'After Summary', '21')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('BRGY_SHARE', 'rptbilling', 'Barangay Share Computation', '25')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('PROV_SHARE', 'rptbilling', 'Province Share Computation', '27')
go 
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('LGU_SHARE', 'rptbilling', 'LGU Share Computation', '26')
go 




create view vw_landtax_lgu_account_mapping
as 
select 
  ia.org_objid as org_objid,
  ia.org_name as org_name, 
  o.orgclass as org_class, 
  p.objid as parent_objid,
  p.code as parent_code,
  p.title as parent_title,
  ia.objid as item_objid,
  ia.code as item_code,
  ia.title as item_title,
  ia.fund_objid as item_fund_objid, 
  ia.fund_code as item_fund_code,
  ia.fund_title as item_fund_title,
  ia.type as item_type,
  pt.tag as item_tag
from itemaccount ia
inner join itemaccount p on ia.parentid = p.objid 
inner join itemaccount_tag pt on p.objid = pt.acctid
inner join sys_org o on ia.org_objid = o.objid 
where p.state = 'ACTIVE'
go 



/*=============================================================
*
* COMPROMISE UPDATE 
*
==============================================================*/


CREATE TABLE rptcompromise (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  txnno varchar(25) NOT NULL,
  txndate date NOT NULL,
  faasid varchar(50) DEFAULT NULL,
  rptledgerid varchar(50) NOT NULL,
  lastyearpaid int NOT NULL,
  lastqtrpaid int NOT NULL,
  startyear int NOT NULL,
  startqtr int NOT NULL,
  endyear int NOT NULL,
  endqtr int NOT NULL,
  enddate date NOT NULL,
  cypaymentrequired int DEFAULT NULL,
  cypaymentorno varchar(10) DEFAULT NULL,
  cypaymentordate date DEFAULT NULL,
  cypaymentoramount decimal(10,2) DEFAULT NULL,
  downpaymentrequired int NOT NULL,
  downpaymentrate decimal(10,0) NOT NULL,
  downpayment decimal(10,2) NOT NULL,
  downpaymentorno varchar(50) DEFAULT NULL,
  downpaymentordate date DEFAULT NULL,
  term int NOT NULL,
  numofinstallment int NOT NULL,
  amount decimal(16,2) NOT NULL,
  amtforinstallment decimal(16,2) NOT NULL,
  amtpaid decimal(16,2) NOT NULL,
  firstpartyname varchar(100) NOT NULL,
  firstpartytitle varchar(50) NOT NULL,
  firstpartyaddress varchar(100) NOT NULL,
  firstpartyctcno varchar(15) NOT NULL,
  firstpartyctcissued varchar(100) NOT NULL,
  firstpartyctcdate date NOT NULL,
  firstpartynationality varchar(50) NOT NULL,
  firstpartystatus varchar(50) NOT NULL,
  firstpartygender varchar(10) NOT NULL,
  secondpartyrepresentative varchar(100) NOT NULL,
  secondpartyname varchar(100) NOT NULL,
  secondpartyaddress varchar(100) NOT NULL,
  secondpartyctcno varchar(15) NOT NULL,
  secondpartyctcissued varchar(100) NOT NULL,
  secondpartyctcdate date NOT NULL,
  secondpartynationality varchar(50) NOT NULL,
  secondpartystatus varchar(50) NOT NULL,
  secondpartygender varchar(10) NOT NULL,
  dtsigned date DEFAULT NULL,
  notarizeddate date DEFAULT NULL,
  notarizedby varchar(100) DEFAULT NULL,
  notarizedbytitle varchar(50) DEFAULT NULL,
  signatories varchar(1000) NOT NULL,
  manualdiff decimal(16,2) NOT NULL DEFAULT '0.00',
  cypaymentreceiptid varchar(50) DEFAULT NULL,
  downpaymentreceiptid varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

create index ix_rptcompromise_faasid on rptcompromise(faasid)
go 

create index ix_rptcompromise_ledgerid on rptcompromise(rptledgerid)
go 

alter table rptcompromise add CONSTRAINT fk_rptcompromise_faas 
  FOREIGN KEY (faasid) REFERENCES faas (objid)
go 

alter table rptcompromise add CONSTRAINT fk_rptcompromise_rptledger 
  FOREIGN KEY (rptledgerid) REFERENCES rptledger (objid)
go 




CREATE TABLE rptcompromise_installment (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  installmentno int NOT NULL,
  duedate date NOT NULL,
  amount decimal(16,2) NOT NULL,
  amtpaid decimal(16,2) NOT NULL,
  fullypaid int NOT NULL,
  PRIMARY KEY (objid)
)
go 


create index ix_rptcompromise_installment_rptcompromiseid on rptcompromise_installment(parentid)
go 

alter table rptcompromise_installment 
  add CONSTRAINT fk_rptcompromise_installment_rptcompromise 
  FOREIGN KEY (parentid) REFERENCES rptcompromise (objid)
go 



  CREATE TABLE rptcompromise_credit (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  receiptid varchar(50) DEFAULT NULL,
  installmentid varchar(50) DEFAULT NULL,
  collector_name varchar(100) NOT NULL,
  collector_title varchar(50) NOT NULL,
  orno varchar(10) NOT NULL,
  ordate date NOT NULL,
  oramount decimal(16,2) NOT NULL,
  amount decimal(16,2) NOT NULL,
  mode varchar(50) NOT NULL,
  paidby varchar(150) NOT NULL,
  paidbyaddress varchar(100) NOT NULL,
  partial int DEFAULT NULL,
  remarks varchar(100) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go  

create index ix_rptcompromise_credit_parentid on rptcompromise_credit(parentid)
go 

create index ix_rptcompromise_credit_receiptid on rptcompromise_credit(receiptid)
go 

create index ix_rptcompromise_credit_installmentid on rptcompromise_credit(installmentid)
go 


alter table rptcompromise_credit 
  add CONSTRAINT fk_rptcompromise_credit_rptcompromise_installment 
  FOREIGN KEY (installmentid) REFERENCES rptcompromise_installment (objid)
go   

alter table rptcompromise_credit 
  add CONSTRAINT fk_rptcompromise_credit_cashreceipt 
  FOREIGN KEY (receiptid) REFERENCES cashreceipt (objid)
go   

alter table rptcompromise_credit 
  add CONSTRAINT fk_rptcompromise_credit_rptcompromise 
  FOREIGN KEY (parentid) REFERENCES rptcompromise (objid)
go   



CREATE TABLE rptcompromise_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  rptledgerfaasid varchar(50) NOT NULL,
  revtype varchar(50) NOT NULL,
  revperiod varchar(50) NOT NULL,
  year int NOT NULL,
  amount decimal(16,2) NOT NULL,
  amtpaid decimal(16,2) NOT NULL,
  interest decimal(16,2) NOT NULL,
  interestpaid decimal(16,2) NOT NULL,
  priority int DEFAULT NULL,
  taxdifference int DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

create index ix_rptcompromise_item_rptcompromise on rptcompromise_item (parentid)
go   
create index ix_rptcompromise_item_rptledgerfaas on rptcompromise_item (rptledgerfaasid)
go   

alter table rptcompromise_item 
  add CONSTRAINT fk_rptcompromise_item_rptcompromise 
  FOREIGN KEY (parentid) REFERENCES rptcompromise (objid)
go   

alter table rptcompromise_item 
  add CONSTRAINT fk_rptcompromise_item_rptledgerfaas 
  FOREIGN KEY (rptledgerfaasid) REFERENCES rptledgerfaas (objid)
go   





/*====================================================================
*
* LANDTAX RPT DELINQUENCY UPDATE 
*
====================================================================*/


if exists(select * from information_schema.tables where table_name = N'report_rptdelinquency_error')
begin 
  drop table report_rptdelinquency_error
end 

if exists(select * from information_schema.tables where table_name = N'report_rptdelinquency_forprocess')
begin 
  drop table report_rptdelinquency_forprocess
end 

if exists(select * from information_schema.tables where table_name = N'report_rptdelinquency_item')
begin 
  drop table report_rptdelinquency_item
end 

if exists(select * from information_schema.tables where table_name = N'report_rptdelinquency_barangay')
begin 
  drop table report_rptdelinquency_barangay
end 

if exists(select * from information_schema.tables where table_name = N'report_rptdelinquency')
begin 
  drop table report_rptdelinquency
end 
go 



CREATE TABLE report_rptdelinquency (
  objid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  dtgenerated datetime NOT NULL,
  dtcomputed datetime NOT NULL,
  generatedby_name varchar(255) NOT NULL,
  generatedby_title varchar(100) NOT NULL,
  PRIMARY KEY (objid)
) 
go 

CREATE TABLE report_rptdelinquency_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  rptledgerid varchar(50) NOT NULL,
  barangayid varchar(50) NOT NULL,
  year integer NOT NULL,
  qtr integer DEFAULT NULL,
  revtype varchar(50) NOT NULL,
  amount decimal(16,2) NOT NULL,
  interest decimal(16,2) NOT NULL,
  discount decimal(16,2) NOT NULL,
  PRIMARY KEY (objid)
) 
go 

alter table report_rptdelinquency_item 
  add constraint fk_rptdelinquency_item_rptdelinquency foreign key(parentid)
  references report_rptdelinquency(objid)
go 

create index fk_rptdelinquency_item_rptdelinquency on report_rptdelinquency_item(parentid)  
go 


alter table report_rptdelinquency_item 
  add constraint fk_rptdelinquency_item_rptledger foreign key(rptledgerid)
  references rptledger(objid)
go 

create index fk_rptdelinquency_item_rptledger on report_rptdelinquency_item(rptledgerid)  
go 

alter table report_rptdelinquency_item 
  add constraint fk_rptdelinquency_item_barangay foreign key(barangayid)
  references barangay(objid)
go 

create index fk_rptdelinquency_item_barangay on report_rptdelinquency_item(barangayid)  
go 




CREATE TABLE report_rptdelinquency_barangay (
  objid varchar(50) not null, 
  parentid varchar(50) not null, 
  barangayid varchar(50) NOT NULL,
  count int not null,
  processed int not null, 
  errors int not null, 
  ignored int not null, 
  PRIMARY KEY (objid)
) 
go 


alter table report_rptdelinquency_barangay 
  add constraint fk_rptdelinquency_barangay_rptdelinquency foreign key(parentid)
  references report_rptdelinquency(objid)
go 

create index fk_rptdelinquency_barangay_rptdelinquency on report_rptdelinquency_item(parentid)  
go 


alter table report_rptdelinquency_barangay 
  add constraint fk_rptdelinquency_barangay_barangay foreign key(barangayid)
  references barangay(objid)
go 

create index fk_rptdelinquency_barangay_barangay on report_rptdelinquency_barangay(barangayid)  
go 


CREATE TABLE report_rptdelinquency_forprocess (
  objid varchar(50) NOT NULL,
  barangayid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
)
go 

create index ix_barangayid on report_rptdelinquency_forprocess(barangayid)
go 
  


CREATE TABLE report_rptdelinquency_error (
  objid varchar(50) NOT NULL,
  barangayid varchar(50) NOT NULL,
  error text NULL,
  ignored integer NULL,
  PRIMARY KEY (objid)
)
go 

create index ix_barangayid on report_rptdelinquency_error(barangayid)
go
  




drop view vw_landtax_report_rptdelinquency_detail
go 

create view vw_landtax_report_rptdelinquency_detail 
as
select
  parentid, 
  rptledgerid,
  barangayid,
  year,
  qtr,
  case when revtype = 'basic' then amount else 0 end as basic,
  case when revtype = 'basic' then interest else 0 end as basicint,
  case when revtype = 'basic' then discount else 0 end as basicdisc,
  case when revtype = 'basic' then interest - discount else 0 end as basicdp,
  case when revtype = 'basic' then amount + interest - discount else 0 end as basicnet,
  case when revtype = 'basicidle' then amount else 0 end as basicidle,
  case when revtype = 'basicidle' then interest else 0 end as basicidleint,
  case when revtype = 'basicidle' then discount else 0 end as basicidledisc,
  case when revtype = 'basicidle' then interest - discount else 0 end as basicidledp,
  case when revtype = 'basicidle' then amount + interest - discount else 0 end as basicidlenet,
  case when revtype = 'sef' then amount else 0 end as sef,
  case when revtype = 'sef' then interest else 0 end as sefint,
  case when revtype = 'sef' then discount else 0 end as sefdisc,
  case when revtype = 'sef' then interest - discount else 0 end as sefdp,
  case when revtype = 'sef' then amount + interest - discount else 0 end as sefnet,
  case when revtype = 'firecode' then amount else 0 end as firecode,
  case when revtype = 'firecode' then interest else 0 end as firecodeint,
  case when revtype = 'firecode' then discount else 0 end as firecodedisc,
  case when revtype = 'firecode' then interest - discount else 0 end as firecodedp,
  case when revtype = 'firecode' then amount + interest - discount else 0 end as firecodenet,
  case when revtype = 'sh' then amount else 0 end as sh,
  case when revtype = 'sh' then interest else 0 end as shint,
  case when revtype = 'sh' then discount else 0 end as shdisc,
  case when revtype = 'sh' then interest - discount else 0 end as shdp,
  case when revtype = 'sh' then amount + interest - discount else 0 end as shnet,
  amount + interest - discount as total
from report_rptdelinquency_item 
go




drop  view vw_landtax_report_rptdelinquency
go 

create view vw_landtax_report_rptdelinquency
as
select
  v.rptledgerid,
  v.barangayid,
  v.year,
  v.qtr,
  rr.dtgenerated,
  rr.generatedby_name,
  rr.generatedby_title,
  sum(v.basic) as basic,
  sum(v.basicint) as basicint,
  sum(v.basicdisc) as basicdisc,
  sum(v.basicdp) as basicdp,
  sum(v.basicnet) as basicnet,
  sum(v.basicidle) as basicidle,
  sum(v.basicidleint) as basicidleint,
  sum(v.basicidledisc) as basicidledisc,
  sum(v.basicidledp) as basicidledp,
  sum(v.basicidlenet) as basicidlenet,
  sum(v.sef) as sef,
  sum(v.sefint) as sefint,
  sum(v.sefdisc) as sefdisc,
  sum(v.sefdp) as sefdp,
  sum(v.sefnet) as sefnet,
  sum(v.firecode) as firecode,
  sum(v.firecodeint) as firecodeint,
  sum(v.firecodedisc) as firecodedisc,
  sum(v.firecodedp) as firecodedp,
  sum(v.firecodenet) as firecodenet,
  sum(v.sh) as sh,
  sum(v.shint) as shint,
  sum(v.shdisc) as shdisc,
  sum(v.shdp) as shdp,
  sum(v.shnet) as shnet,
  sum(v.total) as total
from report_rptdelinquency rr 
inner join vw_landtax_report_rptdelinquency_detail v on rr.objid = v.parentid 
group by 
  v.rptledgerid,
  v.barangayid,
  v.year,
  v.qtr,
  rr.dtgenerated,
  rr.generatedby_name,
  rr.generatedby_title
go



/* 03021 */

/*============================================
*
* TAX DIFFERENCE
*
*============================================*/

CREATE TABLE rptledger_avdifference (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  rptledgerfaas_objid varchar(50) NOT NULL,
  year int NOT NULL,
  av decimal(16,2) NOT NULL,
  paid int NOT NULL,
  PRIMARY KEY (objid)
) 
go 

create index fk_rptledger on rptledger_avdifference (parent_objid)
go 

create index fk_rptledgerfaas on rptledger_avdifference (rptledgerfaas_objid)
go 
 
alter table rptledger_avdifference 
	add CONSTRAINT fk_rptledgerfaas FOREIGN KEY (rptledgerfaas_objid) 
	REFERENCES rptledgerfaas (objid)
go 

alter table rptledger_avdifference 
	add CONSTRAINT fk_rptledger FOREIGN KEY (parent_objid) 
	REFERENCES rptledger (objid)
go 



create view vw_rptledger_avdifference
as 
select 
  rlf.objid,
  'APPROVED' as state,
  d.parent_objid as rptledgerid,
  rl.faasid,
  rl.tdno,
  rlf.txntype_objid,
  rlf.classification_objid,
  rlf.actualuse_objid,
  rlf.taxable,
  rlf.backtax,
  d.year as fromyear,
  1 as fromqtr,
  d.year as toyear,
  4 as toqtr,
  d.av as assessedvalue,
  1 as systemcreated,
  rlf.reclassed,
  rlf.idleland,
  1 as taxdifference
from rptledger_avdifference d 
inner join rptledgerfaas rlf on d.rptledgerfaas_objid = rlf.objid 
inner join rptledger rl on d.parent_objid = rl.objid 
go 


/* 03022 */

/*============================================
*
* SYNC PROVINCE AND REMOTE LEGERS
*
*============================================*/

drop table rptledger_remote
go 

CREATE TABLE remote_mapping (
  objid varchar(50) NOT NULL,
  doctype varchar(50) NOT NULL,
  remote_objid varchar(50) NULL,
  createdby_name varchar(255) NOT NULL,
  createdby_title varchar(100) DEFAULT NULL,
  dtcreated datetime NOT NULL,
  orgcode varchar(10) DEFAULT NULL,
  remote_orgcode varchar(10) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 


create index ix_doctype on remote_mapping(doctype)
go 
create index ix_orgcode on remote_mapping(orgcode)
go 
create index ix_remote_orgcode on remote_mapping(remote_orgcode)
go 
create index ix_remote_objid on remote_mapping(remote_objid)
go 


alter table faas alter column prevtdno varchar(1000)
go 



create view vw_txn_log 
as 
select 
  distinct
  u.objid as userid, 
  u.name as username, 
  txndate, 
  ref,
  action, 
  1 as cnt 
from txnlog t
inner join sys_user u on t.userid = u.objid 

union 

select 
  u.objid as userid, 
  u.name as username,
  t.enddate as txndate, 
  'faas' as ref,
  case 
    when t.state like '%receiver%' then 'receive'
    when t.state like '%examiner%' then 'examine'
    when t.state like '%taxmapper_chief%' then 'approve taxmap'
    when t.state like '%taxmapper%' then 'taxmap'
    when t.state like '%appraiser%' then 'appraise'
    when t.state like '%appraiser_chief%' then 'approve appraisal'
    when t.state like '%recommender%' then 'recommend'
    when t.state like '%approver%' then 'approve'
    else t.state 
  end action, 
  1 as cnt 
from faas_task t 
inner join sys_user u on t.actor_objid = u.objid 
where t.state not like '%assign%'

union 

select 
  u.objid as userid, 
  u.name as username,
  t.enddate as txndate, 
  'subdivision' as ref,
  case 
    when t.state like '%receiver%' then 'receive'
    when t.state like '%examiner%' then 'examine'
    when t.state like '%taxmapper_chief%' then 'approve taxmap'
    when t.state like '%taxmapper%' then 'taxmap'
    when t.state like '%appraiser%' then 'appraise'
    when t.state like '%appraiser_chief%' then 'approve appraisal'
    when t.state like '%recommender%' then 'recommend'
    when t.state like '%approver%' then 'approve'
    else t.state 
  end action, 
  1 as cnt 
from subdivision_task t 
inner join sys_user u on t.actor_objid = u.objid 
where t.state not like '%assign%'

union 

select 
  u.objid as userid, 
  u.name as username,
  t.enddate as txndate, 
  'consolidation' as ref,
  case 
    when t.state like '%receiver%' then 'receive'
    when t.state like '%examiner%' then 'examine'
    when t.state like '%taxmapper_chief%' then 'approve taxmap'
    when t.state like '%taxmapper%' then 'taxmap'
    when t.state like '%appraiser%' then 'appraise'
    when t.state like '%appraiser_chief%' then 'approve appraisal'
    when t.state like '%recommender%' then 'recommend'
    when t.state like '%approver%' then 'approve'
    else t.state 
  end action, 
  1 as cnt 
from subdivision_task t 
inner join sys_user u on t.actor_objid = u.objid 
where t.state not like '%consolidation%'

union 


select 
  u.objid as userid, 
  u.name as username,
  t.enddate as txndate, 
  'cancelledfaas' as ref,
  case 
    when t.state like '%receiver%' then 'receive'
    when t.state like '%examiner%' then 'examine'
    when t.state like '%taxmapper_chief%' then 'approve taxmap'
    when t.state like '%taxmapper%' then 'taxmap'
    when t.state like '%appraiser%' then 'appraise'
    when t.state like '%appraiser_chief%' then 'approve appraisal'
    when t.state like '%recommender%' then 'recommend'
    when t.state like '%approver%' then 'approve'
    else t.state 
  end action, 
  1 as cnt 
from subdivision_task t 
inner join sys_user u on t.actor_objid = u.objid 
where t.state not like '%cancelledfaas%'
go 



/*===================================================
* DELINQUENCY UPDATE 
====================================================*/


alter table report_rptdelinquency_barangay add idx int
go 

update report_rptdelinquency_barangay set idx = 0 where idx is null
go 


create view vw_faas_lookup
as 
SELECT 
f.*,
e.name as taxpayer_name, 
e.address_text as taxpayer_address,
pc.code AS classification_code, 
pc.code AS classcode, 
pc.name AS classification_name, 
pc.name AS classname, 
r.ry, r.rputype, r.totalmv, r.totalav,
r.totalareasqm, r.totalareaha, r.suffix, r.rpumasterid, 
rp.barangayid, rp.cadastrallotno, rp.blockno, rp.surveyno, rp.pintype, 
rp.section, rp.parcel, rp.stewardshipno, rp.pin, 
b.name AS barangay_name 
FROM faas f 
INNER JOIN faas_list fl on f.objid = fl.objid 
INNER JOIN rpu r ON f.rpuid = r.objid 
INNER JOIN realproperty rp ON f.realpropertyid = rp.objid 
INNER JOIN propertyclassification pc ON r.classification_objid = pc.objid 
INNER JOIN barangay b ON rp.barangayid = b.objid 
INNER JOIN entity e on f.taxpayer_objid = e.objid
go 

drop  view vw_rptpayment_item_detail
go 

create view vw_rptpayment_item_detail
as 
select
  rpi.objid,
  rpi.parentid,
  rp.refid as rptledgerid, 
  rpi.rptledgerfaasid,
  rpi.year,
  rpi.qtr,
  rpi.revperiod, 
  case when rpi.revtype = 'basic' then rpi.amount else 0 end as basic,
  case when rpi.revtype = 'basic' then rpi.interest else 0 end as basicint,
  case when rpi.revtype = 'basic' then rpi.discount else 0 end as basicdisc,
  case when rpi.revtype = 'basic' then rpi.interest - rpi.discount else 0 end as basicdp,
  case when rpi.revtype = 'basic' then rpi.amount + rpi.interest - rpi.discount else 0 end as basicnet,
  case when rpi.revtype = 'basicidle' then rpi.amount + rpi.interest - rpi.discount else 0 end as basicidle,
  case when rpi.revtype = 'basicidle' then rpi.interest else 0 end as basicidleint,
  case when rpi.revtype = 'basicidle' then rpi.discount else 0 end as basicidledisc,
  case when rpi.revtype = 'basicidle' then rpi.interest - rpi.discount else 0 end as basicidledp,
  case when rpi.revtype = 'sef' then rpi.amount else 0 end as sef,
  case when rpi.revtype = 'sef' then rpi.interest else 0 end as sefint,
  case when rpi.revtype = 'sef' then rpi.discount else 0 end as sefdisc,
  case when rpi.revtype = 'sef' then rpi.interest - rpi.discount else 0 end as sefdp,
  case when rpi.revtype = 'sef' then rpi.amount + rpi.interest - rpi.discount else 0 end as sefnet,
  case when rpi.revtype = 'firecode' then rpi.amount + rpi.interest - rpi.discount else 0 end as firecode,
  case when rpi.revtype = 'sh' then rpi.amount + rpi.interest - rpi.discount else 0 end as sh,
  case when rpi.revtype = 'sh' then rpi.interest else 0 end as shint,
  case when rpi.revtype = 'sh' then rpi.discount else 0 end as shdisc,
  case when rpi.revtype = 'sh' then rpi.interest - rpi.discount else 0 end as shdp,
  rpi.amount + rpi.interest - rpi.discount as amount,
  rpi.partialled as partialled,
  rp.voided 
from rptpayment_item rpi
inner join rptpayment rp on rpi.parentid = rp.objid

go 

drop view vw_rptpayment_item 
go 

create view vw_rptpayment_item 
as 
select 
    x.rptledgerid, 
    x.parentid,
    x.rptledgerfaasid,
    x.year,
    x.qtr,
    x.revperiod,
    sum(x.basic) as basic,
    sum(x.basicint) as basicint,
    sum(x.basicdisc) as basicdisc,
    sum(x.basicdp) as basicdp,
    sum(x.basicnet) as basicnet,
    sum(x.basicidle) as basicidle,
    sum(x.basicidleint) as basicidleint,
    sum(x.basicidledisc) as basicidledisc,
    sum(x.basicidledp) as basicidledp,
    sum(x.sef) as sef,
    sum(x.sefint) as sefint,
    sum(x.sefdisc) as sefdisc,
    sum(x.sefdp) as sefdp,
    sum(x.sefnet) as sefnet,
    sum(x.firecode) as firecode,
    sum(x.sh) as sh,
    sum(x.shint) as shint,
    sum(x.shdisc) as shdisc,
    sum(x.shdp) as shdp,
    sum(x.amount) as amount,
    max(x.partialled) as partialled,
    x.voided 
from vw_rptpayment_item_detail x
group by 
  x.rptledgerid, 
    x.parentid,
    x.rptledgerfaasid,
    x.year,
    x.qtr,
    x.revperiod,
    x.voided

go     




drop index faas.ix_canceldate 
go 


alter table faas drop constraint DF__faas__canceldate__2F2FFC0C
go 

alter table faas alter column canceldate date 
go 

create index ix_faas_canceldate on faas(canceldate)
go 


alter table machdetail alter column depreciation decimal(16,6)
go


/* 255-03001 */

-- create tables: resection and resection_item

if exists(select * from sysobjects where id = object_id('resectionaffectedrpu'))
begin 
	drop table resectionaffectedrpu
end 
go 


if exists(select * from sysobjects where id = object_id('resectionitem'))
begin 
	drop table resectionitem
end 
go 


if exists(select * from sysobjects where id = object_id('resection'))
begin 
	drop table resection
end 
go 


CREATE TABLE resection (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  txnno varchar(25) NOT NULL,
  txndate datetime NOT NULL,
  lgu_objid varchar(50) NOT NULL,
  barangay_objid varchar(50) NOT NULL,
  pintype varchar(3) NOT NULL,
  section varchar(3) NOT NULL,
  originlgu_objid varchar(50) NOT NULL,
  memoranda varchar(255) DEFAULT NULL,
  taskid varchar(50) DEFAULT NULL,
  taskstate varchar(50) DEFAULT NULL,
  assignee_objid varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 



create UNIQUE index ux_resection_txnno on resection(txnno)
go 

create index FK_resection_lgu_org on resection(lgu_objid)
go 
create index FK_resection_barangay_org on resection(barangay_objid)
go 
create index FK_resection_originlgu_org on resection(originlgu_objid)
go 
create index ix_resection_state on resection(state)
go 


  alter table resection 
    add CONSTRAINT FK_resection_barangay_org FOREIGN KEY (barangay_objid) 
    REFERENCES sys_org (objid)
go     
  alter table resection 
    add CONSTRAINT FK_resection_lgu_org FOREIGN KEY (lgu_objid) 
    REFERENCES sys_org (objid)
go     
  alter table resection 
    add CONSTRAINT FK_resection_originlgu_org FOREIGN KEY (originlgu_objid) 
    REFERENCES sys_org (objid)
go     




CREATE TABLE resection_item (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  faas_objid varchar(50) NOT NULL,
  faas_rputype varchar(15) NOT NULL,
  faas_pin varchar(25) NOT NULL,
  faas_suffix int NOT NULL,
  newfaas_objid varchar(50) DEFAULT NULL,
  newfaas_rpuid varchar(50) DEFAULT NULL,
  newfaas_rpid varchar(50) DEFAULT NULL,
  newfaas_section varchar(3) DEFAULT NULL,
  newfaas_parcel varchar(3) DEFAULT NULL,
  newfaas_suffix int DEFAULT NULL,
  newfaas_tdno varchar(25) DEFAULT NULL,
  newfaas_fullpin varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

create UNIQUE index ux_resection_item_tdno on resection_item (newfaas_tdno)
go 

create index FK_resection_item_item on resection_item(parent_objid)
go   
create index FK_resection_item_faas on resection_item(faas_objid)
go   
create index FK_resection_item_newfaas on resection_item(newfaas_objid)
go   
create index ix_resection_item_fullpin on resection_item(newfaas_fullpin)
go   


alter table resection_item add CONSTRAINT FK_resection_item_faas FOREIGN KEY (faas_objid) 
  REFERENCES faas (objid)
go   
alter table resection_item add CONSTRAINT FK_resection_item_item FOREIGN KEY (parent_objid) 
  REFERENCES resection (objid)
go   
alter table resection_item add CONSTRAINT FK_resection_item_newfaas FOREIGN KEY (newfaas_objid) 
  REFERENCES faas (objid)
go     



CREATE TABLE resection_task (
  objid varchar(50) NOT NULL,
  refid varchar(50) DEFAULT NULL,
  parentprocessid varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  startdate datetime DEFAULT NULL,
  enddate datetime DEFAULT NULL,
  assignee_objid varchar(50) DEFAULT NULL,
  assignee_name varchar(100) DEFAULT NULL,
  assignee_title varchar(80) DEFAULT NULL,
  actor_objid varchar(50) DEFAULT NULL,
  actor_name varchar(100) DEFAULT NULL,
  actor_title varchar(80) DEFAULT NULL,
  message varchar(255) DEFAULT NULL,
  signature text,
  PRIMARY KEY (objid)
)
go 


create index  ix_assignee_objid on resection_task (assignee_objid)
go 
create index  ix_refid on resection_task (refid)
go 



delete from sys_wf_transition where processname ='resection'
go
delete from sys_wf_node where processname ='resection'
go 

INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('start', 'resection', 'Start', 'start', '1', NULL, 'RPT', NULL)
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('receiver', 'resection', 'Review and Verification', 'state', '5', NULL, 'RPT', 'RECEIVER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-examiner', 'resection', 'For Examination', 'state', '10', NULL, 'RPT', 'EXAMINER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('examiner', 'resection', 'Examination', 'state', '15', NULL, 'RPT', 'EXAMINER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-taxmapper', 'resection', 'For Taxmapping', 'state', '20', NULL, 'RPT', 'TAXMAPPER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('taxmapper', 'resection', 'Taxmapping', 'state', '25', NULL, 'RPT', 'TAXMAPPER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-taxmapping-approval', 'resection', 'For Taxmapping Approval', 'state', '30', NULL, 'RPT', 'TAXMAPPER_CHIEF')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('taxmapper_chief', 'resection', 'Taxmapping Approval', 'state', '35', NULL, 'RPT', 'TAXMAPPER_CHIEF')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-appraiser', 'resection', 'For Appraisal', 'state', '40', NULL, 'RPT', 'APPRAISER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('appraiser', 'resection', 'Appraisal', 'state', '45', NULL, 'RPT', 'APPRAISER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-appraisal-chief', 'resection', 'For Appraisal Approval', 'state', '50', NULL, 'RPT', 'APPRAISAL_CHIEF')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('appraiser_chief', 'resection', 'Appraisal Approval', 'state', '55', NULL, 'RPT', 'APPRAISAL_CHIEF')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-recommender', 'resection', 'For Recommending Aprpoval', 'state', '70', NULL, 'RPT', 'RECOMMENDER,ASSISTANT_ASSESSOR')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('recommender', 'resection', 'Assessor Approval', 'state', '75', NULL, 'RPT', 'RECOMMENDER,ASSISTANT_ASSESSOR')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-approver', 'resection', 'Assign Approver', 'state', '76', NULL, 'RPT', 'APPROVER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('approver', 'resection', 'Assessor Approval', 'state', '90', NULL, 'RPT', 'APPROVER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('cityapprover', 'resection', 'City Approver', 'state', '100', NULL, 'RPT', 'APPROVER')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-record', 'resection', 'For Record Section', 'state', '101', NULL, 'RPT', 'RECORD')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('record', 'resection', 'Record', 'state', '105', NULL, 'RPT', 'RECORD')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('assign-release', 'resection', 'For Release', 'state', '110', NULL, 'RPT', 'RELEASING')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('release', 'resection', 'Release', 'state', '115', NULL, 'RPT', 'RELEASING')
go
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role]) VALUES ('end', 'resection', 'End', 'end', '1000', NULL, 'RPT', NULL)
go

INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('start', 'resection', '', 'receiver', '1', NULL, NULL, 'RECEIVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('receiver', 'resection', 'submit_examiner', 'assign-examiner', '5', NULL, '[caption:''Submit For Examination'', confirm:''Submit?'']', 'RECEIVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('receiver', 'resection', 'submit_taxmapper', 'assign-taxmapper', '5', NULL, '[caption:''Submit For Taxmapping'', confirm:''Submit?'']', 'RECEIVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('receiver', 'resection', 'delete', 'end', '6', NULL, '[caption:''Delete'', confirm:''Delete?'', closeonend:true]', 'RECEIVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-examiner', 'resection', '', 'examiner', '10', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', 'EXAMINER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('examiner', 'resection', 'returnreceiver', 'receiver', '15', NULL, '[caption:''Return to Receiver'', confirm:''Return to receiver?'', messagehandler:''default'']', 'EXAMINER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('examiner', 'resection', 'submit', 'assign-taxmapper', '16', NULL, '[caption:''Submit for Taxmapping'', confirm:''Submit?'']', 'EXAMINER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-taxmapper', 'resection', '', 'taxmapper', '20', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', 'TAXMAPPER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('taxmapper', 'resection', 'returnexaminer', 'examiner', '25', NULL, '[caption:''Return to Examiner'', confirm:''Return to examiner?'', messagehandler:''default'']', 'TAXMAPPER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('taxmapper', 'resection', 'submit', 'assign-appraiser', '26', NULL, '[caption:''Submit for Appraisal'', confirm:''Submit?'', messagehandler:''rptmessage:create'']', 'TAXMAPPER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-appraiser', 'resection', '', 'appraiser', '40', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', 'APPRAISER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('appraiser', 'resection', 'returntaxmapper', 'taxmapper', '45', NULL, '[caption:''Return to Taxmapper'', confirm:''Return to taxmapper?'', messagehandler:''default'']', 'APPRAISER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('appraiser', 'resection', 'returnexaminer', 'examiner', '46', NULL, '[caption:''Return to Examiner'', confirm:''Return to examiner?'', messagehandler:''default'']', 'APPRAISER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('appraiser', 'resection', 'submit', 'assign-recommender', '47', NULL, '[caption:''Submit for Recommending Approval'', confirm:''Submit?'', messagehandler:''default'']', 'APPRAISER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-recommender', 'resection', '', 'recommender', '70', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', 'RECOMMENDER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('recommender', 'resection', 'returnexaminer', 'examiner', '75', NULL, '[caption:''Return to Examiner'', confirm:''Return to examiner?'', messagehandler:''default'']', 'RECOMMENDER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('recommender', 'resection', 'returntaxmapper', 'taxmapper', '76', NULL, '[caption:''Return to Taxmapper'', confirm:''Return to taxmapper?'', messagehandler:''default'']', 'RECOMMENDER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('recommender', 'resection', 'returnappraiser', 'appraiser', '77', NULL, '[caption:''Return to Appraiser'', confirm:''Return to appraiser?'', messagehandler:''default'']', 'RECOMMENDER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('recommender', 'resection', 'submit', 'assign-approver', '78', NULL, '[caption:''Submit to Assessor'', confirm:''Submit to Assessor Approval'', messagehandler:''default'']', 'RECOMMENDER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-approver', 'resection', '', 'approver', '80', NULL, '[caption:''Assign to Me'', confirm:''Assign task to you?'']', 'APPROVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('approver', 'resection', 'approve', 'cityapprover', '81', NULL, '[caption:''Approve'', confirm:''Assign task to you?'', messagehandler:''default'']', 'APPROVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('approver', 'resection', 'return_recommender', 'recommender', '82', NULL, '[caption:''Return to Recommender'',confirm:''Return to Recommender?'', messagehandler:''default'']', 'APPROVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('approver', 'resection', 'return_taxmapper', 'taxmapper', '83', NULL, '[caption:''Return to Taxmapper'',confirm:''Return to Taxmapper?'', messagehandler:''default'']', 'APPROVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('approver', 'resection', 'return_appraiser', 'appraiser', '84', NULL, '[caption:''Return to Appraiser'',confirm:''Return to Appraiser?'', messagehandler:''default'']', 'APPROVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('cityapprover', 'resection', 'backapprover', 'approver', '85', NULL, '[caption:''Cancel Posting'', confirm:''Cancel posting record?'']', 'APPROVER')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('cityapprover', 'resection', 'completed', 'assign-record', '95', NULL, '[caption:''Approved'', visible:false]', '')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-record', 'resection', '', 'record', '105', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', '')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('record', 'resection', 'submit', 'assign-release', '110', NULL, '[caption:''Submit for Releasing'',confirm:''Submit for releasing?'',messagehandler:''default'']', '')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('assign-release', 'resection', '', 'release', '115', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', '')
go
INSERT INTO sys_wf_transition (parentid, processname, [action], [to], idx, eval, properties, permission) VALUES ('release', 'resection', 'submit', 'end', '120', NULL, '[caption:''Receive Documents'',confirm:''Receive documents?'',messagehandler:''default'', closeonend:false]', '')
go

/* 255-03001 */
alter table rptcertification add properties varchar(2000)
go 

	
alter table faas_signatory add reviewer_objid varchar(50)
go 
alter table faas_signatory add reviewer_name varchar(100)
go 
alter table faas_signatory add reviewer_title varchar(75)
go 
alter table faas_signatory add reviewer_dtsigned datetime
go 
alter table faas_signatory add reviewer_taskid varchar(50)
go 
alter table faas_signatory add assessor_name varchar(100)
go 
alter table faas_signatory add assessor_title varchar(100)
go 


alter table cancelledfaas_signatory add reviewer_objid varchar(50)
go 
alter table cancelledfaas_signatory add reviewer_name varchar(100)
go 
alter table cancelledfaas_signatory add reviewer_title varchar(75)
go 
alter table cancelledfaas_signatory add reviewer_dtsigned datetime
go 
alter table cancelledfaas_signatory add reviewer_taskid varchar(50)
go 
alter table cancelledfaas_signatory add assessor_name varchar(100)
go 
alter table cancelledfaas_signatory add assessor_title varchar(100)
go 



    

CREATE TABLE rptacknowledgement (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  txnno varchar(25) NOT NULL,
  txndate datetime DEFAULT NULL,
  taxpayer_objid varchar(50) DEFAULT NULL,
  txntype_objid varchar(50) DEFAULT NULL,
  releasedate datetime DEFAULT NULL,
  releasemode varchar(50) DEFAULT NULL,
  receivedby varchar(255) DEFAULT NULL,
  remarks varchar(255) DEFAULT NULL,
  pin varchar(25) DEFAULT NULL,
  createdby_objid varchar(25) DEFAULT NULL,
  createdby_name varchar(25) DEFAULT NULL,
  createdby_title varchar(25) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go 

create UNIQUE index  ux_rptacknowledgement_txnno on rptacknowledgement(txnno)
go 
create index ix_rptacknowledgement_pin on rptacknowledgement(pin)
go 
create index ix_rptacknowledgement_taxpayerid on rptacknowledgement(taxpayer_objid)
go 


CREATE TABLE rptacknowledgement_item (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  trackingno varchar(25) NULL,
  faas_objid varchar(50) DEFAULT NULL,
  newfaas_objid varchar(50) DEFAULT NULL,
  remarks varchar(255) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

alter table rptacknowledgement_item 
  add constraint fk_rptacknowledgement_item_rptacknowledgement
  foreign key (parent_objid) references rptacknowledgement(objid)
go 

create index ix_rptacknowledgement_parentid on rptacknowledgement_item(parent_objid)
go 

create unique index ux_rptacknowledgement_itemno on rptacknowledgement_item(trackingno)
go 

create index ix_rptacknowledgement_item_faasid  on rptacknowledgement_item(faas_objid)
go 

create index ix_rptacknowledgement_item_newfaasid on rptacknowledgement_item(newfaas_objid)
go 


    

drop  view vw_faas_lookup
go 

CREATE view vw_faas_lookup AS 
select 
  fl.objid AS objid,
  fl.state AS state,
  fl.rpuid AS rpuid,
  fl.utdno AS utdno,
  fl.tdno AS tdno,
  fl.txntype_objid AS txntype_objid,
  fl.effectivityyear AS effectivityyear,
  fl.effectivityqtr AS effectivityqtr,
  fl.taxpayer_objid AS taxpayer_objid,
  fl.owner_name AS owner_name,
  fl.owner_address AS owner_address,
  fl.prevtdno AS prevtdno,
  fl.cancelreason AS cancelreason,
  fl.cancelledbytdnos AS cancelledbytdnos,
  fl.lguid AS lguid,
  fl.realpropertyid AS realpropertyid,
  fl.displaypin AS fullpin,
  fl.originlguid AS originlguid,
  e.name AS taxpayer_name,
  e.address_text AS taxpayer_address,
  pc.code AS classification_code,
  pc.code AS classcode,
  pc.name AS classification_name,
  pc.name AS classname,
  fl.ry AS ry,
  fl.rputype AS rputype,
  fl.totalmv AS totalmv,
  fl.totalav AS totalav,
  fl.totalareasqm AS totalareasqm,
  fl.totalareaha AS totalareaha,
  fl.barangayid AS barangayid,
  fl.cadastrallotno AS cadastrallotno,
  fl.blockno AS blockno,
  fl.surveyno AS surveyno,
  fl.pin AS pin,
  fl.barangay AS barangay_name,
  fl.trackingno
from faas_list fl
left join propertyclassification pc on fl.classification_objid = pc.objid
left join entity e on fl.taxpayer_objid = e.objid
go 



alter table faas_list alter column prevtdno varchar(800)
go 
alter table faas_list alter column owner_name varchar(2000)
go 
alter table faas_list alter column cadastrallotno varchar(500)
go 


create index ix_faaslist_prevtdno on faas_list(prevtdno)
go 
create index ix_faaslist_cadastrallotno on faas_list(cadastrallotno)
go 
create index ix_faaslist_owner_name on faas_list(owner_name)
go 
create index ix_faaslist_txntype_objid on faas_list(txntype_objid)
go 



alter table rptledger alter column prevtdno varchar(800)
go 
create index ix_rptledger_prevtdno on rptledger(prevtdno)
go 
create index ix_rptledgerfaas_tdno on rptledgerfaas(tdno)
go 

  
alter table rptledger alter column owner_name varchar(1500) not null
go 
create index ix_rptledger_owner_name on rptledger(owner_name)
go 

/* 255-03012 */

/*=====================================
* LEDGER TAG
=====================================*/
CREATE TABLE rptledger_tag (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  tag varchar(255) NOT NULL,
  PRIMARY KEY (objid)
)
go 

create UNIQUE index ux_rptledger_tag on rptledger_tag(parent_objid,tag)
go 

create index FK_rptledgertag_rptledger on rptledger_tag(parent_objid)
go 
  
alter table rptledger_tag 
    add CONSTRAINT FK_rptledgertag_rptledger 
    FOREIGN KEY (parent_objid) REFERENCES rptledger (objid)
go     

/* 255-03013 */
alter table resection_item add newfaas_claimno varchar(25)
go
alter table resection_item add faas_claimno varchar(25)
go 


/* 255-03015 */

create table rptcertification_online (
  objid varchar(50) not null,
  state varchar(25) not null,
  reftype varchar(25) not null,
  refid varchar(50) not null,
  refno varchar(50) not null,
  refdate date not null,
  orno varchar(25) default null,
  ordate date default null,
  oramount decimal(16,2) default null,
  primary key (objid)
)
go 

alter table rptcertification_online 
	add constraint fk_rptcertification_online_rptcertification foreign key (objid) references rptcertification (objid)
go 
 
create index ix_state on rptcertification_online(state)
go 
 
create index ix_refid on rptcertification_online(refid)
go 
 
create index ix_refno on rptcertification_online(refno)
go 
 
create index ix_orno on rptcertification_online(orno)
go 
  



CREATE TABLE assessmentnotice_online (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  reftype varchar(25) NOT NULL,
  refid varchar(50) NOT NULL,
  refno varchar(50) NOT NULL,
  refdate date NOT NULL,
  orno varchar(25) DEFAULT NULL,
  ordate date DEFAULT NULL,
  oramount decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go 

create index ix_state on assessmentnotice_online (state)
go 
create index ix_refid on assessmentnotice_online (refid)
go 
create index ix_refno on assessmentnotice_online (refno)
go 
create index ix_orno on assessmentnotice_online (orno)
go 
  
alter table assessmentnotice_online 
  add CONSTRAINT fk_assessmentnotice_online_assessmentnotice 
  FOREIGN KEY (objid) REFERENCES assessmentnotice (objid)
go   



/*===============================================================
**
** FAAS ANNOTATION
**
===============================================================*/
CREATE TABLE faasannotation_faas (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  faas_objid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
) 
go 


alter table faasannotation_faas 
add constraint fk_faasannotationfaas_faasannotation foreign key(parent_objid)
references faasannotation (objid)
go

alter table faasannotation_faas 
add constraint fk_faasannotationfaas_faas foreign key(faas_objid)
references faas (objid)
go

create index ix_parent_objid on faasannotation_faas(parent_objid)
go

create index ix_faas_objid on faasannotation_faas(faas_objid)
go


create unique index ux_parent_faas on faasannotation_faas(parent_objid, faas_objid)
go

alter table faasannotation alter column faasid varchar(50) null
go



-- insert annotated faas
insert into faasannotation_faas(
  objid, 
  parent_objid,
  faas_objid 
)
select 
  objid, 
  objid as parent_objid,
  faasid as faas_objid 
from faasannotation
go
  


/*============================================
*
*  LEDGER FAAS FACTS
*
=============================================*/
INSERT INTO sys_var ([name], [value], [description], [datatype], [category]) 
VALUES ('rptledger_rule_include_ledger_faases', '0', 'Include Ledger FAASes as rule facts', 'checkbox', 'LANDTAX')
go

INSERT INTO sys_var ([name], [value], [description], [datatype], [category]) 
VALUES ('rptledger_post_ledgerfaas_by_actualuse', '0', 'Post by Ledger FAAS by actual use', 'checkbox', 'LANDTAX')
go 


/* 255-03016 */

/*================================================================
*
* RPTLEDGER REDFLAG
*
================================================================*/

CREATE TABLE rptledger_redflag (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  caseno varchar(25) NULL,
  dtfiled datetime NULL,
  type varchar(25) NOT NULL,
  finding text,
  remarks text,
  blockaction varchar(25) DEFAULT NULL,
  filedby_objid varchar(50) DEFAULT NULL,
  filedby_name varchar(255) DEFAULT NULL,
  filedby_title varchar(50) DEFAULT NULL,
  resolvedby_objid varchar(50) DEFAULT NULL,
  resolvedby_name varchar(255) DEFAULT NULL,
  resolvedby_title varchar(50) DEFAULT NULL,
  dtresolved datetime NULL,
  PRIMARY KEY (objid)
) 
go

create index ix_parent_objid on rptledger_redflag(parent_objid)
go
create index ix_state on rptledger_redflag(state)
go
create unique index ux_caseno on rptledger_redflag(caseno)
go
create index ix_type on rptledger_redflag(type)
go
create index ix_filedby_objid on rptledger_redflag(filedby_objid)
go
create index ix_resolvedby_objid on rptledger_redflag(resolvedby_objid)
go

alter table rptledger_redflag 
add constraint fk_rptledger_redflag_rptledger foreign key (parent_objid)
references rptledger(objid)
go

alter table rptledger_redflag 
add constraint fk_rptledger_redflag_filedby foreign key (filedby_objid)
references sys_user(objid)
go

alter table rptledger_redflag 
add constraint fk_rptledger_redflag_resolvedby foreign key (resolvedby_objid)
references sys_user(objid)
go




/*==================================================
* RETURNED TASK 
==================================================*/
alter table faas_task add returnedby varchar(100)
go 
alter table subdivision_task add returnedby varchar(100)
go 
alter table consolidation_task add returnedby varchar(100)
go 
alter table cancelledfaas_task add returnedby varchar(100)
go 
alter table resection_task add returnedby varchar(100)
go 


/* 255-03016 */

/*================================================================
*
* LANDTAX SHARE POSTING
*
================================================================*/
alter table rptpayment_share add iscommon int
go 

alter table rptpayment_share add year int
go 

update rptpayment_share set iscommon = 0 where iscommon is null 
go 




CREATE TABLE cashreceipt_rpt_share_forposting (
  objid varchar(50) NOT NULL,
  receiptid varchar(50) NOT NULL,
  rptledgerid varchar(50) NOT NULL,
  txndate datetime,
  error int NOT NULL,
  msg text,
  PRIMARY KEY (objid)
) 
go 


create UNIQUE index ux_receiptid_rptledgerid on cashreceipt_rpt_share_forposting (receiptid,rptledgerid)
go 
create index fk_cashreceipt_rpt_share_forposing_rptledger on cashreceipt_rpt_share_forposting (rptledgerid)
go 
create index fk_cashreceipt_rpt_share_forposing_cashreceipt on cashreceipt_rpt_share_forposting (receiptid)
go 

alter table cashreceipt_rpt_share_forposting add CONSTRAINT fk_cashreceipt_rpt_share_forposing_rptledger 
FOREIGN KEY (rptledgerid) REFERENCES rptledger (objid)
go 
alter table cashreceipt_rpt_share_forposting add CONSTRAINT fk_cashreceipt_rpt_share_forposing_cashreceipt 
FOREIGN KEY (receiptid) REFERENCES cashreceipt (objid)
go 




/*==================================================
**
** BLDG DATE CONSTRUCTED SUPPORT 
**
===================================================*/

alter table bldgrpu add dtconstructed date
go 

/* 255-03018 */

/*==================================================
**
** ONLINE BATCH GR 
**
===================================================*/

if exists(select * from sysobjects where id = object_id('vw_batchgr')) 
begin 
	drop view vw_batchgr
end 
go 


if exists(select * from sysobjects where id = object_id('batchgr_log')) 
begin 
	drop table batchgr_log
end 
go 

if exists(select * from sysobjects where id = object_id('batchgr_error')) 
begin 
	drop table batchgr_error
end 
go 

if exists(select * from sysobjects where id = object_id('batchgr_forprocess')) 
begin 
	drop table batchgr_forprocess
end 
go 

if exists(select * from sysobjects where id = object_id('batchgr_task')) 
begin 
	drop table batchgr_task
end 
go 


if exists(select * from sysobjects where id = object_id('batchgr_item')) 
begin 
	drop table batchgr_item
end 
go 


if exists(select * from sysobjects where id = object_id('batchgr')) 
begin 
	drop table batchgr
end 
go 



create table batchgr (
  objid varchar(50) not null,
  state varchar(50) not null,
  ry int not null,
  txntype_objid varchar(5) not null,
  txnno varchar(25) not null,
  txndate datetime not null,
  effectivityyear int not null,
  effectivityqtr int not null,
  memoranda varchar(255) not null,
  originlguid varchar(50) not null,
  lguid varchar(50) not null,
  barangayid varchar(50) not null,
  rputype varchar(15) default null,
  classificationid varchar(50) default null,
  section varchar(10) default null,
  primary key (objid)
)
go 

create index ix_state on batchgr(state)
go
create index ix_ry on batchgr(ry)
go
create index ix_txnno on batchgr(txnno)
go
create index ix_lguid on batchgr(lguid)
go
create index ix_barangayid on batchgr(barangayid)
go
create index ix_classificationid on batchgr(classificationid)
go
create index ix_section on batchgr(section)
go

alter table batchgr 
add constraint fk_batchgr_lguid foreign key(lguid) 
references sys_org(objid)
go

alter table batchgr 
add constraint fk_batchgr_barangayid foreign key(barangayid) 
references sys_org(objid)
go

alter table batchgr 
add constraint fk_batchgr_classificationid foreign key(classificationid) 
references propertyclassification(objid)
go


create table batchgr_item (
  objid varchar(50) not null,
  parent_objid varchar(50) not null,
  state varchar(50) not null,
  rputype varchar(15) not null,
  tdno varchar(50) not null,
  fullpin varchar(50) not null,
  pin varchar(50) not null,
  suffix int not null,
  subsuffix int null,
  newfaasid varchar(50) default null,
  error text,
  primary key (objid)
) 
go

create index ix_parent_objid on batchgr_item(parent_objid)
go
create index ix_tdno on batchgr_item(tdno)
go
create index ix_pin on batchgr_item(pin)
go
create index ix_newfaasid on batchgr_item(newfaasid)
go

alter table batchgr_item 
add constraint fk_batchgr_item_batchgr foreign key(parent_objid) 
references batchgr(objid)
go

alter table batchgr_item 
add constraint fk_batchgr_item_faas foreign key(newfaasid) 
references faas(objid)
go

create table batchgr_task (
  objid varchar(50) not null,
  refid varchar(50) default null,
  parentprocessid varchar(50) default null,
  state varchar(50) default null,
  startdate datetime default null,
  enddate datetime default null,
  assignee_objid varchar(50) default null,
  assignee_name varchar(100) default null,
  assignee_title varchar(80) default null,
  actor_objid varchar(50) default null,
  actor_name varchar(100) default null,
  actor_title varchar(80) default null,
  message varchar(255) default null,
  signature text,
  returnedby varchar(100) default null,
  primary key (objid)
)
go 

create index ix_assignee_objid on batchgr_task(assignee_objid)
go
create index ix_refid on batchgr_task(refid)
go

alter table batchgr_task 
add constraint fk_batchgr_task_batchgr foreign key(refid) 
references batchgr(objid)
go


create view vw_batchgr 
as 
select 
  bg.*,
  l.name as lgu_name,
  b.name as barangay_name,
  pc.name as classification_name,
  t.objid AS taskid,
  t.state AS taskstate,
  t.assignee_objid 
from batchgr bg
inner join sys_org l on bg.lguid = l.objid 
left join sys_org b on bg.barangayid = b.objid
left join propertyclassification pc on bg.classificationid = pc.objid 
left join batchgr_task t on bg.objid = t.refid  and t.enddate is null 
go




/*===========================================
*
*  ENTITY MAPPING (PROVINCE)
*
============================================*/
if exists(select * from sysobjects where id = object_id('entity_mapping')) 
begin 
  drop table entity_mapping
end 
go 

CREATE TABLE entity_mapping (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  org_objid varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go

if exists(select * from sysobjects where id = object_id('vw_entity_mapping')) 
begin 
  drop view vw_entity_mapping
end 
go 

create view vw_entity_mapping
as 
select 
  r.*,
  e.entityno,
  e.name, 
  e.address_text as address_text,
  a.province as address_province,
  a.municipality as address_municipality
from entity_mapping r 
inner join entity e on r.objid = e.objid 
left join entity_address a on e.address_objid = a.objid
left join sys_org b on a.barangay_objid = b.objid 
left join sys_org m on b.parent_objid = m.objid 
go



/*===========================================
*
*  CERTIFICATION UPDATES
*
============================================*/
if exists(select * from sysobjects where id = object_id('vw_rptcertification_item')) 
begin 
  drop view vw_rptcertification_item
end 
go 

create view vw_rptcertification_item
as 
SELECT 
  rci.rptcertificationid,
  f.objid as faasid,
  f.fullpin, 
  f.tdno,
  e.objid as taxpayerid,
  e.name as taxpayer_name, 
  f.owner_name, 
  f.administrator_name,
  f.titleno,  
  f.rpuid, 
  pc.code AS classcode, 
  pc.name AS classname,
  so.name AS lguname,
  b.name AS barangay, 
  r.rputype, 
  r.suffix,
  r.totalareaha AS totalareaha,
  r.totalareasqm AS totalareasqm,
  r.totalav,
  r.totalmv, 
  rp.street,
  rp.blockno,
  rp.cadastrallotno,
  rp.surveyno,
  r.taxable,
  f.effectivityyear,
  f.effectivityqtr
FROM rptcertificationitem rci 
  INNER JOIN faas f ON rci.refid = f.objid 
  INNER JOIN rpu r ON f.rpuid = r.objid 
  INNER JOIN propertyclassification pc ON r.classification_objid = pc.objid 
  INNER JOIN realproperty rp ON f.realpropertyid = rp.objid 
  INNER JOIN barangay b ON rp.barangayid = b.objid 
  INNER JOIN sys_org so on f.lguid = so.objid 
  INNER JOIN entity e on f.taxpayer_objid = e.objid 
go




/*===========================================
*
*  SUBDIVISION ASSISTANCE
*
============================================*/
if exists(select * from sysobjects where id = object_id('subdivision_assist_item')) 
begin 
  drop view subdivision_assist_item
end 
go 

if exists(select * from sysobjects where id = object_id('subdivision_assist')) 
begin 
  drop view subdivision_assist
end 
go 




CREATE TABLE subdivision_assist (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  taskstate varchar(50) NOT NULL,
  assignee_objid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
)
go

alter table subdivision_assist 
add constraint fk_subdivision_assist_subdivision foreign key(parent_objid)
references subdivision(objid)
go

alter table subdivision_assist 
add constraint fk_subdivision_assist_user foreign key(assignee_objid)
references sys_user(objid)
go

create index ix_parent_objid on subdivision_assist(parent_objid)
go

create index ix_assignee_objid on subdivision_assist(assignee_objid)
go

create unique index ux_parent_assignee on subdivision_assist(parent_objid, taskstate, assignee_objid)
go


CREATE TABLE subdivision_assist_item (
  objid varchar(50) NOT NULL,
  subdivision_objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  pintype varchar(10) NOT NULL,
  section varchar(5) NOT NULL,
  startparcel int NOT NULL,
  endparcel int NOT NULL,
  parcelcount int NOT NULL,
  parcelcreated int NULL,
  PRIMARY KEY (objid)
)
go

alter table subdivision_assist_item 
add constraint fk_subdivision_assist_item_subdivision foreign key(subdivision_objid)
references subdivision(objid)
go

alter table subdivision_assist_item 
add constraint fk_subdivision_assist_item_subdivision_assist foreign key(parent_objid)
references subdivision_assist(objid)
go

create index ix_subdivision_objid on subdivision_assist_item(subdivision_objid)
go

create index ix_parent_objid on subdivision_assist_item(parent_objid)
go







/*==================================================
**
** REALTY TAX CREDIT
**
===================================================*/

if exists(select * from sysobjects where id = object_id('rpttaxcredit')) 
begin 
  drop view rpttaxcredit
end 
go 


CREATE TABLE rpttaxcredit (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  type varchar(25) NOT NULL,
  txnno varchar(25) DEFAULT NULL,
  txndate datetime DEFAULT NULL,
  reftype varchar(25) DEFAULT NULL,
  refid varchar(50) DEFAULT NULL,
  refno varchar(25) NOT NULL,
  refdate date NOT NULL,
  amount decimal(16,2) NOT NULL,
  amtapplied decimal(16,2) NOT NULL,
  rptledger_objid varchar(50) NOT NULL,
  srcledger_objid varchar(50) DEFAULT NULL,
  remarks varchar(255) DEFAULT NULL,
  approvedby_objid varchar(50) DEFAULT NULL,
  approvedby_name varchar(150) DEFAULT NULL,
  approvedby_title varchar(75) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go


create index ix_state on rpttaxcredit(state)
go

create index ix_type on rpttaxcredit(type)
go

create unique index ux_txnno on rpttaxcredit(txnno)
go

create index ix_reftype on rpttaxcredit(reftype)
go

create index ix_refid on rpttaxcredit(refid)
go

create index ix_refno on rpttaxcredit(refno)
go

create index ix_rptledger_objid on rpttaxcredit(rptledger_objid)
go

create index ix_srcledger_objid on rpttaxcredit(srcledger_objid)
go

alter table rpttaxcredit
add constraint fk_rpttaxcredit_rptledger foreign key (rptledger_objid)
references rptledger (objid)
go

alter table rpttaxcredit
add constraint fk_rpttaxcredit_srcledger foreign key (srcledger_objid)
references rptledger (objid)
go

alter table rpttaxcredit
add constraint fk_rpttaxcredit_sys_user foreign key (approvedby_objid)
references sys_user(objid)
go







/*==================================================
**
** MACHINE SMV
**
===================================================*/

CREATE TABLE machine_smv (
  objid varchar(50) NOT NULL,
  parent_objid varchar(50) NOT NULL,
  machine_objid varchar(50) NOT NULL,
  expr varchar(255) NOT NULL,
  previd varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go

create index ix_parent_objid on machine_smv(parent_objid)
go
create index ix_machine_objid on machine_smv(machine_objid)
go
create index ix_previd on machine_smv(previd)
go
create unique index ux_parent_machine on machine_smv(parent_objid, machine_objid)
go



alter table machine_smv
add constraint fk_machinesmv_machrysetting foreign key (parent_objid)
references machrysetting (objid)
go

alter table machine_smv
add constraint fk_machinesmv_machine foreign key (machine_objid)
references machine(objid)
go


alter table machine_smv
add constraint fk_machinesmv_machinesmv foreign key (previd)
references machine_smv(objid)
go


create view vw_machine_smv 
as 
select 
  ms.*, 
  m.code,
  m.name
from machine_smv ms 
inner join machine m on ms.machine_objid = m.objid 
go


alter table machdetail add smvid varchar(50)
go 
alter table machdetail add params text
go

update machdetail set params = '[]' where params is null
go

create index ix_smvid on machdetail(smvid)
go


alter table machdetail 
add constraint fk_machdetail_machine_smv foreign key(smvid)
references machine_smv(objid)
go 





/*==================================================
**
** SUBDIVISION AFFECTED RPUS TXNTYPE (DP)
**
===================================================*/

INSERT INTO sys_var (name, value, description, datatype, category) 
VALUES ('faas_affected_rpu_txntype_dp', '0', 'Set affected improvements FAAS txntype to DP e.g. SD and CS', 'checkbox', 'ASSESSOR')
go


delete from sys_wf_transition where processname = 'batchgr'
go
delete from sys_wf_node where processname = 'batchgr'
go



INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('start', 'batchgr', 'Start', 'start', '1', NULL, 'RPT', 'START', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-receiver', 'batchgr', 'For Review and Verification', 'state', '2', NULL, 'RPT', 'RECEIVER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('receiver', 'batchgr', 'Review and Verification', 'state', '5', NULL, 'RPT', 'RECEIVER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-examiner', 'batchgr', 'For Examination', 'state', '10', NULL, 'RPT', 'EXAMINER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('examiner', 'batchgr', 'Examination', 'state', '15', NULL, 'RPT', 'EXAMINER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-taxmapper', 'batchgr', 'For Taxmapping', 'state', '20', NULL, 'RPT', 'TAXMAPPER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-provtaxmapper', 'batchgr', 'For Taxmapping', 'state', '20', NULL, 'RPT', 'TAXMAPPER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('taxmapper', 'batchgr', 'Taxmapping', 'state', '25', NULL, 'RPT', 'TAXMAPPER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('provtaxmapper', 'batchgr', 'Taxmapping', 'state', '25', NULL, 'RPT', 'TAXMAPPER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-taxmapping-approval', 'batchgr', 'For Taxmapping Approval', 'state', '30', NULL, 'RPT', 'TAXMAPPER_CHIEF', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('taxmapper_chief', 'batchgr', 'Taxmapping Approval', 'state', '35', NULL, 'RPT', 'TAXMAPPER_CHIEF', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-appraiser', 'batchgr', 'For Appraisal', 'state', '40', NULL, 'RPT', 'APPRAISER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-provappraiser', 'batchgr', 'For Appraisal', 'state', '40', NULL, 'RPT', 'APPRAISER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('appraiser', 'batchgr', 'Appraisal', 'state', '45', NULL, 'RPT', 'APPRAISER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('provappraiser', 'batchgr', 'Appraisal', 'state', '45', NULL, 'RPT', 'APPRAISER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-appraisal-chief', 'batchgr', 'For Appraisal Approval', 'state', '50', NULL, 'RPT', 'APPRAISAL_CHIEF', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('appraiser_chief', 'batchgr', 'Appraisal Approval', 'state', '55', NULL, 'RPT', 'APPRAISAL_CHIEF', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-recommender', 'batchgr', 'For Recommending Approval', 'state', '70', NULL, 'RPT', 'RECOMMENDER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('recommender', 'batchgr', 'Recommending Approval', 'state', '75', NULL, 'RPT', 'RECOMMENDER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('forprovsubmission', 'batchgr', 'For Province Submission', 'state', '80', NULL, 'RPT', 'RECOMMENDER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('forprovapproval', 'batchgr', 'For Province Approval', 'state', '81', NULL, 'RPT', 'RECOMMENDER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('forapproval', 'batchgr', 'Provincial Assessor Approval', 'state', '85', NULL, 'RPT', 'APPROVER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-approver', 'batchgr', 'For Provincial Assessor Approval', 'state', '90', NULL, 'RPT', 'APPROVER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('approver', 'batchgr', 'Provincial Assessor Approval', 'state', '95', NULL, 'RPT', 'APPROVER,ASSESSOR', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('provapprover', 'batchgr', 'Approved By Province', 'state', '96', NULL, 'RPT', 'APPROVER', NULL, NULL, NULL)
go 
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('end', 'batchgr', 'End', 'end', '1000', NULL, 'RPT', NULL, NULL, NULL, NULL)
go 

INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('start', 'batchgr', '', 'assign-receiver', '1', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('assign-receiver', 'batchgr', '', 'receiver', '2', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('receiver', 'batchgr', 'submit', 'assign-provtaxmapper', '5', NULL, '[caption:''Submit For Taxmapping'', confirm:''Submit?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('assign-examiner', 'batchgr', '', 'examiner', '10', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('examiner', 'batchgr', 'returnreceiver', 'receiver', '15', NULL, '[caption:''Return to Receiver'', confirm:''Return to receiver?'', messagehandler:''default'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('examiner', 'batchgr', 'submit', 'assign-provtaxmapper', '16', NULL, '[caption:''Submit for Approval'', confirm:''Submit?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('assign-provtaxmapper', 'batchgr', '', 'provtaxmapper', '20', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provtaxmapper', 'batchgr', 'returnexaminer', 'examiner', '25', NULL, '[caption:''Return to Examiner'', confirm:''Return to examiner?'', messagehandler:''default'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provtaxmapper', 'batchgr', 'submit', 'assign-provappraiser', '26', NULL, '[caption:''Submit for Approval'', confirm:''Submit?'', messagehandler:''rptmessage:sign'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('assign-provappraiser', 'batchgr', '', 'provappraiser', '40', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provappraiser', 'batchgr', 'returntaxmapper', 'provtaxmapper', '45', NULL, '[caption:''Return to Taxmapper'', confirm:''Return to taxmapper?'', messagehandler:''default'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provappraiser', 'batchgr', 'returnexaminer', 'examiner', '46', NULL, '[caption:''Return to Examiner'', confirm:''Return to examiner?'', messagehandler:''default'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provappraiser', 'batchgr', 'submit', 'assign-approver', '47', NULL, '[caption:''Submit for Approval'', confirm:''Submit?'', messagehandler:''rptmessage:sign'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('assign-approver', 'batchgr', '', 'approver', '70', NULL, '[caption:''Assign To Me'', confirm:''Assign task to you?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('approver', 'batchgr', 'approve', 'provapprover', '90', NULL, '[caption:''Approve'', confirm:''Approve record?'', messagehandler:''rptmessage:sign'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provapprover', 'batchgr', 'backforprovapproval', 'approver', '95', NULL, '[caption:''Cancel Posting'', confirm:''Cancel posting record?'']', NULL, NULL, NULL)
go
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('provapprover', 'batchgr', 'completed', 'end', '100', NULL, '[caption:''Approved'', visible:false]', NULL, NULL, NULL)
go


alter table bldgrpu add occpermitno varchar(25)
go

alter table rpu add isonline int
go

update rpu set isonline = 0 where isonline is null 
go 

if exists(select * from sysobjects where id = OBJECT_ID('sync_data_forprocess'))
begin 
  drop table sync_data_forprocess
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('sync_data_pending'))
begin 
  drop table sync_data_pending
end 
go 


if exists(select * from sysobjects where id = OBJECT_ID('sync_data'))
begin 
  drop table sync_data
end 
go 



if exists(select * from sysobjects where id = OBJECT_ID('syncdata_pending'))
begin 
  drop table syncdata_pending
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata_forprocess'))
begin 
  drop table syncdata_forprocess
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata_item'))
begin 
  drop table syncdata_item
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata'))
begin 
  drop table syncdata
end 
go 

if exists(select * from sysobjects where id = OBJECT_ID('syncdata_forsync'))
begin 
  drop table syncdata_forsync
end 
go 



CREATE TABLE syncdata_forsync (
  objid varchar(50) NOT NULL,
  reftype varchar(100) NOT NULL,
  refno varchar(50) NOT NULL,
  action varchar(100) NOT NULL,
  orgid varchar(25) NOT NULL,
  dtfiled datetime NOT NULL,
  createdby_objid varchar(50) DEFAULT NULL,
  createdby_name varchar(255) DEFAULT NULL,
  createdby_title varchar(100) DEFAULT NULL,
  info text,
  PRIMARY KEY (objid)
) 
go

CREATE INDEX ix_dtfiled ON syncdata_forsync (dtfiled)
go
CREATE INDEX ix_createdbyid ON syncdata_forsync (createdby_objid)
go
CREATE INDEX ix_reftype ON syncdata_forsync (reftype) 
go
CREATE INDEX ix_refno ON syncdata_forsync (refno)
go


CREATE TABLE syncdata (
  objid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) DEFAULT NULL,
  action varchar(50) NOT NULL,
  dtfiled datetime NOT NULL,
  orgid varchar(50) DEFAULT NULL,
  remote_orgid varchar(50) DEFAULT NULL,
  remote_orgcode varchar(20) DEFAULT NULL,
  remote_orgclass varchar(20) DEFAULT NULL,
  sender_objid varchar(50) DEFAULT NULL,
  sender_name varchar(150) DEFAULT NULL,
  fileid varchar(255) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go

CREATE INDEX ix_reftype on syncdata (reftype)
go
CREATE INDEX ix_refno on syncdata (refno)
go
CREATE INDEX ix_orgid on syncdata (orgid)
go
CREATE INDEX ix_dtfiled on syncdata (dtfiled)
go
CREATE INDEX ix_fileid on syncdata (fileid)
go
CREATE INDEX ix_refid on syncdata (refid)
go


CREATE TABLE syncdata_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(255) NOT NULL,
  refno varchar(50) DEFAULT NULL,
  action varchar(100) NOT NULL,
  error text,
  idx int NOT NULL,
  info text,
  PRIMARY KEY (objid)
)
go

CREATE INDEX ix_parentid ON syncdata_item(parentid)
go
CREATE INDEX ix_refid ON syncdata_item(refid)
go
CREATE INDEX ix_refno ON syncdata_item(refno)
go


ALTER TABLE syncdata_item 
ADD CONSTRAINT fk_syncdataitem_syncdata 
FOREIGN KEY (parentid) REFERENCES syncdata (objid)
GO 



CREATE TABLE syncdata_forprocess (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
) 
go

CREATE INDEX ix_parentid ON syncdata_forprocess (parentid)
go 

ALTER TABLE syncdata_forprocess 
ADD CONSTRAINT fk_syncdata_forprocess_syncdata_item 
FOREIGN KEY (objid) REFERENCES syncdata_item (objid)
go


CREATE TABLE syncdata_pending (
  objid varchar(50) NOT NULL,
  error text,
  expirydate datetime DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go

CREATE INDEX ix_expirydate ON syncdata_pending(expirydate)
go 

ALTER TABLE syncdata_pending 
ADD CONSTRAINT fk_syncdata_pending_syncdata 
FOREIGN KEY (objid) REFERENCES syncdata (objid)
go



/* PREVTAXABILITY */
alter table faas_previous add prevtaxability varchar(10)
go


update pf set 
  pf.prevtaxability = case when r.taxable = 1 then 'TAXABLE' else 'EXEMPT' end 
from faas_previous pf, faas f, rpu r
where pf.prevfaasid = f.objid
and f.rpuid = r.objid 
and pf.prevtaxability is null 
go 



/* 255-03020 */

alter table syncdata_item add async int
go 
alter table syncdata_item add dependedaction varchar(100)
go


create index ix_state on syncdata(state)
go
create index ix_state on syncdata_item(state)
go


create table syncdata_offline_org (
	orgid varchar(50) not null,
	expirydate datetime not null,
	primary key(orgid)
)
go




/*=======================================
*
*  QRRPA: Mixed-Use Support
*
=======================================*/
if exists(select * from sysobjects where id = OBJECT_ID('vw_rpu_assessment'))
begin 
  drop table vw_rpu_assessment
end 
go 


create view vw_rpu_assessment as 
select 
	r.objid,
	r.rputype,
	dpc.objid as dominantclass_objid,
	dpc.code as dominantclass_code,
	dpc.name as dominantclass_name,
	dpc.orderno as dominantclass_orderno,
	ra.areasqm,
	ra.areaha,
	ra.marketvalue,
	ra.assesslevel,
	ra.assessedvalue,
	ra.taxable,
	au.code as actualuse_code, 
	au.name  as actualuse_name,
	auc.objid as actualuse_objid,
	auc.code as actualuse_classcode,
	auc.name as actualuse_classname,
	auc.orderno as actualuse_orderno
from rpu r 
inner join propertyclassification dpc on r.classification_objid = dpc.objid
inner join rpu_assessment ra on r.objid = ra.rpuid
inner join landassesslevel au on ra.actualuse_objid = au.objid 
left join propertyclassification auc on au.classification_objid = auc.objid

union 

select 
	r.objid,
	r.rputype,
	dpc.objid as dominantclass_objid,
	dpc.code as dominantclass_code,
	dpc.name as dominantclass_name,
	dpc.orderno as dominantclass_orderno,
	ra.areasqm,
	ra.areaha,
	ra.marketvalue,
	ra.assesslevel,
	ra.assessedvalue,
	ra.taxable,
	au.code as actualuse_code, 
	au.name  as actualuse_name,
	auc.objid as actualuse_objid,
	auc.code as actualuse_classcode,
	auc.name as actualuse_classname,
	auc.orderno as actualuse_orderno
from rpu r 
inner join propertyclassification dpc on r.classification_objid = dpc.objid
inner join rpu_assessment ra on r.objid = ra.rpuid
inner join bldgassesslevel au on ra.actualuse_objid = au.objid 
left join propertyclassification auc on au.classification_objid = auc.objid

union 

select 
	r.objid,
	r.rputype,
	dpc.objid as dominantclass_objid,
	dpc.code as dominantclass_code,
	dpc.name as dominantclass_name,
	dpc.orderno as dominantclass_orderno,
	ra.areasqm,
	ra.areaha,
	ra.marketvalue,
	ra.assesslevel,
	ra.assessedvalue,
	ra.taxable,
	au.code as actualuse_code, 
	au.name  as actualuse_name,
	auc.objid as actualuse_objid,
	auc.code as actualuse_classcode,
	auc.name as actualuse_classname,
	auc.orderno as actualuse_orderno
from rpu r 
inner join propertyclassification dpc on r.classification_objid = dpc.objid
inner join rpu_assessment ra on r.objid = ra.rpuid
inner join machassesslevel au on ra.actualuse_objid = au.objid 
left join propertyclassification auc on au.classification_objid = auc.objid

union 

select 
	r.objid,
	r.rputype,
	dpc.objid as dominantclass_objid,
	dpc.code as dominantclass_code,
	dpc.name as dominantclass_name,
	dpc.orderno as dominantclass_orderno,
	ra.areasqm,
	ra.areaha,
	ra.marketvalue,
	ra.assesslevel,
	ra.assessedvalue,
	ra.taxable,
	au.code as actualuse_code, 
	au.name  as actualuse_name,
	auc.objid as actualuse_objid,
	auc.code as actualuse_classcode,
	auc.name as actualuse_classname,
	auc.orderno as actualuse_orderno
from rpu r 
inner join propertyclassification dpc on r.classification_objid = dpc.objid
inner join rpu_assessment ra on r.objid = ra.rpuid
inner join planttreeassesslevel au on ra.actualuse_objid = au.objid 
left join propertyclassification auc on au.classification_objid = auc.objid

union 

select 
	r.objid,
	r.rputype,
	dpc.objid as dominantclass_objid,
	dpc.code as dominantclass_code,
	dpc.name as dominantclass_name,
	dpc.orderno as dominantclass_orderno,
	ra.areasqm,
	ra.areaha,
	ra.marketvalue,
	ra.assesslevel,
	ra.assessedvalue,
	ra.taxable,
	au.code as actualuse_code, 
	au.name  as actualuse_name,
	auc.objid as actualuse_objid,
	auc.code as actualuse_classcode,
	auc.name as actualuse_classname,
	auc.orderno as actualuse_orderno
from rpu r 
inner join propertyclassification dpc on r.classification_objid = dpc.objid
inner join rpu_assessment ra on r.objid = ra.rpuid
inner join miscassesslevel au on ra.actualuse_objid = au.objid 
left join propertyclassification auc on au.classification_objid = auc.objid
go 



drop table syncdata_offline_org
go


CREATE TABLE syncdata_org (
  orgid varchar(50) NOT NULL,
  state varchar(50) NOT NULL,
  errorcount int,
  PRIMARY KEY (orgid)
) 
go

create index ix_state on syncdata_org(state)
;

insert into syncdata_org (
  orgid, 
  state, 
  errorcount
)
select 
  objid,
  'ACTIVE',
  0
from sys_org
where orgclass = 'province'
;


drop table syncdata_forprocess
go 

CREATE TABLE syncdata_forprocess (
  objid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
) 
go




alter table rptledger_item add fromqtr int
go 
alter table rptledger_item add toqtr int
go 
CREATE TABLE batch_rpttaxcredit (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  txndate date NOT NULL,
  txnno varchar(25) NOT NULL,
  rate decimal(10,2) NOT NULL,
  paymentfrom date DEFAULT NULL,
  paymentto varchar(255) DEFAULT NULL,
  creditedyear int NOT NULL,
  reason varchar(255) NOT NULL,
  validity date NULL,
  PRIMARY KEY (objid)
) 
go

create index ix_state on batch_rpttaxcredit(state)
go
create index ix_txnno on batch_rpttaxcredit(txnno)
go

CREATE TABLE batch_rpttaxcredit_ledger (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  error varchar(255) NULL,
	barangayid varchar(50) not null, 
  PRIMARY KEY (objid)
) 
go


create index ix_parentid on batch_rpttaxcredit_ledger (parentid)
go
create index ix_state on batch_rpttaxcredit_ledger (state)
go
create index ix_barangayid on batch_rpttaxcredit_ledger (barangayid)
go

alter table batch_rpttaxcredit_ledger 
add constraint fk_rpttaxcredit_rptledger_parent foreign key(parentid) references batch_rpttaxcredit(objid)
go

alter table batch_rpttaxcredit_ledger 
add constraint fk_rpttaxcredit_rptledger_rptledger foreign key(objid) references rptledger(objid)
go




CREATE TABLE batch_rpttaxcredit_ledger_posted (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  barangayid varchar(50) NOT NULL,
  PRIMARY KEY (objid)
)
go

create index ix_parentid on batch_rpttaxcredit_ledger_posted(parentid)
go
create index ix_barangayid on batch_rpttaxcredit_ledger_posted(barangayid)
go

alter table batch_rpttaxcredit_ledger_posted 
add constraint fk_rpttaxcredit_rptledger_posted_parent foreign key(parentid) references batch_rpttaxcredit(objid)
go

alter table batch_rpttaxcredit_ledger_posted 
add constraint fk_rpttaxcredit_rptledger_posted_rptledger foreign key(objid) references rptledger(objid)
go

create view vw_batch_rpttaxcredit_error
as 
select br.*, rl.tdno
from batch_rpttaxcredit_ledger br 
inner join rptledger rl on br.objid = rl.objid 
where br.state = 'ERROR'
go

alter table rpttaxcredit add info text
go


alter table rpttaxcredit add discapplied decimal(16,2) not null
go

update rpttaxcredit set discapplied = 0 where discapplied is null 
go

CREATE TABLE rpt_syncdata_forsync (
  [objid] varchar(50) NOT NULL,
  [reftype] varchar(50) NOT NULL,
  [refno] varchar(50) NOT NULL,
  [action] varchar(50) NOT NULL,
  [orgid] varchar(50) NOT NULL,
  [dtfiled] datetime NOT NULL,
  [createdby_objid] varchar(50) DEFAULT NULL,
  [createdby_name] varchar(255) DEFAULT NULL,
  [createdby_title] varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 
create index ix_refno on rpt_syncdata_forsync (refno)
go
create index ix_orgid on rpt_syncdata_forsync (orgid)
go

CREATE TABLE rpt_syncdata (
  [objid] varchar(50) NOT NULL,
  [state] varchar(25) NOT NULL,
  [refid] varchar(50) NOT NULL,
  [reftype] varchar(50) NOT NULL,
  [refno] varchar(50) NOT NULL,
  [action] varchar(50) NOT NULL,
  [dtfiled] datetime NOT NULL,
  [orgid] varchar(50) NOT NULL,
  [remote_orgid] varchar(50) DEFAULT NULL,
  [remote_orgcode] varchar(5) DEFAULT NULL,
  [remote_orgclass] varchar(25) DEFAULT NULL,
  [sender_objid] varchar(50) DEFAULT NULL,
  [sender_name] varchar(255) DEFAULT NULL,
  [sender_title] varchar(80) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go

create index ix_state on rpt_syncdata (state)
go
create index ix_refid on rpt_syncdata (refid)
go
create index ix_refno on rpt_syncdata (refno)
go
create index ix_orgid on rpt_syncdata (orgid)
go

CREATE TABLE rpt_syncdata_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) NOT NULL,
  action varchar(50) NOT NULL,
  idx int NOT NULL,
  info text,
  PRIMARY KEY (objid)
)
go 

create index ix_parentid on rpt_syncdata_item (parentid)
go
create index ix_state on rpt_syncdata_item (state)
go
create index ix_refid on rpt_syncdata_item (refid)
go
create index ix_refno on rpt_syncdata_item (refno)
go


alter table rpt_syncdata_item
  add CONSTRAINT FK_parentid_rpt_syncdata 
  FOREIGN KEY (parentid) REFERENCES rpt_syncdata (objid)
go 

CREATE TABLE rpt_syncdata_error (
  [objid] varchar(50) NOT NULL,
  [filekey] varchar(1000) NOT NULL,
  [error] text,
  [refid] varchar(50) NOT NULL,
  [reftype] varchar(50) NOT NULL,
  [refno] varchar(50) NOT NULL,
  [action] varchar(50) NOT NULL,
  [idx] int NOT NULL,
  [info] text,
  [parent] text,
  [remote_orgid] varchar(50) DEFAULT NULL,
  [remote_orgcode] varchar(5) DEFAULT NULL,
  [remote_orgclass] varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

create index ix_refid on rpt_syncdata_error (refid)
go
create index ix_refno on rpt_syncdata_error (refno)
go

create index ix_filekey on rpt_syncdata_error (filekey)
go
create index ix_remote_orgid on rpt_syncdata_error (remote_orgid)
go
create index ix_remote_orgcode on rpt_syncdata_error (remote_orgcode)
go

INSERT INTO sys_var ([name], [value], [description], [datatype], [category]) 
VALUES ('assesser_new_sync_lgus', NULL, 'List of LGUs using new sync facility', NULL, 'ASSESSOR')
go 





ALTER TABLE rpt_syncdata_forsync ADD remote_orgid VARCHAR(15)
go 

INSERT INTO sys_var ([name], [value], [description], [datatype], [category]) 
VALUES ('fileserver_upload_task_active', '0', 'Activate / Deactivate upload task', 'boolean', 'SYSTEM')
go 


INSERT INTO sys_var ([name], [value], [description], [datatype], [category]) 
VALUES ('fileserver_download_task_active', '0', 'Activate / Deactivate download task', 'boolean', 'SYSTEM')
go



CREATE TABLE rpt_syncdata_completed (
  [objid] varchar(255) NOT NULL,
  [idx] int DEFAULT NULL,
  [action] varchar(100) DEFAULT NULL,
  [refno] varchar(50) DEFAULT NULL,
  [refid] varchar(50) DEFAULT NULL,
  [reftype] varchar(50) DEFAULT NULL,
  [parent_orgid] varchar(50) DEFAULT NULL,
  [sender_name] varchar(255) DEFAULT NULL,
  [sender_title] varchar(255) DEFAULT NULL,
  [dtcreated] datetime DEFAULT NULL,
  PRIMARY KEY (objid)
)
go 

CREATE INDEX ix_refno ON rpt_syncdata_completed (refno)
go
CREATE INDEX ix_refid ON rpt_syncdata_completed (refid)
go
CREATE INDEX ix_parent_orgid ON rpt_syncdata_completed (parent_orgid)
go



UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_BASICINT_CURRENT' WHERE objid='TFA00000011'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_SEFINT_CURRENT' WHERE objid='TFA00000012'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_BASIC_CURRENT' WHERE objid='TFA10000144'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_BASIC_PREVIOUS' WHERE objid='TFA10000145'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_BASICINT_PREVIOUS' WHERE objid='TFA10000147'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_BASIC_ADVANCE' WHERE objid='TFA10000149'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_SEF_CURRENT' WHERE objid='TFA10000150'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_SEF_PREVIOUS' WHERE objid='TFA10000151'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_SEFINT_PREVIOUS' WHERE objid='TFA10000153'
go
UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_SEF_ADVANCE' WHERE objid='TFA10000155'
go


UPDATE itemaccount SET org_objid='189', org_name='SORSOGON CITY', parentid='RPT_FIRE_CODE' WHERE objid='TFA10000148'
go


alter table rptledger add beneficiary_objid varchar(50)
go 

alter table sys_org add txncode varchar(5)
go 








/* RULESETS AND RULES */
alter table sys_rule_fact add factsuperclass varchar(255)
go 
alter table sys_rule_action_param  add rangeoption varchar(255)
GO



delete from sys_rule_action_param where parentid in ( 
  select ra.objid 
  from sys_rule r, sys_rule_action ra 
  where r.ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    ) and ra.parentid=r.objid 
)
go

delete from sys_rule_actiondef_param where parentid in ( 
  select ra.objid from sys_ruleset_actiondef rsa 
    inner join sys_rule_actiondef ra on ra.objid=rsa.actiondef 
  where rsa.ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    )
)
go

delete from sys_rule_actiondef where objid in ( 
  select actiondef from sys_ruleset_actiondef where ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    )
)
go

delete from sys_rule_action where parentid in ( 
  select objid from sys_rule 
  where ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    )
)
go

delete from sys_rule_condition_constraint where parentid in ( 
  select rc.objid 
  from sys_rule r, sys_rule_condition rc 
  where r.ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    ) and rc.parentid=r.objid 
)
go

delete from sys_rule_condition_var where parentid in ( 
  select rc.objid 
  from sys_rule r, sys_rule_condition rc 
  where r.ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    ) and rc.parentid=r.objid 
)
go

delete from sys_rule_condition where parentid in ( 
  select objid from sys_rule where ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    )
)
go


delete from sys_rule_fact_field where parentid in (
	select objid from sys_rule_fact where domain in ('rpt', 'landtax')
)
go

delete  from sys_rule_fact where domain in ('rpt', 'landtax')
go

delete from sys_rule_deployed where objid in ( 
  select objid from sys_rule where ruleset in (
        select name  from sys_ruleset where domain in ('rpt', 'landtax')
    )
    
)
go

delete from sys_rule where ruleset in (
    select name  from sys_ruleset where domain in ('rpt', 'landtax')
)
go

delete from sys_ruleset_fact where ruleset in (
    select name  from sys_ruleset where domain in ('rpt', 'landtax')
)
go


delete from sys_ruleset_actiondef where ruleset in (
    select name  from sys_ruleset where domain in ('rpt', 'landtax')
)
go

delete from sys_rulegroup where ruleset in (
    select name  from sys_ruleset where domain in ('rpt', 'landtax')
)
go

delete from sys_ruleset where domain in ('rpt', 'landtax')
go




INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('bldgassessment', 'Building Assessment Rules', 'bldgassessment', 'RPT', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('landassessment', 'Land Assessment Rules', 'landassessment', 'RPT', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('machassessment', 'Machinery Assessment Rules', 'machassessment', 'RPT', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('miscassessment', 'Miscellaneous Assessment Rules', 'miscassessment', 'RPT', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('planttreeassessment', 'Plant/Tree Assessment Rules', 'planttreeassessment', 'RPT', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('rptbilling', 'RPT Billing Rules', 'rptbilling', 'LANDTAX', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('rptledger', 'Ledger Billing Rules', 'rptledger', 'LANDTAX', 'RULE_AUTHOR', NULL)
go
INSERT INTO sys_ruleset ([name], [title], [packagename], [domain], [role], [permission]) VALUES ('rptrequirement', 'RPT Requirement Rules', 'rptrequirement', 'RPT', 'RULE_AUTHOR', NULL)
go


INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ADDITIONAL', 'bldgassessment', 'Additional Item Computation', '18')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ADJUSTMENT', 'bldgassessment', 'Adjustment Computation', '25')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ADDITIONAL', 'bldgassessment', 'After Additional Item Computation', '19')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ADJUSTMENT', 'bldgassessment', 'After Adjustment Computation', '30')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSLEVEL', 'bldgassessment', 'After Calculate Assess Level', '60')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSVALUE', 'bldgassessment', 'After Assess Value Computation', '75')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-BASEMARKETVALUE', 'bldgassessment', 'After Base Market Value Computation', '15')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-DEPRECIATION', 'bldgassessment', 'After Depreciation Computation', '34')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-FLOOR', 'bldgassessment', 'AFter Floor Computation', '3')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-MARKETVALUE', 'bldgassessment', 'After Market Value Computation', '45')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-SUMMARY', 'bldgassessment', 'After Summary Computation', '105')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSLEVEL', 'bldgassessment', 'Calculate Assess Level', '55')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSVALUE', 'bldgassessment', 'Assess Value Computation', '70')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BASEMARKETVALUE', 'bldgassessment', 'Base Market Value Computation', '10')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-ADDITIONAL', 'bldgassessment', 'Before Additional Item Computation', '17')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-ADJUSTMENT', 'bldgassessment', 'Before Adjustment Computation', '20')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-ASSESSLEVEL', 'bldgassessment', 'Before Calculate Assess Level', '50')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-ASSESSVALUE', 'bldgassessment', 'Before Assess Value Computation', '65')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-BASEMARKETVALUE', 'bldgassessment', 'Before Base Market Value Computation', '5')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-DEPRECIATON', 'bldgassessment', 'Before Depreciation Computation', '32')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-MARKETVALUE', 'bldgassessment', 'Before Market Value Computation', '35')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('DEPRECIATION', 'bldgassessment', 'Depreciation Computation', '33')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('FLOOR', 'bldgassessment', 'Floor Computation', '2')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MARKETVALUE', 'bldgassessment', 'Market Value Computation', '40')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('PRE-ASSESSMENT', 'bldgassessment', 'Pre-Assessment', '1')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('SUMMARY', 'bldgassessment', 'Summary', '100')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ADJUSTMENT', 'landassessment', 'Adjustment Computation', '14')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ADJUSTMENT', 'landassessment', 'After Adjustment Computation', '15')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSEDVALUE', 'landassessment', 'After Assessed Value Computation', '45')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSLEVEL', 'landassessment', 'After Assess Level Computation', '36')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-BASEMARKETVALUE', 'landassessment', 'After Base Market Value Computation', '10')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-MARKETVALUE', 'landassessment', 'After Market Value Computation', '30')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-SUMMARY', 'landassessment', 'After Summary Computation', '105')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSEDVALUE', 'landassessment', 'Assessed Value Computation', '40')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSLEVEL', 'landassessment', 'Assess Level Computation', '35')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BASEMARKETVALUE', 'landassessment', 'Base Market Value Computation', '5')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-ADJUSTMENT', 'landassessment', 'Before Adjustment Computation', '13')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-MARKETVALUE', 'landassessment', 'Before Market Value', '25')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('INITIAL', 'landassessment', 'Initial Computation', '0')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MARKETVALUE', 'landassessment', 'Market Value Computation', '26')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('SUMMARY', 'landassessment', 'Summary Computation', '100')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSEDVALUE', 'machassessment', 'After Machine Assessed Value Computation', '45')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSLEVEL', 'machassessment', 'After Machine Assess Level Computation', '36')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-BASEMARKETVALUE', 'machassessment', 'After Machine Base Market Value Computation', '10')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-DEPRECIATION', 'machassessment', 'After Machine Depreciation Computation', '12')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-MARKETVALUE', 'machassessment', 'After Machine Market Value Computation', '30')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-SUMMARY', 'machassessment', 'After Summary Computation', '105')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSEDVALUE', 'machassessment', 'Machine Assessed Value Computation', '40')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSLEVEL', 'machassessment', 'Machine Assess Level Computation', '35')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BASEMARKETVALUE', 'machassessment', 'Machine Base Market Value Computation', '5')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('DEPRECIATION', 'machassessment', 'Machine Depreciation Computation', '11')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('INITIAL', 'machassessment', 'Initial Computation', '0')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MARKETVALUE', 'machassessment', 'Machine Market Value Computation', '25')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MUASSESSEDVALUE', 'machassessment', 'Actual Use Assessed Value Computation', '55')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MUASSESSLEVEL', 'machassessment', 'Actual Use Assess Level Computation', '50')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('SUMMARY', 'machassessment', 'Summary Computation', '100')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFER-DEPRECIATION', 'miscassessment', 'After Depreciation Computation', '16')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSEDVALUE', 'miscassessment', 'After Assessed Value Computation', '45')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSLEVEL', 'miscassessment', 'After Assess Level Computation', '36')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-BASEMARKETVALUE', 'miscassessment', 'After Base Market Value Computation', '10')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-MARKETVALUE', 'miscassessment', 'After Market Value Computation', '30')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-SUMMARY', 'miscassessment', 'After Summary Computation', '105')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSEDVALUE', 'miscassessment', 'Assessed Value Computation', '40')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSLEVEL', 'miscassessment', 'Assess Level Computation', '35')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BASEMARKETVALUE', 'miscassessment', 'Base Market Value Computation', '5')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE-ASSESSLEVEL', 'miscassessment', 'Before Assess Level Computation', '34')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('DEPRECIATION', 'miscassessment', 'Depreciation Computation', '15')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('INITIAL', 'miscassessment', 'Initial Computation', '0')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MARKETVALUE', 'miscassessment', 'Market Value Computation', '25')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('SUMMARY', 'miscassessment', 'Summary Computation', '100')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ADJUSTMENT', 'planttreeassessment', 'Adjustment Computation', '15')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ADJUSTMENT', 'planttreeassessment', 'AFter Adjustment Computation', '16')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSEDVALUE', 'planttreeassessment', 'After Assessed Value Computation', '45')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-ASSESSLEVEL', 'planttreeassessment', 'After Assess Level Computation', '36')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-BASEMARKETVALUE', 'planttreeassessment', 'After Base Market Value Computation', '10')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-MARKETVALUE', 'planttreeassessment', 'After Market Value Computation', '30')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER-SUMMARY', 'planttreeassessment', 'After Summary Computation', '105')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSEDVALUE', 'planttreeassessment', 'Assessed Value Computation', '40')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('ASSESSLEVEL', 'planttreeassessment', 'Assess Level Computation', '35')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BASEMARKETVALUE', 'planttreeassessment', 'Base Market Value Computation', '5')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('INITIAL', 'planttreeassessment', 'Initial Computation', '0')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('MARKETVALUE', 'planttreeassessment', 'Market Value Computation', '25')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('SUMMARY', 'planttreeassessment', 'Summary Computation', '100')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER_DISCOUNT', 'rptbilling', 'After Discount Computation', '10')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER_PENALTY', 'rptbilling', 'After Penalty Computation', '8')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER_SUMMARY', 'rptbilling', 'After Summary', '21')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BEFORE_SUMMARY', 'rptbilling', 'Before Summary ', '19')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('BRGY_SHARE', 'rptbilling', 'Barangay Share Computation', '25')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('DISCOUNT', 'rptbilling', 'Discount Computation', '9')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('INIT', 'rptbilling', 'Init', '0')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('LGU_SHARE', 'rptbilling', 'LGU Share Computation', '26')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('PENALTY', 'rptbilling', 'Penalty Computation', '7')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('PROV_SHARE', 'rptbilling', 'Province Share Computation', '27')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('SUMMARY', 'rptbilling', 'Summary', '20')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER_TAX', 'rptledger', 'Post Tax Computation', '3')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('INIT', 'rptledger', 'Init', '0')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('LEDGER_ITEM', 'rptledger', 'Ledger Item Posting', '1')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('TAX', 'rptledger', 'Tax Computation', '2')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('AFTER_REQUIREMENT', 'rptrequirement', 'After Requirement', '2')
go
INSERT INTO sys_rulegroup ([name], [ruleset], [title], [sortorder]) VALUES ('REQUIREMENT', 'rptrequirement', 'Requirement', '1')
go


INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.actions.AddDeriveVariable')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.actions.CalcRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.actions.CalcTotalRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.AddAssessmentInfo')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.AdjustUnitValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcAssessLevel')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcBldgAge')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcBldgEffectiveAge')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcBldgUseBMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcBldgUseDepreciation')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcBldgUseMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcDepreciationByRange')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcDepreciationFromSked')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcFloorBMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.CalcFloorMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'rptis.bldg.actions.ResetAdjustment')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'RULADEF-2486b0ca:146fff66c3e:-723b')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('bldgassessment', 'RULADEF1441128c:1471efa4c1c:-69a5')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.actions.AddDeriveVariable')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.actions.CalcRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.actions.CalcTotalRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.AddAssessmentInfo')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.CalcAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.CalcBaseMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.CalcMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.UpdateAdjustment')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.UpdateLandDetailActualUseAdj')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.UpdateLandDetailAdjustment')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('landassessment', 'rptis.land.actions.UpdateLandDetailValueAdjustment')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.actions.AddDeriveVar')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.actions.CalcRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.actions.CalcTotalRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.AddAssessmentInfo')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachineAssessLevel')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachineAV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachineBMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachineDepreciation')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachineMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachUseAssessLevel')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('machassessment', 'rptis.mach.actions.CalcMachUseAV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.actions.AddDeriveVariable')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.actions.CalcRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.actions.CalcTotalRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcBaseMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcDepreciation')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcMiscRPUAssessLevel')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcMiscRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcMiscRPUBaseMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('miscassessment', 'rptis.misc.actions.CalcMiscRPUMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.actions.AddDeriveVariable')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.actions.CalcRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.actions.CalcTotalRPUAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.planttree.actions.AddPlantTreeAssessmentInfo')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.planttree.actions.CalcPlantTreeAdjustment')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.planttree.actions.CalcPlantTreeAssessValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.planttree.actions.CalcPlantTreeBMV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('planttreeassessment', 'rptis.planttree.actions.CalcPlantTreeMarketValue')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.AddBillItem')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.AddShare')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.AggregateLedgerItem')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.CalcDiscount')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.CalcInterest')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.CreateTaxSummary')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.RemoveLedgerItem')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.SetBillExpiryDate')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.SplitByQtr')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptbilling', 'rptis.landtax.actions.SplitLedgerItem')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.AddBasic')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.AddFireCode')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.AddIdleLand')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.AddSef')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.AddSocialHousing')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.CalcTax')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptledger', 'rptis.landtax.actions.UpdateAV')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptrequirement', 'AddRequirement')
go
INSERT INTO sys_ruleset_actiondef ([ruleset], [actiondef]) VALUES ('rptrequirement', 'rptis.actions.AddRequirement')
go



INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.bldg.facts.BldgAdjustment')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.bldg.facts.BldgFloor')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.bldg.facts.BldgRPU')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.bldg.facts.BldgStructure')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.bldg.facts.BldgUse')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.bldg.facts.BldgVariable')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.facts.Classification')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.facts.RPTVariable')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.facts.RPU')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('bldgassessment', 'rptis.facts.RPUAssessment')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('landassessment', 'rptis.facts.Classification')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('landassessment', 'rptis.facts.RPUAssessment')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('landassessment', 'rptis.land.facts.LandAdjustment')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('landassessment', 'rptis.land.facts.LandDetail')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('machassessment', 'rptis.facts.RPUAssessment')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('machassessment', 'rptis.mach.facts.MachineActualUse')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('machassessment', 'rptis.mach.facts.MachineDetail')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('miscassessment', 'rptis.facts.RPU')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('miscassessment', 'rptis.facts.RPUAssessment')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('miscassessment', 'rptis.misc.facts.MiscItem')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('miscassessment', 'rptis.misc.facts.MiscRPU')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('planttreeassessment', 'rptis.facts.RPU')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('planttreeassessment', 'rptis.planttree.facts.PlantTreeDetail')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'CurrentDate')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.Bill')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.RPTBillItem')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.RPTIncentive')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.RPTLedgerFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.RPTLedgerItemFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptbilling', 'rptis.landtax.facts.ShareFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptledger', 'com.rameses.rules.common.CurrentDate')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptledger', 'rptis.landtax.facts.AssessedValue')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptledger', 'rptis.landtax.facts.Classification')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptledger', 'rptis.landtax.facts.RPTLedgerFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptledger', 'rptis.landtax.facts.RPTLedgerItemFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptrequirement', 'rptis.facts.RPU')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptrequirement', 'RPTTxnInfoFact')
go
INSERT INTO sys_ruleset_fact ([ruleset], [rulefact]) VALUES ('rptrequirement', 'TxnAttributeFact')
go


INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-128a4cad:146f96a678e:-7e52', 'DEPLOYED', 'COMPUTE_AV', 'landassessment', 'ASSESSEDVALUE', 'COMPUTE AV', NULL, '50000', NULL, NULL, '2014-12-16 12:59:22.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-1a2d6e9b:1692d429304:-7779', 'DEPLOYED', 'BASIC_AND_SEF', 'rptledger', 'LEDGER_ITEM', 'BASIC_AND_SEF', NULL, '50000', NULL, NULL, '2019-02-27 12:48:06.000', 'USR-12b70fa0:16929d068ad:-7e8e', 'LANDTAX', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-2486b0ca:146fff66c3e:-2c4a', 'DEPLOYED', 'CALC_ACTUAL_USE_MV', 'bldgassessment', 'MARKETVALUE', 'CALC ACTUAL USE MV', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-2486b0ca:146fff66c3e:-38e4', 'DEPLOYED', 'CALC_FLOOR_MARKET_VALUE', 'bldgassessment', 'BEFORE-MARKETVALUE', 'CALC FLOOR MARKET VALUE', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-2486b0ca:146fff66c3e:-4192', 'DEPLOYED', 'CALC_DEPRECIATION', 'bldgassessment', 'DEPRECIATION', 'CALC DEPRECIATION', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-2486b0ca:146fff66c3e:-4697', 'APPROVED', 'CALC_DEPRECATION_RATE_FROM_SKED', 'bldgassessment', 'BEFORE-DEPRECIATON', 'CALC DEPRECATION RATE FROM SKED', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-2486b0ca:146fff66c3e:-6b05', 'DEPLOYED', 'CALC_FLOOR_BMV', 'bldgassessment', 'FLOOR', 'CALC FLOOR BMV', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-2ede6703:16642adb9ce:-7ba0', 'DEPLOYED', 'EXPIRY_ADVANCE_BILLING', 'rptbilling', 'BEFORE_SUMMARY', 'EXPIRY ADVANCE BILLING', NULL, '5000', NULL, NULL, '2018-10-05 01:28:47.000', 'USR6bd70b1f:1662cdef89a:-7e3e', 'RAMESES', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-37dab195:17819c202a5:-58b3', 'DEPLOYED', 'DISCOUNT_CURRENT', 'rptbilling', 'DISCOUNT', 'DISCOUNT_CURRENT', NULL, '50000', NULL, NULL, '2021-03-10 10:13:15.500', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-37dab195:17819c202a5:-70b9', 'DEPLOYED', 'PENALTY_1997_TO_LESS_CY', 'rptbilling', 'PENALTY', 'PENALTY 1997 TO LESS CY', NULL, '50000', NULL, NULL, '2021-03-10 10:05:35.540', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-37dab195:17819c202a5:-76ff', 'DEPLOYED', 'SEF_FOR_ENERGY', 'rptledger', 'AFTER_TAX', 'SEF FOR ENERGY', NULL, '50000', NULL, NULL, '2021-03-10 09:57:47.090', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-37dab195:17819c202a5:-7a3b', 'DEPLOYED', 'BASIC_AGR_2014_TO_PRESENT', 'rptledger', 'TAX', 'BASIC AGR 2014 TO PRESENT', NULL, '40000', NULL, NULL, '2021-03-10 09:56:09.650', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-3e8edbea:156bc08656a:-5f05', 'DEPLOYED', 'RECALC_RPU_TOTAL_AV', 'landassessment', 'AFTER-SUMMARY', 'RECALC RPU TOTAL AV', NULL, '40000', NULL, NULL, '2016-08-24 19:03:36.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-525fef3d:1781a13900b:a48', 'DEPLOYED', 'BASIC_2012_2013', 'rptledger', 'TAX', 'BASIC_2012_2013', NULL, '40000', NULL, NULL, '2021-03-10 13:08:58.780', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-60c99d04:1470b276e7f:-7ecc', 'DEPLOYED', 'CALC_BMV', 'bldgassessment', 'BASEMARKETVALUE', 'CALC BMV ', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-79a9a347:15cfcae84de:-55fd', 'DEPLOYED', 'CALC_TOTAL_ASSESSEMENT_AV', 'landassessment', 'AFTER-SUMMARY', 'CALC TOTAL ASSESSEMENT AV', NULL, '50000', NULL, NULL, '2017-07-01 14:32:46.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-79a9a347:15cfcae84de:-6401', 'DEPLOYED', 'CALC_TOTAL_ASSESSEMENT_AV', 'bldgassessment', 'AFTER-SUMMARY', 'CALC TOTAL ASSESSEMENT AV', NULL, '40000', NULL, NULL, '2017-07-01 14:16:02.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL-79a9a347:15cfcae84de:-6f2a', 'DEPLOYED', 'RECALC_TOTAL_AV', 'bldgassessment', 'AFTER-SUMMARY', 'RECALC TOTAL AV', NULL, '50000', NULL, NULL, '2017-07-01 14:09:32.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL1262ad19:166ae41b1fb:-7c88', 'DEPLOYED', 'TOTAL_PREVIOUS', 'rptbilling', 'SUMMARY', 'TOTAL PREVIOUS', NULL, '50000', NULL, NULL, '2018-10-25 22:55:00.000', 'USR6de55768:158e0e57805:-74f2', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL1441128c:1471efa4c1c:-6b41', 'DEPLOYED', 'CALC_ASSESS_VALUE', 'bldgassessment', 'ASSESSVALUE', 'CALC ASSESS VALUE', NULL, '50000', NULL, NULL, '2015-05-23 15:13:46.000', 'USR-1b82c604:14cc29913bb:-7fec', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL1441128c:1471efa4c1c:-6c93', 'DEPLOYED', 'CALC_ASSESS_LEVEL', 'bldgassessment', 'AFTER-ASSESSLEVEL', 'CALC ASSESS LEVEL', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL1441128c:1471efa4c1c:-6eaa', 'DEPLOYED', 'BUILD_ASSESSMENT_INFO', 'bldgassessment', 'BEFORE-ASSESSLEVEL', 'BUILD ASSESSMENT INFO', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL3e2b89cb:146ff734573:-7dcc', 'DEPLOYED', 'COMPUTE_BLDG_AGE', 'bldgassessment', 'PRE-ASSESSMENT', 'COMPUTE BLDG AGE', NULL, '50000', NULL, NULL, '2014-12-16 12:59:15.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL483027b0:16be9375c61:-77e6', 'DEPLOYED', 'BASIC_AND_SEF_TAX', 'rptledger', 'TAX', 'BASIC AND SEF TAX', NULL, '50000', NULL, NULL, '2019-07-13 10:51:37.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL5b4ac915:147baaa06b4:-6f31', 'DEPLOYED', 'BUILD_ASSESSMENT_INFO_SPLIT', 'landassessment', 'SUMMARY', 'BUILD_ASSESSMENT_INFO_SPLIT', NULL, '50000', NULL, NULL, '2014-12-16 12:59:22.000', 'USR7e15465b:14a51353b1a:-7fb7', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL7afd4d64:17816d5ee78:-7ad2', 'DEPLOYED', 'ADJ_NON_TAXABLE', 'landassessment', 'AFTER-ASSESSEDVALUE', 'ADJ NON TAXABLE', NULL, '50000', NULL, NULL, '2021-03-09 20:29:06.617', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RUL7e02b404:166ae687f42:-5511', 'DEPLOYED', 'PENALTY_CURRENT_YEAR', 'rptbilling', 'PENALTY', 'PENALTY_CURRENT_YEAR', NULL, '50000', NULL, NULL, '2018-10-25 23:53:42.000', 'USR6de55768:158e0e57805:-74f2', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-255e', 'DEPLOYED', 'BUILD_BILL_ITEMS', 'rptbilling', 'AFTER_SUMMARY', 'BUILD BILL ITEMS', NULL, '50000', NULL, NULL, '2018-09-29 00:27:14.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-26bf', 'DEPLOYED', 'TOTAL_ADVANCE', 'rptbilling', 'SUMMARY', 'TOTAL ADVANCE', NULL, '50000', NULL, NULL, '2018-09-29 00:26:00.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-26d0', 'DEPLOYED', 'TOTAL_CURRENT', 'rptbilling', 'SUMMARY', 'TOTAL_CURRENT', NULL, '50000', NULL, NULL, '2018-09-29 00:25:49.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-2f1f', 'DEPLOYED', 'EXPIRY_DATE_DEFAULT', 'rptbilling', 'BEFORE_SUMMARY', 'EXPIRY DATE DEFAULT', NULL, '10000', NULL, NULL, '2018-09-29 00:17:38.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-319f', 'DEPLOYED', 'EXPIRY_DATE_ADVANCE_YEAR', 'rptbilling', 'BEFORE_SUMMARY', 'EXPIRY_DATE_ADVANCE_YEAR', NULL, '5000', NULL, NULL, '2018-09-29 00:14:01.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-3811', 'DEPLOYED', 'SPLIT_QUARTERLY_BILLED_ITEMS', 'rptbilling', 'BEFORE_SUMMARY', 'SPLIT QUARTERLY BILLED ITEMS', NULL, '50000', NULL, NULL, '2018-09-29 00:07:10.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-3c17', 'DEPLOYED', 'AGGREGATE_PREVIOUS_ITEMS', 'rptbilling', 'BEFORE_SUMMARY', 'AGGREGATE PREVIOUS ITEMS', NULL, '60000', NULL, NULL, '2018-09-29 00:05:33.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-4197', 'DEPLOYED', 'DISCOUNT_ADVANCE', 'rptbilling', 'DISCOUNT', 'DISCOUNT_ADVANCE', NULL, '40000', NULL, NULL, '2018-09-29 00:02:22.000', 'USR-ADMIN', 'ADMIN', '1', '')
go
INSERT INTO sys_rule ([objid], [state], [name], [ruleset], [rulegroup], [title], [description], [salience], [effectivefrom], [effectiveto], [dtfiled], [user_objid], [user_name], [noloop], [_ukey]) VALUES ('RULec9d7ab:166235c2e16:-5fcb', 'DEPLOYED', 'SPLIT_QTR', 'rptbilling', 'INIT', 'SPLIT_QTR', NULL, '50000', NULL, NULL, '2018-09-28 23:48:57.000', 'USR-ADMIN', 'ADMIN', '1', '')
go



INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-128a4cad:146f96a678e:-7e52', '
package landassessment.COMPUTE_AV;
import landassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "COMPUTE_AV"
	agenda-group "ASSESSEDVALUE"
	salience 50000
	no-loop
	when
		
		
		LA: rptis.land.facts.LandDetail (  MV:marketvalue,AL:assesslevel ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("LA", LA );
		
		bindings.put("MV", MV );
		
		bindings.put("AL", AL );
		
	Map _p0 = new HashMap();
_p0.put( "landdetail", LA );
_p0.put( "expr", (new ActionExpression("@ROUNDTOTEN( MV * AL / 100.0  )", bindings)) );
action.execute( "calc-av",_p0,drools);

end


	')
go


INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-1a2d6e9b:1692d429304:-7779', '
package rptledger.BASIC_AND_SEF;
import rptledger.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BASIC_AND_SEF"
	agenda-group "LEDGER_ITEM"
	salience 50000
	no-loop
	when
		
		
		AVINFO: rptis.landtax.facts.AssessedValue (  YR:year,AV:av ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("AVINFO", AVINFO );
		
		bindings.put("YR", YR );
		
		bindings.put("AV", AV );
		
	Map _p0 = new HashMap();
_p0.put( "avfact", AVINFO );
_p0.put( "year", YR );
_p0.put( "av", (new ActionExpression("AV", bindings)) );
action.execute( "add-sef",_p0,drools);
Map _p1 = new HashMap();
_p1.put( "avfact", AVINFO );
_p1.put( "year", YR );
_p1.put( "av", (new ActionExpression("AV", bindings)) );
action.execute( "add-basic",_p1,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-2486b0ca:146fff66c3e:-2c4a', '
package bldgassessment.CALC_ACTUAL_USE_MV;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_ACTUAL_USE_MV"
	agenda-group "MARKETVALUE"
	salience 50000
	no-loop
	when
		
		
		BU: rptis.bldg.facts.BldgUse (  BMV:basemarketvalue,DEP:depreciationvalue,ADJ:adjustment ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BU", BU );
		
		bindings.put("BMV", BMV );
		
		bindings.put("DEP", DEP );
		
		bindings.put("ADJ", ADJ );
		
	Map _p0 = new HashMap();
_p0.put( "bldguse", BU );
_p0.put( "expr", (new ActionExpression("@ROUND( BMV + ADJ - DEP )", bindings)) );
action.execute( "calc-bldguse-mv",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-2486b0ca:146fff66c3e:-38e4', '
package bldgassessment.CALC_FLOOR_MARKET_VALUE;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_FLOOR_MARKET_VALUE"
	agenda-group "BEFORE-MARKETVALUE"
	salience 50000
	no-loop
	when
		
		
		BF: rptis.bldg.facts.BldgFloor (  BMV:basemarketvalue,ADJ:adjustment ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BF", BF );
		
		bindings.put("BMV", BMV );
		
		bindings.put("ADJ", ADJ );
		
	Map _p0 = new HashMap();
_p0.put( "bldgfloor", BF );
_p0.put( "expr", (new ActionExpression("@ROUND( BMV + ADJ )", bindings)) );
action.execute( "calc-floor-mv",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-2486b0ca:146fff66c3e:-4192', '
package bldgassessment.CALC_DEPRECIATION;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_DEPRECIATION"
	agenda-group "DEPRECIATION"
	salience 50000
	no-loop
	when
		
		
		RPU: rptis.bldg.facts.BldgRPU (  DPRATE:depreciation ) 
		
		BU: rptis.bldg.facts.BldgUse (  BMV:basemarketvalue,ADJUSTMENT:adjustment ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RPU", RPU );
		
		bindings.put("DPRATE", DPRATE );
		
		bindings.put("BMV", BMV );
		
		bindings.put("BU", BU );
		
		bindings.put("ADJUSTMENT", ADJUSTMENT );
		
	Map _p0 = new HashMap();
_p0.put( "bldguse", BU );
_p0.put( "expr", (new ActionExpression("@ROUND(  ( BMV + ADJUSTMENT ) * DPRATE / 100.0 )", bindings)) );
action.execute( "calc-bldguse-depreciation",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-2486b0ca:146fff66c3e:-6b05', '
package bldgassessment.CALC_FLOOR_BMV;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_FLOOR_BMV"
	agenda-group "FLOOR"
	salience 50000
	no-loop
	when
		
		
		BF: rptis.bldg.facts.BldgFloor (  AREA:area,UV:unitvalue ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BF", BF );
		
		bindings.put("AREA", AREA );
		
		bindings.put("UV", UV );
		
	Map _p0 = new HashMap();
_p0.put( "bldgfloor", BF );
_p0.put( "expr", (new ActionExpression("AREA * UV", bindings)) );
action.execute( "calc-floor-bmv",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-2ede6703:16642adb9ce:-7ba0', '
package rptbilling.EXPIRY_ADVANCE_BILLING;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "EXPIRY_ADVANCE_BILLING"
	agenda-group "BEFORE_SUMMARY"
	salience 5000
	no-loop
	when
		
		
		BILL: rptis.landtax.facts.Bill (  advancebill == true ,BILLDATE:billdate ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BILL", BILL );
		
		bindings.put("BILLDATE", BILLDATE );
		
	Map _p0 = new HashMap();
_p0.put( "bill", BILL );
_p0.put( "expr", (new ActionExpression("@MONTHEND( BILLDATE )", bindings)) );
action.execute( "set-bill-expiry",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-37dab195:17819c202a5:-58b3', '
package rptbilling.DISCOUNT_CURRENT;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "DISCOUNT_CURRENT"
	agenda-group "DISCOUNT"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CQTR:qtr,CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year == CY,revtype matches "basic|sef",qtr >= CQTR,TAX:amtdue ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CQTR", CQTR );
		
		bindings.put("RLI", RLI );
		
		bindings.put("CY", CY );
		
		bindings.put("TAX", TAX );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("@ROUND(TAX * 0.10)", bindings)) );
action.execute( "calc-discount",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-37dab195:17819c202a5:-70b9', '
package rptbilling.PENALTY_1997_TO_LESS_CY;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "PENALTY_1997_TO_LESS_CY"
	agenda-group "PENALTY"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year >= 1970,year < CY,TAX:amtdue,NMON:monthsfromjan,revtype matches "basic|sef" ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
		bindings.put("TAX", TAX );
		
		bindings.put("NMON", NMON );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("@ROUND(@IIF( NMON * 0.02 > 0.72, TAX * 0.72, TAX * NMON * 0.02))", bindings)) );
action.execute( "calc-interest",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-37dab195:17819c202a5:-76ff', '
package rptledger.SEF_FOR_ENERGY;
import rptledger.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "SEF_FOR_ENERGY"
	agenda-group "AFTER_TAX"
	salience 50000
	no-loop
	when
		
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  AV:av,revtype matches "sef",year >= 2000 ) 
		
		RL: rptis.landtax.facts.RPTLedgerFact (  taxpayerid matches "JUR-41f18a4b:1651c29df59:-4c1c|JUR-57026396:15dbc0c8430:-3d40" ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RLI", RLI );
		
		bindings.put("AV", AV );
		
		bindings.put("RL", RL );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("( AV * 0.01 ) / 2", bindings)) );
action.execute( "calc-tax",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-37dab195:17819c202a5:-7a3b', '
package rptledger.BASIC_AGR_2014_TO_PRESENT;
import rptledger.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BASIC_AGR_2014_TO_PRESENT"
	agenda-group "TAX"
	salience 40000
	no-loop
	when
		
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year >= 2014,classification matches "FRLCI00000092",AV:av,revtype matches "basic" ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RLI", RLI );
		
		bindings.put("AV", AV );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("AV * 0.008", bindings)) );
action.execute( "calc-tax",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-3e8edbea:156bc08656a:-5f05', '
package landassessment.RECALC_RPU_TOTAL_AV;
import landassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "RECALC_RPU_TOTAL_AV"
	agenda-group "AFTER-SUMMARY"
	salience 40000
	no-loop
	when
		
		
		RPU: rptis.facts.RPU (   ) 
		
		VAR: rptis.facts.RPTVariable (  varid matches "TOTAL_VALUE",AV:value ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RPU", RPU );
		
		bindings.put("AV", AV );
		
		bindings.put("VAR", VAR );
		
	Map _p0 = new HashMap();
_p0.put( "rpu", RPU );
_p0.put( "expr", (new ActionExpression("@ROUNDTOTEN( AV  )", bindings)) );
action.execute( "recalc-rpu-totalav",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-525fef3d:1781a13900b:a48', '
package rptledger.BASIC_2012_2013;
import rptledger.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BASIC_2012_2013"
	agenda-group "TAX"
	salience 40000
	no-loop
	when
		
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year >= 2012,revtype matches "basic",AV:av,year <= 2013 ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RLI", RLI );
		
		bindings.put("AV", AV );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("AV * 0.015", bindings)) );
action.execute( "calc-tax",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-60c99d04:1470b276e7f:-7ecc', '
package bldgassessment.CALC_BMV;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_BMV"
	agenda-group "BASEMARKETVALUE"
	salience 50000
	no-loop
	when
		
		
		BS: rptis.bldg.facts.BldgStructure (  TOTAL_FLOOR_AREA:totalfloorarea ) 
		
		BU: rptis.bldg.facts.BldgUse (  bldgstructure == BS,BASEVALUE:basevalue,BUAREA:area ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BS", BS );
		
		bindings.put("TOTAL_FLOOR_AREA", TOTAL_FLOOR_AREA );
		
		bindings.put("BASEVALUE", BASEVALUE );
		
		bindings.put("BU", BU );
		
		bindings.put("BUAREA", BUAREA );
		
	Map _p0 = new HashMap();
_p0.put( "bldguse", BU );
_p0.put( "expr", (new ActionExpression("@ROUND(  TOTAL_FLOOR_AREA * BASEVALUE )", bindings)) );
action.execute( "calc-bldguse-bmv",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-79a9a347:15cfcae84de:-55fd', '
package landassessment.CALC_TOTAL_ASSESSEMENT_AV;
import landassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_TOTAL_ASSESSEMENT_AV"
	agenda-group "AFTER-SUMMARY"
	salience 50000
	no-loop
	when
		
		
		RA: rptis.facts.RPUAssessment (  actualuseid != null,AV:assessedvalue ) 
		
		RPU: rptis.facts.RPU (  RPUID:objid ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RA", RA );
		
		bindings.put("RPUID", RPUID );
		
		bindings.put("RPU", RPU );
		
		bindings.put("AV", AV );
		
	Map _p0 = new HashMap();
_p0.put( "refid", RPUID );
_p0.put( "var", new KeyValue("TOTAL_VALUE", "TOTAL_VALUE") );
_p0.put( "aggregatetype", "sum" );
_p0.put( "expr", (new ActionExpression("AV", bindings)) );
action.execute( "add-derive-var",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-79a9a347:15cfcae84de:-6401', '
package bldgassessment.CALC_TOTAL_ASSESSEMENT_AV;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_TOTAL_ASSESSEMENT_AV"
	agenda-group "AFTER-SUMMARY"
	salience 40000
	no-loop
	when
		
		
		RA: rptis.facts.RPUAssessment (  actualuseid != null,AV:assessedvalue ) 
		
		RPU: rptis.facts.RPU (  RPUID:objid ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RA", RA );
		
		bindings.put("RPUID", RPUID );
		
		bindings.put("AV", AV );
		
		bindings.put("RPU", RPU );
		
	Map _p0 = new HashMap();
_p0.put( "refid", RPUID );
_p0.put( "var", new KeyValue("TOTAL_VALUE", "TOTAL_VALUE") );
_p0.put( "aggregatetype", "sum" );
_p0.put( "expr", (new ActionExpression("AV", bindings)) );
action.execute( "add-derive-var",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL-79a9a347:15cfcae84de:-6f2a', '
package bldgassessment.RECALC_TOTAL_AV;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "RECALC_TOTAL_AV"
	agenda-group "AFTER-SUMMARY"
	salience 50000
	no-loop
	when
		
		
		RPU: rptis.facts.RPU (  RPUID:objid ) 
		
		VAR: rptis.facts.RPTVariable (  varid matches "TOTAL_VALUE",AV:value ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RPU", RPU );
		
		bindings.put("RPUID", RPUID );
		
		bindings.put("VAR", VAR );
		
		bindings.put("AV", AV );
		
	Map _p0 = new HashMap();
_p0.put( "rpu", RPU );
_p0.put( "expr", (new ActionExpression("@ROUNDTOTEN(AV );", bindings)) );
action.execute( "recalc-rpu-totalav",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL1262ad19:166ae41b1fb:-7c88', '
package rptbilling.TOTAL_PREVIOUS;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "TOTAL_PREVIOUS"
	agenda-group "SUMMARY"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year < CY,revtype not matches "firecode" ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "revperiod", "previous" );
action.execute( "create-tax-summary",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL1441128c:1471efa4c1c:-6b41', '
package bldgassessment.CALC_ASSESS_VALUE;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_ASSESS_VALUE"
	agenda-group "ASSESSVALUE"
	salience 50000
	no-loop
	when
		
		
		BA: rptis.facts.RPUAssessment (  actualuseid != null,MV:marketvalue,AL:assesslevel ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BA", BA );
		
		bindings.put("MV", MV );
		
		bindings.put("AL", AL );
		
	Map _p0 = new HashMap();
_p0.put( "assessment", BA );
_p0.put( "expr", (new ActionExpression("@ROUNDTOTEN(  MV * AL  / 100.0 )", bindings)) );
action.execute( "calc-assess-value",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL1441128c:1471efa4c1c:-6c93', '
package bldgassessment.CALC_ASSESS_LEVEL;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "CALC_ASSESS_LEVEL"
	agenda-group "AFTER-ASSESSLEVEL"
	salience 50000
	no-loop
	when
		
		
		BA: rptis.facts.RPUAssessment (  actualuseid != null ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BA", BA );
		
	Map _p0 = new HashMap();
_p0.put( "assessment", BA );
action.execute( "calc-assess-level",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL1441128c:1471efa4c1c:-6eaa', '
package bldgassessment.BUILD_ASSESSMENT_INFO;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BUILD_ASSESSMENT_INFO"
	agenda-group "BEFORE-ASSESSLEVEL"
	salience 50000
	no-loop
	when
		
		
		BU: rptis.bldg.facts.BldgUse (  ACTUALUSE:actualuseid != null ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BU", BU );
		
		bindings.put("ACTUALUSE", ACTUALUSE );
		
	Map _p0 = new HashMap();
_p0.put( "bldguse", BU );
_p0.put( "actualuseid", ACTUALUSE );
action.execute( "add-assessment-info",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL3e2b89cb:146ff734573:-7dcc', '
package bldgassessment.COMPUTE_BLDG_AGE;
import bldgassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "COMPUTE_BLDG_AGE"
	agenda-group "PRE-ASSESSMENT"
	salience 50000
	no-loop
	when
		
		
		RPU: rptis.bldg.facts.BldgRPU (  YRAPPRAISED:yrappraised > 0,YRCOMPLETED:yrcompleted > 0 ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RPU", RPU );
		
		bindings.put("YRAPPRAISED", YRAPPRAISED );
		
		bindings.put("YRCOMPLETED", YRCOMPLETED );
		
	Map _p0 = new HashMap();
_p0.put( "rpu", RPU );
_p0.put( "expr", (new ActionExpression("YRAPPRAISED - YRCOMPLETED", bindings)) );
action.execute( "calc-bldg-age",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL483027b0:16be9375c61:-77e6', '
package rptledger.BASIC_AND_SEF_TAX;
import rptledger.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BASIC_AND_SEF_TAX"
	agenda-group "TAX"
	salience 50000
	no-loop
	when
		
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  AV:av,revtype matches "basic|sef" ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RLI", RLI );
		
		bindings.put("AV", AV );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("AV * 0.01", bindings)) );
action.execute( "calc-tax",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL5b4ac915:147baaa06b4:-6f31', '
package landassessment.BUILD_ASSESSMENT_INFO_SPLIT;
import landassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BUILD_ASSESSMENT_INFO_SPLIT"
	agenda-group "SUMMARY"
	salience 50000
	no-loop
	when
		
		
		LA: rptis.land.facts.LandDetail (  CLASS:classification != null ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("LA", LA );
		
		bindings.put("CLASS", CLASS );
		
	Map _p0 = new HashMap();
_p0.put( "landdetail", LA );
_p0.put( "classification", CLASS );
action.execute( "add-assessment-info",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL7afd4d64:17816d5ee78:-7ad2', '
package landassessment.ADJ_NON_TAXABLE;
import landassessment.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "ADJ_NON_TAXABLE"
	agenda-group "AFTER-ASSESSEDVALUE"
	salience 50000
	no-loop
	when
		
		
		LA: rptis.land.facts.LandDetail (  taxable == false  ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("LA", LA );
		
	Map _p0 = new HashMap();
_p0.put( "landdetail", LA );
_p0.put( "expr", (new ActionExpression("0", bindings)) );
action.execute( "calc-av",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RUL7e02b404:166ae687f42:-5511', '
package rptbilling.PENALTY_CURRENT_YEAR;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "PENALTY_CURRENT_YEAR"
	agenda-group "PENALTY"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CY:year,CQTR:qtr > 1 ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  revtype matches "basic|sef",year == CY,qtr < CQTR,NMON:monthsfromqtr,TAX:amtdue ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
		bindings.put("CQTR", CQTR );
		
		bindings.put("NMON", NMON );
		
		bindings.put("TAX", TAX );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("TAX * NMON * 0.02", bindings)) );
action.execute( "calc-interest",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-255e', '
package rptbilling.BUILD_BILL_ITEMS;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "BUILD_BILL_ITEMS"
	agenda-group "AFTER_SUMMARY"
	salience 50000
	no-loop
	when
		
		
		RLTS: rptis.landtax.facts.RPTLedgerTaxSummaryFact (   ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RLTS", RLTS );
		
	Map _p0 = new HashMap();
_p0.put( "taxsummary", RLTS );
action.execute( "add-billitem",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-26bf', '
package rptbilling.TOTAL_ADVANCE;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "TOTAL_ADVANCE"
	agenda-group "SUMMARY"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year > CY,revtype not matches "firecode" ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "revperiod", "advance" );
action.execute( "create-tax-summary",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-26d0', '
package rptbilling.TOTAL_CURRENT;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "TOTAL_CURRENT"
	agenda-group "SUMMARY"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year == CY ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "revperiod", "current" );
action.execute( "create-tax-summary",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-2f1f', '
package rptbilling.EXPIRY_DATE_DEFAULT;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "EXPIRY_DATE_DEFAULT"
	agenda-group "BEFORE_SUMMARY"
	salience 10000
	no-loop
	when
		
		
		BILL: rptis.landtax.facts.Bill (  CDATE:currentdate ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("BILL", BILL );
		
		bindings.put("CDATE", CDATE );
		
	Map _p0 = new HashMap();
_p0.put( "bill", BILL );
_p0.put( "expr", (new ActionExpression("@MONTHEND( CDATE )", bindings)) );
action.execute( "set-bill-expiry",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-319f', '
package rptbilling.EXPIRY_DATE_ADVANCE_YEAR;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "EXPIRY_DATE_ADVANCE_YEAR"
	agenda-group "BEFORE_SUMMARY"
	salience 5000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RL: rptis.landtax.facts.RPTLedgerFact (  lastyearpaid == CY,lastqtrpaid == 4 ) 
		
		BILL: rptis.landtax.facts.Bill (  billtoyear > CY ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RL", RL );
		
		bindings.put("BILL", BILL );
		
	Map _p0 = new HashMap();
_p0.put( "bill", BILL );
_p0.put( "expr", (new ActionExpression("@MONTHEND(@DATE(CY, 12, 1));", bindings)) );
action.execute( "set-bill-expiry",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-3811', '
package rptbilling.SPLIT_QUARTERLY_BILLED_ITEMS;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "SPLIT_QUARTERLY_BILLED_ITEMS"
	agenda-group "BEFORE_SUMMARY"
	salience 50000
	no-loop
	when
		
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  qtrly == false ,revtype matches "basic|sef" ) 
		
		BILL: rptis.landtax.facts.Bill (  forpayment == true  ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("RLI", RLI );
		
		bindings.put("BILL", BILL );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
action.execute( "split-bill-item",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-3c17', '
package rptbilling.AGGREGATE_PREVIOUS_ITEMS;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "AGGREGATE_PREVIOUS_ITEMS"
	agenda-group "BEFORE_SUMMARY"
	salience 60000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year < CY,qtrly == true  ) 
		
		BILL: rptis.landtax.facts.Bill (  forpayment == false  ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
		bindings.put("BILL", BILL );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
action.execute( "aggregate-bill-item",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-4197', '
package rptbilling.DISCOUNT_ADVANCE;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "DISCOUNT_ADVANCE"
	agenda-group "DISCOUNT"
	salience 40000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year > CY,revtype matches "basic|sef",TAX:amtdue ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
		bindings.put("TAX", TAX );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
_p0.put( "expr", (new ActionExpression("@ROUND(TAX * 0.20)", bindings)) );
action.execute( "calc-discount",_p0,drools);

end


	')
go

INSERT INTO sys_rule_deployed ([objid], [ruletext]) VALUES ('RULec9d7ab:166235c2e16:-5fcb', '
package rptbilling.SPLIT_QTR;
import rptbilling.*;
import java.util.*;
import com.rameses.rules.common.*;

global RuleAction action;

rule "SPLIT_QTR"
	agenda-group "INIT"
	salience 50000
	no-loop
	when
		
		
		 CurrentDate (  CY:year ) 
		
		RLI: rptis.landtax.facts.RPTLedgerItemFact (  year >= CY ) 
		
	then
		Map bindings = new HashMap();
		
		bindings.put("CY", CY );
		
		bindings.put("RLI", RLI );
		
	Map _p0 = new HashMap();
_p0.put( "rptledgeritem", RLI );
action.execute( "split-by-qtr",_p0,drools);

end


	')
go


INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('CurrentDate', 'CurrentDate', 'Current Date', 'CurrentDate', '1', '', '', NULL, '', '', '', '', '', '', 'LANDTAX', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.bldg.facts.BldgAdjustment', 'rptis.bldg.facts.BldgAdjustment', 'Building Adjustment', 'rptis.bldg.facts.BldgAdjustment', '10', NULL, 'ADJ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.bldg.facts.BldgFloor', 'rptis.bldg.facts.BldgFloor', 'Building Floor', 'rptis.bldg.facts.BldgFloor', '4', NULL, 'BF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.bldg.facts.BldgRPU', 'rptis.bldg.facts.BldgRPU', 'Building RPU', 'rptis.bldg.facts.BldgRPU', '1', NULL, 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.bldg.facts.BldgStructure', 'rptis.bldg.facts.BldgStructure', 'Building Structure', 'rptis.bldg.facts.BldgStructure', '2', NULL, 'BS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.bldg.facts.BldgUse', 'rptis.bldg.facts.BldgUse', 'Building Actual Use', 'rptis.bldg.facts.BldgUse', '3', NULL, 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.bldg.facts.BldgVariable', 'rptis.bldg.facts.BldgVariable', 'Derived Variable', 'rptis.bldg.facts.BldgVariable', '35', NULL, 'VAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.facts.Classification', 'rptis.facts.Classification', 'Classification', 'rptis.facts.Classification', '45', NULL, 'PC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.facts.RPTVariable', 'rptis.facts.RPTVariable', 'System Variable', 'rptis.facts.RPTVariable', '1000', NULL, 'VAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.facts.RPU', 'rptis.facts.RPU', 'RPU', 'rptis.facts.RPU', '-1', NULL, 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.facts.RPUAssessment', 'rptis.facts.RPUAssessment', 'Assessment', 'rptis.facts.RPUAssessment', '80', NULL, 'RA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.land.facts.LandAdjustment', 'rptis.land.facts.LandAdjustment', 'Adjustment', 'rptis.land.facts.LandAdjustment', '6', NULL, 'ADJ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.land.facts.LandDetail', 'rptis.land.facts.LandDetail', 'Appraisal', 'rptis.land.facts.LandDetail', '2', NULL, 'LA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.AssessedValue', 'rptis.landtax.facts.AssessedValue', 'Assessed Value', 'rptis.landtax.facts.AssessedValue', '2', NULL, 'AVINFO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.Bill', 'rptis.landtax.facts.Bill', 'Bill', 'rptis.landtax.facts.Bill', '2', NULL, 'BILL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.Classification', 'rptis.landtax.facts.Classification', 'Classification', 'rptis.landtax.facts.Classification', '0', NULL, 'CLASS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.RPTBillItem', 'rptis.landtax.facts.RPTBillItem', 'Bill Item', 'rptis.landtax.facts.RPTBillItem', '3', NULL, 'BILLITEM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.RPTIncentive', 'rptis.landtax.facts.RPTIncentive', 'Incentive', 'rptis.landtax.facts.RPTIncentive', '10', NULL, 'INCENTIVE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.RPTLedgerFact', 'rptis.landtax.facts.RPTLedgerFact', 'Ledger', 'rptis.landtax.facts.RPTLedgerFact', '5', NULL, 'RL', '0', '', '', '', '', '', NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'Ledger Item', 'rptis.landtax.facts.RPTLedgerItemFact', '6', NULL, 'RLI', NULL, '', '', '', '', '', NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'Tax Summary', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', '21', NULL, 'RLTS', NULL, '', '', '', '', '', NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.landtax.facts.ShareFact', 'rptis.landtax.facts.ShareFact', 'Share', 'rptis.landtax.facts.ShareFact', '50', NULL, 'LSH', NULL, '', '', '', '', '', NULL, 'landtax', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.mach.facts.MachineActualUse', 'rptis.mach.facts.MachineActualUse', 'Actual Use', 'rptis.mach.facts.MachineActualUse', '3', NULL, 'MAU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.mach.facts.MachineDetail', 'rptis.mach.facts.MachineDetail', 'Machine', 'rptis.mach.facts.MachineDetail', '2', NULL, 'MACH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.misc.facts.MiscItem', 'rptis.misc.facts.MiscItem', 'Miscellaneous Item', 'rptis.misc.facts.MiscItem', '1', NULL, 'MI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.misc.facts.MiscRPU', 'rptis.misc.facts.MiscRPU', 'Miscellaneous RPU', 'rptis.misc.facts.MiscRPU', '0', NULL, 'MRPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('rptis.planttree.facts.PlantTreeDetail', 'rptis.planttree.facts.PlantTreeDetail', 'Plant/Tree Appraisal', 'rptis.planttree.facts.PlantTreeDetail', '1', NULL, 'PTD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RPTTxnInfoFact', 'RPTTxnInfoFact', 'Transaction', 'RPTTxnInfoFact', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-2067b891:1502c6f04ca:-7f71', 'PartialPayment', 'Partial Payment', 'rptis.landtax.facts.PartialPayment', '15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-245f3fbb:14f9b505a11:-7f93', 'TxnAttributeFact', 'Attributes', 'TxnAttributeFact', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-2486b0ca:146fff66c3e:-57b0', 'variable', 'Derived Variable', 'rptis.bldg.facts.BldgVariable', '35', NULL, 'VAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-2486b0ca:146fff66c3e:-711c', 'BldgAdjustment', 'Building Adjustment', 'rptis.bldg.facts.BldgAdjustment', '10', NULL, 'ADJ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-2486b0ca:146fff66c3e:-7ad1', 'BldgFloor', 'Building Floor', 'rptis.bldg.facts.BldgFloor', '4', NULL, 'BF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-2486b0ca:146fff66c3e:-7b6a', 'BldgUse', 'Building Actual Use', 'rptis.bldg.facts.BldgUse', '3', NULL, 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-2486b0ca:146fff66c3e:-7e0e', 'BldgStructure', 'Building Structure', 'rptis.bldg.facts.BldgStructure', '2', NULL, 'BS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-39192c48:1471ebc2797:-7faf', 'RPUAssessment', 'Assessment Info', 'rptis.facts.RPUAssessment', '80', NULL, 'RA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT-5e76cf73:14d69e9c549:-7f07', 'LandAdjustment', 'Adjustment', 'rptis.land.facts.LandAdjustment', '6', NULL, 'ADJ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT17d6e7ce:141df4b60c2:-7c21', 'assessedvalue', 'Assessed Value Data', 'rptis.landtax.facts.AssessedValueFact', '20', NULL, NULL, NULL, '', '', '', '', '', NULL, 'LANDTAX', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT1b4af871:14e3cc46e09:-34c1', 'miscvariable', 'Derived Variable', 'rptis.facts.RPTVariable', '1000', NULL, 'VAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT1b4af871:14e3cc46e09:-36aa', 'MiscRPU', 'Miscellaneous RPU', 'rptis.misc.facts.MiscRPU', '0', NULL, 'MRPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT1e772168:14c5a447e35:-7f78', 'MachineDetail', 'Machine', 'rptis.mach.facts.MachineDetail', '2', NULL, 'MACH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT1e772168:14c5a447e35:-7fd5', 'MachineActualUse', 'Machine Actual Use', 'rptis.mach.facts.MachineActualUse', '1', NULL, 'MAU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT357018a9:1452a5dcbf7:-793b', 'ShareInfoFact', 'LGU Share Info', 'rptis.landtax.facts.ShareInfoFact', '50', NULL, 'LSH', NULL, '', '', '', '', '', NULL, 'LANDTAX', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT3afe51b9:146f7088d9c:-7db1', 'LandDetail', 'Land Item Appraisal', 'rptis.land.facts.LandDetail', '2', NULL, 'LA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT3afe51b9:146f7088d9c:-7eb6', 'RPU', 'RPU', 'rptis.facts.RPU', '1', NULL, 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT3e2b89cb:146ff734573:-7fcb', 'BldgRPU', 'Building Real Property', 'rptis.bldg.facts.BldgRPU', '1', NULL, 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT547c5381:1451ae1cd9c:-75e0', 'paymentoption', 'Payment Option', 'rptis.landtax.facts.PaymentOptionFact', '2', NULL, NULL, NULL, '', '', '', '', '', NULL, 'LANDTAX', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT59614e16:14c5e56ecc8:-7fd1', 'MiscItem', 'Miscellaneous Item', 'rptis.misc.facts.MiscItem', '1', NULL, 'MI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT5b4ac915:147baaa06b4:-7146', 'classification', 'Classification', 'rptis.facts.Classification', '45', NULL, 'PC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT64302071:14232ed987c:-7f4e', 'payoption', 'Pay Option', 'bpls.facts.PayOption', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT6b62feef:14c53ac1f59:-7f69', 'PlantTreeDetail', 'Plant/Tree Appraisal', 'rptis.planttree.facts.PlantTreeDetail', '1', NULL, 'PTD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT6d66cc31:1446cc9522e:-7ee1', 'RPTTxnInfoFact', 'Transaction', 'RPTTxnInfoFact', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rpt', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('RULFACT7ee0ab5e:141b6a15885:-7ff1', 'Ledger', 'Business Ledger', 'BPLedger', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go
INSERT INTO sys_rule_fact ([objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], [builtinconstraints], [domain], [factsuperclass]) VALUES ('TxnAttributeFact', 'TxnAttributeFact', 'Attribute', 'TxnAttributeFact', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RPT', NULL)
go



INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('CurrentDate.day', 'CurrentDate', 'day', 'Day', 'integer', '4', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('CurrentDate.month', 'CurrentDate', 'month', 'Month', 'integer', '3', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('CurrentDate.qtr', 'CurrentDate', 'qtr', 'Quarter', 'integer', '2', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('CurrentDate.year', 'CurrentDate', 'year', 'Year', 'integer', '1', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-1be9605b:1561ac64a9e:-7ce0', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'depreciate', 'Depreciate?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-1be9605b:1561ac64a9e:-7d39', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'adjfordepreciation', 'Adjustment for Depreciation', 'decimal', '15', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-20603cf4:146f0c708c1:-7a25', 'RULFACT357018a9:1452a5dcbf7:-793b', 'lguid', 'LGU', 'string', '4', 'lookup', 'municipality:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2067b891:1502c6f04ca:-7f55', 'RULFACT-2067b891:1502c6f04ca:-7f71', 'rptledger', 'RPT Ledger', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerFact', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-23b1baca:15620373769:-7c10', 'RULFACT-39192c48:1471ebc2797:-7faf', 'exemptedmarketvalue', 'Exempted Market Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-245f3fbb:14f9b505a11:-7f76', 'RULFACT-245f3fbb:14f9b505a11:-7f93', 'attribute', 'Attribute', 'string', '2', 'lookup', 'faastxnattributetype:lookup', 'attribute', 'attribute', NULL, NULL, '1', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-245f3fbb:14f9b505a11:-7f7f', 'RULFACT-245f3fbb:14f9b505a11:-7f93', 'txntype', 'Txn Type', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, '0', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-5751', 'RULFACT-2486b0ca:146fff66c3e:-57b0', 'value', 'Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-5ee6', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'fixrate', 'Fix Rate Assess Level?', 'boolean', '26', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-70e6', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'amount', 'Amount', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-70f0', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'adjtype', 'Adjustment Type', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BLDG_ADJUSTMENT_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7104', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'bldgfloor', 'Building Floor', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, '1', 'rptis.bldg.facts.BldgFloor', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-78af', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'fixrate', 'Fix Rate Assess Level?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a4a', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'storeyrate', 'Storey Adjustment', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a55', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'marketvalue', 'Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a60', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'adjustment', 'Adjustment', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a6b', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'basemarketvalue', 'Base Market Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a76', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'unitvalue', 'Unit Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a81', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'basevalue', 'Base Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7a99', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'area', 'Area', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7aa6', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'bldguse', 'Building Actual Use', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b08', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'assessedvalue', 'Assess Value', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b11', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'assesslevel', 'Assess Level', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b1a', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'marketvalue', 'Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b23', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'adjustment', 'Adjustment', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b2c', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'depreciationvalue', 'Depreciation Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b35', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'basemarketvalue', 'Base Market Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b3e', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'area', 'Area', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b47', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'basevalue', 'Base Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7b50', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'bldgstructure', 'Building Structure', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgStructure', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7db5', 'RULFACT-2486b0ca:146fff66c3e:-7e0e', 'unitvalue', 'Unit Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7dbe', 'RULFACT-2486b0ca:146fff66c3e:-7e0e', 'basevalue', 'Base Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7dc7', 'RULFACT-2486b0ca:146fff66c3e:-7e0e', 'totalfloorarea', 'Total Floor Area', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7dd0', 'RULFACT-2486b0ca:146fff66c3e:-7e0e', 'basefloorarea', 'Base Floor Area', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7dd9', 'RULFACT-2486b0ca:146fff66c3e:-7e0e', 'floorcount', 'Floor Count', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-7dea', 'RULFACT-2486b0ca:146fff66c3e:-7e0e', 'rpu', 'Building Real Property', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, '0', 'rptis.bldg.facts.BldgRPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-2486b0ca:146fff66c3e:-a3f', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'additionalitemcode', 'Adjustment Code', 'string', '3', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-28dc975:156bcab666c:-6789', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'objid', 'RPUID', 'string', '13', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-345b6aee:15625b107e8:-2d2d', 'RULFACT1e772168:14c5a447e35:-7fd5', 'taxable', 'Taxable', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-39192c48:1471ebc2797:-7f3a', 'RULFACT-39192c48:1471ebc2797:-7faf', 'assessedvalue', 'Assessed Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-39192c48:1471ebc2797:-7f51', 'RULFACT-39192c48:1471ebc2797:-7faf', 'assesslevel', 'Assess Level', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-39192c48:1471ebc2797:-7f7e', 'RULFACT-39192c48:1471ebc2797:-7faf', 'marketvalue', 'Market Value', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-39192c48:1471ebc2797:-7f95', 'RULFACT-39192c48:1471ebc2797:-7faf', 'actualuseid', 'Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, '1', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-3ff2d28f:1508dea0692:-769e', 'RULFACT1b4af871:14e3cc46e09:-34c1', 'objid', 'Objid', NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-46fca07e:14c545f3e6a:-79a6', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'area', 'Area', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-533535f1:14ff7d1a0c7:2246', 'RULFACT6d66cc31:1446cc9522e:-7ee1', 'rputype', 'Property Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_RPUTYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-533535f1:14ff7d1a0c7:226d', 'RULFACT6d66cc31:1446cc9522e:-7ee1', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-5e76cf73:14d69e9c549:-7ec9', 'RULFACT-5e76cf73:14d69e9c549:-7f07', 'type', 'Adjustment Type', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_LAND_ADJUSTMENT_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-5e76cf73:14d69e9c549:-7ed2', 'RULFACT-5e76cf73:14d69e9c549:-7f07', 'adjustment', 'Adjustment', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-5e76cf73:14d69e9c549:-7ee3', 'RULFACT-5e76cf73:14d69e9c549:-7f07', 'landdetail', 'Land Detail', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-5e76cf73:14d69e9c549:-7eec', 'RULFACT-5e76cf73:14d69e9c549:-7f07', 'rpu', 'RPU', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.facts.RPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-66ddf216:14f92338db7:-797f', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'useswornamount', 'Use Sworn Amount?', 'boolean', '14', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-66ddf216:14f92338db7:-798a', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'swornamount', 'Sworn Amount', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-6c4ec747:154bd626092:-5677', 'RULFACT1e772168:14c5a447e35:-7f78', 'useswornamount', 'Is Sworn Amount?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-6c4ec747:154bd626092:-5693', 'RULFACT1e772168:14c5a447e35:-7f78', 'swornamount', 'Sworn Amount', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-7530836f:1508909e112:-7693', 'RULFACT-2486b0ca:146fff66c3e:-7ad1', 'objid', 'Objid', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-a35dd35:14e51ec3311:-608a', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'swornamount', 'Sworn Amount', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD-a35dd35:14e51ec3311:-6104', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'useswornamount', 'Use Sworn Amount?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD102ab3e1:147190e9fe4:-56af', 'RULFACT-2486b0ca:146fff66c3e:-57b0', 'bldguse', 'Building Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD102ab3e1:147190e9fe4:-66be', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'bldguse', 'Building Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1441128c:1471efa4c1c:-6de2', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'actualuseid', 'Actual Use', 'string', '12', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1441128c:1471efa4c1c:-75ab', 'RULFACT-2486b0ca:146fff66c3e:-57b0', 'varid', 'Variable Name', 'string', '2', 'lookup', 'rptparameter:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD16890479:155dcd2ec4e:-7dd1', 'RULFACT1e772168:14c5a447e35:-7f78', 'taxable', 'Is Taxable', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD17d6e7ce:141df4b60c2:-7c0c', 'RULFACT17d6e7ce:141df4b60c2:-7c21', 'assessedvalue', 'Assessed Value', 'decimal', '2', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD17d6e7ce:141df4b60c2:-7c13', 'RULFACT17d6e7ce:141df4b60c2:-7c21', 'year', 'Year', 'integer', '1', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-3491', 'RULFACT1b4af871:14e3cc46e09:-34c1', 'value', 'Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-34a2', 'RULFACT1b4af871:14e3cc46e09:-34c1', 'varid', 'Variable Name', 'string', '3', 'lookup', 'rptparameter:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-34ab', 'RULFACT1b4af871:14e3cc46e09:-34c1', 'refid', 'Reference ID', 'string', '2', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-3642', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'assessedvalue', 'Asessed Value', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-364b', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'assesslevel', 'Assess Level', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-3654', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'marketvalue', 'Market Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-365d', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'basemarketvalue', 'Base Market Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-366e', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'actualuseid', 'Actual Use', 'string', '3', 'lookup', 'propertyclassification:objid', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1b4af871:14e3cc46e09:-367f', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-332b', 'RULFACT357018a9:1452a5dcbf7:-793b', 'lgutype', 'LGU Type', 'string', '1', 'lov', '', '', '', '', NULL, '1', 'string', 'RPT_BILLING_LGU_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-3ee8', 'RULFACT357018a9:1452a5dcbf7:-793b', 'sefint', 'SEF Interest', 'decimal', '11', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-3f01', 'RULFACT357018a9:1452a5dcbf7:-793b', 'sefdisc', 'SEF Discount', 'decimal', '10', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-3f1a', 'RULFACT357018a9:1452a5dcbf7:-793b', 'sef', 'SEF', 'decimal', '9', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-3f33', 'RULFACT357018a9:1452a5dcbf7:-793b', 'basicint', 'Basic Interest', 'decimal', '8', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-3f4c', 'RULFACT357018a9:1452a5dcbf7:-793b', 'basicdisc', 'Basic Discount', 'decimal', '7', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-3f65', 'RULFACT357018a9:1452a5dcbf7:-793b', 'basic', 'Basic', 'decimal', '6', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-45b2', 'RULFACT357018a9:1452a5dcbf7:-793b', 'revperiod', 'Revenue Period', 'string', '3', 'lov', '', '', '', '', NULL, '0', 'string', 'RPT_REVENUE_PERIODS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1be07afa:1452a9809e9:-608c', 'RULFACT357018a9:1452a5dcbf7:-793b', 'barangay', 'Barangay', 'string', '5', 'lookup', 'barangay:lookup', 'objid', 'name', '', NULL, NULL, 'string', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1cb5fe2e:14cdb1a6034:-4308', 'RULFACT-2486b0ca:146fff66c3e:-711c', 'additionalitemcode', 'Adjustment Code', 'string', '3', 'string', 'bldgadditionalitem:lookup', 'objid', 'name', NULL, NULL, '0', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-662f', 'RULFACT1e772168:14c5a447e35:-7f78', 'depreciationvalue', 'Depreciation Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7f47', 'RULFACT1e772168:14c5a447e35:-7f78', 'assessedvalue', 'Assessed Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7f50', 'RULFACT1e772168:14c5a447e35:-7f78', 'marketvalue', 'Market Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7f59', 'RULFACT1e772168:14c5a447e35:-7f78', 'basemarketvalue', 'Base Market Value', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7f62', 'RULFACT1e772168:14c5a447e35:-7f78', 'machuse', 'Machine Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'MachineActualUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7f98', 'RULFACT1e772168:14c5a447e35:-7fd5', 'assessedvalue', 'Assessed Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7fa3', 'RULFACT1e772168:14c5a447e35:-7fd5', 'marketvalue', 'Market Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7fae', 'RULFACT1e772168:14c5a447e35:-7fd5', 'basemarketvalue', 'Base Market Value', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD1e772168:14c5a447e35:-7fc1', 'RULFACT1e772168:14c5a447e35:-7fd5', 'actualuseid', 'Actual Use', 'string', '1', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD2701c487:141e346f838:-7f2e', 'RULFACT17d6e7ce:141df4b60c2:-7c21', 'rptledger', 'RPT Ledger', 'string', '3', 'var', '', '', '', '', NULL, NULL, 'rptis.landtax.facts.RPTLedgerFact', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD29e16c33:156249fdf8e:-6e66', 'RULFACT-39192c48:1471ebc2797:-7faf', 'taxable', 'Taxable', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD357018a9:1452a5dcbf7:-7765', 'RULFACT357018a9:1452a5dcbf7:-793b', 'sharetype', 'Share Type', 'string', '2', 'lov', '', '', '', '', NULL, '0', 'string', 'RPT_BILLING_SHARE_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d2b', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'assessedvalue', 'Assessed Value', 'decimal', '14', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d34', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'assesslevel', 'Assess Level', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d3d', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'marketvalue', 'Market Value', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d46', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'actualuseadjustment', 'Actual Use Adjustment', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d4f', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'landvalueadjustment', 'Land Value Adjustment', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d58', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'adjustment', 'Adjustment', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d61', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'basemarketvalue', 'Base Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d6a', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'taxable', 'Taxable', 'boolean', '7', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d73', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'unitvalue', 'Unit Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d7c', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'basevalue', 'Base Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d85', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'areaha', 'Area in Hectare', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d8e', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'areasqm', 'Area in Sq. Meter', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7d97', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'rpu', 'RPU', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'RPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7de0', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'useswornamount', 'Use Sworn Amount?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7dfb', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'swornamount', 'Sworn Amount', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e0d', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'totalav', 'Assessed Value', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e16', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'totalmv', 'Market Value', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e1f', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'totalbmv', 'Base Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e28', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'totalareaha', 'Area in Hectare', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e31', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'totalareasqm', 'Area in Sq. Meter', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e3a', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'taxable', 'Taxable?', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e4b', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'exemptiontypeid', 'Exemption Type', 'string', '4', 'lookup', 'exemptiontype:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e5c', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'classificationid', 'Classification', 'string', '3', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e65', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'ry', 'Revision Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3afe51b9:146f7088d9c:-7e92', 'RULFACT3afe51b9:146f7088d9c:-7eb6', 'rputype', 'Property Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_RPUTYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7e70', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'bldgclass', 'Building Class', 'string', '25', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BLDG_CLASS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7e79', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'condominium', 'Is Condominium', 'boolean', '24', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7e82', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'assesslevel', 'Assess Level', 'decimal', '23', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7e8b', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'percentcompleted', 'Percent Completed', 'integer', '22', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7e96', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'totaladjustment', 'Total Adjustment', 'decimal', '21', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7e9f', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'depreciationvalue', 'Deprecation Value', 'decimal', '20', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ea8', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'depreciation', 'Depreciation Rate', 'decimal', '19', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7eb1', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'floorcount', 'Floor Count', 'integer', '18', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7eba', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'effectiveage', 'Effective Building Age', 'integer', '17', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ec3', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'bldgage', 'Building Age', 'integer', '16', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ecc', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'yroccupied', 'Year Occupied', 'integer', '15', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ed5', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'yrcompleted', 'Year Completed', 'integer', '14', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ede', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'yrappraised', 'Year Appraised', 'integer', '13', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ee7', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'basevalue', 'Base Value', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7ef9', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'useswornamount', 'Use Sworn Amount?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f02', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'swornamount', 'Sworn Amount', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f0b', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'totalav', 'Assess Value', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f14', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'totalmv', 'Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f1d', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'totalbmv', 'Base Market Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f26', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'totalareasqm', 'Area in Sq. Meter', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f2f', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'totalareaha', 'Area in Hectare', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f38', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'taxable', 'Taxable?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f49', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'exemptiontypeid', 'Exemption Type', 'string', '3', 'lookup', 'exemptiontype:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f5a', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', 'property')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD3e2b89cb:146ff734573:-7f63', 'RULFACT3e2b89cb:146ff734573:-7fcb', 'ry', 'Revision Year', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD441bb08f:1436c079bff:-7fc1', 'RULFACT17d6e7ce:141df4b60c2:-7c21', 'qtrlyav', 'Quarterly Assessed Value', 'decimal', '4', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD49a3c540:14e51feb8f6:-5a4c', 'RULFACT-2486b0ca:146fff66c3e:-7b6a', 'objid', 'Objid', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD49a3c540:14e51feb8f6:-6cc5', 'RULFACT1b4af871:14e3cc46e09:-36aa', 'objid', 'RPU ID', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD4bf973aa:1562a233196:-4e2d', 'RULFACT1e772168:14c5a447e35:-7f78', 'depreciation', 'Depreciation Rate', 'boolean', '9', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD547c5381:1451ae1cd9c:-75c6', 'RULFACT547c5381:1451ae1cd9c:-75e0', 'type', 'Type', 'string', '1', 'lov', '', '', '', '', NULL, NULL, 'string', 'RPT_BILLING_PAYMENT_OPTIONS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD59614e16:14c5e56ecc8:-7ea9', 'RULFACT59614e16:14c5e56ecc8:-7fd1', 'depreciation', 'Deprecation Rate', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD59614e16:14c5e56ecc8:-7f8f', 'RULFACT59614e16:14c5e56ecc8:-7fd1', 'assessedvalue', 'Assessed Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD59614e16:14c5e56ecc8:-7f9a', 'RULFACT59614e16:14c5e56ecc8:-7fd1', 'assesslevel', 'Assess Level', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD59614e16:14c5e56ecc8:-7fa5', 'RULFACT59614e16:14c5e56ecc8:-7fd1', 'marketvalue', 'Market Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD59614e16:14c5e56ecc8:-7fb0', 'RULFACT59614e16:14c5e56ecc8:-7fd1', 'depreciatedvalue', 'Depreciation', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD59614e16:14c5e56ecc8:-7fbb', 'RULFACT59614e16:14c5e56ecc8:-7fd1', 'basemarketvalue', 'Base Market Value', 'decimal', '1', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD5b4ac915:147baaa06b4:-6e01', 'RULFACT3afe51b9:146f7088d9c:-7db1', 'classification', 'Classification', 'string', '15', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.facts.Classification', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD5b4ac915:147baaa06b4:-7111', 'RULFACT5b4ac915:147baaa06b4:-7146', 'objid', 'Classification', 'string', '1', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD64302071:14232ed987c:-7f3d', 'RULFACT64302071:14232ed987c:-7f4e', 'type', 'Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'BP_PAYOPTIONS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7ec5', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'assessedvalue', 'Assessed Value', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7ece', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'assesslevel', 'Assess Level', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7ed7', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'marketvalue', 'Market Value', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7ee0', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'adjustmentrate', 'Adjustment Rate', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7ee9', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'adjustment', 'Adjustment', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7ef2', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'basemarketvalue', 'Base Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7efb', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'unitvalue', 'Unit Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7f04', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'areacovered', 'Area Covered', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7f0d', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'nonproductive', 'Non-Productive', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7f16', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'productive', 'Productive', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7f39', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7f4a', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'actualuseid', 'Actual Use', 'string', '3', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6b62feef:14c53ac1f59:-7f53', 'RULFACT6b62feef:14c53ac1f59:-7f69', 'RPU', 'RPU', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'RPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6d66cc31:1446cc9522e:-7e84', 'RULFACT6d66cc31:1446cc9522e:-7ee1', 'planRequired', 'Approved Plan Required', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6d66cc31:1446cc9522e:-7ea0', 'RULFACT6d66cc31:1446cc9522e:-7ee1', 'txntypemode', 'Txn Type Mode', 'string', '3', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_TXN_TYPE_MODES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD6d66cc31:1446cc9522e:-7ebd', 'RULFACT6d66cc31:1446cc9522e:-7ee1', 'txntype', 'Txn Type', 'string', '5', 'lov', NULL, NULL, NULL, NULL, NULL, '1', 'string', 'RPT_TXN_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD7ee0ab5e:141b6a15885:-7fd5', 'RULFACT7ee0ab5e:141b6a15885:-7ff1', 'amtdue', 'Amount Due', 'decimal', '1', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD7ee0ab5e:141b6a15885:-7fdc', 'RULFACT7ee0ab5e:141b6a15885:-7ff1', 'qtr', 'Qtr', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD7ee0ab5e:141b6a15885:-7fe3', 'RULFACT7ee0ab5e:141b6a15885:-7ff1', 'year', 'Year', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('FACTFLD7ee0ab5e:141b6a15885:-7fea', 'RULFACT7ee0ab5e:141b6a15885:-7ff1', 'apptype', 'Application Type', NULL, '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BUSINESS_APP_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgAdjustment.additionalitemcode', 'rptis.bldg.facts.BldgAdjustment', 'additionalitemcode', 'Adjustment Code', 'string', '3', 'string', 'bldgadditionalitem:lookup', 'objid', 'name', NULL, NULL, '0', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgAdjustment.adjtype', 'rptis.bldg.facts.BldgAdjustment', 'adjtype', 'Adjustment Type', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BLDG_ADJUSTMENT_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgAdjustment.amount', 'rptis.bldg.facts.BldgAdjustment', 'amount', 'Amount', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgAdjustment.bldgfloor', 'rptis.bldg.facts.BldgAdjustment', 'bldgfloor', 'Building Floor', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, '1', 'rptis.bldg.facts.BldgFloor', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgAdjustment.bldguse', 'rptis.bldg.facts.BldgAdjustment', 'bldguse', 'Building Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgAdjustment.depreciate', 'rptis.bldg.facts.BldgAdjustment', 'depreciate', 'Depreciate?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.adjustment', 'rptis.bldg.facts.BldgFloor', 'adjustment', 'Adjustment', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.area', 'rptis.bldg.facts.BldgFloor', 'area', 'Area', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.basemarketvalue', 'rptis.bldg.facts.BldgFloor', 'basemarketvalue', 'Base Market Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.basevalue', 'rptis.bldg.facts.BldgFloor', 'basevalue', 'Base Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.bldguse', 'rptis.bldg.facts.BldgFloor', 'bldguse', 'Building Actual Use', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.marketvalue', 'rptis.bldg.facts.BldgFloor', 'marketvalue', 'Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.objid', 'rptis.bldg.facts.BldgFloor', 'objid', 'Objid', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.storeyrate', 'rptis.bldg.facts.BldgFloor', 'storeyrate', 'Storey Adjustment', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgFloor.unitvalue', 'rptis.bldg.facts.BldgFloor', 'unitvalue', 'Unit Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.assesslevel', 'rptis.bldg.facts.BldgRPU', 'assesslevel', 'Assess Level', 'decimal', '23', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.basevalue', 'rptis.bldg.facts.BldgRPU', 'basevalue', 'Base Value', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.bldgage', 'rptis.bldg.facts.BldgRPU', 'bldgage', 'Building Age', 'integer', '16', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.bldgclass', 'rptis.bldg.facts.BldgRPU', 'bldgclass', 'Building Class', 'string', '25', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BLDG_CLASS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.classificationid', 'rptis.bldg.facts.BldgRPU', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', 'property')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.condominium', 'rptis.bldg.facts.BldgRPU', 'condominium', 'Is Condominium', 'boolean', '24', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.depreciation', 'rptis.bldg.facts.BldgRPU', 'depreciation', 'Depreciation Rate', 'decimal', '19', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.depreciationvalue', 'rptis.bldg.facts.BldgRPU', 'depreciationvalue', 'Deprecation Value', 'decimal', '20', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.effectiveage', 'rptis.bldg.facts.BldgRPU', 'effectiveage', 'Effective Building Age', 'integer', '17', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.exemptiontypeid', 'rptis.bldg.facts.BldgRPU', 'exemptiontypeid', 'Exemption Type', 'string', '3', 'lookup', 'exemptiontype:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.fixrate', 'rptis.bldg.facts.BldgRPU', 'fixrate', 'Fix Rate Assess Level?', 'boolean', '26', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.floorcount', 'rptis.bldg.facts.BldgRPU', 'floorcount', 'Floor Count', 'integer', '18', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.percentcompleted', 'rptis.bldg.facts.BldgRPU', 'percentcompleted', 'Percent Completed', 'integer', '22', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.ry', 'rptis.bldg.facts.BldgRPU', 'ry', 'Revision Year', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.swornamount', 'rptis.bldg.facts.BldgRPU', 'swornamount', 'Sworn Amount', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.taxable', 'rptis.bldg.facts.BldgRPU', 'taxable', 'Taxable?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.totaladjustment', 'rptis.bldg.facts.BldgRPU', 'totaladjustment', 'Total Adjustment', 'decimal', '21', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.totalareaha', 'rptis.bldg.facts.BldgRPU', 'totalareaha', 'Area in Hectare', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.totalareasqm', 'rptis.bldg.facts.BldgRPU', 'totalareasqm', 'Area in Sq. Meter', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.totalav', 'rptis.bldg.facts.BldgRPU', 'totalav', 'Assess Value', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.totalbmv', 'rptis.bldg.facts.BldgRPU', 'totalbmv', 'Base Market Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.totalmv', 'rptis.bldg.facts.BldgRPU', 'totalmv', 'Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.useswornamount', 'rptis.bldg.facts.BldgRPU', 'useswornamount', 'Use Sworn Amount?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.yrappraised', 'rptis.bldg.facts.BldgRPU', 'yrappraised', 'Year Appraised', 'integer', '13', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.yrcompleted', 'rptis.bldg.facts.BldgRPU', 'yrcompleted', 'Year Completed', 'integer', '14', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgRPU.yroccupied', 'rptis.bldg.facts.BldgRPU', 'yroccupied', 'Year Occupied', 'integer', '15', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgStructure.basefloorarea', 'rptis.bldg.facts.BldgStructure', 'basefloorarea', 'Base Floor Area', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgStructure.basevalue', 'rptis.bldg.facts.BldgStructure', 'basevalue', 'Base Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgStructure.floorcount', 'rptis.bldg.facts.BldgStructure', 'floorcount', 'Floor Count', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgStructure.rpu', 'rptis.bldg.facts.BldgStructure', 'rpu', 'Building Real Property', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, '0', 'rptis.bldg.facts.BldgRPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgStructure.totalfloorarea', 'rptis.bldg.facts.BldgStructure', 'totalfloorarea', 'Total Floor Area', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgStructure.unitvalue', 'rptis.bldg.facts.BldgStructure', 'unitvalue', 'Unit Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.actualuseid', 'rptis.bldg.facts.BldgUse', 'actualuseid', 'Actual Use', 'string', '12', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.adjfordepreciation', 'rptis.bldg.facts.BldgUse', 'adjfordepreciation', 'Adjustment for Depreciation', 'decimal', '15', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.adjustment', 'rptis.bldg.facts.BldgUse', 'adjustment', 'Adjustment', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.area', 'rptis.bldg.facts.BldgUse', 'area', 'Area', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.assessedvalue', 'rptis.bldg.facts.BldgUse', 'assessedvalue', 'Assess Value', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.assesslevel', 'rptis.bldg.facts.BldgUse', 'assesslevel', 'Assess Level', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.basemarketvalue', 'rptis.bldg.facts.BldgUse', 'basemarketvalue', 'Base Market Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.basevalue', 'rptis.bldg.facts.BldgUse', 'basevalue', 'Base Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.bldgstructure', 'rptis.bldg.facts.BldgUse', 'bldgstructure', 'Building Structure', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgStructure', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.depreciationvalue', 'rptis.bldg.facts.BldgUse', 'depreciationvalue', 'Depreciation Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.fixrate', 'rptis.bldg.facts.BldgUse', 'fixrate', 'Fix Rate Assess Level?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.marketvalue', 'rptis.bldg.facts.BldgUse', 'marketvalue', 'Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.objid', 'rptis.bldg.facts.BldgUse', 'objid', 'Objid', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.swornamount', 'rptis.bldg.facts.BldgUse', 'swornamount', 'Sworn Amount', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgUse.useswornamount', 'rptis.bldg.facts.BldgUse', 'useswornamount', 'Use Sworn Amount?', 'boolean', '14', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgVariable.bldguse', 'rptis.bldg.facts.BldgVariable', 'bldguse', 'Building Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgVariable.value', 'rptis.bldg.facts.BldgVariable', 'value', 'Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.bldg.facts.BldgVariable.varid', 'rptis.bldg.facts.BldgVariable', 'varid', 'Variable Name', 'string', '2', 'lookup', 'rptparameter:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.Classification.objid', 'rptis.facts.Classification', 'objid', 'Classification', 'string', '1', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPTVariable.objid', 'rptis.facts.RPTVariable', 'objid', 'Objid', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPTVariable.refid', 'rptis.facts.RPTVariable', 'refid', 'Reference ID', 'string', '2', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPTVariable.value', 'rptis.facts.RPTVariable', 'value', 'Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPTVariable.varid', 'rptis.facts.RPTVariable', 'varid', 'Variable Name', 'string', '3', 'lookup', 'rptparameter:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.classificationid', 'rptis.facts.RPU', 'classificationid', 'Classification', 'string', '4', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.exemptiontypeid', 'rptis.facts.RPU', 'exemptiontypeid', 'Exemption Type', 'string', '5', 'lookup', 'exemptiontype:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.objid', 'rptis.facts.RPU', 'objid', 'objid', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.rputype', 'rptis.facts.RPU', 'rputype', 'Property Type', 'string', '2', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_RPUTYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.ry', 'rptis.facts.RPU', 'ry', 'Revision Year', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.swornamount', 'rptis.facts.RPU', 'swornamount', 'Sworn Amount', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.taxable', 'rptis.facts.RPU', 'taxable', 'Taxable?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.totalareaha', 'rptis.facts.RPU', 'totalareaha', 'Area in Hectare', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.totalareasqm', 'rptis.facts.RPU', 'totalareasqm', 'Area in Sq. Meter', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.totalav', 'rptis.facts.RPU', 'totalav', 'Assessed Value', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.totalbmv', 'rptis.facts.RPU', 'totalbmv', 'Base Market Value', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.totalmv', 'rptis.facts.RPU', 'totalmv', 'Market Value', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPU.useswornamount', 'rptis.facts.RPU', 'useswornamount', 'Use Sworn Amount?', 'boolean', '12', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPUAssessment.actualuseid', 'rptis.facts.RPUAssessment', 'actualuseid', 'Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, '1', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPUAssessment.assessedvalue', 'rptis.facts.RPUAssessment', 'assessedvalue', 'Assessed Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPUAssessment.assesslevel', 'rptis.facts.RPUAssessment', 'assesslevel', 'Assess Level', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPUAssessment.exemptedmarketvalue', 'rptis.facts.RPUAssessment', 'exemptedmarketvalue', 'Exempted Market Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPUAssessment.marketvalue', 'rptis.facts.RPUAssessment', 'marketvalue', 'Market Value', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.facts.RPUAssessment.taxable', 'rptis.facts.RPUAssessment', 'taxable', 'Taxable', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandAdjustment.adjustment', 'rptis.land.facts.LandAdjustment', 'adjustment', 'Adjustment', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandAdjustment.landdetail', 'rptis.land.facts.LandAdjustment', 'landdetail', 'Land Detail', 'string', '2', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandAdjustment.rpu', 'rptis.land.facts.LandAdjustment', 'rpu', 'RPU', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.facts.RPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandAdjustment.type', 'rptis.land.facts.LandAdjustment', 'type', 'Adjustment Type', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_LAND_ADJUSTMENT_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.actualuseadjustment', 'rptis.land.facts.LandDetail', 'actualuseadjustment', 'Actual Use Adjustment', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.adjustment', 'rptis.land.facts.LandDetail', 'adjustment', 'Adjustment', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.area', 'rptis.land.facts.LandDetail', 'area', 'Area', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.areaha', 'rptis.land.facts.LandDetail', 'areaha', 'Area in Hectare', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.areasqm', 'rptis.land.facts.LandDetail', 'areasqm', 'Area in Sq. Meter', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.assessedvalue', 'rptis.land.facts.LandDetail', 'assessedvalue', 'Assessed Value', 'decimal', '14', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.assesslevel', 'rptis.land.facts.LandDetail', 'assesslevel', 'Assess Level', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.basemarketvalue', 'rptis.land.facts.LandDetail', 'basemarketvalue', 'Base Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.basevalue', 'rptis.land.facts.LandDetail', 'basevalue', 'Base Value', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.classification', 'rptis.land.facts.LandDetail', 'classification', 'Classification', 'string', '15', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.facts.Classification', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.landvalueadjustment', 'rptis.land.facts.LandDetail', 'landvalueadjustment', 'Land Value Adjustment', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.marketvalue', 'rptis.land.facts.LandDetail', 'marketvalue', 'Market Value', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.rpu', 'rptis.land.facts.LandDetail', 'rpu', 'RPU', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'RPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.taxable', 'rptis.land.facts.LandDetail', 'taxable', 'Taxable', 'boolean', '7', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.land.facts.LandDetail.unitvalue', 'rptis.land.facts.LandDetail', 'unitvalue', 'Unit Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.actualuse', 'rptis.landtax.facts.AssessedValue', 'actualuse', 'Actual Use', 'string', '4', 'var', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, '0', 'rptis.landtax.facts.Classification', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.av', 'rptis.landtax.facts.AssessedValue', 'av', 'Assessed Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, '1', 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.basicav', 'rptis.landtax.facts.AssessedValue', 'basicav', 'Basic Assessed Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.classification', 'rptis.landtax.facts.AssessedValue', 'classification', 'Classification', 'string', '3', 'var', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'rptis.landtax.facts.Classification', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.idleland', 'rptis.landtax.facts.AssessedValue', 'idleland', 'Is Idle Land?', 'boolean', '9', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.rputype', 'rptis.landtax.facts.AssessedValue', 'rputype', 'Property Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_RPUTYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.sefav', 'rptis.landtax.facts.AssessedValue', 'sefav', 'SEF Assessed Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.txntype', 'rptis.landtax.facts.AssessedValue', 'txntype', 'Transaction Type', 'string', '2', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_TXN_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.AssessedValue.year', 'rptis.landtax.facts.AssessedValue', 'year', 'Year', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, '1', 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Bill.advancebill', 'rptis.landtax.facts.Bill', 'advancebill', 'Is Advance Billing?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Bill.billdate', 'rptis.landtax.facts.Bill', 'billdate', 'Bill Date', 'date', '5', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Bill.billtoqtr', 'rptis.landtax.facts.Bill', 'billtoqtr', 'Quarter', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, '0', 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Bill.billtoyear', 'rptis.landtax.facts.Bill', 'billtoyear', 'Year', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Bill.currentdate', 'rptis.landtax.facts.Bill', 'currentdate', 'Current Date', 'date', '3', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Bill.forpayment', 'rptis.landtax.facts.Bill', 'forpayment', 'Is for Payment?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.Classification.objid', 'rptis.landtax.facts.Classification', 'objid', 'Classification', 'string', '1', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTBillItem.amount', 'rptis.landtax.facts.RPTBillItem', 'amount', 'Amount', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTBillItem.parentacctid', 'rptis.landtax.facts.RPTBillItem', 'parentacctid', 'Account', 'string', '1', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTBillItem.revperiod', 'rptis.landtax.facts.RPTBillItem', 'revperiod', 'Revenue Period', 'string', '3', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_REVENUE_PERIODS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTBillItem.revtype', 'rptis.landtax.facts.RPTBillItem', 'revtype', 'Revenue Type', 'string', '2', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BILLING_REVENUE_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTBillItem.sharetype', 'rptis.landtax.facts.RPTBillItem', 'sharetype', 'Share Type', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BILLING_LGU_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTIncentive.basicrate', 'rptis.landtax.facts.RPTIncentive', 'basicrate', 'Basic Rate', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTIncentive.fromyear', 'rptis.landtax.facts.RPTIncentive', 'fromyear', 'From Year', 'integer', '4', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTIncentive.rptledger', 'rptis.landtax.facts.RPTIncentive', 'rptledger', 'Ledger', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerFact', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTIncentive.sefrate', 'rptis.landtax.facts.RPTIncentive', 'sefrate', 'SEF Rate', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTIncentive.toyear', 'rptis.landtax.facts.RPTIncentive', 'toyear', 'To Year', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.barangay', 'rptis.landtax.facts.RPTLedgerFact', 'barangay', 'Barangay', 'string', '8', 'lookup', 'barangay:lookup', 'objid', 'name', '', NULL, NULL, 'string', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.barangayid', 'rptis.landtax.facts.RPTLedgerFact', 'barangayid', 'Barangay ID', 'string', '12', 'lookup', 'barangay:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.firstqtrpaidontime', 'rptis.landtax.facts.RPTLedgerFact', 'firstqtrpaidontime', '1st Qtr is Paid On-Time', 'boolean', '4', 'boolean', '', '', '', '', NULL, NULL, 'boolean', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.lastqtrpaid', 'rptis.landtax.facts.RPTLedgerFact', 'lastqtrpaid', 'Last Qtr Paid', 'integer', '3', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.lastyearpaid', 'rptis.landtax.facts.RPTLedgerFact', 'lastyearpaid', 'Last Year Paid', 'integer', '2', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.lguid', 'rptis.landtax.facts.RPTLedgerFact', 'lguid', 'LGU ID', 'string', '11', 'lookup', 'municipality:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.missedpayment', 'rptis.landtax.facts.RPTLedgerFact', 'missedpayment', 'Has missed current year Quarterly Payment?', 'boolean', '7', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.objid', 'rptis.landtax.facts.RPTLedgerFact', 'objid', 'Objid', 'string', '1', 'lookup', 'rptledger:lookup', 'objid', 'tdno', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.parentlguid', 'rptis.landtax.facts.RPTLedgerFact', 'parentlguid', 'Parent LGU', 'string', '10', 'lookup', 'province:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.qtrlypaymentpaidontime', 'rptis.landtax.facts.RPTLedgerFact', 'qtrlypaymentpaidontime', 'Quarterly Payment is Paid On-Time', 'boolean', '5', 'boolean', '', '', '', '', NULL, NULL, 'boolean', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.rputype', 'rptis.landtax.facts.RPTLedgerFact', 'rputype', 'Property Type', 'string', '9', 'lov', '', '', '', '', NULL, NULL, 'string', 'RPT_RPUTYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.taxpayerid', 'rptis.landtax.facts.RPTLedgerFact', 'taxpayerid', 'Taxpayer', 'string', '13', 'lookup', 'entity:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerFact.undercompromise', 'rptis.landtax.facts.RPTLedgerFact', 'undercompromise', 'Is under Compromise?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.actualuse', 'rptis.landtax.facts.RPTLedgerItemFact', 'actualuse', 'Actual Use', 'string', '9', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.amtdue', 'rptis.landtax.facts.RPTLedgerItemFact', 'amtdue', 'Tax', 'decimal', '21', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.av', 'rptis.landtax.facts.RPTLedgerItemFact', 'av', 'Assessed Value', 'decimal', '4', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.backtax', 'rptis.landtax.facts.RPTLedgerItemFact', 'backtax', 'Is Back Tax?', 'boolean', '18', 'boolean', '', '', '', '', NULL, NULL, 'boolean', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.basicav', 'rptis.landtax.facts.RPTLedgerItemFact', 'basicav', 'AV for Basic', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.classification', 'rptis.landtax.facts.RPTLedgerItemFact', 'classification', 'Classification', 'string', '8', 'lookup', 'propertyclassification:lookup', 'objid', 'name', '', '0', NULL, 'string', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.discount', 'rptis.landtax.facts.RPTLedgerItemFact', 'discount', 'Discount', 'decimal', '23', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.fullypaid', 'rptis.landtax.facts.RPTLedgerItemFact', 'fullypaid', 'Is Fully Paid?', 'boolean', '13', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.idleland', 'rptis.landtax.facts.RPTLedgerItemFact', 'idleland', 'Is Idle Land?', 'boolean', '12', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.interest', 'rptis.landtax.facts.RPTLedgerItemFact', 'interest', 'Interest', 'decimal', '22', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.monthsfromjan', 'rptis.landtax.facts.RPTLedgerItemFact', 'monthsfromjan', 'Number of Months from January', 'integer', '17', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.monthsfromqtr', 'rptis.landtax.facts.RPTLedgerItemFact', 'monthsfromqtr', 'Number of Months From Quarter', 'integer', '16', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.originalav', 'rptis.landtax.facts.RPTLedgerItemFact', 'originalav', 'Original AV', 'decimal', '10', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.qtr', 'rptis.landtax.facts.RPTLedgerItemFact', 'qtr', 'Qtr', 'integer', '2', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.qtrly', 'rptis.landtax.facts.RPTLedgerItemFact', 'qtrly', 'Is quarterly computed?', 'boolean', '24', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.qtrlypaymentavailed', 'rptis.landtax.facts.RPTLedgerItemFact', 'qtrlypaymentavailed', 'Is Quarterly Payment?', 'boolean', '14', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.reclassed', 'rptis.landtax.facts.RPTLedgerItemFact', 'reclassed', 'Is Reclassed?', 'boolean', '11', 'boolean', '', '', '', '', NULL, NULL, 'boolean', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.revperiod', 'rptis.landtax.facts.RPTLedgerItemFact', 'revperiod', 'Revenue Period', 'string', '20', 'lov', '', '', '', '', NULL, NULL, 'string', 'RPT_REVENUE_PERIODS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.revtype', 'rptis.landtax.facts.RPTLedgerItemFact', 'revtype', 'Revenue Type', 'string', '19', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BILLING_REVENUE_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.rptledger', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptledger', 'RPT Ledger', 'string', '3', 'var', '', '', '', '', NULL, '0', 'rptis.landtax.facts.RPTLedgerFact', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.sefav', 'rptis.landtax.facts.RPTLedgerItemFact', 'sefav', 'AV for SEF', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.taxdifference', 'rptis.landtax.facts.RPTLedgerItemFact', 'taxdifference', 'Is Tax Difference?', 'boolean', '15', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.txntype', 'rptis.landtax.facts.RPTLedgerItemFact', 'txntype', 'Txn Type', 'string', '7', 'lov', '', '', '', '', NULL, NULL, 'string', 'RPT_TXN_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerItemFact.year', 'rptis.landtax.facts.RPTLedgerItemFact', 'year', 'Year', 'integer', '1', 'integer', '', '', '', '', NULL, NULL, 'integer', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.amount', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'amount', 'Amount', 'decimal', '6', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.discount', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'discount', 'Discount', 'decimal', '7', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.firecode', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'firecode', 'Fire Code', 'decimal', '10', 'decimal', '', '', '', '', NULL, NULL, 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.interest', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'interest', 'Interest', 'decimal', '8', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.ledger', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'ledger', 'Ledger', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerFact', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.objid', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'objid', 'Variable Name', 'string', '2', 'lookup', 'rptparameter:lookup', 'name', 'name', '', NULL, '0', 'string', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.revperiod', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'revperiod', 'Revenue Period', 'string', '5', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'RPT_REVENUE_PERIODS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.revtype', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'revtype', 'Revenue Type', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_BILLING_REVENUE_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.rptledger', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'rptledger', 'RPT Ledger', 'string', '3', 'var', '', '', '', '', NULL, NULL, 'rptis.landtax.facts.RPTLedgerFact', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.sef', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'sef', 'SEF', 'decimal', '7', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.sefdisc', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'sefdisc', 'SEF Discount', 'decimal', '8', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.sefint', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'sefint', 'SEF Interest', 'decimal', '9', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.sh', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'sh', 'Socialized Housing Tax', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.shdisc', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'shdisc', 'Socialized Housing Discount', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.RPTLedgerTaxSummaryFact.shint', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'shint', 'Socialized Housing Interest', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.amount', 'rptis.landtax.facts.ShareFact', 'amount', 'Amount', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.barangay', 'rptis.landtax.facts.ShareFact', 'barangay', 'Barangay', 'string', '7', 'lookup', 'barangay:lookup', 'objid', 'name', '', NULL, NULL, 'string', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.basic', 'rptis.landtax.facts.ShareFact', 'basic', 'Basic', 'decimal', '6', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.basicdisc', 'rptis.landtax.facts.ShareFact', 'basicdisc', 'Basic Discount', 'decimal', '7', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.basicint', 'rptis.landtax.facts.ShareFact', 'basicint', 'Basic Interest', 'decimal', '8', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.discount', 'rptis.landtax.facts.ShareFact', 'discount', 'Discount', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.lguid', 'rptis.landtax.facts.ShareFact', 'lguid', 'LGU', 'string', '5', 'lookup', 'municipality:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.lgutype', 'rptis.landtax.facts.ShareFact', 'lgutype', 'LGU Type', 'string', '1', 'lov', '', '', '', '', NULL, '1', 'string', 'RPT_BILLING_LGU_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.revperiod', 'rptis.landtax.facts.ShareFact', 'revperiod', 'Revenue Period', 'string', '4', 'lov', '', '', '', '', NULL, '1', 'string', 'RPT_REVENUE_PERIODS')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.revtype', 'rptis.landtax.facts.ShareFact', 'revtype', 'Revenue Type', 'string', '3', 'lov', NULL, NULL, NULL, NULL, NULL, '1', 'string', 'RPT_BILLING_REVENUE_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.sef', 'rptis.landtax.facts.ShareFact', 'sef', 'SEF', 'decimal', '9', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.sefdisc', 'rptis.landtax.facts.ShareFact', 'sefdisc', 'SEF Discount', 'decimal', '10', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.sefint', 'rptis.landtax.facts.ShareFact', 'sefint', 'SEF Interest', 'decimal', '11', 'decimal', '', '', '', '', NULL, '0', 'decimal', '')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.sh', 'rptis.landtax.facts.ShareFact', 'sh', 'Socialized Housing Tax', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.sharetype', 'rptis.landtax.facts.ShareFact', 'sharetype', 'Share Type', 'string', '2', 'lov', '', '', '', '', NULL, '1', 'string', 'RPT_BILLING_SHARE_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.shdisc', 'rptis.landtax.facts.ShareFact', 'shdisc', 'Socialized Housing Discount', 'decimal', '14', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.landtax.facts.ShareFact.shint', 'rptis.landtax.facts.ShareFact', 'shint', 'Socialized Housing Interest', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineActualUse.actualuseid', 'rptis.mach.facts.MachineActualUse', 'actualuseid', 'Actual Use', 'string', '1', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineActualUse.assessedvalue', 'rptis.mach.facts.MachineActualUse', 'assessedvalue', 'Assessed Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineActualUse.basemarketvalue', 'rptis.mach.facts.MachineActualUse', 'basemarketvalue', 'Base Market Value', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineActualUse.marketvalue', 'rptis.mach.facts.MachineActualUse', 'marketvalue', 'Market Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineActualUse.taxable', 'rptis.mach.facts.MachineActualUse', 'taxable', 'Taxable', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.assessedvalue', 'rptis.mach.facts.MachineDetail', 'assessedvalue', 'Assessed Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.assesslevel', 'rptis.mach.facts.MachineDetail', 'assesslevel', 'Assess Level', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.basemarketvalue', 'rptis.mach.facts.MachineDetail', 'basemarketvalue', 'Base Market Value', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.depreciation', 'rptis.mach.facts.MachineDetail', 'depreciation', 'Depreciation Rate', 'boolean', '10', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.depreciationvalue', 'rptis.mach.facts.MachineDetail', 'depreciationvalue', 'Depreciation Value', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.machuse', 'rptis.mach.facts.MachineDetail', 'machuse', 'Machine Actual Use', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'rptis.mach.facts.MachineActualUse', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.marketvalue', 'rptis.mach.facts.MachineDetail', 'marketvalue', 'Market Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.swornamount', 'rptis.mach.facts.MachineDetail', 'swornamount', 'Sworn Amount', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.taxable', 'rptis.mach.facts.MachineDetail', 'taxable', 'Is Taxable', 'boolean', '7', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.mach.facts.MachineDetail.useswornamount', 'rptis.mach.facts.MachineDetail', 'useswornamount', 'Is Sworn Amount?', 'boolean', '8', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscItem.assessedvalue', 'rptis.misc.facts.MiscItem', 'assessedvalue', 'Assessed Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscItem.assesslevel', 'rptis.misc.facts.MiscItem', 'assesslevel', 'Assess Level', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscItem.basemarketvalue', 'rptis.misc.facts.MiscItem', 'basemarketvalue', 'Base Market Value', 'decimal', '1', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscItem.depreciatedvalue', 'rptis.misc.facts.MiscItem', 'depreciatedvalue', 'Depreciation', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscItem.depreciation', 'rptis.misc.facts.MiscItem', 'depreciation', 'Deprecation Rate', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscItem.marketvalue', 'rptis.misc.facts.MiscItem', 'marketvalue', 'Market Value', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.actualuseid', 'rptis.misc.facts.MiscRPU', 'actualuseid', 'Actual Use', 'string', '3', 'lookup', 'propertyclassification:objid', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.assessedvalue', 'rptis.misc.facts.MiscRPU', 'assessedvalue', 'Asessed Value', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.assesslevel', 'rptis.misc.facts.MiscRPU', 'assesslevel', 'Assess Level', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.basemarketvalue', 'rptis.misc.facts.MiscRPU', 'basemarketvalue', 'Base Market Value', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.classificationid', 'rptis.misc.facts.MiscRPU', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.marketvalue', 'rptis.misc.facts.MiscRPU', 'marketvalue', 'Market Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.objid', 'rptis.misc.facts.MiscRPU', 'objid', 'RPU ID', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.swornamount', 'rptis.misc.facts.MiscRPU', 'swornamount', 'Sworn Amount', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.misc.facts.MiscRPU.useswornamount', 'rptis.misc.facts.MiscRPU', 'useswornamount', 'Use Sworn Amount?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.actualuseid', 'rptis.planttree.facts.PlantTreeDetail', 'actualuseid', 'Actual Use', 'string', '3', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.adjustment', 'rptis.planttree.facts.PlantTreeDetail', 'adjustment', 'Adjustment', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.adjustmentrate', 'rptis.planttree.facts.PlantTreeDetail', 'adjustmentrate', 'Adjustment Rate', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.areacovered', 'rptis.planttree.facts.PlantTreeDetail', 'areacovered', 'Area Covered', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.assessedvalue', 'rptis.planttree.facts.PlantTreeDetail', 'assessedvalue', 'Assessed Value', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.assesslevel', 'rptis.planttree.facts.PlantTreeDetail', 'assesslevel', 'Assess Level', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.basemarketvalue', 'rptis.planttree.facts.PlantTreeDetail', 'basemarketvalue', 'Base Market Value', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.classificationid', 'rptis.planttree.facts.PlantTreeDetail', 'classificationid', 'Classification', 'string', '2', 'lookup', 'propertyclassification:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.marketvalue', 'rptis.planttree.facts.PlantTreeDetail', 'marketvalue', 'Market Value', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.nonproductive', 'rptis.planttree.facts.PlantTreeDetail', 'nonproductive', 'Non-Productive', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.productive', 'rptis.planttree.facts.PlantTreeDetail', 'productive', 'Productive', 'decimal', '4', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.RPU', 'rptis.planttree.facts.PlantTreeDetail', 'RPU', 'RPU', 'string', '1', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'RPU', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('rptis.planttree.facts.PlantTreeDetail.unitvalue', 'rptis.planttree.facts.PlantTreeDetail', 'unitvalue', 'Unit Value', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('RPTTxnInfoFact.planRequired', 'RPTTxnInfoFact', 'planRequired', 'Approved Plan Required', 'boolean', '3', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('RPTTxnInfoFact.txntype', 'RPTTxnInfoFact', 'txntype', 'Txn Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_TXN_TYPES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('RPTTxnInfoFact.txntypemode', 'RPTTxnInfoFact', 'txntypemode', 'Txn Type Mode', 'string', '2', 'lov', NULL, NULL, NULL, NULL, NULL, NULL, 'string', 'RPT_TXN_TYPE_MODES')
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('TxnAttributeFact.attribute', 'TxnAttributeFact', 'attribute', 'Attribute', 'string', '2', 'lookup', 'faastxnattributetype:lookup', 'attribute', 'attribute', NULL, NULL, '1', 'string', NULL)
go
INSERT INTO sys_rule_fact_field ([objid], [parentid], [name], [title], [datatype], [sortorder], [handler], [lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], [required], [vardatatype], [lovname]) VALUES ('TxnAttributeFact.txntype', 'TxnAttributeFact', 'txntype', 'Txn Type', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, '0', 'string', NULL)
go


INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC-17442746:16be936f033:-7e86', 'RUL483027b0:16be9375c61:-77e6', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC-5f8a4a63:17819c1a2a6:-7f18', 'RUL-37dab195:17819c202a5:-58b3', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC-5f8a4a63:17819c1a2a6:-7f1c', 'RUL-37dab195:17819c202a5:-58b3', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC-5f8a4a63:17819c1a2a6:-7f5b', 'RUL-37dab195:17819c202a5:-70b9', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC-5f8a4a63:17819c1a2a6:-7f5d', 'RUL-37dab195:17819c202a5:-70b9', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC16a7ee38:15cfcd300fe:-7fba', 'RUL-79a9a347:15cfcae84de:-55fd', 'rptis.facts.RPUAssessment', 'rptis.facts.RPUAssessment', 'RA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC16a7ee38:15cfcd300fe:-7fbc', 'RUL-79a9a347:15cfcae84de:-55fd', 'rptis.facts.RPU', 'rptis.facts.RPU', 'RPU', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC440e47f4:166ae4152f1:-7fbe', 'RUL1262ad19:166ae41b1fb:-7c88', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC440e47f4:166ae4152f1:-7fc0', 'RUL1262ad19:166ae41b1fb:-7c88', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC5ffbf6c9:1781a117eda:-7cf7', 'RUL-525fef3d:1781a13900b:a48', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC70978a15:166ae6875d1:-7f22', 'RUL7e02b404:166ae687f42:-5511', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC70978a15:166ae6875d1:-7f24', 'RUL7e02b404:166ae687f42:-5511', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fad', 'RULec9d7ab:166235c2e16:-26bf', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7faf', 'RULec9d7ab:166235c2e16:-26bf', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fb4', 'RULec9d7ab:166235c2e16:-26d0', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fb6', 'RULec9d7ab:166235c2e16:-26d0', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fbb', 'RULec9d7ab:166235c2e16:-319f', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fbd', 'RULec9d7ab:166235c2e16:-319f', 'rptis.landtax.facts.RPTLedgerFact', 'rptis.landtax.facts.RPTLedgerFact', 'RL', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fc0', 'RULec9d7ab:166235c2e16:-319f', 'rptis.landtax.facts.Bill', 'rptis.landtax.facts.Bill', 'BILL', '2', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fc7', 'RULec9d7ab:166235c2e16:-3811', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fc9', 'RULec9d7ab:166235c2e16:-3811', 'rptis.landtax.facts.Bill', 'rptis.landtax.facts.Bill', 'BILL', '2', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fcf', 'RULec9d7ab:166235c2e16:-4197', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RC7280357:166235c1be7:-7fd4', 'RULec9d7ab:166235c2e16:-4197', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-103fed47:146ffb40356:-7d40', 'RUL3e2b89cb:146ff734573:-7dcc', 'rptis.bldg.facts.BldgRPU', 'rptis.bldg.facts.BldgRPU', 'RPU', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-128a4cad:146f96a678e:-7e14', 'RUL-128a4cad:146f96a678e:-7e52', 'rptis.land.facts.LandDetail', 'rptis.land.facts.LandDetail', 'LA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-1a2d6e9b:1692d429304:-7748', 'RUL-1a2d6e9b:1692d429304:-7779', 'rptis.landtax.facts.AssessedValue', 'rptis.landtax.facts.AssessedValue', 'AVINFO', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2486b0ca:146fff66c3e:-2bf1', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'rptis.bldg.facts.BldgUse', 'rptis.bldg.facts.BldgUse', 'BU', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2486b0ca:146fff66c3e:-3888', 'RUL-2486b0ca:146fff66c3e:-38e4', 'rptis.bldg.facts.BldgFloor', 'rptis.bldg.facts.BldgFloor', 'BF', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2486b0ca:146fff66c3e:-3ed1', 'RUL-2486b0ca:146fff66c3e:-4192', 'rptis.bldg.facts.BldgUse', 'rptis.bldg.facts.BldgUse', 'BU', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2486b0ca:146fff66c3e:-3f91', 'RUL-2486b0ca:146fff66c3e:-4192', 'rptis.bldg.facts.BldgRPU', 'rptis.bldg.facts.BldgRPU', 'RPU', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2486b0ca:146fff66c3e:-445d', 'RUL-2486b0ca:146fff66c3e:-4697', 'rptis.bldg.facts.BldgStructure', 'rptis.bldg.facts.BldgStructure', 'BS', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2486b0ca:146fff66c3e:-6aad', 'RUL-2486b0ca:146fff66c3e:-6b05', 'rptis.bldg.facts.BldgFloor', 'rptis.bldg.facts.BldgFloor', 'BF', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-28dc975:156bcab666c:-5f3d', 'RUL-3e8edbea:156bc08656a:-5f05', 'rptis.facts.RPTVariable', 'rptis.facts.RPTVariable', 'VAR', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-28dc975:156bcab666c:-6051', 'RUL-3e8edbea:156bc08656a:-5f05', 'rptis.facts.RPU', 'rptis.facts.RPU', 'RPU', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-2ede6703:16642adb9ce:-7a39', 'RUL-2ede6703:16642adb9ce:-7ba0', 'rptis.landtax.facts.Bill', 'rptis.landtax.facts.Bill', 'BILL', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-37dab195:17819c202a5:-7242', 'RUL-37dab195:17819c202a5:-76ff', 'rptis.landtax.facts.RPTLedgerFact', 'rptis.landtax.facts.RPTLedgerFact', 'RL', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-37dab195:17819c202a5:-76c5', 'RUL-37dab195:17819c202a5:-76ff', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-37dab195:17819c202a5:-7a01', 'RUL-37dab195:17819c202a5:-7a3b', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-60c99d04:1470b276e7f:-7dd3', 'RUL-60c99d04:1470b276e7f:-7ecc', 'rptis.bldg.facts.BldgUse', 'rptis.bldg.facts.BldgUse', 'BU', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-60c99d04:1470b276e7f:-7e2a', 'RUL-60c99d04:1470b276e7f:-7ecc', 'rptis.bldg.facts.BldgStructure', 'rptis.bldg.facts.BldgStructure', 'BS', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-79a9a347:15cfcae84de:-5af4', 'RUL-79a9a347:15cfcae84de:-6f2a', 'rptis.facts.RPTVariable', 'rptis.facts.RPTVariable', 'VAR', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-79a9a347:15cfcae84de:-6222', 'RUL-79a9a347:15cfcae84de:-6401', 'rptis.facts.RPU', 'rptis.facts.RPU', 'RPU', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-79a9a347:15cfcae84de:-637a', 'RUL-79a9a347:15cfcae84de:-6401', 'rptis.facts.RPUAssessment', 'rptis.facts.RPUAssessment', 'RA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND-79a9a347:15cfcae84de:-6ebc', 'RUL-79a9a347:15cfcae84de:-6f2a', 'rptis.facts.RPU', 'rptis.facts.RPU', 'RPU', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND1441128c:1471efa4c1c:-6add', 'RUL1441128c:1471efa4c1c:-6b41', 'rptis.facts.RPUAssessment', 'rptis.facts.RPUAssessment', 'BA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND1441128c:1471efa4c1c:-6c2f', 'RUL1441128c:1471efa4c1c:-6c93', 'rptis.facts.RPUAssessment', 'rptis.facts.RPUAssessment', 'BA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND1441128c:1471efa4c1c:-6d84', 'RUL1441128c:1471efa4c1c:-6eaa', 'rptis.bldg.facts.BldgUse', 'rptis.bldg.facts.BldgUse', 'BU', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND5b4ac915:147baaa06b4:-6da4', 'RUL5b4ac915:147baaa06b4:-6f31', 'rptis.land.facts.LandDetail', 'rptis.land.facts.LandDetail', 'LA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCOND7afd4d64:17816d5ee78:-7a8e', 'RUL7afd4d64:17816d5ee78:-7ad2', 'rptis.land.facts.LandDetail', 'rptis.land.facts.LandDetail', 'LA', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-24fc', 'RULec9d7ab:166235c2e16:-255e', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', 'RLTS', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-2ec7', 'RULec9d7ab:166235c2e16:-2f1f', 'rptis.landtax.facts.Bill', 'rptis.landtax.facts.Bill', 'BILL', '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-3905', 'RULec9d7ab:166235c2e16:-3c17', 'rptis.landtax.facts.Bill', 'rptis.landtax.facts.Bill', 'BILL', '2', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-3b0b', 'RULec9d7ab:166235c2e16:-3c17', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-3baa', 'RULec9d7ab:166235c2e16:-3c17', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-5e7c', 'RULec9d7ab:166235c2e16:-5fcb', 'rptis.landtax.facts.RPTLedgerItemFact', 'rptis.landtax.facts.RPTLedgerItemFact', 'RLI', '1', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition ([objid], [parentid], [fact_name], [fact_objid], [varname], [pos], [ruletext], [displaytext], [dynamic_datatype], [dynamic_key], [dynamic_value], [notexist]) VALUES ('RCONDec9d7ab:166235c2e16:-5f7f', 'RULec9d7ab:166235c2e16:-5fcb', 'CurrentDate', 'CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0')
go


INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC-17442746:16be936f033:-7e86', 'RC-17442746:16be936f033:-7e86', 'RUL483027b0:16be9375c61:-77e6', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC-5f8a4a63:17819c1a2a6:-7f1c', 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'RUL-37dab195:17819c202a5:-58b3', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC-5f8a4a63:17819c1a2a6:-7f5b', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'RUL-37dab195:17819c202a5:-70b9', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC16a7ee38:15cfcd300fe:-7fba', 'RC16a7ee38:15cfcd300fe:-7fba', 'RUL-79a9a347:15cfcae84de:-55fd', 'RA', 'rptis.facts.RPUAssessment', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC16a7ee38:15cfcd300fe:-7fbc', 'RC16a7ee38:15cfcd300fe:-7fbc', 'RUL-79a9a347:15cfcae84de:-55fd', 'RPU', 'rptis.facts.RPU', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC440e47f4:166ae4152f1:-7fc0', 'RC440e47f4:166ae4152f1:-7fc0', 'RUL1262ad19:166ae41b1fb:-7c88', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC5ffbf6c9:1781a117eda:-7cf7', 'RC5ffbf6c9:1781a117eda:-7cf7', 'RUL-525fef3d:1781a13900b:a48', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC70978a15:166ae6875d1:-7f22', 'RC70978a15:166ae6875d1:-7f22', 'RUL7e02b404:166ae687f42:-5511', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7faf', 'RC7280357:166235c1be7:-7faf', 'RULec9d7ab:166235c2e16:-26bf', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7fb6', 'RC7280357:166235c1be7:-7fb6', 'RULec9d7ab:166235c2e16:-26d0', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7fbd', 'RC7280357:166235c1be7:-7fbd', 'RULec9d7ab:166235c2e16:-319f', 'RL', 'rptis.landtax.facts.RPTLedgerFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7fc0', 'RC7280357:166235c1be7:-7fc0', 'RULec9d7ab:166235c2e16:-319f', 'BILL', 'rptis.landtax.facts.Bill', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7fc7', 'RC7280357:166235c1be7:-7fc7', 'RULec9d7ab:166235c2e16:-3811', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7fc9', 'RC7280357:166235c1be7:-7fc9', 'RULec9d7ab:166235c2e16:-3811', 'BILL', 'rptis.landtax.facts.Bill', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RC7280357:166235c1be7:-7fd4', 'RC7280357:166235c1be7:-7fd4', 'RULec9d7ab:166235c2e16:-4197', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC-17442746:16be936f033:-7e83', 'RC-17442746:16be936f033:-7e86', 'RUL483027b0:16be9375c61:-77e6', 'AV', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f16', 'RC-5f8a4a63:17819c1a2a6:-7f18', 'RUL-37dab195:17819c202a5:-58b3', 'CY', 'integer', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f17', 'RC-5f8a4a63:17819c1a2a6:-7f18', 'RUL-37dab195:17819c202a5:-58b3', 'CQTR', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f5c', 'RC-5f8a4a63:17819c1a2a6:-7f5d', 'RUL-37dab195:17819c202a5:-70b9', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC16a7ee38:15cfcd300fe:-7fb9', 'RC16a7ee38:15cfcd300fe:-7fba', 'RUL-79a9a347:15cfcae84de:-55fd', 'AV', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC16a7ee38:15cfcd300fe:-7fbb', 'RC16a7ee38:15cfcd300fe:-7fbc', 'RUL-79a9a347:15cfcae84de:-55fd', 'RPUID', 'string', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC440e47f4:166ae4152f1:-7fbd', 'RC440e47f4:166ae4152f1:-7fbe', 'RUL1262ad19:166ae41b1fb:-7c88', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC5ffbf6c9:1781a117eda:-7cf6', 'RC5ffbf6c9:1781a117eda:-7cf7', 'RUL-525fef3d:1781a13900b:a48', 'AV', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC70978a15:166ae6875d1:-7f23', 'RC70978a15:166ae6875d1:-7f24', 'RUL7e02b404:166ae687f42:-5511', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC7280357:166235c1be7:-7fac', 'RC7280357:166235c1be7:-7fad', 'RULec9d7ab:166235c2e16:-26bf', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC7280357:166235c1be7:-7fb3', 'RC7280357:166235c1be7:-7fb4', 'RULec9d7ab:166235c2e16:-26d0', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC7280357:166235c1be7:-7fba', 'RC7280357:166235c1be7:-7fbb', 'RULec9d7ab:166235c2e16:-319f', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC7280357:166235c1be7:-7fcd', 'RC7280357:166235c1be7:-7fcf', 'RULec9d7ab:166235c2e16:-4197', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCC7280357:166235c1be7:-7fd3', 'RC7280357:166235c1be7:-7fd4', 'RULec9d7ab:166235c2e16:-4197', 'TAX', 'decimal', '3')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-103fed47:146ffb40356:-7d40', 'RCOND-103fed47:146ffb40356:-7d40', 'RUL3e2b89cb:146ff734573:-7dcc', 'RPU', 'rptis.bldg.facts.BldgRPU', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-128a4cad:146f96a678e:-7e14', 'RCOND-128a4cad:146f96a678e:-7e14', 'RUL-128a4cad:146f96a678e:-7e52', 'LA', 'rptis.land.facts.LandDetail', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-1a2d6e9b:1692d429304:-7748', 'RCOND-1a2d6e9b:1692d429304:-7748', 'RUL-1a2d6e9b:1692d429304:-7779', 'AVINFO', 'rptis.landtax.facts.AssessedValue', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2486b0ca:146fff66c3e:-2bf1', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'BU', 'rptis.bldg.facts.BldgUse', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2486b0ca:146fff66c3e:-3888', 'RCOND-2486b0ca:146fff66c3e:-3888', 'RUL-2486b0ca:146fff66c3e:-38e4', 'BF', 'rptis.bldg.facts.BldgFloor', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2486b0ca:146fff66c3e:-3ed1', 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'RUL-2486b0ca:146fff66c3e:-4192', 'BU', 'rptis.bldg.facts.BldgUse', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2486b0ca:146fff66c3e:-3f91', 'RCOND-2486b0ca:146fff66c3e:-3f91', 'RUL-2486b0ca:146fff66c3e:-4192', 'RPU', 'rptis.bldg.facts.BldgRPU', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2486b0ca:146fff66c3e:-445d', 'RCOND-2486b0ca:146fff66c3e:-445d', 'RUL-2486b0ca:146fff66c3e:-4697', 'BS', 'rptis.bldg.facts.BldgStructure', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2486b0ca:146fff66c3e:-6aad', 'RCOND-2486b0ca:146fff66c3e:-6aad', 'RUL-2486b0ca:146fff66c3e:-6b05', 'BF', 'rptis.bldg.facts.BldgFloor', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-28dc975:156bcab666c:-5f3d', 'RCOND-28dc975:156bcab666c:-5f3d', 'RUL-3e8edbea:156bc08656a:-5f05', 'VAR', 'rptis.facts.RPTVariable', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-28dc975:156bcab666c:-6051', 'RCOND-28dc975:156bcab666c:-6051', 'RUL-3e8edbea:156bc08656a:-5f05', 'RPU', 'rptis.facts.RPU', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-2ede6703:16642adb9ce:-7a39', 'RCOND-2ede6703:16642adb9ce:-7a39', 'RUL-2ede6703:16642adb9ce:-7ba0', 'BILL', 'rptis.landtax.facts.Bill', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-37dab195:17819c202a5:-7242', 'RCOND-37dab195:17819c202a5:-7242', 'RUL-37dab195:17819c202a5:-76ff', 'RL', 'rptis.landtax.facts.RPTLedgerFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-37dab195:17819c202a5:-76c5', 'RCOND-37dab195:17819c202a5:-76c5', 'RUL-37dab195:17819c202a5:-76ff', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-37dab195:17819c202a5:-7a01', 'RCOND-37dab195:17819c202a5:-7a01', 'RUL-37dab195:17819c202a5:-7a3b', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-60c99d04:1470b276e7f:-7dd3', 'RCOND-60c99d04:1470b276e7f:-7dd3', 'RUL-60c99d04:1470b276e7f:-7ecc', 'BU', 'rptis.bldg.facts.BldgUse', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-60c99d04:1470b276e7f:-7e2a', 'RCOND-60c99d04:1470b276e7f:-7e2a', 'RUL-60c99d04:1470b276e7f:-7ecc', 'BS', 'rptis.bldg.facts.BldgStructure', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-79a9a347:15cfcae84de:-5af4', 'RCOND-79a9a347:15cfcae84de:-5af4', 'RUL-79a9a347:15cfcae84de:-6f2a', 'VAR', 'rptis.facts.RPTVariable', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-79a9a347:15cfcae84de:-6222', 'RCOND-79a9a347:15cfcae84de:-6222', 'RUL-79a9a347:15cfcae84de:-6401', 'RPU', 'rptis.facts.RPU', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-79a9a347:15cfcae84de:-637a', 'RCOND-79a9a347:15cfcae84de:-637a', 'RUL-79a9a347:15cfcae84de:-6401', 'RA', 'rptis.facts.RPUAssessment', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND-79a9a347:15cfcae84de:-6ebc', 'RCOND-79a9a347:15cfcae84de:-6ebc', 'RUL-79a9a347:15cfcae84de:-6f2a', 'RPU', 'rptis.facts.RPU', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND1441128c:1471efa4c1c:-6add', 'RCOND1441128c:1471efa4c1c:-6add', 'RUL1441128c:1471efa4c1c:-6b41', 'BA', 'rptis.facts.RPUAssessment', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND1441128c:1471efa4c1c:-6c2f', 'RCOND1441128c:1471efa4c1c:-6c2f', 'RUL1441128c:1471efa4c1c:-6c93', 'BA', 'rptis.facts.RPUAssessment', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND1441128c:1471efa4c1c:-6d84', 'RCOND1441128c:1471efa4c1c:-6d84', 'RUL1441128c:1471efa4c1c:-6eaa', 'BU', 'rptis.bldg.facts.BldgUse', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND5b4ac915:147baaa06b4:-6da4', 'RCOND5b4ac915:147baaa06b4:-6da4', 'RUL5b4ac915:147baaa06b4:-6f31', 'LA', 'rptis.land.facts.LandDetail', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCOND7afd4d64:17816d5ee78:-7a8e', 'RCOND7afd4d64:17816d5ee78:-7a8e', 'RUL7afd4d64:17816d5ee78:-7ad2', 'LA', 'rptis.land.facts.LandDetail', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONDec9d7ab:166235c2e16:-24fc', 'RCONDec9d7ab:166235c2e16:-24fc', 'RULec9d7ab:166235c2e16:-255e', 'RLTS', 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONDec9d7ab:166235c2e16:-2ec7', 'RCONDec9d7ab:166235c2e16:-2ec7', 'RULec9d7ab:166235c2e16:-2f1f', 'BILL', 'rptis.landtax.facts.Bill', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONDec9d7ab:166235c2e16:-3905', 'RCONDec9d7ab:166235c2e16:-3905', 'RULec9d7ab:166235c2e16:-3c17', 'BILL', 'rptis.landtax.facts.Bill', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONDec9d7ab:166235c2e16:-3b0b', 'RCONDec9d7ab:166235c2e16:-3b0b', 'RULec9d7ab:166235c2e16:-3c17', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONDec9d7ab:166235c2e16:-5e7c', 'RCONDec9d7ab:166235c2e16:-5e7c', 'RULec9d7ab:166235c2e16:-5fcb', 'RLI', 'rptis.landtax.facts.RPTLedgerItemFact', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-103fed47:146ffb40356:-7c7c', 'RCOND-103fed47:146ffb40356:-7d40', 'RUL3e2b89cb:146ff734573:-7dcc', 'YRCOMPLETED', 'integer', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-103fed47:146ffb40356:-7ce5', 'RCOND-103fed47:146ffb40356:-7d40', 'RUL3e2b89cb:146ff734573:-7dcc', 'YRAPPRAISED', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-128a4cad:146f96a678e:-7d80', 'RCOND-128a4cad:146f96a678e:-7e14', 'RUL-128a4cad:146f96a678e:-7e52', 'AL', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-128a4cad:146f96a678e:-7dd0', 'RCOND-128a4cad:146f96a678e:-7e14', 'RUL-128a4cad:146f96a678e:-7e52', 'MV', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-1a2d6e9b:1692d429304:-7746', 'RCOND-1a2d6e9b:1692d429304:-7748', 'RUL-1a2d6e9b:1692d429304:-7779', 'AV', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-1a2d6e9b:1692d429304:-7747', 'RCOND-1a2d6e9b:1692d429304:-7748', 'RUL-1a2d6e9b:1692d429304:-7779', 'YR', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-2b45', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'ADJ', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-2b8c', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'DEP', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-2bc5', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'BMV', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-382b', 'RCOND-2486b0ca:146fff66c3e:-3888', 'RUL-2486b0ca:146fff66c3e:-38e4', 'ADJ', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-3860', 'RCOND-2486b0ca:146fff66c3e:-3888', 'RUL-2486b0ca:146fff66c3e:-38e4', 'BMV', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-3f19', 'RCOND-2486b0ca:146fff66c3e:-3f91', 'RUL-2486b0ca:146fff66c3e:-4192', 'DPRATE', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-6a5a', 'RCOND-2486b0ca:146fff66c3e:-6aad', 'RUL-2486b0ca:146fff66c3e:-6b05', 'UV', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-6a8b', 'RCOND-2486b0ca:146fff66c3e:-6aad', 'RUL-2486b0ca:146fff66c3e:-6b05', 'AREA', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-28dc975:156bcab666c:-5ed8', 'RCOND-28dc975:156bcab666c:-5f3d', 'RUL-3e8edbea:156bc08656a:-5f05', 'AV', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2ede6703:16642adb9ce:-79c8', 'RCOND-2ede6703:16642adb9ce:-7a39', 'RUL-2ede6703:16642adb9ce:-7ba0', 'BILLDATE', 'date', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-2ef3c345:147ed584975:-7e3d', 'RCOND-60c99d04:1470b276e7f:-7e2a', 'RUL-60c99d04:1470b276e7f:-7ecc', 'TOTAL_FLOOR_AREA', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-5676', 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'RUL-37dab195:17819c202a5:-58b3', 'TAX', 'decimal', '3')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-5ab5', 'RC70978a15:166ae6875d1:-7f22', 'RUL7e02b404:166ae687f42:-5511', 'NMON', 'integer', '4')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-6d63', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'RUL-37dab195:17819c202a5:-70b9', 'NMON', 'integer', '3')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-6e57', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'RUL-37dab195:17819c202a5:-70b9', 'TAX', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-765f', 'RCOND-37dab195:17819c202a5:-76c5', 'RUL-37dab195:17819c202a5:-76ff', 'AV', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-7887', 'RCOND-37dab195:17819c202a5:-7a01', 'RUL-37dab195:17819c202a5:-7a3b', 'AV', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-60c99d04:1470b276e7f:-7d64', 'RCOND-60c99d04:1470b276e7f:-7dd3', 'RUL-60c99d04:1470b276e7f:-7ecc', 'BASEVALUE', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-5a45', 'RCOND-79a9a347:15cfcae84de:-5af4', 'RUL-79a9a347:15cfcae84de:-6f2a', 'AV', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-5ccd', 'RCOND-79a9a347:15cfcae84de:-6ebc', 'RUL-79a9a347:15cfcae84de:-6f2a', 'RPUID', 'string', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-61bf', 'RCOND-79a9a347:15cfcae84de:-6222', 'RUL-79a9a347:15cfcae84de:-6401', 'RPUID', 'string', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-62a7', 'RCOND-79a9a347:15cfcae84de:-637a', 'RUL-79a9a347:15cfcae84de:-6401', 'AV', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST102ab3e1:147190e9fe4:-26f3', 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'RUL-2486b0ca:146fff66c3e:-4192', 'ADJUSTMENT', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST102ab3e1:147190e9fe4:-272e', 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'RUL-2486b0ca:146fff66c3e:-4192', 'BMV', 'decimal', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6a9b', 'RCOND1441128c:1471efa4c1c:-6add', 'RUL1441128c:1471efa4c1c:-6b41', 'AL', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6abf', 'RCOND1441128c:1471efa4c1c:-6add', 'RUL1441128c:1471efa4c1c:-6b41', 'MV', 'decimal', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6d47', 'RCOND1441128c:1471efa4c1c:-6d84', 'RUL1441128c:1471efa4c1c:-6eaa', 'ACTUALUSE', 'string', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST40c0977:151a9b0cb60:-7d29', 'RCOND-60c99d04:1470b276e7f:-7dd3', 'RUL-60c99d04:1470b276e7f:-7ecc', 'BUAREA', 'decimal', '2')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST5b4ac915:147baaa06b4:-6d59', 'RCOND5b4ac915:147baaa06b4:-6da4', 'RUL5b4ac915:147baaa06b4:-6f31', 'CLASS', 'rptis.facts.Classification', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST5ffbdc02:166e7b2c367:-641c', 'RC70978a15:166ae6875d1:-7f22', 'RUL7e02b404:166ae687f42:-5511', 'TAX', 'decimal', '4')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONST7e02b404:166ae687f42:-54ad', 'RC70978a15:166ae6875d1:-7f24', 'RUL7e02b404:166ae687f42:-5511', 'CQTR', 'integer', '1')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-2ea1', 'RCONDec9d7ab:166235c2e16:-2ec7', 'RULec9d7ab:166235c2e16:-2f1f', 'CDATE', 'date', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-3b8e', 'RCONDec9d7ab:166235c2e16:-3baa', 'RULec9d7ab:166235c2e16:-3c17', 'CY', 'integer', '0')
go
INSERT INTO sys_rule_condition_var ([objid], [parentid], [ruleid], [varname], [datatype], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-5f63', 'RCONDec9d7ab:166235c2e16:-5f7f', 'RULec9d7ab:166235c2e16:-5fcb', 'CY', 'integer', '0')
go



INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-17442746:16be936f033:-7e83', 'RC-17442746:16be936f033:-7e86', 'rptis.landtax.facts.RPTLedgerItemFact.av', 'av', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f16', 'RC-5f8a4a63:17819c1a2a6:-7f18', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f17', 'RC-5f8a4a63:17819c1a2a6:-7f18', 'CurrentDate.qtr', 'qtr', 'CQTR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f19', 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'rptis.landtax.facts.RPTLedgerItemFact.qtr', 'qtr', NULL, 'greater than or equal to', '>=', '1', 'RCC-5f8a4a63:17819c1a2a6:-7f17', 'CQTR', NULL, NULL, NULL, NULL, NULL, '3')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f1a', 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'equal to', '==', '1', 'RCC-5f8a4a63:17819c1a2a6:-7f16', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f59', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than or equal to', '>=', '0', NULL, NULL, NULL, '1970', NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC-5f8a4a63:17819c1a2a6:-7f5c', 'RC-5f8a4a63:17819c1a2a6:-7f5d', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC16a7ee38:15cfcd300fe:-7fb8', 'RC16a7ee38:15cfcd300fe:-7fba', 'rptis.facts.RPUAssessment.actualuseid', 'actualuseid', NULL, 'not null', '!= null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC16a7ee38:15cfcd300fe:-7fb9', 'RC16a7ee38:15cfcd300fe:-7fba', 'rptis.facts.RPUAssessment.assessedvalue', 'assessedvalue', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC16a7ee38:15cfcd300fe:-7fbb', 'RC16a7ee38:15cfcd300fe:-7fbc', 'rptis.facts.RPU.objid', 'objid', 'RPUID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC440e47f4:166ae4152f1:-7fbd', 'RC440e47f4:166ae4152f1:-7fbe', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC440e47f4:166ae4152f1:-7fbf', 'RC440e47f4:166ae4152f1:-7fc0', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'less than', '<', '1', 'RCC440e47f4:166ae4152f1:-7fbd', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC5ffbf6c9:1781a117eda:-7cf4', 'RC5ffbf6c9:1781a117eda:-7cf7', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than or equal to', '>=', NULL, NULL, NULL, NULL, '2012', NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC5ffbf6c9:1781a117eda:-7cf5', 'RC5ffbf6c9:1781a117eda:-7cf7', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["basic"]', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC5ffbf6c9:1781a117eda:-7cf6', 'RC5ffbf6c9:1781a117eda:-7cf7', 'rptis.landtax.facts.RPTLedgerItemFact.av', 'av', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC70978a15:166ae6875d1:-7f1d', 'RC70978a15:166ae6875d1:-7f22', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["basic","sef"]', NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC70978a15:166ae6875d1:-7f23', 'RC70978a15:166ae6875d1:-7f24', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fac', 'RC7280357:166235c1be7:-7fad', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fae', 'RC7280357:166235c1be7:-7faf', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than', '>', '1', 'RCC7280357:166235c1be7:-7fac', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fb3', 'RC7280357:166235c1be7:-7fb4', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fb5', 'RC7280357:166235c1be7:-7fb6', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'equal to', '==', '1', 'RCC7280357:166235c1be7:-7fb3', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fba', 'RC7280357:166235c1be7:-7fbb', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fbc', 'RC7280357:166235c1be7:-7fbd', 'rptis.landtax.facts.RPTLedgerFact.lastyearpaid', 'lastyearpaid', NULL, 'equal to', '==', '1', 'RCC7280357:166235c1be7:-7fba', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fbf', 'RC7280357:166235c1be7:-7fc0', 'rptis.landtax.facts.Bill.billtoyear', 'billtoyear', NULL, 'greater than', '>', '1', 'RCC7280357:166235c1be7:-7fba', 'CY', NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fc6', 'RC7280357:166235c1be7:-7fc7', 'rptis.landtax.facts.RPTLedgerItemFact.qtrly', 'qtrly', NULL, 'not true', '== false', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fc8', 'RC7280357:166235c1be7:-7fc9', 'rptis.landtax.facts.Bill.forpayment', 'forpayment', NULL, 'is true', '== true', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fcd', 'RC7280357:166235c1be7:-7fcf', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fd0', 'RC7280357:166235c1be7:-7fd4', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than', '>', '1', 'RCC7280357:166235c1be7:-7fcd', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCC7280357:166235c1be7:-7fd3', 'RC7280357:166235c1be7:-7fd4', 'rptis.landtax.facts.RPTLedgerItemFact.amtdue', 'amtdue', 'TAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-103fed47:146ffb40356:-7c7c', 'RCOND-103fed47:146ffb40356:-7d40', 'rptis.bldg.facts.BldgRPU.yrcompleted', 'yrcompleted', 'YRCOMPLETED', 'greater than', '>', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-103fed47:146ffb40356:-7ce5', 'RCOND-103fed47:146ffb40356:-7d40', 'rptis.bldg.facts.BldgRPU.yrappraised', 'yrappraised', 'YRAPPRAISED', 'greater than', '>', '0', NULL, NULL, NULL, '0', NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-128a4cad:146f96a678e:-7d80', 'RCOND-128a4cad:146f96a678e:-7e14', 'rptis.land.facts.LandDetail.assesslevel', 'assesslevel', 'AL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-128a4cad:146f96a678e:-7dd0', 'RCOND-128a4cad:146f96a678e:-7e14', 'rptis.land.facts.LandDetail.marketvalue', 'marketvalue', 'MV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-1a2d6e9b:1692d429304:-7746', 'RCOND-1a2d6e9b:1692d429304:-7748', 'rptis.landtax.facts.AssessedValue.av', 'av', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-1a2d6e9b:1692d429304:-7747', 'RCOND-1a2d6e9b:1692d429304:-7748', 'rptis.landtax.facts.AssessedValue.year', 'year', 'YR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-20ef5a5a:1781af283df:-6b84', 'RCOND-37dab195:17819c202a5:-7a01', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["basic"]', NULL, '3')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-2b45', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'rptis.bldg.facts.BldgUse.adjustment', 'adjustment', 'ADJ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-2b8c', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'rptis.bldg.facts.BldgUse.depreciationvalue', 'depreciationvalue', 'DEP', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-2bc5', 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'rptis.bldg.facts.BldgUse.basemarketvalue', 'basemarketvalue', 'BMV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-382b', 'RCOND-2486b0ca:146fff66c3e:-3888', 'rptis.bldg.facts.BldgFloor.adjustment', 'adjustment', 'ADJ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-3860', 'RCOND-2486b0ca:146fff66c3e:-3888', 'rptis.bldg.facts.BldgFloor.basemarketvalue', 'basemarketvalue', 'BMV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-3f19', 'RCOND-2486b0ca:146fff66c3e:-3f91', 'rptis.bldg.facts.BldgRPU.depreciation', 'depreciation', 'DPRATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-6a5a', 'RCOND-2486b0ca:146fff66c3e:-6aad', 'rptis.bldg.facts.BldgFloor.unitvalue', 'unitvalue', 'UV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2486b0ca:146fff66c3e:-6a8b', 'RCOND-2486b0ca:146fff66c3e:-6aad', 'rptis.bldg.facts.BldgFloor.area', 'area', 'AREA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-28dc975:156bcab666c:-5ed8', 'RCOND-28dc975:156bcab666c:-5f3d', 'rptis.facts.RPTVariable.value', 'value', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-28dc975:156bcab666c:-5f1b', 'RCOND-28dc975:156bcab666c:-5f3d', 'rptis.facts.RPTVariable.varid', 'varid', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '[[key:"TOTAL_VALUE",value:"TOTAL_VALUE"]]', NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2ede6703:16642adb9ce:-79c8', 'RCOND-2ede6703:16642adb9ce:-7a39', 'rptis.landtax.facts.Bill.billdate', 'billdate', 'BILLDATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2ede6703:16642adb9ce:-7a03', 'RCOND-2ede6703:16642adb9ce:-7a39', 'rptis.landtax.facts.Bill.advancebill', 'advancebill', NULL, 'is true', '== true', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-2ef3c345:147ed584975:-7e3d', 'RCOND-60c99d04:1470b276e7f:-7e2a', 'rptis.bldg.facts.BldgStructure.totalfloorarea', 'totalfloorarea', 'TOTAL_FLOOR_AREA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-543f', 'RC7280357:166235c1be7:-7fd4', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["basic","sef"]', NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-5676', 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'rptis.landtax.facts.RPTLedgerItemFact.amtdue', 'amtdue', 'TAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-5773', 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["basic","sef"]', NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-5ab5', 'RC70978a15:166ae6875d1:-7f22', 'rptis.landtax.facts.RPTLedgerItemFact.monthsfromqtr', 'monthsfromqtr', 'NMON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-6c40', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["basic","sef"]', NULL, '4')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-6d63', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'rptis.landtax.facts.RPTLedgerItemFact.monthsfromjan', 'monthsfromjan', 'NMON', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-6e57', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'rptis.landtax.facts.RPTLedgerItemFact.amtdue', 'amtdue', 'TAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-6f34', 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'less than', '<', '1', 'RCC-5f8a4a63:17819c1a2a6:-7f5c', 'CY', NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-71d6', 'RCOND-37dab195:17819c202a5:-7242', 'rptis.landtax.facts.RPTLedgerFact.taxpayerid', 'taxpayerid', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '[[key:"JUR-41f18a4b:1651c29df59:-4c1c",value:"EDC SIKLAB POWER CORPORATION"],[key:"JUR-57026396:15dbc0c8430:-3d40",value:"NATIONAL POWER CORPORATION"]]', NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-7529', 'RCOND-37dab195:17819c202a5:-76c5', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than or equal to', '>=', NULL, NULL, NULL, NULL, '2000', NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-75b1', 'RCOND-37dab195:17819c202a5:-76c5', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '["sef"]', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-765f', 'RCOND-37dab195:17819c202a5:-76c5', 'rptis.landtax.facts.RPTLedgerItemFact.av', 'av', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-7887', 'RCOND-37dab195:17819c202a5:-7a01', 'rptis.landtax.facts.RPTLedgerItemFact.av', 'av', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-792b', 'RCOND-37dab195:17819c202a5:-7a01', 'rptis.landtax.facts.RPTLedgerItemFact.classification', 'classification', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '[[key:"FRLCI00000092",value:"AGRICULTURAL"]]', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-37dab195:17819c202a5:-79af', 'RCOND-37dab195:17819c202a5:-7a01', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than or equal to', '>=', NULL, NULL, NULL, NULL, '2014', NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-525fef3d:1781a13900b:5465', 'RC440e47f4:166ae4152f1:-7fc0', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'not exist in', 'not matches', NULL, NULL, NULL, NULL, NULL, NULL, '["firecode"]', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-525fef3d:1781a13900b:5685', 'RC7280357:166235c1be7:-7faf', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'not exist in', 'not matches', NULL, NULL, NULL, NULL, NULL, NULL, '["firecode"]', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-525fef3d:1781a13900b:ae9', 'RC5ffbf6c9:1781a117eda:-7cf7', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'less than or equal to', '<=', NULL, NULL, NULL, NULL, '2013', NULL, NULL, NULL, '3')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-60c99d04:1470b276e7f:-7d64', 'RCOND-60c99d04:1470b276e7f:-7dd3', 'rptis.bldg.facts.BldgUse.basevalue', 'basevalue', 'BASEVALUE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-60c99d04:1470b276e7f:-7dae', 'RCOND-60c99d04:1470b276e7f:-7dd3', 'rptis.bldg.facts.BldgUse.bldgstructure', 'bldgstructure', NULL, 'equals', '==', NULL, 'RCOND-60c99d04:1470b276e7f:-7e2a', 'BS', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-5a45', 'RCOND-79a9a347:15cfcae84de:-5af4', 'rptis.facts.RPTVariable.value', 'value', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-5aaa', 'RCOND-79a9a347:15cfcae84de:-5af4', 'rptis.facts.RPTVariable.varid', 'varid', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '[[key:"TOTAL_VALUE",value:"TOTAL_VALUE"]]', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-5ccd', 'RCOND-79a9a347:15cfcae84de:-6ebc', 'rptis.facts.RPU.objid', 'objid', 'RPUID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-61bf', 'RCOND-79a9a347:15cfcae84de:-6222', 'rptis.facts.RPU.objid', 'objid', 'RPUID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-62a7', 'RCOND-79a9a347:15cfcae84de:-637a', 'rptis.facts.RPUAssessment.assessedvalue', 'assessedvalue', 'AV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST-79a9a347:15cfcae84de:-6379', 'RCOND-79a9a347:15cfcae84de:-637a', 'rptis.facts.RPUAssessment.actualuseid', 'actualuseid', NULL, 'not null', '!= null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST102ab3e1:147190e9fe4:-26f3', 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'rptis.bldg.facts.BldgUse.adjustment', 'adjustment', 'ADJUSTMENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST102ab3e1:147190e9fe4:-272e', 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'rptis.bldg.facts.BldgUse.basemarketvalue', 'basemarketvalue', 'BMV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6a9b', 'RCOND1441128c:1471efa4c1c:-6add', 'rptis.facts.RPUAssessment.assesslevel', 'assesslevel', 'AL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6abf', 'RCOND1441128c:1471efa4c1c:-6add', 'rptis.facts.RPUAssessment.marketvalue', 'marketvalue', 'MV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6adc', 'RCOND1441128c:1471efa4c1c:-6add', 'rptis.facts.RPUAssessment.actualuseid', 'actualuseid', NULL, 'not null', '!= null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6c2e', 'RCOND1441128c:1471efa4c1c:-6c2f', 'rptis.facts.RPUAssessment.actualuseid', 'actualuseid', NULL, 'not null', '!= null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST1441128c:1471efa4c1c:-6d47', 'RCOND1441128c:1471efa4c1c:-6d84', 'rptis.bldg.facts.BldgUse.actualuseid', 'actualuseid', 'ACTUALUSE', 'not null', '!= null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST40ac2a42:171728cfca4:-72f6', 'RCONDec9d7ab:166235c2e16:-5e7c', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'greater than or equal to', '>=', '1', 'RCONSTec9d7ab:166235c2e16:-5f63', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST40c0977:151a9b0cb60:-7d29', 'RCOND-60c99d04:1470b276e7f:-7dd3', 'rptis.bldg.facts.BldgUse.area', 'area', 'BUAREA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST43877190:16db8bfd315:-6faf', 'RC-17442746:16be936f033:-7e86', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', NULL, NULL, NULL, NULL, NULL, NULL, '[''basic'',''sef'']', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST5b4ac915:147baaa06b4:-6d59', 'RCOND5b4ac915:147baaa06b4:-6da4', 'rptis.land.facts.LandDetail.classification', 'classification', 'CLASS', 'not null', '!= null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST5ffbdc02:166e7b2c367:-641c', 'RC70978a15:166ae6875d1:-7f22', 'rptis.landtax.facts.RPTLedgerItemFact.amtdue', 'amtdue', 'TAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST5ffbdc02:166e7b2c367:-65fd', 'RC70978a15:166ae6875d1:-7f22', 'rptis.landtax.facts.RPTLedgerItemFact.qtr', 'qtr', NULL, 'less than', '<', '1', 'RCONST7e02b404:166ae687f42:-54ad', 'CQTR', NULL, NULL, NULL, NULL, NULL, '2')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST5ffbdc02:166e7b2c367:-66a5', 'RC70978a15:166ae6875d1:-7f22', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'equal to', '==', '1', 'RCC70978a15:166ae6875d1:-7f23', 'CY', NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST7afd4d64:17816d5ee78:-7a35', 'RCOND7afd4d64:17816d5ee78:-7a8e', 'rptis.land.facts.LandDetail.taxable', 'taxable', NULL, 'not true', '== false', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONST7e02b404:166ae687f42:-54ad', 'RC70978a15:166ae6875d1:-7f24', 'CurrentDate.qtr', 'qtr', 'CQTR', 'greater than', '>', NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-2ea1', 'RCONDec9d7ab:166235c2e16:-2ec7', 'rptis.landtax.facts.Bill.currentdate', 'currentdate', 'CDATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-311f', 'RC7280357:166235c1be7:-7fbd', 'rptis.landtax.facts.RPTLedgerFact.lastqtrpaid', 'lastqtrpaid', NULL, 'equal to', '==', NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-36b2', 'RC7280357:166235c1be7:-7fc7', 'rptis.landtax.facts.RPTLedgerItemFact.revtype', 'revtype', NULL, 'is any of the ff.', 'matches', '0', NULL, NULL, NULL, NULL, NULL, '[''basic'',''sef'']', NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-38dd', 'RCONDec9d7ab:166235c2e16:-3905', 'rptis.landtax.facts.Bill.forpayment', 'forpayment', NULL, 'not true', '== false', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-39af', 'RCONDec9d7ab:166235c2e16:-3b0b', 'rptis.landtax.facts.RPTLedgerItemFact.qtrly', 'qtrly', NULL, 'is true', '== true', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-3abb', 'RCONDec9d7ab:166235c2e16:-3b0b', 'rptis.landtax.facts.RPTLedgerItemFact.year', 'year', NULL, 'less than', '<', '1', 'RCONSTec9d7ab:166235c2e16:-3b8e', 'CY', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-3b8e', 'RCONDec9d7ab:166235c2e16:-3baa', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_condition_constraint ([objid], [parentid], [field_objid], [fieldname], [varname], [operator_caption], [operator_symbol], [usevar], [var_objid], [var_name], [decimalvalue], [intvalue], [stringvalue], [listvalue], [datevalue], [pos]) VALUES ('RCONSTec9d7ab:166235c2e16:-5f63', 'RCONDec9d7ab:166235c2e16:-5f7f', 'CurrentDate.year', 'year', 'CY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go



INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA-17442746:16be936f033:-7e82', 'RUL483027b0:16be9375c61:-77e6', 'rptis.landtax.actions.CalcTax', 'calc-tax', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA-5f8a4a63:17819c1a2a6:-7f15', 'RUL-37dab195:17819c202a5:-58b3', 'rptis.landtax.actions.CalcDiscount', 'calc-discount', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA-5f8a4a63:17819c1a2a6:-7f56', 'RUL-37dab195:17819c202a5:-70b9', 'rptis.landtax.actions.CalcInterest', 'calc-interest', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA16a7ee38:15cfcd300fe:-7fb7', 'RUL-79a9a347:15cfcae84de:-55fd', 'rptis.actions.AddDeriveVar', 'add-derive-var', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA440e47f4:166ae4152f1:-7fbc', 'RUL1262ad19:166ae41b1fb:-7c88', 'rptis.landtax.actions.CreateTaxSummary', 'create-tax-summary', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA5ffbf6c9:1781a117eda:-7cf3', 'RUL-525fef3d:1781a13900b:a48', 'rptis.landtax.actions.CalcTax', 'calc-tax', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA7280357:166235c1be7:-7fab', 'RULec9d7ab:166235c2e16:-26bf', 'rptis.landtax.actions.CreateTaxSummary', 'create-tax-summary', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA7280357:166235c1be7:-7fb2', 'RULec9d7ab:166235c2e16:-26d0', 'rptis.landtax.actions.CreateTaxSummary', 'create-tax-summary', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA7280357:166235c1be7:-7fb9', 'RULec9d7ab:166235c2e16:-319f', 'rptis.landtax.actions.SetBillExpiryDate', 'set-bill-expiry', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RA7280357:166235c1be7:-7fcc', 'RULec9d7ab:166235c2e16:-4197', 'rptis.landtax.actions.CalcDiscount', 'calc-discount', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-103fed47:146ffb40356:-7c51', 'RUL3e2b89cb:146ff734573:-7dcc', 'RULADEF3e2b89cb:146ff734573:-7c47', 'calc-bldg-age', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-128a4cad:146f96a678e:-7d4d', 'RUL-128a4cad:146f96a678e:-7e52', 'RULADEF-128a4cad:146f96a678e:-7efa', 'calc-av', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-1a2d6e9b:1692d429304:-7649', 'RUL-1a2d6e9b:1692d429304:-7779', 'rptis.landtax.actions.AddSef', 'add-sef', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-1a2d6e9b:1692d429304:-7700', 'RUL-1a2d6e9b:1692d429304:-7779', 'rptis.landtax.actions.AddBasic', 'add-basic', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-230de61f:15fbcfe4002:1a6d', 'RUL-2486b0ca:146fff66c3e:-4697', 'rptis.bldg.actions.CalcDepreciationByRange', 'calc-depreciation-range', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-2486b0ca:146fff66c3e:-2ade', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'RULADEF-2486b0ca:146fff66c3e:-3151', 'calc-bldguse-mv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-2486b0ca:146fff66c3e:-37a2', 'RUL-2486b0ca:146fff66c3e:-38e4', 'RULADEF-2486b0ca:146fff66c3e:-79a8', 'calc-floor-mv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-2486b0ca:146fff66c3e:-3d32', 'RUL-2486b0ca:146fff66c3e:-4192', 'RULADEF-2486b0ca:146fff66c3e:-4365', 'calc-bldguse-depreciation', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-2486b0ca:146fff66c3e:-6a12', 'RUL-2486b0ca:146fff66c3e:-6b05', 'RULADEF-2486b0ca:146fff66c3e:-7a02', 'calc-floor-bmv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-28dc975:156bcab666c:-5e3c', 'RUL-3e8edbea:156bc08656a:-5f05', 'rptis.actions.CalcTotalRPUAssessValue', 'recalc-rpu-totalav', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-2ede6703:16642adb9ce:-794c', 'RUL-2ede6703:16642adb9ce:-7ba0', 'rptis.landtax.actions.SetBillExpiryDate', 'set-bill-expiry', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-37dab195:17819c202a5:-7151', 'RUL-37dab195:17819c202a5:-76ff', 'rptis.landtax.actions.CalcTax', 'calc-tax', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-37dab195:17819c202a5:-77d4', 'RUL-37dab195:17819c202a5:-7a3b', 'rptis.landtax.actions.CalcTax', 'calc-tax', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-60c99d04:1470b276e7f:-7a52', 'RUL-60c99d04:1470b276e7f:-7ecc', 'RULADEF-60c99d04:1470b276e7f:-7c52', 'calc-bldguse-bmv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-79a9a347:15cfcae84de:-5e1c', 'RUL-79a9a347:15cfcae84de:-6401', 'rptis.actions.AddDeriveVar', 'add-derive-var', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT-79a9a347:15cfcae84de:-6d86', 'RUL-79a9a347:15cfcae84de:-6f2a', 'rptis.actions.CalcTotalRPUAssessValue', 'recalc-rpu-totalav', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT1441128c:1471efa4c1c:-68bd', 'RUL1441128c:1471efa4c1c:-6b41', 'RULADEF1441128c:1471efa4c1c:-69a5', 'calc-assess-value', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT1441128c:1471efa4c1c:-6b97', 'RUL1441128c:1471efa4c1c:-6c93', 'RULADEF-39192c48:1471ebc2797:-7dae', 'calc-assess-level', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT1441128c:1471efa4c1c:-6ce7', 'RUL1441128c:1471efa4c1c:-6eaa', 'RULADEF-39192c48:1471ebc2797:-7dee', 'add-assessment-info', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT5b4ac915:147baaa06b4:-6be9', 'RUL5b4ac915:147baaa06b4:-6f31', 'rptis.land.actions.AddAssessmentInfo', 'add-assessment-info', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT5ffbdc02:166e7b2c367:-6229', 'RUL7e02b404:166ae687f42:-5511', 'rptis.landtax.actions.CalcInterest', 'calc-interest', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-6bbe', 'RUL1441128c:1471efa4c1c:-6c93', 'rptis.bldg.actions.CalcAssessLevel', 'calc-assess-level', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-6d19', 'RUL1441128c:1471efa4c1c:-6eaa', 'rptis.bldg.actions.AddAssessmentInfo', 'add-assessment-info', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-6eb4', 'RUL-2486b0ca:146fff66c3e:-2c4a', 'rptis.bldg.actions.CalcBldgUseMV', 'calc-bldguse-mv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-6fcc', 'RUL-2486b0ca:146fff66c3e:-38e4', 'rptis.bldg.actions.CalcFloorMV', 'calc-floor-mv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-713c', 'RUL-2486b0ca:146fff66c3e:-4192', 'rptis.bldg.actions.CalcBldgUseDepreciation', 'calc-bldguse-depreciation', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-73bb', 'RUL-60c99d04:1470b276e7f:-7ecc', 'rptis.bldg.actions.CalcBldgUseBMV', 'calc-bldguse-bmv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-7564', 'RUL-2486b0ca:146fff66c3e:-6b05', 'rptis.bldg.actions.CalcFloorBMV', 'calc-floor-bmv', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-7734', 'RUL3e2b89cb:146ff734573:-7dcc', 'rptis.bldg.actions.CalcBldgAge', 'calc-bldg-age', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-79c8', 'RUL7afd4d64:17816d5ee78:-7ad2', 'rptis.land.actions.CalcAssessValue', 'calc-av', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACT7afd4d64:17816d5ee78:-7c5d', 'RUL-128a4cad:146f96a678e:-7e52', 'rptis.land.actions.CalcAssessValue', 'calc-av', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACTec9d7ab:166235c2e16:-249a', 'RULec9d7ab:166235c2e16:-255e', 'rptis.landtax.actions.AddBillItem', 'add-billitem', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACTec9d7ab:166235c2e16:-2e2e', 'RULec9d7ab:166235c2e16:-2f1f', 'rptis.landtax.actions.SetBillExpiryDate', 'set-bill-expiry', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACTec9d7ab:166235c2e16:-35b3', 'RULec9d7ab:166235c2e16:-3811', 'rptis.landtax.actions.SplitLedgerItem', 'split-bill-item', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACTec9d7ab:166235c2e16:-3879', 'RULec9d7ab:166235c2e16:-3c17', 'rptis.landtax.actions.AggregateLedgerItem', 'aggregate-bill-item', '0')
go
INSERT INTO sys_rule_action ([objid], [parentid], [actiondef_objid], [actiondef_name], [pos]) VALUES ('RACTec9d7ab:166235c2e16:-5b6f', 'RULec9d7ab:166235c2e16:-5fcb', 'rptis.landtax.actions.SplitByQtr', 'split-by-qtr', '0')
go




INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('AddRequirement', 'add-requirement', 'Add Requirement', '1', 'add-requirement', 'rpt', 'AddRequirement')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.actions.AddDeriveVar', 'add-derive-var', 'Add Derive Variable', '45', 'add-derive-var', 'RPT', 'rptis.actions.AddDeriveVar')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.actions.AddDeriveVariable', 'add-derive-var', 'Add Derive Variable', '50', 'add-derive-var', 'RPT', 'rptis.actions.AddDeriveVariable')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.actions.CalcRPUAssessValue', 'recalc-rpuassessment', 'Recalculate Assessment AV', '1050', 'recalc-rpuassessment', 'rpt', 'rptis.actions.CalcRPUAssessValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.actions.CalcTotalRPUAssessValue', 'recalc-rpu-totalav', 'Recalculate RPU Total AV', '1100', 'recalc-rpu-totalav', 'rpt', 'rptis.actions.CalcTotalRPUAssessValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.AddAssessmentInfo', 'add-assessment-info', 'Add Assessment Info', '80', 'add-assessment-info', 'RPT', 'rptis.bldg.actions.AddAssessmentInfo')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.AdjustUnitValue', 'adjust-uv', 'Adjust Unit Value', '2', 'adjust-uv', 'RPT', 'rptis.bldg.actions.AdjustUnitValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcAssessLevel', 'calc-assess-level', 'Calculate Assess Level', '85', 'calc-assess-level', 'RPT', 'rptis.bldg.actions.CalcAssessLevel')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcBldgAge', 'calc-bldg-age', 'Calculate Building Age', '1', 'calc-bldg-age', 'RPT', 'rptis.bldg.actions.CalcBldgAge')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcBldgEffectiveAge', 'calc-bldg-effectiveage', 'Calculate Building Effective Age', '2', 'calc-bldg-effectiveage', 'RPT', 'rptis.bldg.actions.CalcBldgEffectiveAge')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcBldgUseBMV', 'calc-bldguse-bmv', 'Calculate Actual Use Base Market Value', '20', 'calc-bldguse-bmv', 'RPT', 'rptis.bldg.actions.CalcBldgUseBMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcBldgUseDepreciation', 'calc-bldguse-depreciation', 'Calculate Depreciation', '60', 'calc-bldguse-depreciation', 'RPT', 'rptis.bldg.actions.CalcBldgUseDepreciation')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcBldgUseMV', 'calc-bldguse-mv', 'Calculate Actual Use Market Value', '24', 'calc-bldguse-mv', 'RPT', 'rptis.bldg.actions.CalcBldgUseMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcDepreciationByRange', 'calc-depreciation-range', 'Calculate Depreciation Rate by Range', '56', 'calc-depreciation-range', 'rpt', 'rptis.bldg.actions.CalcDepreciationByRange')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcDepreciationFromSked', 'calc-depreciation-sked', 'Calculate Depreciation Rate', '55', 'calc-depreciation-sked', 'rpt', 'rptis.bldg.actions.CalcDepreciationFromSked')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcFloorBMV', 'calc-floor-bmv', 'Calculate Floor Base Market Value', '10', 'calc-floor-bmv', 'RPT', 'rptis.bldg.actions.CalcFloorBMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.CalcFloorMV', 'calc-floor-mv', 'Calculate Floor Market Value', '15', 'calc-floor-mv', 'RPT', 'rptis.bldg.actions.CalcFloorMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.bldg.actions.ResetAdjustment', 'reset-adj', 'Reset Adjustment Value', '70', 'reset-adj', 'RPT', 'rptis.bldg.actions.ResetAdjustment')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.AddAssessmentInfo', 'add-assessment-info', 'Add Assessment Summary', '50', 'add-assessment-info', 'rpt', 'rptis.land.actions.AddAssessmentInfo')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.CalcAssessValue', 'calc-av', 'Calculate Assess Value', '20', 'calc-av', 'RPT', 'rptis.land.actions.CalcAssessValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.CalcBaseMarketValue', 'calc-bmv', 'Calculate Base Market Value', '1', 'calc-bmv', 'RPT', 'rptis.land.actions.CalcBaseMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.CalcMarketValue', 'calc-mv', 'Calculate Market Value', '5', 'calc-mv', 'RPT', 'rptis.land.actions.CalcMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.UpdateAdjustment', 'update-adj', 'Update Adjustment', '2', 'update-adj', 'RPT', 'rptis.land.actions.UpdateAdjustment')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.UpdateLandDetailActualUseAdj', 'update-landdetail-actualuse-adj', 'Update Appraisal Actual Use Adjustment', '3', 'update-landdetail-actualuse-adj', 'rpt', 'rptis.land.actions.UpdateLandDetailActualUseAdj')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.UpdateLandDetailAdjustment', 'update-landdetail-adj', 'Update Appraisal Adjustment', '3', 'update-landdetail-adj', 'rpt', 'rptis.land.actions.UpdateLandDetailAdjustment')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.land.actions.UpdateLandDetailValueAdjustment', 'update-landdetail-value-adj', 'Update Appraisal Value Adjustment', '3', 'update-landdetail-value-adj', 'rpt', 'rptis.land.actions.UpdateLandDetailValueAdjustment')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddBasic', 'add-basic', 'Add Basic Entry', '1', 'add-basic', 'landtax', 'rptis.landtax.actions.AddBasic')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddBillItem', 'add-billitem', 'Add Bill Item', '25', 'add-billitem', 'landtax', 'rptis.landtax.actions.AddBillItem')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddFireCode', 'add-firecode', 'Add Fire Code', '10', 'add-firecode', 'landtax', 'rptis.landtax.actions.AddFireCode')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddIdleLand', 'add-basicidle', 'Add Idle Land Entry', '6', 'add-basicidle', 'landtax', 'rptis.landtax.actions.AddIdleLand')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddSef', 'add-sef', 'Add SEF Entry', '5', 'add-sef', 'landtax', 'rptis.landtax.actions.AddSef')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddShare', 'add-share', 'Add Revenue Share', '28', 'add-share', 'landtax', 'rptis.landtax.actions.AddShare')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AddSocialHousing', 'add-sh', 'Add Social Housing Entry', '8', 'add-sh', 'landtax', 'rptis.landtax.actions.AddSocialHousing')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.AggregateLedgerItem', 'aggregate-bill-item', 'Aggregate Ledger Items', '12', 'aggregate-bill-item', 'landtax', 'rptis.landtax.actions.AggregateLedgerItem')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.CalcDiscount', 'calc-discount', 'Calculate Discount', '6', 'calc-discount', 'landtax', 'rptis.landtax.actions.CalcDiscount')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.CalcInterest', 'calc-interest', 'Calculate Interest', '5', 'calc-interest', 'landtax', 'rptis.landtax.actions.CalcInterest')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.CalcTax', 'calc-tax', 'Calculate Tax', '1001', 'calc-tax', 'landtax', 'rptis.landtax.actions.CalcTax')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.CreateTaxSummary', 'create-tax-summary', 'Create Tax Summary', '20', 'create-tax-summary', 'landtax', 'rptis.landtax.actions.CreateTaxSummary')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.RemoveLedgerItem', 'remove-bill-item', 'Remove Ledger Item', '11', 'remove-bill-item', 'landtax', 'rptis.landtax.actions.RemoveLedgerItem')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.SetBillExpiryDate', 'set-bill-expiry', 'Set Bill Expiry Date', '20', 'set-bill-expiry', 'landtax', 'rptis.landtax.actions.SetBillExpiryDate')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.SplitByQtr', 'split-by-qtr', 'Split By Quarter', '0', 'split-by-qtr', 'LANDTAX', 'rptis.landtax.actions.SplitByQtr')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.SplitLedgerItem', 'split-bill-item', 'Split Ledger Item', '10', 'split-bill-item', 'landtax', 'rptis.landtax.actions.SplitLedgerItem')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.landtax.actions.UpdateAV', 'update-av', 'Update AV', '1000', 'update-av', 'LANDTAX', 'rptis.landtax.actions.UpdateAV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.AddAssessmentInfo', 'add-assessment-info', 'Add Assessment Info', '1000', 'add-assessment-info', 'rpt', 'rptis.mach.actions.AddAssessmentInfo')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachineAssessLevel', 'calc-mach-al', 'Calculate Machine Assess Level', '5', 'calc-mach-al', 'RPT', 'rptis.mach.actions.CalcMachineAssessLevel')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachineAV', 'calc-mach-av', 'Calculate Machine Assessed Value', '6', 'calc-mach-av', 'RPT', 'rptis.mach.actions.CalcMachineAV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachineBMV', 'calc-mach-bmv', 'Calculate Base Market Value', '1', 'calc-mach-bmv', 'rpt', 'rptis.mach.actions.CalcMachineBMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachineDepreciation', 'calc-mach-depreciation', 'Calculate Depreciation', '2', 'calc-mach-depreciation', 'rpt', 'rptis.mach.actions.CalcMachineDepreciation')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachineMV', 'calc-mach-mv', 'Calculate Machine Market Value', '2', 'calc-mach-mv', 'RPT', 'rptis.mach.actions.CalcMachineMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachUseAssessLevel', 'calc-machuse-al', 'Calculate Actual Use Assess Level', '10', 'calc-machuse-al', 'RPT', 'rptis.mach.actions.CalcMachUseAssessLevel')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.mach.actions.CalcMachUseAV', 'calc-machuse-av', 'Calculate Actual Use Assessed Value', '11', 'calc-machuse-av', 'RPT', 'rptis.mach.actions.CalcMachUseAV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcAssessValue', 'calc-av', 'Calculate Assessed Value', '4', 'calc-av', 'RPT', 'rptis.misc.actions.CalcAssessValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcBaseMarketValue', 'calc-bmv', 'Calculate Base Market Value', '1', 'calc-bmv', 'RPT', 'rptis.misc.actions.CalcBaseMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcDepreciation', 'calc-depreciation', 'Calculate Depreciation', '1', 'calc-depreciation', 'RPT', 'rptis.misc.actions.CalcDepreciation')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcMarketValue', 'calc-mv', 'Calculate Market Value', '3', 'calc-mv', 'RPT', 'rptis.misc.actions.CalcMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcMiscRPUAssessLevel', 'calc-rpu-al', 'Calculate RPU Assess Level', '12', 'calc-rpu-al', 'RPT', 'rptis.misc.actions.CalcMiscRPUAssessLevel')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcMiscRPUAssessValue', 'calc-rpu-av', 'Calculate RPU Assessed Value', '13', 'calc-rpu-av', 'RPT', 'rptis.misc.actions.CalcMiscRPUAssessValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcMiscRPUBaseMarketValue', 'calc-rpu-bmv', 'Calculate RPU Base Market Value', '10', 'calc-rpu-bmv', 'RPT', 'rptis.misc.actions.CalcMiscRPUBaseMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.misc.actions.CalcMiscRPUMarketValue', 'calc-rpu-mv', 'Calculate RPU Market Value', '11', 'calc-rpu-mv', 'RPT', 'rptis.misc.actions.CalcMiscRPUMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.planttree.actions.AddPlantTreeAssessmentInfo', 'add-planttree-assessment-info', 'Add Assessment', '100', 'add-planttree-assessment-info', 'rpt', 'rptis.planttree.actions.AddPlantTreeAssessmentInfo')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.planttree.actions.CalcPlantTreeAdjustment', 'calc-planttree-adjustment', 'Calculate Adjustment', '2', 'calc-planttree-adjustment', 'RPT', 'rptis.planttree.actions.CalcPlantTreeAdjustment')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.planttree.actions.CalcPlantTreeAssessValue', 'calc-planttree-av', 'Calculate Assessed Value', '4', 'calc-planttree-av', 'RPT', 'rptis.planttree.actions.CalcPlantTreeAssessValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.planttree.actions.CalcPlantTreeBMV', 'calc-planttree-bmv', 'Calculate Base Market Value', '1', 'calc-planttree-bmv', 'RPT', 'rptis.planttree.actions.CalcPlantTreeBMV')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('rptis.planttree.actions.CalcPlantTreeMarketValue', 'calc-planttree-mv', 'Calculate Market Value', '3', 'calc-planttree-mv', 'RPT', 'rptis.planttree.actions.CalcPlantTreeMarketValue')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('RULADEF-2486b0ca:146fff66c3e:-723b', 'calc-adj', 'Calculate Adjustment', '35', 'calc-adj', 'RPT', 'rptis.bldg.actions.CalcAdjustment')
go
INSERT INTO sys_rule_actiondef ([objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]) VALUES ('RULADEF1441128c:1471efa4c1c:-69a5', 'calc-assess-value', 'Calculate Assess Value', '90', 'calc-assess-value', 'RPT', 'rptis.bldg.actions.CalcAssessValue')
go



INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('ACTPARAM-2486b0ca:146fff66c3e:-7204', 'RULADEF-2486b0ca:146fff66c3e:-723b', 'expr', '3', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('ACTPARAM-2486b0ca:146fff66c3e:-7224', 'RULADEF-2486b0ca:146fff66c3e:-723b', 'adjustment', '1', 'Adjustment', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgAdjustment', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('ACTPARAM102ab3e1:147190e9fe4:-f75', 'RULADEF-2486b0ca:146fff66c3e:-723b', 'var', '2', 'Derived Variable', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgVariable', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('ACTPARAM1441128c:1471efa4c1c:-6969', 'RULADEF1441128c:1471efa4c1c:-69a5', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('ACTPARAM1441128c:1471efa4c1c:-698e', 'RULADEF1441128c:1471efa4c1c:-69a5', 'assessment', '1', 'Assessment Info', NULL, 'var', NULL, NULL, NULL, 'rptis.facts.RPUAssessment', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('ACTPARAM49a3c540:14e51feb8f6:-4c86', 'RULADEF-2486b0ca:146fff66c3e:-723b', 'var', '2', 'Variable', NULL, 'var', NULL, NULL, NULL, 'rptis.facts.RPTVariable', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('AddRequirement.requirementtype', 'AddRequirement', 'requirementtype', '1', 'Requirement Type', NULL, 'lookup', 'rptrequirementtype:lookup', 'objid', 'name', NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVar.aggregatetype', 'rptis.actions.AddDeriveVar', 'aggregatetype', '3', 'Aggregation', NULL, 'lov', NULL, NULL, NULL, NULL, 'RPT_VAR_AGGRETATION_TYPES')
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVar.expr', 'rptis.actions.AddDeriveVar', 'expr', '4', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVar.refid', 'rptis.actions.AddDeriveVar', 'refid', '1', 'Reference ID', NULL, 'var', NULL, NULL, NULL, 'String', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVar.var', 'rptis.actions.AddDeriveVar', 'var', '2', 'Variable', NULL, 'lookup', 'rptparameter:lookup', 'objid', 'name', NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVariable.aggregatetype', 'rptis.actions.AddDeriveVariable', 'aggregatetype', '3', 'Aggregation', NULL, 'lov', NULL, NULL, NULL, NULL, 'RPT_VAR_AGGRETATION_TYPES')
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVariable.bldguse', 'rptis.actions.AddDeriveVariable', 'bldguse', '1', 'Building Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVariable.expr', 'rptis.actions.AddDeriveVariable', 'expr', '4', 'Value Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.AddDeriveVariable.var', 'rptis.actions.AddDeriveVariable', 'var', '2', 'Variable', NULL, 'lookup', 'rptparameter:lookup', 'objid', 'name', NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.CalcRPUAssessValue.expr', 'rptis.actions.CalcRPUAssessValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.CalcRPUAssessValue.rpuassessment', 'rptis.actions.CalcRPUAssessValue', 'rpuassessment', '1', 'Assessment', NULL, 'var', NULL, NULL, NULL, 'rptis.facts.RPUAssessment', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.CalcTotalRPUAssessValue.expr', 'rptis.actions.CalcTotalRPUAssessValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.actions.CalcTotalRPUAssessValue.rpu', 'rptis.actions.CalcTotalRPUAssessValue', 'rpu', '1', 'RPU', NULL, 'var', NULL, NULL, NULL, 'rptis.facts.RPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.AddAssessmentInfo.actualuseid', 'rptis.bldg.actions.AddAssessmentInfo', 'actualuseid', '2', 'Actual Use', NULL, 'var', NULL, NULL, NULL, 'string', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.AddAssessmentInfo.bldguse', 'rptis.bldg.actions.AddAssessmentInfo', 'bldguse', '1', 'Building Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.AdjustUnitValue.bldgstructure', 'rptis.bldg.actions.AdjustUnitValue', 'bldgstructure', '1', 'Building Structure', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgStructure', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.AdjustUnitValue.expr', 'rptis.bldg.actions.AdjustUnitValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcAssessLevel.assessment', 'rptis.bldg.actions.CalcAssessLevel', 'assessment', '1', 'Assessment', NULL, 'var', NULL, NULL, NULL, 'rptis.facts.RPUAssessment', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgAge.expr', 'rptis.bldg.actions.CalcBldgAge', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgAge.rpu', 'rptis.bldg.actions.CalcBldgAge', 'rpu', '1', 'Building Real Property', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgRPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgEffectiveAge.expr', 'rptis.bldg.actions.CalcBldgEffectiveAge', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgEffectiveAge.rpu', 'rptis.bldg.actions.CalcBldgEffectiveAge', 'rpu', '1', 'Building Real Property', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgRPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgUseBMV.bldguse', 'rptis.bldg.actions.CalcBldgUseBMV', 'bldguse', '1', 'Building Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgUseBMV.expr', 'rptis.bldg.actions.CalcBldgUseBMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgUseDepreciation.bldguse', 'rptis.bldg.actions.CalcBldgUseDepreciation', 'bldguse', '1', 'Building Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgUseDepreciation.expr', 'rptis.bldg.actions.CalcBldgUseDepreciation', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgUseMV.bldguse', 'rptis.bldg.actions.CalcBldgUseMV', 'bldguse', '1', 'Building Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcBldgUseMV.expr', 'rptis.bldg.actions.CalcBldgUseMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcDepreciationByRange.bldgstructure', 'rptis.bldg.actions.CalcDepreciationByRange', 'bldgstructure', '1', 'Building Structure', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgStructure', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcDepreciationFromSked.bldgstructure', 'rptis.bldg.actions.CalcDepreciationFromSked', 'bldgstructure', '1', 'Building Structure', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgStructure', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcFloorBMV.bldgfloor', 'rptis.bldg.actions.CalcFloorBMV', 'bldgfloor', '1', 'Building Floor', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgFloor', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcFloorBMV.expr', 'rptis.bldg.actions.CalcFloorBMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcFloorMV.bldgfloor', 'rptis.bldg.actions.CalcFloorMV', 'bldgfloor', '1', 'Building Floor', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgFloor', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.CalcFloorMV.expr', 'rptis.bldg.actions.CalcFloorMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.bldg.actions.ResetAdjustment.adjustment', 'rptis.bldg.actions.ResetAdjustment', 'adjustment', '1', 'Building Adjustment', NULL, 'var', NULL, NULL, NULL, 'rptis.bldg.facts.BldgAdjustment', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.AddAssessmentInfo.classification', 'rptis.land.actions.AddAssessmentInfo', 'classification', '2', 'Classification', NULL, 'var', NULL, NULL, NULL, 'rptis.facts.Classification', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.AddAssessmentInfo.landdetail', 'rptis.land.actions.AddAssessmentInfo', 'landdetail', '1', 'Land Item Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.CalcAssessValue.expr', 'rptis.land.actions.CalcAssessValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.CalcAssessValue.landdetail', 'rptis.land.actions.CalcAssessValue', 'landdetail', '1', 'Land Item Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.CalcBaseMarketValue.expr', 'rptis.land.actions.CalcBaseMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.CalcBaseMarketValue.landdetail', 'rptis.land.actions.CalcBaseMarketValue', 'landdetail', '1', 'Land Item Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.CalcMarketValue.expr', 'rptis.land.actions.CalcMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.CalcMarketValue.landdetail', 'rptis.land.actions.CalcMarketValue', 'landdetail', '1', 'Land Item Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateAdjustment.adjustment', 'rptis.land.actions.UpdateAdjustment', 'adjustment', '1', 'Adjustment', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandAdjustment', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateAdjustment.expr', 'rptis.land.actions.UpdateAdjustment', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateLandDetailActualUseAdj.expr', 'rptis.land.actions.UpdateLandDetailActualUseAdj', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateLandDetailActualUseAdj.landdetail', 'rptis.land.actions.UpdateLandDetailActualUseAdj', 'landdetail', '1', 'Land Item Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateLandDetailAdjustment.expr', 'rptis.land.actions.UpdateLandDetailAdjustment', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateLandDetailAdjustment.landdetail', 'rptis.land.actions.UpdateLandDetailAdjustment', 'landdetail', '1', 'Land Item Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateLandDetailValueAdjustment.expr', 'rptis.land.actions.UpdateLandDetailValueAdjustment', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.land.actions.UpdateLandDetailValueAdjustment.landdetail', 'rptis.land.actions.UpdateLandDetailValueAdjustment', 'landdetail', '1', 'Land Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.land.facts.LandDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddBasic.av', 'rptis.landtax.actions.AddBasic', 'av', '3', 'AV', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddBasic.avfact', 'rptis.landtax.actions.AddBasic', 'avfact', '1', 'AV Info', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.AssessedValue', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddBasic.year', 'rptis.landtax.actions.AddBasic', 'year', '2', 'Year', NULL, 'var', NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddBillItem.taxsummary', 'rptis.landtax.actions.AddBillItem', 'taxsummary', '1', 'Tax Summary', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerTaxSummaryFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddFireCode.av', 'rptis.landtax.actions.AddFireCode', 'av', '3', 'AV', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddFireCode.avfact', 'rptis.landtax.actions.AddFireCode', 'avfact', '1', 'AV Info', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.AssessedValue', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddFireCode.year', 'rptis.landtax.actions.AddFireCode', 'year', '2', 'Year', NULL, 'var', NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddIdleLand.av', 'rptis.landtax.actions.AddIdleLand', 'av', '3', 'AV', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddIdleLand.avfact', 'rptis.landtax.actions.AddIdleLand', 'avfact', '1', 'AV Info', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.AssessedValue', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddIdleLand.year', 'rptis.landtax.actions.AddIdleLand', 'year', '2', 'Year', NULL, 'var', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddSef.av', 'rptis.landtax.actions.AddSef', 'av', '3', 'AV', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddSef.avfact', 'rptis.landtax.actions.AddSef', 'avfact', '1', 'AV Info', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.AssessedValue', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddSef.year', 'rptis.landtax.actions.AddSef', 'year', '2', 'Year', NULL, 'var', NULL, NULL, NULL, 'integer', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddShare.amtdue', 'rptis.landtax.actions.AddShare', 'amtdue', '5', 'Amount Due', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddShare.billitem', 'rptis.landtax.actions.AddShare', 'billitem', '1', 'Bill Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTBillItem', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddShare.orgclass', 'rptis.landtax.actions.AddShare', 'orgclass', '2', 'Share Type', NULL, 'lov', NULL, NULL, NULL, NULL, 'RPT_BILLING_LGU_TYPES')
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddShare.orgid', 'rptis.landtax.actions.AddShare', 'orgid', '3', 'Org', NULL, 'var', 'org:lookup', 'objid', 'name', 'String', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddShare.payableparentacct', 'rptis.landtax.actions.AddShare', 'payableparentacct', '4', 'Payable Account', NULL, 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddShare.rate', 'rptis.landtax.actions.AddShare', 'rate', '6', 'Share (decimal)', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddSocialHousing.av', 'rptis.landtax.actions.AddSocialHousing', 'av', '3', 'AV', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddSocialHousing.avfact', 'rptis.landtax.actions.AddSocialHousing', 'avfact', '1', 'AV Info', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.AssessedValue', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AddSocialHousing.year', 'rptis.landtax.actions.AddSocialHousing', 'year', '2', 'Year', NULL, 'var', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.AggregateLedgerItem.rptledgeritem', 'rptis.landtax.actions.AggregateLedgerItem', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CalcDiscount.expr', 'rptis.landtax.actions.CalcDiscount', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CalcDiscount.rptledgeritem', 'rptis.landtax.actions.CalcDiscount', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CalcInterest.expr', 'rptis.landtax.actions.CalcInterest', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CalcInterest.rptledgeritem', 'rptis.landtax.actions.CalcInterest', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CalcTax.expr', 'rptis.landtax.actions.CalcTax', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CalcTax.rptledgeritem', 'rptis.landtax.actions.CalcTax', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CreateTaxSummary.revperiod', 'rptis.landtax.actions.CreateTaxSummary', 'revperiod', '2', 'Revenue Period', NULL, 'lov', NULL, NULL, NULL, NULL, 'RPT_REVENUE_PERIODS')
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CreateTaxSummary.rptledgeritem', 'rptis.landtax.actions.CreateTaxSummary', 'rptledgeritem', '1', 'RPT Ledger Item', '', 'var', '', '', '', 'rptis.landtax.facts.RPTLedgerItemFact', '')
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.CreateTaxSummary.var', 'rptis.landtax.actions.CreateTaxSummary', 'var', '3', 'Variable Name', NULL, 'lookup', 'rptparameter:lookup', 'name', 'name', NULL, '')
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.RemoveLedgerItem.rptledgeritem', 'rptis.landtax.actions.RemoveLedgerItem', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.SetBillExpiryDate.bill', 'rptis.landtax.actions.SetBillExpiryDate', 'bill', '1', 'Bill', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.Bill', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.SetBillExpiryDate.expr', 'rptis.landtax.actions.SetBillExpiryDate', 'expr', '2', 'Expiry Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.SplitByQtr.rptledgeritem', 'rptis.landtax.actions.SplitByQtr', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.SplitLedgerItem.rptledgeritem', 'rptis.landtax.actions.SplitLedgerItem', 'rptledgeritem', '1', 'Ledger Item', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.RPTLedgerItemFact', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.UpdateAV.avfact', 'rptis.landtax.actions.UpdateAV', 'avfact', '1', 'Assessed Value', NULL, 'var', NULL, NULL, NULL, 'rptis.landtax.facts.AssessedValue', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.landtax.actions.UpdateAV.expr', 'rptis.landtax.actions.UpdateAV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.AddAssessmentInfo.machuse', 'rptis.mach.actions.AddAssessmentInfo', 'machuse', '1', 'Machine Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineActualUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineAssessLevel.machine', 'rptis.mach.actions.CalcMachineAssessLevel', 'machine', '2', 'Machine', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineAssessLevel.machuse', 'rptis.mach.actions.CalcMachineAssessLevel', 'machuse', '1', 'Machine Use', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineActualUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineAV.expr', 'rptis.mach.actions.CalcMachineAV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineAV.machine', 'rptis.mach.actions.CalcMachineAV', 'machine', '1', 'Machinery', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineBMV.expr', 'rptis.mach.actions.CalcMachineBMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineBMV.machine', 'rptis.mach.actions.CalcMachineBMV', 'machine', '1', 'Machinery', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineDepreciation.expr', 'rptis.mach.actions.CalcMachineDepreciation', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineDepreciation.machine', 'rptis.mach.actions.CalcMachineDepreciation', 'machine', '1', 'Machinery', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineMV.expr', 'rptis.mach.actions.CalcMachineMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachineMV.machine', 'rptis.mach.actions.CalcMachineMV', 'machine', '1', 'Machinery', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachUseAssessLevel.machuse', 'rptis.mach.actions.CalcMachUseAssessLevel', 'machuse', '1', 'Machine Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineActualUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.mach.actions.CalcMachUseAV.machuse', 'rptis.mach.actions.CalcMachUseAV', 'machuse', '1', 'Machine Actual Use', NULL, 'var', NULL, NULL, NULL, 'rptis.mach.facts.MachineActualUse', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcAssessValue.expr', 'rptis.misc.actions.CalcAssessValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcAssessValue.miscitem', 'rptis.misc.actions.CalcAssessValue', 'miscitem', '1', 'Miscellaneous Item', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscItem', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcBaseMarketValue.expr', 'rptis.misc.actions.CalcBaseMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcBaseMarketValue.miscitem', 'rptis.misc.actions.CalcBaseMarketValue', 'miscitem', '1', 'Miscellaneous Item', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscItem', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcDepreciation.expr', 'rptis.misc.actions.CalcDepreciation', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcDepreciation.miscitem', 'rptis.misc.actions.CalcDepreciation', 'miscitem', '1', 'Miscellaneous Item', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscItem', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMarketValue.expr', 'rptis.misc.actions.CalcMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMarketValue.miscitem', 'rptis.misc.actions.CalcMarketValue', 'miscitem', '1', 'Miscelleneous Item', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscItem', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUAssessLevel.expr', 'rptis.misc.actions.CalcMiscRPUAssessLevel', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUAssessLevel.miscrpu', 'rptis.misc.actions.CalcMiscRPUAssessLevel', 'miscrpu', '1', 'Miscellaneous RPU', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscRPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUAssessValue.expr', 'rptis.misc.actions.CalcMiscRPUAssessValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUAssessValue.miscrpu', 'rptis.misc.actions.CalcMiscRPUAssessValue', 'miscrpu', '1', 'Miscellaneous RPU', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscRPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUBaseMarketValue.expr', 'rptis.misc.actions.CalcMiscRPUBaseMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUBaseMarketValue.miscrpu', 'rptis.misc.actions.CalcMiscRPUBaseMarketValue', 'miscrpu', '1', 'Miscellaneous RPU', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscRPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUMarketValue.expr', 'rptis.misc.actions.CalcMiscRPUMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.misc.actions.CalcMiscRPUMarketValue.miscrpu', 'rptis.misc.actions.CalcMiscRPUMarketValue', 'miscrpu', '1', 'Miscellaneous RPU', NULL, 'var', NULL, NULL, NULL, 'rptis.misc.facts.MiscRPU', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.AddPlantTreeAssessmentInfo.planttreedetail', 'rptis.planttree.actions.AddPlantTreeAssessmentInfo', 'planttreedetail', '1', 'Plant/Tree', NULL, 'var', NULL, NULL, NULL, 'rptis.planttree.facts.PlantTreeDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeAdjustment.expr', 'rptis.planttree.actions.CalcPlantTreeAdjustment', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeAdjustment.planttreedetail', 'rptis.planttree.actions.CalcPlantTreeAdjustment', 'planttreedetail', '1', 'Plant/Tree Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.planttree.facts.PlantTreeDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeAssessValue.expr', 'rptis.planttree.actions.CalcPlantTreeAssessValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeAssessValue.planttreedetail', 'rptis.planttree.actions.CalcPlantTreeAssessValue', 'planttreedetail', '1', 'Plant/Tree Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.planttree.facts.PlantTreeDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeBMV.expr', 'rptis.planttree.actions.CalcPlantTreeBMV', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeBMV.planttreedetail', 'rptis.planttree.actions.CalcPlantTreeBMV', 'planttreedetail', '1', 'Plant/Tree Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.planttree.facts.PlantTreeDetail', NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeMarketValue.expr', 'rptis.planttree.actions.CalcPlantTreeMarketValue', 'expr', '2', 'Computation', NULL, 'expression', NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_actiondef_param ([objid], [parentid], [name], [sortorder], [title], [datatype], [handler], [lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]) VALUES ('rptis.planttree.actions.CalcPlantTreeMarketValue.planttreedetail', 'rptis.planttree.actions.CalcPlantTreeMarketValue', 'planttreedetail', '1', 'Plant/Tree Appraisal', NULL, 'var', NULL, NULL, NULL, 'rptis.planttree.facts.PlantTreeDetail', NULL)
go



INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP-17442746:16be936f033:-7e80', 'RA-17442746:16be936f033:-7e82', 'rptis.landtax.actions.CalcTax.rptledgeritem', NULL, NULL, 'RC-17442746:16be936f033:-7e86', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP-17442746:16be936f033:-7e81', 'RA-17442746:16be936f033:-7e82', 'rptis.landtax.actions.CalcTax.expr', NULL, NULL, NULL, NULL, 'AV * 0.01', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP-5f8a4a63:17819c1a2a6:-7f13', 'RA-5f8a4a63:17819c1a2a6:-7f15', 'rptis.landtax.actions.CalcDiscount.rptledgeritem', NULL, NULL, 'RC-5f8a4a63:17819c1a2a6:-7f1c', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP-5f8a4a63:17819c1a2a6:-7f14', 'RA-5f8a4a63:17819c1a2a6:-7f15', 'rptis.landtax.actions.CalcDiscount.expr', NULL, NULL, NULL, NULL, '@ROUND(TAX * 0.10)', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP-5f8a4a63:17819c1a2a6:-7f54', 'RA-5f8a4a63:17819c1a2a6:-7f56', 'rptis.landtax.actions.CalcInterest.expr', NULL, NULL, NULL, NULL, '@ROUND(@IIF( NMON * 0.02 > 0.72, TAX * 0.72, TAX * NMON * 0.02))', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP-5f8a4a63:17819c1a2a6:-7f55', 'RA-5f8a4a63:17819c1a2a6:-7f56', 'rptis.landtax.actions.CalcInterest.rptledgeritem', NULL, NULL, 'RC-5f8a4a63:17819c1a2a6:-7f5b', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP16a7ee38:15cfcd300fe:-7fb3', 'RA16a7ee38:15cfcd300fe:-7fb7', 'rptis.actions.AddDeriveVar.refid', NULL, NULL, 'RCC16a7ee38:15cfcd300fe:-7fbb', 'RPUID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP16a7ee38:15cfcd300fe:-7fb4', 'RA16a7ee38:15cfcd300fe:-7fb7', 'rptis.actions.AddDeriveVar.var', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TOTAL_VALUE', 'TOTAL_VALUE', NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP16a7ee38:15cfcd300fe:-7fb5', 'RA16a7ee38:15cfcd300fe:-7fb7', 'rptis.actions.AddDeriveVar.aggregatetype', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sum', NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP16a7ee38:15cfcd300fe:-7fb6', 'RA16a7ee38:15cfcd300fe:-7fb7', 'rptis.actions.AddDeriveVar.expr', NULL, NULL, NULL, NULL, 'AV', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP440e47f4:166ae4152f1:-7fba', 'RA440e47f4:166ae4152f1:-7fbc', 'rptis.landtax.actions.CreateTaxSummary.rptledgeritem', NULL, NULL, 'RC440e47f4:166ae4152f1:-7fc0', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP440e47f4:166ae4152f1:-7fbb', 'RA440e47f4:166ae4152f1:-7fbc', 'rptis.landtax.actions.CreateTaxSummary.revperiod', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'previous', NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP5ffbf6c9:1781a117eda:-7cf1', 'RA5ffbf6c9:1781a117eda:-7cf3', 'rptis.landtax.actions.CalcTax.rptledgeritem', NULL, NULL, 'RC5ffbf6c9:1781a117eda:-7cf7', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP5ffbf6c9:1781a117eda:-7cf2', 'RA5ffbf6c9:1781a117eda:-7cf3', 'rptis.landtax.actions.CalcTax.expr', NULL, NULL, NULL, NULL, 'AV * 0.015', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fa9', 'RA7280357:166235c1be7:-7fab', 'rptis.landtax.actions.CreateTaxSummary.rptledgeritem', NULL, NULL, 'RC7280357:166235c1be7:-7faf', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7faa', 'RA7280357:166235c1be7:-7fab', 'rptis.landtax.actions.CreateTaxSummary.revperiod', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'advance', NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fb0', 'RA7280357:166235c1be7:-7fb2', 'rptis.landtax.actions.CreateTaxSummary.rptledgeritem', NULL, NULL, 'RC7280357:166235c1be7:-7fb6', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fb1', 'RA7280357:166235c1be7:-7fb2', 'rptis.landtax.actions.CreateTaxSummary.revperiod', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'current', NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fb7', 'RA7280357:166235c1be7:-7fb9', 'rptis.landtax.actions.SetBillExpiryDate.bill', NULL, NULL, 'RC7280357:166235c1be7:-7fc0', 'BILL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fb8', 'RA7280357:166235c1be7:-7fb9', 'rptis.landtax.actions.SetBillExpiryDate.expr', NULL, NULL, NULL, NULL, '@MONTHEND(@DATE(CY, 12, 1));', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fca', 'RA7280357:166235c1be7:-7fcc', 'rptis.landtax.actions.CalcDiscount.rptledgeritem', NULL, NULL, 'RC7280357:166235c1be7:-7fd4', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RAP7280357:166235c1be7:-7fcb', 'RA7280357:166235c1be7:-7fcc', 'rptis.landtax.actions.CalcDiscount.expr', NULL, NULL, NULL, NULL, '@ROUND(TAX * 0.20)', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-103fed47:146ffb40356:-7c4f', 'RACT-103fed47:146ffb40356:-7c51', 'ACTPARAM3e2b89cb:146ff734573:-7c34', NULL, NULL, NULL, NULL, 'YRAPPRAISED - YRCOMPLETED', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-103fed47:146ffb40356:-7c50', 'RACT-103fed47:146ffb40356:-7c51', 'ACTPARAM3e2b89cb:146ff734573:-7c3c', NULL, NULL, 'RCOND-103fed47:146ffb40356:-7d40', 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-128a4cad:146f96a678e:-7d4b', 'RACT-128a4cad:146f96a678e:-7d4d', 'ACTPARAM-128a4cad:146f96a678e:-7ee7', NULL, NULL, NULL, NULL, '@ROUNDTOTEN( MV * AL / 100.0 )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-128a4cad:146f96a678e:-7d4c', 'RACT-128a4cad:146f96a678e:-7d4d', 'ACTPARAM-128a4cad:146f96a678e:-7ef0', NULL, NULL, 'RCOND-128a4cad:146f96a678e:-7e14', 'LA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-1a2d6e9b:1692d429304:-7607', 'RACT-1a2d6e9b:1692d429304:-7649', 'rptis.landtax.actions.AddSef.av', NULL, NULL, NULL, NULL, 'AV', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-1a2d6e9b:1692d429304:-7622', 'RACT-1a2d6e9b:1692d429304:-7649', 'rptis.landtax.actions.AddSef.year', NULL, NULL, 'RCONST-1a2d6e9b:1692d429304:-7747', 'YR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-1a2d6e9b:1692d429304:-7639', 'RACT-1a2d6e9b:1692d429304:-7649', 'rptis.landtax.actions.AddSef.avfact', NULL, NULL, 'RCOND-1a2d6e9b:1692d429304:-7748', 'AVINFO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-1a2d6e9b:1692d429304:-76bc', 'RACT-1a2d6e9b:1692d429304:-7700', 'rptis.landtax.actions.AddBasic.av', NULL, NULL, NULL, NULL, 'AV', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-1a2d6e9b:1692d429304:-76d7', 'RACT-1a2d6e9b:1692d429304:-7700', 'rptis.landtax.actions.AddBasic.year', NULL, NULL, 'RCONST-1a2d6e9b:1692d429304:-7747', 'YR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-1a2d6e9b:1692d429304:-76ef', 'RACT-1a2d6e9b:1692d429304:-7700', 'rptis.landtax.actions.AddBasic.avfact', NULL, NULL, 'RCOND-1a2d6e9b:1692d429304:-7748', 'AVINFO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-230de61f:15fbcfe4002:1a6e', 'RACT-230de61f:15fbcfe4002:1a6d', 'rptis.bldg.actions.CalcDepreciationByRange.bldgstructure', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-445d', 'BS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-2adc', 'RACT-2486b0ca:146fff66c3e:-2ade', 'ACTPARAM-2486b0ca:146fff66c3e:-30fe', NULL, NULL, NULL, NULL, '@ROUND( BMV + ADJ - DEP  )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-2add', 'RACT-2486b0ca:146fff66c3e:-2ade', 'ACTPARAM-2486b0ca:146fff66c3e:-3105', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-37a0', 'RACT-2486b0ca:146fff66c3e:-37a2', 'ACTPARAM-2486b0ca:146fff66c3e:-7994', NULL, NULL, NULL, NULL, '@ROUND( BMV + ADJ )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-37a1', 'RACT-2486b0ca:146fff66c3e:-37a2', 'ACTPARAM-2486b0ca:146fff66c3e:-799f', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-3888', 'BF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-3d30', 'RACT-2486b0ca:146fff66c3e:-3d32', 'ACTPARAM-2486b0ca:146fff66c3e:-4090', NULL, NULL, NULL, NULL, '@ROUND( (BMV )  * DPRATE / 100.0, 0)', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-3d31', 'RACT-2486b0ca:146fff66c3e:-3d32', 'ACTPARAM-2486b0ca:146fff66c3e:-4351', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-6a10', 'RACT-2486b0ca:146fff66c3e:-6a12', 'ACTPARAM-2486b0ca:146fff66c3e:-79dc', NULL, NULL, NULL, NULL, 'AREA * UV', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2486b0ca:146fff66c3e:-6a11', 'RACT-2486b0ca:146fff66c3e:-6a12', 'ACTPARAM-2486b0ca:146fff66c3e:-79e3', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-6aad', 'BF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-28dc975:156bcab666c:-5e3a', 'RACT-28dc975:156bcab666c:-5e3c', 'rptis.actions.CalcTotalRPUAssessValue.expr', NULL, NULL, NULL, NULL, '@ROUNDTOTEN( AV  )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-28dc975:156bcab666c:-5e3b', 'RACT-28dc975:156bcab666c:-5e3c', 'rptis.actions.CalcTotalRPUAssessValue.rpu', NULL, NULL, 'RCOND-28dc975:156bcab666c:-6051', 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2ede6703:16642adb9ce:-7926', 'RACT-2ede6703:16642adb9ce:-794c', 'rptis.landtax.actions.SetBillExpiryDate.expr', NULL, NULL, NULL, NULL, '@MONTHEND( BILLDATE )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-2ede6703:16642adb9ce:-793c', 'RACT-2ede6703:16642adb9ce:-794c', 'rptis.landtax.actions.SetBillExpiryDate.bill', NULL, NULL, 'RCOND-2ede6703:16642adb9ce:-7a39', 'BILL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-37dab195:17819c202a5:-712b', 'RACT-37dab195:17819c202a5:-7151', 'rptis.landtax.actions.CalcTax.expr', NULL, NULL, NULL, NULL, '( AV * 0.01 ) / 2', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-37dab195:17819c202a5:-7141', 'RACT-37dab195:17819c202a5:-7151', 'rptis.landtax.actions.CalcTax.rptledgeritem', NULL, NULL, 'RCOND-37dab195:17819c202a5:-76c5', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-37dab195:17819c202a5:-77ae', 'RACT-37dab195:17819c202a5:-77d4', 'rptis.landtax.actions.CalcTax.expr', NULL, NULL, NULL, NULL, 'AV * 0.008', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-37dab195:17819c202a5:-77c4', 'RACT-37dab195:17819c202a5:-77d4', 'rptis.landtax.actions.CalcTax.rptledgeritem', NULL, NULL, 'RCOND-37dab195:17819c202a5:-7a01', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-60c99d04:1470b276e7f:-7a50', 'RACT-60c99d04:1470b276e7f:-7a52', 'ACTPARAM-60c99d04:1470b276e7f:-7c0e', NULL, NULL, NULL, NULL, '@ROUND( BUAREA * BASEVALUE  )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-60c99d04:1470b276e7f:-7a51', 'RACT-60c99d04:1470b276e7f:-7a52', 'ACTPARAM-60c99d04:1470b276e7f:-7c15', NULL, NULL, 'RCOND-60c99d04:1470b276e7f:-7dd3', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-79a9a347:15cfcae84de:-5e18', 'RACT-79a9a347:15cfcae84de:-5e1c', 'rptis.actions.AddDeriveVar.expr', NULL, NULL, NULL, NULL, 'AV', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-79a9a347:15cfcae84de:-5e19', 'RACT-79a9a347:15cfcae84de:-5e1c', 'rptis.actions.AddDeriveVar.aggregatetype', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sum', NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-79a9a347:15cfcae84de:-5e1a', 'RACT-79a9a347:15cfcae84de:-5e1c', 'rptis.actions.AddDeriveVar.var', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TOTAL_VALUE', 'TOTAL_VALUE', NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-79a9a347:15cfcae84de:-5e1b', 'RACT-79a9a347:15cfcae84de:-5e1c', 'rptis.actions.AddDeriveVar.refid', NULL, NULL, 'RCONST-79a9a347:15cfcae84de:-61bf', 'RPUID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-79a9a347:15cfcae84de:-6d84', 'RACT-79a9a347:15cfcae84de:-6d86', 'rptis.actions.CalcTotalRPUAssessValue.expr', NULL, NULL, NULL, NULL, '@ROUNDTOTEN(AV );', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT-79a9a347:15cfcae84de:-6d85', 'RACT-79a9a347:15cfcae84de:-6d86', 'rptis.actions.CalcTotalRPUAssessValue.rpu', NULL, NULL, 'RCOND-79a9a347:15cfcae84de:-6ebc', 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT1441128c:1471efa4c1c:-68bb', 'RACT1441128c:1471efa4c1c:-68bd', 'ACTPARAM1441128c:1471efa4c1c:-6969', NULL, NULL, NULL, NULL, '@ROUNDTOTEN(  MV * AL  / 100.0 )', 'expression', NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT1441128c:1471efa4c1c:-68bc', 'RACT1441128c:1471efa4c1c:-68bd', 'ACTPARAM1441128c:1471efa4c1c:-698e', NULL, NULL, 'RCOND1441128c:1471efa4c1c:-6add', 'BA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0')
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT1441128c:1471efa4c1c:-6b96', 'RACT1441128c:1471efa4c1c:-6b97', 'ACTPARAM-39192c48:1471ebc2797:-7da1', NULL, NULL, 'RCOND1441128c:1471efa4c1c:-6c2f', 'BA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT1441128c:1471efa4c1c:-6ce5', 'RACT1441128c:1471efa4c1c:-6ce7', 'ACTPARAM-39192c48:1471ebc2797:-7dd8', NULL, NULL, 'RCONST1441128c:1471efa4c1c:-6d47', 'ACTUALUSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT1441128c:1471efa4c1c:-6ce6', 'RACT1441128c:1471efa4c1c:-6ce7', 'ACTPARAM-39192c48:1471ebc2797:-7de1', NULL, NULL, 'RCOND1441128c:1471efa4c1c:-6d84', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT5b4ac915:147baaa06b4:-6be7', 'RACT5b4ac915:147baaa06b4:-6be9', 'rptis.land.actions.AddAssessmentInfo.classification', NULL, NULL, 'RCONST5b4ac915:147baaa06b4:-6d59', 'CLASS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT5b4ac915:147baaa06b4:-6be8', 'RACT5b4ac915:147baaa06b4:-6be9', 'rptis.land.actions.AddAssessmentInfo.landdetail', NULL, NULL, 'RCOND5b4ac915:147baaa06b4:-6da4', 'LA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT5ffbdc02:166e7b2c367:-6203', 'RACT5ffbdc02:166e7b2c367:-6229', 'rptis.landtax.actions.CalcInterest.expr', NULL, NULL, NULL, NULL, 'TAX * NMON * 0.02', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT5ffbdc02:166e7b2c367:-6219', 'RACT5ffbdc02:166e7b2c367:-6229', 'rptis.landtax.actions.CalcInterest.rptledgeritem', NULL, NULL, 'RC70978a15:166ae6875d1:-7f22', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6bb2', 'RACT7afd4d64:17816d5ee78:-6bbe', 'rptis.bldg.actions.CalcAssessLevel.assessment', NULL, NULL, 'RCOND1441128c:1471efa4c1c:-6c2f', 'BA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6cf3', 'RACT7afd4d64:17816d5ee78:-6d19', 'rptis.bldg.actions.AddAssessmentInfo.actualuseid', NULL, NULL, 'RCONST1441128c:1471efa4c1c:-6d47', 'ACTUALUSE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6d09', 'RACT7afd4d64:17816d5ee78:-6d19', 'rptis.bldg.actions.AddAssessmentInfo.bldguse', NULL, NULL, 'RCOND1441128c:1471efa4c1c:-6d84', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6e8e', 'RACT7afd4d64:17816d5ee78:-6eb4', 'rptis.bldg.actions.CalcBldgUseMV.expr', NULL, NULL, NULL, NULL, '@ROUND( BMV + ADJ - DEP )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6ea4', 'RACT7afd4d64:17816d5ee78:-6eb4', 'rptis.bldg.actions.CalcBldgUseMV.bldguse', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-2bf1', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6fa6', 'RACT7afd4d64:17816d5ee78:-6fcc', 'rptis.bldg.actions.CalcFloorMV.expr', NULL, NULL, NULL, NULL, '@ROUND( BMV + ADJ )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-6fbc', 'RACT7afd4d64:17816d5ee78:-6fcc', 'rptis.bldg.actions.CalcFloorMV.bldgfloor', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-3888', 'BF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-7116', 'RACT7afd4d64:17816d5ee78:-713c', 'rptis.bldg.actions.CalcBldgUseDepreciation.expr', NULL, NULL, NULL, NULL, '@ROUND(  ( BMV + ADJUSTMENT ) * DPRATE / 100.0 )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-712c', 'RACT7afd4d64:17816d5ee78:-713c', 'rptis.bldg.actions.CalcBldgUseDepreciation.bldguse', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-3ed1', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-7395', 'RACT7afd4d64:17816d5ee78:-73bb', 'rptis.bldg.actions.CalcBldgUseBMV.expr', NULL, NULL, NULL, NULL, '@ROUND(  TOTAL_FLOOR_AREA * BASEVALUE )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-73ab', 'RACT7afd4d64:17816d5ee78:-73bb', 'rptis.bldg.actions.CalcBldgUseBMV.bldguse', NULL, NULL, 'RCOND-60c99d04:1470b276e7f:-7dd3', 'BU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-753e', 'RACT7afd4d64:17816d5ee78:-7564', 'rptis.bldg.actions.CalcFloorBMV.expr', NULL, NULL, NULL, NULL, 'AREA * UV', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-7554', 'RACT7afd4d64:17816d5ee78:-7564', 'rptis.bldg.actions.CalcFloorBMV.bldgfloor', NULL, NULL, 'RCOND-2486b0ca:146fff66c3e:-6aad', 'BF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-770e', 'RACT7afd4d64:17816d5ee78:-7734', 'rptis.bldg.actions.CalcBldgAge.expr', NULL, NULL, NULL, NULL, 'YRAPPRAISED - YRCOMPLETED', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-7724', 'RACT7afd4d64:17816d5ee78:-7734', 'rptis.bldg.actions.CalcBldgAge.rpu', NULL, NULL, 'RCOND-103fed47:146ffb40356:-7d40', 'RPU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-79a2', 'RACT7afd4d64:17816d5ee78:-79c8', 'rptis.land.actions.CalcAssessValue.expr', NULL, NULL, NULL, NULL, '0', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-79b8', 'RACT7afd4d64:17816d5ee78:-79c8', 'rptis.land.actions.CalcAssessValue.landdetail', NULL, NULL, 'RCOND7afd4d64:17816d5ee78:-7a8e', 'LA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-7c37', 'RACT7afd4d64:17816d5ee78:-7c5d', 'rptis.land.actions.CalcAssessValue.expr', NULL, NULL, NULL, NULL, '@ROUNDTOTEN( MV * AL / 100.0  )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACT7afd4d64:17816d5ee78:-7c4d', 'RACT7afd4d64:17816d5ee78:-7c5d', 'rptis.land.actions.CalcAssessValue.landdetail', NULL, NULL, 'RCOND-128a4cad:146f96a678e:-7e14', 'LA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACTec9d7ab:166235c2e16:-248e', 'RACTec9d7ab:166235c2e16:-249a', 'rptis.landtax.actions.AddBillItem.taxsummary', NULL, NULL, 'RCONDec9d7ab:166235c2e16:-24fc', 'RLTS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACTec9d7ab:166235c2e16:-2e08', 'RACTec9d7ab:166235c2e16:-2e2e', 'rptis.landtax.actions.SetBillExpiryDate.expr', NULL, NULL, NULL, NULL, '@MONTHEND( CDATE )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACTec9d7ab:166235c2e16:-2e1e', 'RACTec9d7ab:166235c2e16:-2e2e', 'rptis.landtax.actions.SetBillExpiryDate.bill', NULL, NULL, 'RCONDec9d7ab:166235c2e16:-2ec7', 'BILL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACTec9d7ab:166235c2e16:-35a7', 'RACTec9d7ab:166235c2e16:-35b3', 'rptis.landtax.actions.SplitLedgerItem.rptledgeritem', NULL, NULL, 'RC7280357:166235c1be7:-7fc7', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACTec9d7ab:166235c2e16:-386d', 'RACTec9d7ab:166235c2e16:-3879', 'rptis.landtax.actions.AggregateLedgerItem.rptledgeritem', NULL, NULL, 'RCONDec9d7ab:166235c2e16:-3b0b', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go
INSERT INTO sys_rule_action_param ([objid], [parentid], [actiondefparam_objid], [stringvalue], [booleanvalue], [var_objid], [var_name], [expr], [exprtype], [pos], [obj_key], [obj_value], [listvalue], [lov], [rangeoption]) VALUES ('RULACTec9d7ab:166235c2e16:-5b63', 'RACTec9d7ab:166235c2e16:-5b6f', 'rptis.landtax.actions.SplitByQtr.rptledgeritem', NULL, NULL, 'RCONDec9d7ab:166235c2e16:-5e7c', 'RLI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go





update rptledger set lguid = (select objid from sys_org where root = 1)
go


update itemaccount set 
    org_objid = '189-01-0010',
    org_name = 'GATBO',
    parentid = 'RPT_BASIC_PREVIOUS_BRGY_SHARE'
where objid = 'ITMACCT-533fcd11:15bfaab02eb:-5b4e'
go


update itemaccount set 
    org_objid = '189-01-0009',
    org_name = 'DEL ROSARIO',
    parentid = 'RPT_BASIC_PREVIOUS_BRGY_SHARE'
where objid = 'ITMACCT-533fcd11:15bfaab02eb:-5d7d'
go


update itemaccount set 
    org_objid = '189-03-0018',
    org_name = 'SALVACION WEST',
    parentid = 'RPT_BASICINT_PREVIOUS_BRGY_SHARE'
where objid = 'ITMACCT35079393:15c09b722f6:-6bd5'
go

update itemaccount set 
    org_objid = '189-03-0019',
    org_name = 'SAN ISIDRO WEST',
    parentid = 'RPT_BASICINT_CURRENT_BRGY_SHARE'
where objid = 'ITMACCT35079393:15c09b722f6:-61e9'
go

