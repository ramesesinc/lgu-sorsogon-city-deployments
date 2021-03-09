
use etracs255_sorsogoncity
go


-- ## 2020-05-15

if object_id('dbo.vw_remittance_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptitem; 
go 

create view vw_remittance_cashreceiptitem AS 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.formtype AS formtype, 
  c.formno AS formno, 
  (case when (c.formtype = 'serial') then 0 else 1 end) AS formtypeindex, 
  cri.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.controlid as controlid, 
  c.series as series, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  (case when v.objid is null then cri.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cri.amount end) AS voidamount  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem cri on cri.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_collectionvoucher_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_collectionvoucher_cashreceiptitem; 
go 

create view vw_collectionvoucher_cashreceiptitem AS 
select 
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.remittanceid AS remittanceid, 
  v.remittance_controldate AS remittance_controldate, 
  v.remittance_controlno AS remittance_controlno, 
  v.collectionvoucherid AS collectionvoucherid, 
  v.collectiontype_objid AS collectiontype_objid, 
  v.collectiontype_name AS collectiontype_name, 
  v.org_objid AS org_objid, 
  v.org_name AS org_name, 
  v.formtype AS formtype, 
  v.formno AS formno, 
  v.formtypeindex AS formtypeindex, 
  v.receiptid AS receiptid, 
  v.receiptdate AS receiptdate, 
  v.receiptno AS receiptno, 
  v.controlid as controlid,
  v.series as series,
  v.paidby AS paidby, 
  v.paidbyaddress AS paidbyaddress, 
  v.collectorid AS collectorid, 
  v.collectorname AS collectorname, 
  v.collectortitle AS collectortitle, 
  v.fundid AS fundid, 
  v.acctid AS acctid, 
  v.acctcode AS acctcode, 
  v.acctname AS acctname, 
  v.amount AS amount, 
  v.voided AS voided, 
  v.voidamount AS voidamount, 
  v.remarks as remarks 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptitem v on v.collectionvoucherid = cv.objid 
go 




-- ## 2020-06-04

alter table checkpayment add constraint fk_checkpayment_bankid 
  foreign key (bankid) references bank (objid) 
; 




-- ## 2020-06-06

alter table aftxn add lockid varchar(50) null 
go 

-- alter table af_control add constraint fk_af_control_afid 
--  foreign key (afid) references af (objid) 
-- go 

alter table af_control add constraint fk_af_control_allocid 
  foreign key (allocid) references af_allocation (objid) 
go 

if object_id('dbo.vw_af_inventory_summary', 'V') IS NOT NULL 
  drop view dbo.vw_af_inventory_summary; 
go 

create view vw_af_inventory_summary as 
select top 100 percent 
  af.objid, af.title, u.unit, af.formtype, 
  (case when af.formtype='serial' then 0 else 1 end) as formtypeindex, 
  (select count(0) from af_control where afid = af.objid and state = 'OPEN') AS countopen, 
  (select count(0) from af_control where afid = af.objid and state = 'ISSUED') AS countissued, 
  (select count(0) from af_control where afid = af.objid and state = 'ISSUED' and currentseries > endseries) AS countclosed, 
  (select count(0) from af_control where afid = af.objid and state = 'SOLD') AS countsold, 
  (select count(0) from af_control where afid = af.objid and state = 'PROCESSING') AS countprocessing, 
  (select count(0) from af_control where afid = af.objid and state = 'HOLD') AS counthold
from af, afunit u 
where af.objid = u.itemid
order by (case when af.formtype='serial' then 0 else 1 end), af.objid 
go 

alter table af_control add salecost decimal(16,2) not null default '0.0'
go 

-- update af_control set salecost = cost where state = 'SOLD' and cost > 0 and salecost = 0 
-- go  


insert into sys_usergroup (
  objid, title, domain, role, userclass
) values (
  'TREASURY.AFO_ADMIN', 'TREASURY AFO ADMIN', 'TREASURY', 'AFO_ADMIN', 'usergroup' 
)
go  

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-AFO-ADMIN-aftxn-changetxntype', 'TREASURY.AFO_ADMIN', 'aftxn', 'changeTxnType', 'Change Txn Type'
); 




-- ## 2020-06-09

