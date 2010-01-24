INSERT INTO servers (server_id,server_description,server_ip,active,asterisk_version)values('TESTast','Test install of Asterisk server', '10.10.10.15','Y','1.4.21.2');

INSERT INTO server_updater SET server_ip='10.10.10.15', last_update='';

INSERT INTO phones (extension, dialplan_number, voicemail_id, phone_ip, computer_ip, server_ip, login, pass, status, active, phone_type, fullname, company, picture, messages, old_messages, protocol) values('gs102','102','102','10.10.10.16','10.10.9.16','10.10.10.15','gs102','test', 'ADMIN','Y','Grandstream BT 102','Test Admin Phone','TEST','','0','0','SIP');
INSERT INTO phones (extension, dialplan_number, voicemail_id, phone_ip, computer_ip, server_ip, login, pass, status, active, phone_type, fullname, company, protocol) values('callin','8300','8300','10.10.10.15','10.10.10.15','10.10.10.15','callin','test', 'ACTIVE','Y','Dial-in agent phone','Dial-in Agent Phone','TEST','EXTERNAL');

INSERT INTO vicidial_users (user,pass,full_name,user_level,user_group,load_leads,campaign_detail,ast_admin_access,modify_users) values('6666','1234','Admin','9','ADMIN','1','1','1','1');
INSERT INTO vicidial_users (user,pass,full_name,user_level,user_group,active) values('VDAD','donotedit','Outbound Auto Dial','1','ADMIN','N');
INSERT INTO vicidial_users (user,pass,full_name,user_level,user_group,active) values('VDCL','donotedit','Inbound No Agent','1','ADMIN','N');

INSERT INTO conferences values('8600001','10.10.10.15','');
INSERT INTO conferences values('8600002','10.10.10.15','');
INSERT INTO conferences values('8600003','10.10.10.15','');
INSERT INTO conferences values('8600004','10.10.10.15','');
INSERT INTO conferences values('8600005','10.10.10.15','');
INSERT INTO conferences values('8600006','10.10.10.15','');
INSERT INTO conferences values('8600007','10.10.10.15','');
INSERT INTO conferences values('8600008','10.10.10.15','');
INSERT INTO conferences values('8600009','10.10.10.15','');
INSERT INTO conferences values('8600010','10.10.10.15','');
INSERT INTO conferences values('8600011','10.10.10.15','');
INSERT INTO conferences values('8600012','10.10.10.15','');
INSERT INTO conferences values('8600013','10.10.10.15','');
INSERT INTO conferences values('8600014','10.10.10.15','');
INSERT INTO conferences values('8600015','10.10.10.15','');
INSERT INTO conferences values('8600016','10.10.10.15','');
INSERT INTO conferences values('8600017','10.10.10.15','');
INSERT INTO conferences values('8600018','10.10.10.15','');
INSERT INTO conferences values('8600019','10.10.10.15','');
INSERT INTO conferences values('8600020','10.10.10.15','');
INSERT INTO conferences values('8600021','10.10.10.15','');
INSERT INTO conferences values('8600022','10.10.10.15','');
INSERT INTO conferences values('8600023','10.10.10.15','');
INSERT INTO conferences values('8600024','10.10.10.15','');
INSERT INTO conferences values('8600025','10.10.10.15','');
INSERT INTO conferences values('8600026','10.10.10.15','');
INSERT INTO conferences values('8600027','10.10.10.15','');
INSERT INTO conferences values('8600028','10.10.10.15','');
INSERT INTO conferences values('8600029','10.10.10.15','');
INSERT INTO conferences values('8600030','10.10.10.15','');
INSERT INTO conferences values('8600031','10.10.10.15','');
INSERT INTO conferences values('8600032','10.10.10.15','');
INSERT INTO conferences values('8600033','10.10.10.15','');
INSERT INTO conferences values('8600034','10.10.10.15','');
INSERT INTO conferences values('8600035','10.10.10.15','');
INSERT INTO conferences values('8600036','10.10.10.15','');
INSERT INTO conferences values('8600037','10.10.10.15','');
INSERT INTO conferences values('8600038','10.10.10.15','');
INSERT INTO conferences values('8600039','10.10.10.15','');
INSERT INTO conferences values('8600040','10.10.10.15','');
INSERT INTO conferences values('8600041','10.10.10.15','');
INSERT INTO conferences values('8600042','10.10.10.15','');
INSERT INTO conferences values('8600043','10.10.10.15','');
INSERT INTO conferences values('8600044','10.10.10.15','');
INSERT INTO conferences values('8600045','10.10.10.15','');
INSERT INTO conferences values('8600046','10.10.10.15','');
INSERT INTO conferences values('8600047','10.10.10.15','');
INSERT INTO conferences values('8600048','10.10.10.15','');
INSERT INTO conferences values('8600049','10.10.10.15','');

INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600051','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600052','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600053','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600054','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600055','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600056','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600057','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600058','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600059','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600060','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600061','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600062','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600063','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600064','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600065','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600066','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600067','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600068','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600069','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600070','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600071','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600072','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600073','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600074','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600075','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600076','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600077','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600078','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600079','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600080','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600081','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600082','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600083','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600084','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600085','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600086','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600087','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600088','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600089','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600090','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600091','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600092','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600093','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600094','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600095','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600096','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600097','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600098','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600099','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600100','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600101','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600102','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600103','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600104','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600105','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600106','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600107','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600108','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600109','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600110','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600111','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600112','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600113','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600114','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600115','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600116','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600117','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600118','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600119','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600120','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600121','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600122','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600123','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600124','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600125','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600126','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600127','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600128','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600129','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600130','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600131','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600132','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600133','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600134','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600135','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600136','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600137','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600138','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600139','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600140','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600141','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600142','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600143','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600144','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600145','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600146','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600147','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600148','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600149','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600150','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600151','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600152','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600153','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600154','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600155','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600156','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600157','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600158','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600159','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600160','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600161','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600162','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600163','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600164','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600165','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600166','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600167','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600168','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600169','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600170','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600171','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600172','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600173','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600174','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600175','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600176','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600177','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600178','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600179','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600180','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600181','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600182','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600183','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600184','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600185','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600186','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600187','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600188','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600189','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600190','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600191','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600192','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600193','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600194','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600195','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600196','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600197','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600198','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600199','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600200','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600201','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600202','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600203','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600204','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600205','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600206','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600207','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600208','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600209','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600210','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600211','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600212','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600213','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600214','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600215','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600216','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600217','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600218','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600219','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600220','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600221','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600222','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600223','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600224','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600225','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600226','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600227','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600228','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600229','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600230','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600231','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600232','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600233','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600234','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600235','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600236','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600237','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600238','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600239','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600240','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600241','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600242','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600243','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600244','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600245','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600246','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600247','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600248','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600249','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600250','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600251','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600252','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600253','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600254','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600255','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600256','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600257','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600258','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600259','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600260','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600261','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600262','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600263','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600264','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600265','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600266','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600267','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600268','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600269','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600270','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600271','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600272','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600273','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600274','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600275','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600276','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600277','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600278','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600279','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600280','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600281','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600282','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600283','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600284','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600285','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600286','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600287','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600288','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600289','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600290','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600291','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600292','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600293','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600294','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600295','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600296','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600297','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600298','10.10.10.15');
INSERT INTO vicidial_conferences(conf_exten,server_ip) values('8600299','10.10.10.15');

INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead01','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');
INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead02','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');
INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead03','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');
INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead04','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');
INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead05','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');
INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead06','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');
INSERT INTO vicidial_list(status,list_id,phone_code,phone_number,first_name,last_name,address1,city,state,postal_code,country_code,gender,email) values('NEW','101','1','7275551212','Matt','lead07','1234 Fake St.','Clearwater','FL','33760','USA','M','test@test.com');

INSERT INTO vicidial_statuses values('NEW','New Lead','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('QUEUE','Lead To Be Called','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('INCALL','Lead Being Called','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('DROP','Agent Not Available','N','Y','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('XDROP','Agent Not Available IN','N','Y','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('NA','No Answer AutoDial','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('CALLBK','Call Back','Y','Y','UNDEFINED','N','N','Y','N','N');
INSERT INTO vicidial_statuses values('CBHOLD','Call Back Hold','N','Y','UNDEFINED','N','N','Y','N','N');
INSERT INTO vicidial_statuses values('A','Answering Machine','Y','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('AA','Answering Machine Auto','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('AM','Answering Machine Sent to Mesg','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('AL','Answering Machine Msg Played','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('AFAX','Fax Machine Auto','N','N','UNDEFINED','N','N','N','N','Y');
INSERT INTO vicidial_statuses values('AB','Busy Auto','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('B','Busy','Y','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('DC','Disconnected Number','Y','N','UNDEFINED','N','N','N','N','Y');
INSERT INTO vicidial_statuses values('ADC','Disconnected Number Auto','N','N','UNDEFINED','N','N','N','N','Y');
INSERT INTO vicidial_statuses values('DEC','Declined Sale','Y','Y','UNDEFINED','N','N','Y','N','N');
INSERT INTO vicidial_statuses values('DNC','DO NOT CALL','Y','Y','UNDEFINED','N','Y','N','N','N');
INSERT INTO vicidial_statuses values('DNCL','DO NOT CALL Hopper Match','N','N','UNDEFINED','N','Y','N','N','N');
INSERT INTO vicidial_statuses values('DNCC','DO NOT CALL Camp Match','N','N','UNDEFINED','N','Y','N','N','N');
INSERT INTO vicidial_statuses values('SALE','Sale Made','Y','Y','UNDEFINED','Y','N','N','N','N');
INSERT INTO vicidial_statuses values('N','No Answer','Y','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('NI','Not Interested','Y','Y','UNDEFINED','N','N','Y','Y','N');
INSERT INTO vicidial_statuses values('NP','No Pitch No Price','Y','Y','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('PU','Call Picked Up','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('PM','Played Message','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('XFER','Call Transferred','Y','Y','UNDEFINED','N','N','Y','N','N');
INSERT INTO vicidial_statuses values('ERI','Agent Error','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('SVYEXT','Survey sent to Extension','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('SVYVM','Survey sent to Voicemail','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('SVYHU','Survey Hungup','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('SVYREC','Survey sent to Record','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('QVMAIL','Queue Abandon Voicemail Left','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('RQXFER','Re-Queue','N','Y','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('TIMEOT','Inbound Queue Timeout Drop','N','Y','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('AFTHRS','Inbound After Hours Drop','N','Y','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('NANQUE','Inbound No Agent No Queue Drop','N','Y','UNDEFINED','N','N','N','N','N');
