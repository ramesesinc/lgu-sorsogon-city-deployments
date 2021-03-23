CREATE TABLE [dbo].[ztmp_sys_ruleset] (
[name] varchar(50) NOT NULL ,
[title] varchar(160) NULL ,
[packagename] varchar(50) NULL ,
[domain] varchar(50) NULL ,
[role] varchar(50) NULL ,
[permission] varchar(50) NULL 
)
GO

CREATE TABLE [dbo].[ztmp_sys_rulegroup] (
[name] varchar(50) NOT NULL ,
[ruleset] varchar(50) NOT NULL ,
[title] varchar(160) NULL ,
[sortorder] int NULL DEFAULT ('0') 
)
go 

CREATE TABLE [dbo].[ztmp_sys_rule_fact] (
[objid] varchar(50) NOT NULL ,
[name] varchar(50) NOT NULL DEFAULT '' ,
[title] varchar(160) NULL ,
[factclass] varchar(50) NULL ,
[sortorder] int NULL ,
[handler] varchar(50) NULL ,
[defaultvarname] varchar(25) NULL ,
[dynamic] int NULL ,
[lookuphandler] varchar(50) NULL ,
[lookupkey] varchar(50) NULL ,
[lookupvalue] varchar(50) NULL ,
[lookupdatatype] varchar(50) NULL ,
[dynamicfieldname] varchar(50) NULL ,
[builtinconstraints] varchar(50) NULL ,
[domain] varchar(50) NULL 
)
go 

CREATE TABLE [dbo].[ztmp_sys_rule_fact_field] (
[objid] varchar(255) NOT NULL ,
[parentid] varchar(50) NULL ,
[name] varchar(50) NOT NULL DEFAULT '' ,
[title] varchar(160) NULL ,
[datatype] varchar(50) NULL ,
[sortorder] int NULL ,
[handler] varchar(50) NULL ,
[lookuphandler] varchar(50) NULL ,
[lookupkey] varchar(50) NULL ,
[lookupvalue] varchar(50) NULL ,
[lookupdatatype] varchar(50) NULL ,
[multivalued] int NULL ,
[required] int NULL ,
[vardatatype] varchar(50) NULL ,
[lovname] varchar(50) NULL 
)
go

CREATE TABLE [dbo].[ztmp_sys_rule_actiondef] (
[objid] varchar(50) NOT NULL DEFAULT '' ,
[name] varchar(50) NOT NULL DEFAULT '' ,
[title] varchar(250) NULL ,
[sortorder] int NULL ,
[actionname] varchar(50) NULL ,
[domain] varchar(50) NULL ,
[actionclass] varchar(255) NULL 
)
go 

CREATE TABLE [dbo].[ztmp_sys_rule_actiondef_param] (
[objid] varchar(255) NOT NULL ,
[parentid] varchar(50) NULL ,
[name] varchar(50) NOT NULL DEFAULT '' ,
[sortorder] int NULL ,
[title] varchar(50) NULL ,
[datatype] varchar(50) NULL ,
[handler] varchar(50) NULL ,
[lookuphandler] varchar(50) NULL ,
[lookupkey] varchar(50) NULL ,
[lookupvalue] varchar(50) NULL ,
[vardatatype] varchar(50) NULL ,
[lovname] varchar(50) NULL 
)
go

CREATE TABLE [dbo].[ztmp_sys_ruleset_fact] (
[ruleset] varchar(50) NOT NULL ,
[rulefact] varchar(50) NOT NULL 
)
go 

CREATE TABLE [dbo].[ztmp_sys_ruleset_actiondef] (
[ruleset] varchar(50) NOT NULL ,
[actiondef] varchar(50) NOT NULL 
)
go 


alter table sys_rule_fact add factsuperclass varchar(255) null; 
alter table ztmp_sys_rule_fact add factsuperclass varchar(255) null;


INSERT INTO ztmp_sys_ruleset (name, title, packagename, domain, role, permission) VALUES ('ctcbilling', 'Community Tax Billing', 'ctc', 'CTC', 'RULE_AUTHOR', NULL);