insert into sys_usergroup (
  objid, title, domain, role, userclass
) values (
  'TREASURY.COLLECTOR_ADMIN', 'TREASURY COLLECTOR ADMIN', 'TREASURY', 'COLLECTOR_ADMIN', 'usergroup' 
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-COLLECTOR-ADMIN-aftxn-changetxntype', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'rebuildFund', 'Rebuild Remittance Fund'
); 




-- ## 2020-06-10

update af_control_detail set reftype = 'ISSUE' where txntype='SALE' and reftype <> 'ISSUE' 
; 

update aa set 
  aa.issuedstartseries = bb.endingstartseries, aa.issuedendseries = bb.endingendseries, aa.qtyissued = bb.qtyending, 
  aa.endingstartseries = null, aa.endingendseries = null, aa.qtyending = 0 
from af_control_detail aa, ( 
    select 
      (select count(*) from cashreceipt where controlid = d.controlid) as receiptcount, 
      d.objid, d.controlid, d.endingstartseries, d.endingendseries, d.qtyending 
    from af_control_detail d 
    where d.txntype='SALE' 
      and d.qtyending > 0
  )bb 
where aa.objid = bb.objid 
  and bb.receiptcount = 0 
;

update aa set 
  aa.reftype = 'ISSUE', aa.txntype = 'COLLECTION', aa.remarks = 'COLLECTION' 
from af_control_detail aa, ( 
    select 
      (select count(*) from cashreceipt where controlid = d.controlid) as receiptcount, 
      d.objid, d.controlid, d.endingstartseries, d.endingendseries, d.qtyending 
    from af_control_detail d 
    where d.txntype='SALE' 
      and d.qtyending > 0
  )bb 
where aa.objid = bb.objid 
  and bb.receiptcount > 0 
;


insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-COLLECTOR-ADMIN-remittance-modifyCashBreakdown', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'modifyCashBreakdown', 'Modify Remittance Cash Breakdown'
); 




-- ## 2020-06-11

update aa set 
  aa.receivedstartseries = bb.issuedstartseries, aa.receivedendseries = bb.issuedendseries, aa.qtyreceived = bb.qtyissued, 
  aa.beginstartseries = null, aa.beginendseries = null, aa.qtybegin = 0 
from af_control_detail aa, ( 
    select objid, issuedstartseries, issuedendseries, qtyissued 
    from af_control_detail 
    where txntype='sale' 
      and qtyissued > 0 
  ) bb  
where aa.objid = bb.objid 
; 

update aa set 
  aa.currentdetailid = null, aa.currentindexno = 0 
from af_control aa, ( 
    select a.objid 
    from af_control a 
    where a.objid not in (
      select distinct controlid from af_control_detail where controlid = a.objid
    ) 
  )bb 
where aa.objid = bb.objid 
; 


update aa set 
  aa.currentseries = aa.endseries+1 
from  af_control aa, ( 
    select d.controlid 
    from af_control_detail d, af_control a 
    where d.txntype = 'SALE' 
      and d.controlid = a.objid 
      and a.currentseries <= a.endseries 
  )bb 
where aa.objid = bb.controlid 
; 


update af_control set 
  currentindexno = (select indexno from af_control_detail where objid = af_control.currentdetailid)
where currentdetailid is not null 
; 


insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-COLLECTOR-ADMIN-remittance-voidReceipt', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'voidReceipt', 'Void Receipt'
); 




-- ## 2020-06-12

insert into sys_usergroup (
  objid, title, domain, role, userclass
) values (
  'TREASURY.LIQ_OFFICER_ADMIN', 'TREASURY LIQ. OFFICER ADMIN', 
  'TREASURY', 'LIQ_OFFICER_ADMIN', 'usergroup' 
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-d2bb69a6769517e0c8e672fec41f5fd7', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'collectionvoucher', 'changeLiqOfficer', 'Change Liquidating Officer'
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-3219ec222220f68d1f69d4d1d76021e0', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'collectionvoucher', 'modifyCashBreakdown', 'Modify Cash Breakdown'
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-4e508bdd04888894926f677bbc0be374', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'collectionvoucher', 'rebuildFund', 'Rebuild Fund Summary'
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-cf543fabc2aca483c6e5d3d48c39c4cc', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'incomesummary', 'rebuild', 'Rebuild Income Summary'
); 




-- ## 2020-10-13

-- CREATE TABLE cashreceipt_plugin ( 
--    objid varchar(50) NOT NULL, 
--    connection varchar(150) NOT NULL, 
--    servicename varchar(255) NOT NULL,
--    CONSTRAINT pk_cashreceipt_plugin PRIMARY KEY (objid)
-- ) 
-- go 

