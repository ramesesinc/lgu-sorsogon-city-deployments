delete from collectiontype where objid in ('CTCC','CTCI');

INSERT INTO collectiontype (objid, state, name, title, formno, handler, allowbatch, allowonline, allowoffline, sortorder, allowpaymentorder, allowkiosk, allowcreditmemo, system) 
VALUES ('CTCC', 'ACTIVE', 'CTCC', 'CTC Corporate Collection', '0017', 'ctccorporate', 0, 1, 1, 0, 0, 0, 0, 0);

INSERT INTO collectiontype (objid, state, name, title, formno, handler, allowbatch, allowonline, allowoffline, sortorder, allowpaymentorder, allowkiosk, allowcreditmemo, system) 
VALUES ('CTCI', 'ACTIVE', 'CTCI', 'CTC Individual Collection', '0016', 'ctcindividual', 0, 1, 1, 0, 0, 0, 0, 0);


INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid, generic, sortorder, hidefromlookup) 
VALUES ('ITEMACCT-CTCI', 'ACTIVE', '-', 'COMMUNITY TAX - INDIVIDUAL', NULL, 'REVENUE', 'GENERAL', '01', 'GENERAL', 0.00, 'ANY', NULL, NULL, NULL, 0, 0, 0);

INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid, generic, sortorder, hidefromlookup) 
VALUES ('ITEMACCT-CTCIP', 'ACTIVE', '-', 'COMMUNITY TAX - INDIVIDUAL PENALTY', NULL, 'REVENUE', 'GENERAL', '01', 'GENERAL', 0.00, 'ANY', NULL, NULL, NULL, 0, 0, 0);

INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid, generic, sortorder, hidefromlookup) 
VALUES ('ITEMACCT-CTCC', 'ACTIVE', '-', 'COMMUNITY TAX - CORPORATE', NULL, 'REVENUE', 'GENERAL', '01', 'GENERAL', 0.00, 'ANY', NULL, NULL, NULL, 0, 0, 0);

INSERT INTO itemaccount (objid, state, code, title, description, type, fund_objid, fund_code, fund_title, defaultvalue, valuetype, org_objid, org_name, parentid, generic, sortorder, hidefromlookup) 
VALUES ('ITEMACCT-CTCCP', 'ACTIVE', '-', 'COMMUNITY TAX - CORPORATE PENALTY', NULL, 'REVENUE', 'GENERAL', '01', 'GENERAL', 0.00, 'ANY', NULL, NULL, NULL, 0, 0, 0);
