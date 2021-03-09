
CREATE DATABASE eor 
go 

USE eor
go 

-- ## patch-01

-- ----------------------------
-- Table structure for eor
-- ----------------------------
CREATE TABLE eor (
  objid varchar(50) NOT NULL,
  receiptno varchar(50) NULL,
  receiptdate date NULL,
  txndate datetime NULL,
  state varchar(10) NULL,
  partnerid varchar(50) NULL,
  txntype varchar(20) NULL,
  traceid varchar(50) NULL,
  tracedate datetime NULL,
  refid varchar(50) NULL,
  paidby varchar(255) NULL,
  paidbyaddress varchar(255) NULL,
  payer_objid varchar(50) NULL,
  paymethod varchar(20) NULL,
  paymentrefid varchar(50) NULL,
  remittanceid varchar(50) NULL,
  remarks varchar(255) NULL,
  amount decimal(16,4) NULL,
  lockid varchar(50) NULL,
  constraint pk_eor PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_for_email
-- ----------------------------
CREATE TABLE eor_for_email (
  objid varchar(50) NOT NULL,
  txndate datetime NULL,
  email varchar(255) NULL,
  mobileno varchar(50) NULL,
  state int NULL,
  dtsent datetime NULL,
  errmsg varchar(255) NULL,
  constraint pk_eor_for_email PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_item
-- ----------------------------
CREATE TABLE eor_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NULL,
  item_objid varchar(50) NULL,
  item_code varchar(100) NULL,
  item_title varchar(100) NULL,
  amount decimal(16,4) NULL,
  remarks varchar(255) NULL,
  item_fund_objid varchar(50) NULL,
  constraint pk_eor_item PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_manual_post
-- ----------------------------
CREATE TABLE eor_manual_post (
  objid varchar(50) NOT NULL,
  state varchar(10) NULL,
  paymentorderno varchar(50) NULL,
  amount decimal(16,4) NULL,
  txntype varchar(50) NULL,
  paymentpartnerid varchar(50) NULL,
  traceid varchar(50) NULL,
  tracedate datetime NULL,
  reason text NULL,
  createdby_objid varchar(50) NULL,
  createdby_name varchar(255) NULL,
  dtcreated datetime NULL,
  constraint pk_eor_manual_post PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_number
-- ----------------------------
CREATE TABLE eor_number (
  objid varchar(255) NOT NULL,
  currentno int NOT NULL DEFAULT '1',
  constraint pk_eor_number PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_paymentorder
-- ----------------------------
CREATE TABLE eor_paymentorder (
  objid varchar(50) NOT NULL,
  txndate datetime NULL,
  txntype varchar(50) NULL,
  txntypename varchar(100) NULL,
  payer_objid varchar(50) NULL,
  payer_name varchar(800) NULL,
  paidby varchar(800),
  paidbyaddress varchar(255) NULL,
  particulars varchar(500) NULL,
  amount decimal(16,2) NULL,
  expirydate date NULL,
  refid varchar(50) NULL,
  refno varchar(50) NULL,
  info varchar(MAX) NULL,
  origin varchar(100) NULL,
  controlno varchar(50) NULL,
  locationid varchar(25) NULL,
  items varchar(MAX) NULL,
  state varchar(32) NULL,
  email varchar(255) NULL,
  mobileno varchar(25) NULL,
  constraint pk_eor_paymentorder PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_paymentorder_cancelled
-- ----------------------------
CREATE TABLE eor_paymentorder_cancelled (
  objid varchar(50) NOT NULL,
  txndate datetime NULL,
  txntype varchar(50) NULL,
  txntypename varchar(100) NULL,
  payer_objid varchar(50) NULL,
  payer_name varchar(800) NULL,
  paidby varchar(800),
  paidbyaddress varchar(255) NULL,
  particulars varchar(500) NULL,
  amount decimal(16,2) NULL,
  expirydate date NULL,
  refid varchar(50) NULL,
  refno varchar(50) NULL,
  info varchar(MAX) NULL,
  origin varchar(100) NULL,
  controlno varchar(50) NULL,
  locationid varchar(25) NULL,
  items varchar(MAX) NULL,
  state varchar(10) NULL,
  email varchar(255) NULL,
  mobileno varchar(50) NULL,
  constraint pk_eor_paymentorder_cancelled PRIMARY KEY (objid) 
) 
go

-- ----------------------------
-- Table structure for eor_paymentorder_paid
-- ----------------------------
CREATE TABLE eor_paymentorder_paid (
  objid varchar(50) NOT NULL,
  txndate datetime NULL,
  txntype varchar(50) NULL,
  txntypename varchar(100) NULL,
  payer_objid varchar(50) NULL,
  payer_name varchar(800) NULL,
  paidby varchar(800),
  paidbyaddress varchar(255) NULL,
  particulars varchar(500) NULL,
  amount decimal(16,2) NULL,
  expirydate date NULL,
  refid varchar(50) NULL,
  refno varchar(50) NULL,
  info varchar(MAX) NULL,
  origin varchar(100) NULL,
  controlno varchar(50) NULL,
  locationid varchar(25) NULL,
  items varchar(MAX) NULL,
  state varchar(10) NULL,
  email varchar(255) NULL,
  mobileno varchar(50) NULL,
  constraint pk_eor_paymentorder_paid PRIMARY KEY (objid) 
) 
go

-- ----------------------------
-- Table structure for eor_payment_error
-- ----------------------------
CREATE TABLE eor_payment_error (
  objid varchar(50) NOT NULL,
  txndate datetime NOT NULL,
  paymentrefid varchar(50) NOT NULL,
  errmsg varchar(MAX) NOT NULL,
  errdetail varchar(MAX) NULL,
  errcode int NULL,
  laststate int NULL,
  constraint pk_eor_payment_error PRIMARY KEY (objid) 
) 
go

-- ----------------------------
-- Table structure for eor_remittance
-- ----------------------------
CREATE TABLE eor_remittance (
  objid varchar(50) NOT NULL,
  state varchar(50) NULL,
  controlno varchar(50) NULL,
  partnerid varchar(50) NULL,
  controldate date NULL,
  dtcreated datetime NULL,
  createdby_objid varchar(50) NULL,
  createdby_name varchar(255) NULL,
  amount decimal(16,4) NULL,
  dtposted datetime NULL,
  postedby_objid varchar(50) NULL,
  postedby_name varchar(255) NULL,
  lockid varchar(50) NULL,
  constraint pk_eor_remittance PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_remittance_fund
-- ----------------------------
CREATE TABLE eor_remittance_fund (
  objid varchar(100) NOT NULL,
  remittanceid varchar(50) NULL,
  fund_objid varchar(50) NULL,
  fund_code varchar(50) NULL,
  fund_title varchar(255) NULL,
  amount decimal(16,4) NULL,
  bankaccount_objid varchar(50) NULL,
  bankaccount_title varchar(255) NULL,
  bankaccount_bank_name varchar(255) NULL,
  validation_refno varchar(50) NULL,
  validation_refdate date NULL,
  constraint pk_eor_remittance_fund PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for eor_share
-- ----------------------------
CREATE TABLE eor_share (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  refitem_objid varchar(50) NULL,
  refitem_code varchar(25) NULL,
  refitem_title varchar(255) NULL,
  payableitem_objid varchar(50) NULL,
  payableitem_code varchar(25) NULL,
  payableitem_title varchar(255) NULL,
  amount decimal(16,4) NULL,
  share decimal(16,2) NULL,
  receiptitemid varchar(50) NULL,
  constraint pk_eor_share PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for epayment_plugin
-- ----------------------------
CREATE TABLE epayment_plugin (
  objid varchar(50) NOT NULL,
  connection varchar(50) NULL,
  servicename varchar(255) NULL,
  constraint pk_epayment_plugin PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for jev
-- ----------------------------
CREATE TABLE jev (
  objid varchar(150) NOT NULL,
  jevno varchar(50) NULL,
  jevdate date NULL,
  fundid varchar(50) NULL,
  dtposted datetime NULL,
  txntype varchar(50) NULL,
  refid varchar(50) NULL,
  refno varchar(50) NULL,
  reftype varchar(50) NULL,
  amount decimal(16,4) NULL,
  state varchar(32) NULL,
  postedby_objid varchar(50) NULL,
  postedby_name varchar(255) NULL,
  verifiedby_objid varchar(50) NULL,
  verifiedby_name varchar(255) NULL,
  dtverified datetime NULL,
  batchid varchar(50) NULL,
  refdate date NULL,
  constraint pk_jev PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for jevitem
-- ----------------------------
CREATE TABLE jevitem (
  objid varchar(150) NOT NULL,
  jevid varchar(150) NULL,
  accttype varchar(50) NULL,
  acctid varchar(50) NULL,
  acctcode varchar(32) NULL,
  acctname varchar(255) NULL,
  dr decimal(16,4) NULL,
  cr decimal(16,4) NULL,
  particulars varchar(255) NULL,
  itemrefid varchar(255) NULL,
  constraint pk_jevitem PRIMARY KEY (objid) 
) 
go

-- ----------------------------
-- Table structure for paymentpartner
-- ----------------------------
CREATE TABLE paymentpartner (
  objid varchar(50) NOT NULL,
  code varchar(50) NULL,
  name varchar(100) NULL,
  branch varchar(255) NULL,
  contact varchar(255) NULL,
  mobileno varchar(32) NULL,
  phoneno varchar(32) NULL,
  email varchar(255) NULL,
  indexno varchar(3) NULL,
  constraint pk_paymentpartner PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for sys_email_queue
-- ----------------------------
CREATE TABLE sys_email_queue (
  objid varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  state int NOT NULL,
  reportid varchar(50) NULL,
  dtsent datetime NOT NULL,
  [to] varchar(255) NOT NULL,
  subject varchar(255) NOT NULL,
  message varchar(MAX) NOT NULL,
  errmsg varchar(MAX) NULL,
  connection varchar(50) NULL,
  constraint pk_sys_email_queue PRIMARY KEY (objid) 
) 
go

-- ----------------------------
-- Table structure for sys_email_template
-- ----------------------------
CREATE TABLE sys_email_template (
  objid varchar(50) NOT NULL,
  subject varchar(255) NOT NULL,
  message varchar(MAX) NOT NULL,
  constraint pk_sys_email_template PRIMARY KEY (objid)
) 
go

-- ----------------------------
-- Table structure for unpostedpayment
-- ----------------------------
CREATE TABLE unpostedpayment (
  objid varchar(50) NOT NULL,
  txndate datetime NOT NULL,
  txntype varchar(50) NOT NULL,
  txntypename varchar(150) NOT NULL,
  paymentrefid varchar(50) NOT NULL,
  amount decimal(16,2) NOT NULL,
  orgcode varchar(20) NOT NULL,
  partnerid varchar(50) NOT NULL,
  traceid varchar(100) NOT NULL,
  tracedate datetime NOT NULL,
  refno varchar(50) NULL,
  origin varchar(50) NULL,
  paymentorder varchar(MAX) NULL,
  errmsg varchar(MAX) NOT NULL,
  errdetail varchar(MAX) NULL,
  constraint pk_unpostedpayment PRIMARY KEY (objid)
) 
go



INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) 
VALUES ('DBP', '101', 'DEVELOPMENT BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '101');

INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) 
VALUES ('LBP', '102', 'LAND BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '102');



-- ## patch-02

create UNIQUE index uix_eor_receiptno on eor (receiptno)
go 
create index ix_receiptdate on eor (receiptdate)
go 
create index ix_txndate on eor (txndate)
go 
create index ix_partnerid on eor (partnerid)
go 
create index ix_traceid on eor (traceid)
go 
create index ix_refid on eor (refid)
go 
create index ix_paidby on eor (paidby)
go 
create index ix_payer_objid on eor (payer_objid)
go 
create index ix_paymentrefid on eor (paymentrefid)
go 
create index ix_remittanceid on eor (remittanceid)
go 
create index ix_lockid on eor (lockid)
go 


create index ix_parentid on eor_item (parentid)
go 
create index ix_item_objid on eor_item (item_objid)
go 
create index ix_item_fund_objid on eor_item (item_fund_objid)
go 



create UNIQUE index uix_paymentorderno on eor_manual_post (paymentorderno)
go 


create index ix_state on eor_paymentorder (state)
go 
create index ix_txndate on eor_paymentorder (txndate)
go 
create index ix_txntype on eor_paymentorder (txntype)
go 
create index ix_payer_name on eor_paymentorder (payer_name)
go 
create index ix_paidby on eor_paymentorder (paidby)
go 
create index ix_refid on eor_paymentorder (refid)
go 
create index ix_refno on eor_paymentorder (refno)
go 
create index ix_controlno on eor_paymentorder (controlno)
go 
create index ix_locationid on eor_paymentorder (locationid)
go 


create index ix_state on eor_paymentorder_cancelled (state)
go 
create index ix_txndate on eor_paymentorder_cancelled (txndate)
go 
create index ix_txntype on eor_paymentorder_cancelled (txntype)
go 
create index ix_payer_name on eor_paymentorder_cancelled (payer_name)
go 
create index ix_paidby on eor_paymentorder_cancelled (paidby)
go 
create index ix_refid on eor_paymentorder_cancelled (refid)
go 
create index ix_refno on eor_paymentorder_cancelled (refno)
go 
create index ix_controlno on eor_paymentorder_cancelled (controlno)
go 
create index ix_locationid on eor_paymentorder_cancelled (locationid)
go 


create index ix_state on eor_paymentorder_paid (state)
go 
create index ix_txndate on eor_paymentorder_paid (txndate)
go 
create index ix_txntype on eor_paymentorder_paid (txntype)
go 
create index ix_payer_name on eor_paymentorder_paid (payer_name)
go 
create index ix_paidby on eor_paymentorder_paid (paidby)
go 
create index ix_refid on eor_paymentorder_paid (refid)
go 
create index ix_refno on eor_paymentorder_paid (refno)
go 
create index ix_controlno on eor_paymentorder_paid (controlno)
go 
create index ix_locationid on eor_paymentorder_paid (locationid)
go 



CREATE UNIQUE index ix_paymentrefid on eor_payment_error (paymentrefid)
go 
create index ix_txndate on eor_payment_error (txndate)
go 



create index ix_state on eor_remittance (state)
go 
create index ix_controlno on eor_remittance (controlno)
go 
create index ix_partnerid on eor_remittance (partnerid)
go 
create index ix_controldate on eor_remittance (controldate)
go 
create index ix_dtcreated on eor_remittance (dtcreated)
go 
create index ix_createdby_objid on eor_remittance (createdby_objid)
go 
create index ix_createdby_name on eor_remittance (createdby_name)
go 
create index ix_dtposted on eor_remittance (dtposted)
go 
create index ix_postedby_objid on eor_remittance (postedby_objid)
go 
create index ix_postedby_name on eor_remittance (postedby_name)
go 



create index ix_remittanceid on eor_remittance_fund (remittanceid)
go 


create index ix_parentid on eor_share (parentid)
go 
create index ix_refitem_objid on eor_share (refitem_objid)
go 
create index ix_refitem_title on eor_share (refitem_title)
go 
create index ix_payableitem_objid on eor_share (payableitem_objid)
go 
create index ix_payableitem_title on eor_share (payableitem_title)
go 
create index ix_receiptitemid on eor_share (receiptitemid)
go 



create index ix_batchid on jev (batchid)
go 
create index ix_dtposted on jev (dtposted)
go 
create index ix_dtverified on jev (dtverified)
go 
create index ix_fundid on jev (fundid)
go 
create index ix_jevdate on jev (jevdate)
go 
create index ix_jevno on jev (jevno)
go 
create index ix_postedby_objid on jev (postedby_objid)
go 
create index ix_refdate on jev (refdate)
go 
create index ix_refid on jev (refid)
go 
create index ix_refno on jev (refno)
go 
create index ix_reftype on jev (reftype)
go 
create index ix_verifiedby_objid on jev (verifiedby_objid)
go 




create index ix_jevid on jevitem (jevid)
go 
create index ix_ledgertype on jevitem (accttype)
go 
create index ix_acctid on jevitem (acctid)
go 
create index ix_acctcode on jevitem (acctcode)
go 
create index ix_acctname on jevitem (acctname)
go 
create index ix_itemrefid on jevitem (itemrefid)
go 



create index ix_refid on sys_email_queue (refid)
go 
create index ix_state on sys_email_queue (state)
go 
create index ix_reportid on sys_email_queue (reportid)
go 
create index ix_dtsent on sys_email_queue (dtsent)
go 



create UNIQUE index uix_paymentrefid on unpostedpayment (paymentrefid)
go 
CREATE INDEX ix_txndate ON unpostedpayment (txndate)
go 
CREATE INDEX ix_txntype ON unpostedpayment (txntype)
go 
CREATE INDEX ix_partnerid ON unpostedpayment (partnerid)
go 
CREATE INDEX ix_traceid ON unpostedpayment (traceid)
go 
CREATE INDEX ix_tracedate ON unpostedpayment (tracedate)
go 
CREATE INDEX ix_refno ON unpostedpayment (refno)
go 
CREATE INDEX ix_origin ON unpostedpayment (origin)
go 



-- ## patch-03

alter table eor add CONSTRAINT fk_eor_remittanceid 
  FOREIGN KEY (remittanceid) REFERENCES eor_remittance (objid)
go 

alter table eor_item add CONSTRAINT fk_eoritem_eor 
  FOREIGN KEY (parentid) REFERENCES eor (objid)
go 

alter table eor_remittance_fund add CONSTRAINT fk_eor_remittance_fund_remittanceid
  FOREIGN KEY (remittanceid) REFERENCES eor_remittance (objid)
go 


alter table eor_share add constraint fk_eor_share_parentid 
  foreign key (parentid) references eor (objid) 
go 

alter table eor_share add constraint fk_eor_share_receiptitemid 
  foreign key (receiptitemid) references eor_item (objid) 
go 


alter table jevitem add CONSTRAINT fk_jevitem_jevid 
  FOREIGN KEY (jevid) REFERENCES jev (objid)
go 