-- update cashreceipt_plugin set connection = objid where connection is null 
-- go 




-- ## 2020-11-06

create table sys_email_queue (
	objid varchar(50) not null, 
	refid varchar(50) not null, 
	state int not null, 
	reportid varchar(50) null, 
	dtsent datetime not null, 
	[to] varchar(255) not null, 
	subject varchar(255) not null, 
	message varchar(MAX) not null, 
	errmsg varchar(MAX) null, 
	constraint pk_sys_email_queue primary key (objid) 
) 
GO
create index ix_refid on sys_email_queue (refid)
GO 
create index ix_state on sys_email_queue (state)
GO 
create index ix_reportid on sys_email_queue (reportid)
GO 
create index ix_dtsent on sys_email_queue (dtsent)
GO 


alter table sys_email_queue add connection varchar(50) null 
GO 


-- ## 2020-11-12

CREATE TABLE online_business_application (
  objid varchar(50) NOT NULL,
  state varchar(20) NOT NULL,
  dtcreated datetime NOT NULL,
  createdby_objid varchar(50) NOT NULL,
  createdby_name varchar(100) NOT NULL,
  controlno varchar(25) NOT NULL,
  prevapplicationid varchar(50) NOT NULL,
  business_objid varchar(50) NOT NULL,
  appyear int NOT NULL,
  apptype varchar(20) NOT NULL,
  appdate date NOT NULL,
  lobs text NOT NULL,
  infos varchar(MAX) NOT NULL,
  requirements varchar(MAX) NOT NULL,
  step int NOT NULL DEFAULT '0',
  dtapproved datetime NULL,
  approvedby_objid varchar(50) NULL,
  approvedby_name varchar(150) NULL,
  approvedappno varchar(25) NULL,
  constraint pk_online_business_application PRIMARY KEY (objid)
) 
go 

create index ix_state on online_business_application (state)
go 
create index ix_dtcreated on online_business_application (dtcreated)
go 
create index ix_controlno on online_business_application (controlno)
go 
create index ix_prevapplicationid on online_business_application (prevapplicationid)
go 
create index ix_business_objid on online_business_application (business_objid)
go 
create index ix_appyear on online_business_application (appyear)
go 
create index ix_appdate on online_business_application (appdate)
go 
create index ix_dtapproved on online_business_application (dtapproved)
go 
create index ix_approvedby_objid on online_business_application (approvedby_objid)
go 
create index ix_approvedby_name on online_business_application (approvedby_name)
go 

alter table online_business_application add CONSTRAINT fk_online_business_application_business_objid 
  FOREIGN KEY (business_objid) REFERENCES business (objid) 
go 
alter table online_business_application add CONSTRAINT fk_online_business_application_prevapplicationid 
  FOREIGN KEY (prevapplicationid) REFERENCES business_application (objid) 
go 



CREATE VIEW vw_online_business_application AS 
select 
  oa.objid AS objid, 
  oa.state AS state, 
  oa.dtcreated AS dtcreated, 
  oa.createdby_objid AS createdby_objid, 
  oa.createdby_name AS createdby_name, 
  oa.controlno AS controlno, 
  oa.apptype AS apptype, 
  oa.appyear AS appyear, 
  oa.appdate AS appdate, 
  oa.prevapplicationid AS prevapplicationid, 
  oa.business_objid AS business_objid, 
  b.bin AS bin, 
  b.tradename AS tradename, 
  b.businessname AS businessname, 
  b.address_text AS address_text, 
  b.address_objid AS address_objid, 
  b.owner_name AS owner_name, 
  b.owner_address_text AS owner_address_text, 
  b.owner_address_objid AS owner_address_objid, 
  b.yearstarted AS yearstarted, 
  b.orgtype AS orgtype, 
  b.permittype AS permittype, 
  b.officetype AS officetype, 
  oa.step AS step 
from online_business_application oa 
  inner join business_application a on a.objid = oa.prevapplicationid 
  inner join business b on b.objid = a.business_objid
go 



-- ## 2020-12-22

alter table online_business_application add 
	contact_name varchar(255) not null, 
	contact_address varchar(255) not null, 
	contact_email varchar(255) not null, 
	contact_mobileno varchar(15) null 
go 


-- ## 2020-12-23