INSERT INTO ztmp_sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-bill', 'ctcbilling', 'Compute Bill', '1');
INSERT INTO ztmp_sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-discount', 'ctcbilling', 'Compute Discount', '3');
INSERT INTO ztmp_sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-interest', 'ctcbilling', 'Compute Interest', '5');
INSERT INTO ztmp_sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-surcharge', 'ctcbilling', 'Compute Surcharge', '4');
INSERT INTO ztmp_sys_rulegroup (name, ruleset, title, sortorder) VALUES ('post-compute-bill', 'ctcbilling', 'Post Compute Bill', '2');
INSERT INTO ztmp_sys_rulegroup (name, ruleset, title, sortorder) VALUES ('summary', 'ctcbilling', 'Summary', '6');

INSERT INTO ztmp_sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('com.rameses.rules.common.CurrentDate', 'com.rameses.rules.common.CurrentDate', 'Current Date', 'com.rameses.rules.common.CurrentDate', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SYSTEM', NULL);
INSERT INTO ztmp_sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', 'Corporate CTC', 'ctc.facts.CorporateCTC', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CTC', NULL);
INSERT INTO ztmp_sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'Individual CTC', 'ctc.facts.IndividualCTC', '1', NULL, 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CTC', NULL);
INSERT INTO ztmp_sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('enterprise.facts.DateInfo', 'enterprise.facts.DateInfo', 'Date Info', 'enterprise.facts.DateInfo', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ENTERPRISE', 'enterprise.facts.VariableInfo');
INSERT INTO ztmp_sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('treasury.facts.BillItem', 'treasury.facts.BillItem', 'Bill Item', 'treasury.facts.BillItem', '1', NULL, 'BILLITEM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TREASURY', 'treasury.facts.AbstractBillItem');
INSERT INTO ztmp_sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('treasury.facts.DueDate', 'treasury.facts.DueDate', 'Due Date', 'treasury.facts.DueDate', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TREASURY', NULL);

INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.date', 'com.rameses.rules.common.CurrentDate', 'date', 'Date', 'date', '4', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.day', 'com.rameses.rules.common.CurrentDate', 'day', 'Day', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.month', 'com.rameses.rules.common.CurrentDate', 'month', 'Month', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.qtr', 'com.rameses.rules.common.CurrentDate', 'qtr', 'Qtr', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.year', 'com.rameses.rules.common.CurrentDate', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.additional', 'ctc.facts.CorporateCTC', 'additional', 'Is Additional?', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.additionaltax', 'ctc.facts.CorporateCTC', 'additionaltax', 'Additional Tax', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.basictax', 'ctc.facts.CorporateCTC', 'basictax', 'Basic Tax', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.businessgross', 'ctc.facts.CorporateCTC', 'businessgross', 'Business Gross', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.businessgrosstax', 'ctc.facts.CorporateCTC', 'businessgrosstax', 'Business Gross Tax', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.interest', 'ctc.facts.CorporateCTC', 'interest', 'Interest', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.newbusiness', 'ctc.facts.CorporateCTC', 'newbusiness', 'Is New Business?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, '0', 'boolean', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.orgtype', 'ctc.facts.CorporateCTC', 'orgtype', 'Organization Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'BUSINESS_ORG_TYPE');
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.propertyavtax', 'ctc.facts.CorporateCTC', 'propertyavtax', 'Property AV Tax', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.realpropertyav', 'ctc.facts.CorporateCTC', 'realpropertyav', 'Real Property AV', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.totaltax', 'ctc.facts.CorporateCTC', 'totaltax', 'Total Tax', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.additional', 'ctc.facts.IndividualCTC', 'additional', 'Is Additional?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.additionaltax', 'ctc.facts.IndividualCTC', 'additionaltax', 'Additional Tax', 'decimal', '16', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.age', 'ctc.facts.IndividualCTC', 'age', 'Age', 'integer', '19', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.annualsalary', 'ctc.facts.IndividualCTC', 'annualsalary', 'Annual Salary', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.barangayid', 'ctc.facts.IndividualCTC', 'barangayid', 'Barangay', 'string', '10', 'lookup', 'barangay:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.basictax', 'ctc.facts.IndividualCTC', 'basictax', 'Basic Tax', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.businessgross', 'ctc.facts.IndividualCTC', 'businessgross', 'Business Gross', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.businessgrosstax', 'ctc.facts.IndividualCTC', 'businessgrosstax', 'Business Gross Tax', 'decimal', '14', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.citizenship', 'ctc.facts.IndividualCTC', 'citizenship', 'Citizenship', 'string', '2', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'CITIZENSHIP');
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.civilstatus', 'ctc.facts.IndividualCTC', 'civilstatus', 'Civil Status', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'CIVIL_STATUS');
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.gender', 'ctc.facts.IndividualCTC', 'gender', 'Gender', 'string', '3', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'GENDER');
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.interest', 'ctc.facts.IndividualCTC', 'interest', 'Interest', 'decimal', '18', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.newbusiness', 'ctc.facts.IndividualCTC', 'newbusiness', 'Is New Business?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, '0', 'boolean', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.profession', 'ctc.facts.IndividualCTC', 'profession', 'Profession', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.propertyincome', 'ctc.facts.IndividualCTC', 'propertyincome', 'Property Income', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.propertyincometax', 'ctc.facts.IndividualCTC', 'propertyincometax', 'Property Income Tax', 'decimal', '15', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.salarytax', 'ctc.facts.IndividualCTC', 'salarytax', 'Salary Tax', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.seniorcitizen', 'ctc.facts.IndividualCTC', 'seniorcitizen', 'Is Senior Citizen?', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, '0', 'boolean', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.totaltax', 'ctc.facts.IndividualCTC', 'totaltax', 'Total Tax', 'decimal', '17', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.day', 'enterprise.facts.DateInfo', 'day', 'Day', 'integer', '4', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.month', 'enterprise.facts.DateInfo', 'month', 'Month', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.name', 'enterprise.facts.DateInfo', 'name', 'Name', 'string', '5', 'lookup', 'variableinfo_date:lookup', 'name', 'name', NULL, NULL, '1', 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.qtr', 'enterprise.facts.DateInfo', 'qtr', 'Qtr', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.value', 'enterprise.facts.DateInfo', 'value', 'Date', 'date', '6', 'date', NULL, NULL, NULL, NULL, NULL, '1', 'date', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.year', 'enterprise.facts.DateInfo', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.account', 'treasury.facts.BillItem', 'account', 'Account', 'string', '3', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'object', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.account.objid', 'treasury.facts.BillItem', 'account.objid', 'Account ID', 'string', '2', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.amount', 'treasury.facts.BillItem', 'amount', 'Amount', 'decimal', '1', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.billrefid', 'treasury.facts.BillItem', 'billrefid', 'Bill Ref ID', 'string', '7', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.discount', 'treasury.facts.BillItem', 'discount', 'Discount', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.duedate', 'treasury.facts.BillItem', 'duedate', 'Due Date', 'date', '4', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.fromdate', 'treasury.facts.BillItem', 'fromdate', 'From Date', 'date', '14', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.interest', 'treasury.facts.BillItem', 'interest', 'Interest', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.month', 'treasury.facts.BillItem', 'month', 'Month', 'integer', '13', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.org', 'treasury.facts.BillItem', 'org', 'Org', 'string', '10', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'enterprise.facts.Org', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.parentaccount', 'treasury.facts.BillItem', 'parentaccount', 'Parent Account', 'string', '9', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'object', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.paypriority', 'treasury.facts.BillItem', 'paypriority', 'Pay Priority', 'integer', '18', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.refid', 'treasury.facts.BillItem', 'refid', 'Ref ID', 'string', '16', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.remarks', 'treasury.facts.BillItem', 'remarks', 'Remarks', 'string', '17', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.sortorder', 'treasury.facts.BillItem', 'sortorder', 'Sort Order', 'integer', '19', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.surcharge', 'treasury.facts.BillItem', 'surcharge', 'Surcharge', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.tag', 'treasury.facts.BillItem', 'tag', 'Tag', 'string', '20', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.todate', 'treasury.facts.BillItem', 'todate', 'To Date', 'date', '15', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.txntype', 'treasury.facts.BillItem', 'txntype', 'Txn Type', 'string', '6', 'lookup', 'billitem_txntype:lookup', 'objid', 'title', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.year', 'treasury.facts.BillItem', 'year', 'Year', 'integer', '12', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.date', 'treasury.facts.DueDate', 'date', 'Date', 'date', '1', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.day', 'treasury.facts.DueDate', 'day', 'Day', 'integer', '4', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.month', 'treasury.facts.DueDate', 'month', 'Month', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.qtr', 'treasury.facts.DueDate', 'qtr', 'Qtr', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.year', 'treasury.facts.DueDate', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);

