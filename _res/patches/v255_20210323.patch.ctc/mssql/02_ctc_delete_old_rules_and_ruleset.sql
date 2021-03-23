delete from sys_rule_action_param where parentid in ( 
	select distinct ra.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
		inner join sys_rule_action ra on ra.parentid = r.objid 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_action where parentid in ( 
	select distinct r.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_condition_constraint where parentid in ( 
	select rc.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
		inner join sys_rule_condition rc on rc.parentid = r.objid 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_condition_var where parentid in ( 
	select rc.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
		inner join sys_rule_condition rc on rc.parentid = r.objid 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_condition where parentid in ( 
	select r.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_deployed where objid in (
	select objid from sys_rule where ruleset in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule where ruleset in ('ctcindividual','ctccorporate')
;


if object_id('dbo.ztmp_ctc_actiondef', 'U') IS NOT NULL 
	drop table dbo.ztmp_ctc_actiondef; 
go 
if object_id('dbo.ztmp_ctc_fact', 'U') IS NOT NULL 
	drop table dbo.ztmp_ctc_fact; 
go 

select * 
into ztmp_ctc_actiondef 
from sys_rule_actiondef 
where 
	objid in ( 
		select distinct rsa.actiondef  
		from sys_ruleset rs 
			inner join sys_ruleset_actiondef rsa on rsa.ruleset = rs.name 
		where rs.name in ('ctcindividual','ctccorporate')
	)
	and [domain] = 'CTC' 
go 
select * 
into ztmp_ctc_fact 
from sys_rule_fact 
where 
	objid in ( 
		select distinct rsf.rulefact 
		from sys_ruleset rs 
			inner join sys_ruleset_fact rsf on rsf.ruleset = rs.name 
		where rs.name in ('ctcindividual','ctccorporate')
	)
	and [domain] = 'CTC' 
go 

delete from sys_rule_actiondef_param where parentid in ( 
	select objid from ztmp_ctc_actiondef 
)
;
delete from sys_rule_actiondef where objid in ( 
	select objid from ztmp_ctc_actiondef 
)
;
delete from sys_rule_fact_field where parentid in ( 
	select objid from ztmp_ctc_fact 
)
;
delete from sys_rule_fact where objid in ( 
	select objid from ztmp_ctc_fact 
)
;

if object_id('dbo.ztmp_ctc_actiondef', 'U') IS NOT NULL 
	drop table dbo.ztmp_ctc_actiondef; 
go 
if object_id('dbo.ztmp_ctc_fact', 'U') IS NOT NULL 
	drop table dbo.ztmp_ctc_fact; 
go 

delete from sys_ruleset_fact where ruleset in (
	select rs.name from sys_ruleset rs 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_ruleset_actiondef where ruleset in (
	select rs.name from sys_ruleset rs 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rulegroup where ruleset in ('ctcindividual','ctccorporate')
;
delete from sys_ruleset where name in ('ctcindividual','ctccorporate')
;