alter table business_recurringfee add txntype_objid varchar(50) null 
go 

create index ix_txntype_objid on business_recurringfee  (txntype_objid)
go 

alter table business_recurringfee add constraint fk_business_recurringfee_txntype_objid 
  foreign key (txntype_objid) references business_billitem_txntype (objid)
go 


-- ## 2020-12-24

select 'BPLS' as domain, 'OBO' as role, t1.*, 
	(select title from itemaccount where objid = t1.acctid) as title, 
	(
		select top 1 r.taxfeetype 
		from business_receivable r, business_application a 
		where r.account_objid = t1.acctid 
			and a.objid = r.applicationid 
		order by a.txndate desc 
	) as feetype 
into ztmp_fix_business_billitem_txntype 
from ( select distinct account_objid as acctid from business_recurringfee )t1 
where t1.acctid not in ( 
	select acctid from business_billitem_txntype where acctid = t1.acctid 
) 
go 

insert into business_billitem_txntype (
	objid, title, acctid, feetype, domain, role
) 
select 
	acctid, title, acctid, feetype, domain, role
from ztmp_fix_business_billitem_txntype
go 

update aa set 
	aa.txntype_objid = (
		select top 1 objid 
		from business_billitem_txntype 
		where acctid = aa.account_objid 
	) 
from business_recurringfee aa 
where aa.txntype_objid is null 
go 

drop table ztmp_fix_business_billitem_txntype
go 



alter table online_business_application add partnername varchar(50) not null 
go



-- ## 2021-01-06

if object_id('dbo.vw_collectionvoucher_cashreceiptitem', 'V') IS NOT NULL
	drop view vw_collectionvoucher_cashreceiptitem; 
go 
if object_id('dbo.vw_remittance_cashreceiptitem', 'V') IS NOT NULL
    drop view vw_remittance_cashreceiptitem
go 

create view vw_remittance_cashreceiptitem AS 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.formtype AS formtype, 
  c.formno AS formno, 
  cri.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.controlid as controlid, 
  c.series as series, 
  c.stub as stubno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  (case when v.objid is null then cri.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cri.amount end) AS voidamount,   
  (case when (c.formtype = 'serial') then 0 else 1 end) AS formtypeindex
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem cri on cri.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 

create view vw_collectionvoucher_cashreceiptitem AS 
select 
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.*  
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptitem v on v.collectionvoucherid = cv.objid 
go 



if object_id('dbo.vw_collectionvoucher_cashreceiptshare', 'V') IS NOT NULL
	drop view vw_collectionvoucher_cashreceiptshare
go 

if object_id('dbo.vw_remittance_cashreceiptshare', 'V') IS NOT NULL
	drop view vw_remittance_cashreceiptshare
go 

create view vw_remittance_cashreceiptshare AS 
select 
	c.remittanceid AS remittanceid, 
	r.controldate AS remittance_controldate, 
	r.controlno AS remittance_controlno, 
	r.collectionvoucherid AS collectionvoucherid, 
	c.formno AS formno, 
	c.formtype AS formtype, 
  c.controlid as controlid, 
	cs.receiptid AS receiptid, 
	c.receiptdate AS receiptdate, 
	c.receiptno AS receiptno, 
	c.paidby AS paidby, 
	c.paidbyaddress AS paidbyaddress, 
	c.org_objid AS org_objid, 
	c.org_name AS org_name, 
	c.collectiontype_objid AS collectiontype_objid, 
	c.collectiontype_name AS collectiontype_name, 
	c.collector_objid AS collectorid, 
	c.collector_name AS collectorname, 
	c.collector_title AS collectortitle, 
	cs.refitem_objid AS refacctid, 
	ia.fund_objid AS fundid, 
	ia.objid AS acctid, 
	ia.code AS acctcode, 
	ia.title AS acctname, 
	(case when v.objid is null then cs.amount else 0.0 end) AS amount, 
	(case when v.objid is null then 0 else 1 end) AS voided, 
	(case when v.objid is null then 0.0 else cs.amount end) AS voidamount, 
	(case when (c.formtype = 'serial') then 0 else 1 end) AS formtypeindex  
from remittance r 
	inner join cashreceipt c on c.remittanceid = r.objid 
	inner join cashreceipt_share cs on cs.receiptid = c.objid 
	inner join itemaccount ia on ia.objid = cs.payableitem_objid 
	left join cashreceipt_void v on v.receiptid = c.objid 