INSERT INTO ztmp_sys_rule_actiondef (objid, name, title, sortorder, actionname, domain, actionclass) VALUES ('treasury.actions.AddBillItem', 'add-billitem', 'Add Bill Item', '2', 'add-billitem', 'TREASURY', 'treasury.actions.AddBillItem');
INSERT INTO ztmp_sys_rule_actiondef (objid, name, title, sortorder, actionname, domain, actionclass) VALUES ('treasury.actions.AddDueDate', 'add-duedate', 'Add Due Date', '1', 'add-duedate', 'TREASURY', 'treasury.actions.AddDueDate');
INSERT INTO ztmp_sys_rule_actiondef (objid, name, title, sortorder, actionname, domain, actionclass) VALUES ('treasury.actions.UpdateFieldValue', 'update-field-value', 'Update Field Value', '0', 'update-field-value', 'TREASURY', 'treasury.actions.UpdateFieldValue');

INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.account', 'treasury.actions.AddBillItem', 'account', '1', 'Account', NULL, 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.amount', 'treasury.actions.AddBillItem', 'amount', '2', 'Amount', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.fromdate', 'treasury.actions.AddBillItem', 'fromdate', '6', 'From Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.month', 'treasury.actions.AddBillItem', 'month', '5', 'Month', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.refid', 'treasury.actions.AddBillItem', 'refid', '9', 'Ref ID', NULL, 'var', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.remarks', 'treasury.actions.AddBillItem', 'remarks', '8', 'Remarks', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.todate', 'treasury.actions.AddBillItem', 'todate', '7', 'To Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.txntype', 'treasury.actions.AddBillItem', 'txntype', '3', 'Txn Type', NULL, 'lookup', 'billitem_txntype:lookup', 'objid', 'title', 'string', NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.year', 'treasury.actions.AddBillItem', 'year', '4', 'Year', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddDueDate.date', 'treasury.actions.AddDueDate', 'date', '1', 'Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddDueDate.tag', 'treasury.actions.AddDueDate', 'tag', '2', 'Tag', 'string', 'string', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.UpdateFieldValue.fieldname', 'treasury.actions.UpdateFieldValue', 'fieldname', '2', 'Field name', NULL, 'fieldlist', NULL, 'object', NULL, NULL, NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.UpdateFieldValue.object', 'treasury.actions.UpdateFieldValue', 'object', '1', 'Object', NULL, 'var', NULL, NULL, NULL, 'obj', NULL);
INSERT INTO ztmp_sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.UpdateFieldValue.value', 'treasury.actions.UpdateFieldValue', 'value', '3', 'Value', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);

INSERT INTO ztmp_sys_ruleset_actiondef (ruleset, actiondef) VALUES ('ctcbilling', 'treasury.actions.AddBillItem');
INSERT INTO ztmp_sys_ruleset_actiondef (ruleset, actiondef) VALUES ('ctcbilling', 'treasury.actions.AddDueDate');
INSERT INTO ztmp_sys_ruleset_actiondef (ruleset, actiondef) VALUES ('ctcbilling', 'treasury.actions.UpdateFieldValue');

INSERT INTO ztmp_sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'com.rameses.rules.common.CurrentDate');
INSERT INTO ztmp_sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'ctc.facts.CorporateCTC');
INSERT INTO ztmp_sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'ctc.facts.IndividualCTC');
INSERT INTO ztmp_sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'enterprise.facts.DateInfo');
INSERT INTO ztmp_sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'treasury.facts.BillItem');
INSERT INTO ztmp_sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'treasury.facts.DueDate');


insert into sys_ruleset (
	name, title, packagename, domain, role, permission 
) 
select 
	name, title, packagename, domain, role, permission 
from ztmp_sys_ruleset
where name not in (select name from sys_ruleset) 
; 

insert into sys_rulegroup (
	name, ruleset, title, sortorder 
) 
select 
	name, ruleset, title, sortorder 