go 

create view vw_collectionvoucher_cashreceiptshare AS 
select 
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.* 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptshare v on v.collectionvoucherid = cv.objid 
go 




if object_id('dbo.vw_remittance_cashreceiptpayment_noncash', 'V') IS NOT NULL
  drop view vw_remittance_cashreceiptpayment_noncash
go 

create view vw_remittance_cashreceiptpayment_noncash AS 
select 
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.particulars AS particulars, 
  nc.fund_objid as fundid, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  cp.bankid AS bankid, 
  cp.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'CHECK') 
  inner join checkpayment cp on cp.objid = nc.refid 
  left join cashreceipt_void v on v.receiptid = c.objid 
union all 
select 
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  'EFT' AS reftype, 
  nc.particulars AS particulars, 
  nc.fund_objid as fundid, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  ba.bank_objid AS bankid, 
  ba.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'EFT') 
  inner join eftpayment eft on eft.objid = nc.refid 
  inner join bankaccount ba on ba.objid = eft.bankacctid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 



-- ## 2021-01-08

INSERT INTO sys_ruleset (name, title, packagename, domain, role, permission) 
VALUES ('firebpassessment', 'Fire Assessment Rules', NULL, 'bpls', 'DATAMGMT', NULL);

INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) 
VALUES ('firefee', 'firebpassessment', 'Fire Fee Computation', '0');

INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) 
VALUES ('postfirefee', 'firebpassessment', 'Post Fire Fee Computation', '1');

insert into sys_ruleset_actiondef (
	ruleset, actiondef 
) 
select t1.* 
from ( 
	select 'firebpassessment' as ruleset, actiondef 
	from sys_ruleset_actiondef 
	where ruleset='bpassessment'
)t1 
	left join sys_ruleset_actiondef a on (a.ruleset = t1.ruleset and a.actiondef = t1.actiondef) 
where a.ruleset is null 
; 

insert into sys_ruleset_fact (
	ruleset, rulefact  
) 
select t1.* 
from ( 
	select 'firebpassessment' as ruleset, rulefact  
	from sys_ruleset_fact 
	where ruleset='bpassessment'
)t1 
	left join sys_ruleset_fact a on (a.ruleset = t1.ruleset and a.rulefact = t1.rulefact) 
where a.ruleset is null 
; 



CREATE TABLE sys_domain (
  name varchar(50) NOT NULL,
  connection varchar(50) NOT NULL,
  constraint pk_sys_domain PRIMARY KEY (name)
) 
go 



-- ## 2021-01-11

alter table business add lockid varchar(50) null 
go 



-- ## 2021-01-16

INSERT INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) 
VALUES ('BPLS.ONLINE_DATA_APPROVER', 'BPLS - ONLINE DATA APPROVER', 'BPLS', 'usergroup', NULL, 'ONLINE_DATA_APPROVER')
;


if object_id('dbo.vw_online_business_application', 'V') IS NOT NULL 
	DROP VIEW vw_online_business_application;
go 
CREATE VIEW vw_online_business_application AS 
select 
  oa.objid AS objid, 
  oa.state AS state, 
  oa.dtcreated AS dtcreated, 
  oa.createdby_objid AS createdby_objid, 
  oa.createdby_name AS createdby_name, 
  oa.controlno AS controlno, 
  oa.apptype AS apptype, 
  oa.appyear AS appyear, 
  oa.appdate AS appdate, 
  oa.prevapplicationid AS prevapplicationid, 
  oa.business_objid AS business_objid, 
  b.bin AS bin, 
  b.tradename AS tradename, 
  b.businessname AS businessname, 
  b.address_text AS address_text, 
  b.address_objid AS address_objid, 
  b.owner_name AS owner_name, 
  b.owner_address_text AS owner_address_text, 
  b.owner_address_objid AS owner_address_objid, 
  b.yearstarted AS yearstarted, 
  b.orgtype AS orgtype, 
  b.permittype AS permittype, 
  b.officetype AS officetype, 
  oa.step AS step 
from online_business_application oa 
  inner join business_application a on a.objid = oa.prevapplicationid 
  inner join business b on b.objid = a.business_objid
;


-- ## 2021-01-31


alter table cashreceipt_share add receiptitemid varchar(50) null 
go

create index ix_receiptitemid on cashreceipt_share (receiptitemid) 
go