from ztmp_sys_rulegroup rg 
where (select count(*) from sys_rulegroup where ruleset = rg.ruleset and name = rg.name) = 0 
; 

insert into sys_rule_fact (
	[objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], 
	[lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], 
	[builtinconstraints], [domain], [factsuperclass]	
) 
select 
	[objid], [name], [title], [factclass], [sortorder], [handler], [defaultvarname], [dynamic], 
	[lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [dynamicfieldname], 
	[builtinconstraints], [domain], [factsuperclass]
from ztmp_sys_rule_fact a 
where (select count(*) from sys_rule_fact where objid = a.objid) = 0 
; 

insert into sys_rule_fact_field (
	[objid], [parentid], [name], [title], [datatype], [sortorder], [handler], 
	[lookuphandler], [lookupkey], [lookupvalue], [lookupdatatype], [multivalued], 
	[required], [vardatatype], [lovname]
) 
select * 
from ztmp_sys_rule_fact_field a 
where (select count(*) from sys_rule_fact_field where objid = a.objid) = 0 
; 

insert into sys_rule_actiondef (
	[objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]
) 
select 
	[objid], [name], [title], [sortorder], [actionname], [domain], [actionclass]
from ztmp_sys_rule_actiondef a 
where (select count(*) from sys_rule_actiondef where objid = a.objid) = 0 
; 

insert into sys_rule_actiondef_param (
	[objid], [parentid], [name], [sortorder], [title], [datatype], [handler], 
	[lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]
) 
select 
	[objid], [parentid], [name], [sortorder], [title], [datatype], [handler], 
	[lookuphandler], [lookupkey], [lookupvalue], [vardatatype], [lovname]
from ztmp_sys_rule_actiondef_param a 
where (select count(*) from sys_rule_actiondef_param where objid = a.objid) = 0 
; 

insert into sys_ruleset_fact (
	ruleset, rulefact 
) 
select 
	ruleset, rulefact 
from ztmp_sys_ruleset_fact a 
where (select count(*) from sys_ruleset_fact where ruleset = a.ruleset and rulefact = a.rulefact) = 0 
; 

insert into sys_ruleset_actiondef (
	ruleset, actiondef 
) 
select 
	ruleset, actiondef 
from ztmp_sys_ruleset_actiondef a 
where (select count(*) from sys_ruleset_actiondef where ruleset = a.ruleset and actiondef = a.actiondef) = 0 
; 


DROP TABLE [dbo].[ztmp_sys_ruleset] 
go 
DROP TABLE [dbo].[ztmp_sys_rulegroup] 
go 
DROP TABLE [dbo].[ztmp_sys_rule_fact] 
go 
DROP TABLE [dbo].[ztmp_sys_rule_fact_field] 
go 
DROP TABLE [dbo].[ztmp_sys_rule_actiondef] 
go 
DROP TABLE [dbo].[ztmp_sys_rule_actiondef_param] 
go 
DROP TABLE [dbo].[ztmp_sys_ruleset_fact] 
go 
DROP TABLE [dbo].[ztmp_sys_ruleset_actiondef] 
go 
