UPDATE system_settings SET db_schema_version='1318',version='2.6b0.5',db_schema_update_date=NOW() where db_schema_version < 1318;

ALTER TABLE vicidial_phone_codes MODIFY geographic_description VARCHAR(100);

ALTER TABLE vicidial_campaigns ADD in_group_dial ENUM('DISABLED','MANUAL_DIAL','NO_DIAL','BOTH') default 'DISABLED';
ALTER TABLE vicidial_campaigns ADD in_group_dial_select ENUM('AGENT_SELECTED','CAMPAIGN_SELECTED','ALL_USER_GROUP') default 'CAMPAIGN_SELECTED';

UPDATE system_settings SET db_schema_version='1319',db_schema_update_date=NOW() where db_schema_version < 1319;

ALTER TABLE vicidial_inbound_groups ADD dial_ingroup_cid VARCHAR(20) default '';

UPDATE system_settings SET db_schema_version='1320',db_schema_update_date=NOW() where db_schema_version < 1320;

ALTER TABLE vicidial_campaigns ADD safe_harbor_audio_field VARCHAR(30) default 'DISABLED';

UPDATE system_settings SET db_schema_version='1321',db_schema_update_date=NOW() where db_schema_version < 1321;

ALTER TABLE system_settings ADD call_menu_qualify_enabled ENUM('0','1') default '0';

ALTER TABLE vicidial_call_menu ADD qualify_sql TEXT;

UPDATE system_settings SET db_schema_version='1322',db_schema_update_date=NOW() where db_schema_version < 1322;

ALTER TABLE recording_log MODIFY filename VARCHAR(100);

ALTER TABLE vicidial_live_agents ADD external_recording VARCHAR(20) default '';

UPDATE system_settings SET db_schema_version='1323',db_schema_update_date=NOW() where db_schema_version < 1323;

ALTER TABLE system_settings ADD admin_list_counts ENUM('0','1') default '1';

UPDATE system_settings SET db_schema_version='1324',db_schema_update_date=NOW() where db_schema_version < 1324;

ALTER TABLE phones MODIFY is_webphone ENUM('Y','N','Y_API_LAUNCH') default 'N';

CREATE TABLE vicidial_session_data (
session_name VARCHAR(40) UNIQUE NOT NULL,
user VARCHAR(20),
campaign_id VARCHAR(8),
server_ip VARCHAR(15) NOT NULL,
conf_exten VARCHAR(20),
extension VARCHAR(100) NOT NULL,
login_time DATETIME NOT NULL,
webphone_url TEXT,
agent_login_call TEXT
);

UPDATE system_settings SET db_schema_version='1325',db_schema_update_date=NOW() where db_schema_version < 1325;

CREATE TABLE vicidial_dial_log (
caller_code VARCHAR(30) NOT NULL,
lead_id INT(9) UNSIGNED default '0',
server_ip VARCHAR(15),
call_date DATETIME,
extension VARCHAR(100) default '',
channel VARCHAR(100) default '',
context VARCHAR(100) default '',
timeout MEDIUMINT(7) UNSIGNED default '0',
outbound_cid VARCHAR(100) default '',
index (caller_code),
index (call_date)
);

CREATE TABLE vicidial_dial_log_archive LIKE vicidial_dial_log;
CREATE UNIQUE INDEX vddla on vicidial_dial_log_archive (caller_code,call_date);

UPDATE system_settings SET db_schema_version='1326',db_schema_update_date=NOW() where db_schema_version < 1326;

ALTER TABLE vicidial_campaigns MODIFY agent_dial_owner_only ENUM('NONE','USER','TERRITORY','USER_GROUP','USER_BLANK','TERRITORY_BLANK','USER_GROUP_BLANK') default 'NONE';

UPDATE system_settings SET db_schema_version='1327',db_schema_update_date=NOW() where db_schema_version < 1327;

ALTER TABLE phones ADD voicemail_greeting VARCHAR(100) default '';

ALTER TABLE vicidial_voicemail ADD voicemail_greeting VARCHAR(100) default '';

ALTER TABLE system_settings ADD allow_voicemail_greeting ENUM('0','1') default '0';
ALTER TABLE system_settings ADD audio_store_purge TEXT;

ALTER TABLE servers ADD audio_store_purge TEXT;

UPDATE system_settings SET db_schema_version='1328',db_schema_update_date=NOW() where db_schema_version < 1328;

ALTER TABLE system_settings ADD svn_revision INT(9) default '0';

ALTER TABLE servers ADD svn_revision INT(9) default '0';
ALTER TABLE servers ADD svn_info TEXT;

UPDATE system_settings SET db_schema_version='1329',db_schema_update_date=NOW() where db_schema_version < 1329;

ALTER TABLE vicidial_campaigns ADD pause_after_next_call ENUM('ENABLED','DISABLED') default 'DISABLED';
ALTER TABLE vicidial_campaigns ADD owner_populate ENUM('ENABLED','DISABLED') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1330',db_schema_update_date=NOW() where db_schema_version < 1330;

CREATE TABLE vicidial_qc_agent_log (
qc_agent_log_id INT(9) unsigned NOT NULL AUTO_INCREMENT,
qc_user VARCHAR(20) COLLATE utf8_unicode_ci NOT NULL,
qc_user_group VARCHAR(20) COLLATE utf8_unicode_ci NOT NULL,
qc_user_ip VARCHAR(15) COLLATE utf8_unicode_ci NOT NULL,
lead_user VARCHAR(20) COLLATE utf8_unicode_ci NOT NULL,
web_server_ip VARCHAR(15) COLLATE utf8_unicode_ci NOT NULL,
view_datetime DATETIME NOT NULL,
save_datetime DATETIME DEFAULT NULL,
view_epoch INT(10) unsigned NOT NULL,
save_epoch INT(10) unsigned DEFAULT NULL,
elapsed_seconds SMALLINT(5) unsigned DEFAULT NULL,
lead_id INT(9) unsigned NOT NULL,
list_id BIGINT(14) unsigned NOT NULL,
campaign_id VARCHAR(8) COLLATE utf8_unicode_ci NOT NULL,
old_status VARCHAR(6) COLLATE utf8_unicode_ci DEFAULT NULL,
new_status VARCHAR(6) COLLATE utf8_unicode_ci DEFAULT NULL,
details TEXT COLLATE utf8_unicode_ci,
processed ENUM('Y','N') COLLATE utf8_unicode_ci NOT NULL,
PRIMARY KEY (qc_agent_log_id),
KEY view_epoch (view_epoch)
);

CREATE TABLE vicidial_comments (
comment_id BIGINT(20) unsigned NOT NULL AUTO_INCREMENT,
lead_id INT(11) NOT NULL,
user_id INT(11) NOT NULL,
timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
list_id INT(11) NOT NULL,
campaign_id INT(11) NOT NULL,
comment VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
hidden TINYINT(1) DEFAULT NULL,
hidden_user_id INT(11) DEFAULT NULL,
hidden_timestamp DATETIME DEFAULT NULL,
unhidden_user_id INT(11) DEFAULT NULL,
unhidden_timestamp DATETIME DEFAULT NULL,
PRIMARY KEY (comment_id),
index (lead_id)
);

CREATE TABLE vicidial_configuration (
id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
name VARCHAR(36) NOT NULL ,
value VARCHAR(36) NOT NULL ,
UNIQUE (name)
);

CREATE TABLE vicidial_lists_custom (
list_id BIGINT(14) unsigned NOT NULL,
audit_comments TINYINT(1) DEFAULT NULL COMMENT 'visible',
audit_comments_enabled TINYINT(1) DEFAULT NULL COMMENT 'invisible',
PRIMARY KEY (list_id)
);

ALTER TABLE vicidial_qc_codes ADD qc_result_type ENUM( 'PASS', 'FAIL', 'CANCEL', 'COMMIT' ) NOT NULL;

INSERT INTO vicidial_qc_codes (code,code_name,qc_result_type) VALUES ('QCPASS','PASS','PASS');
INSERT INTO vicidial_qc_codes (code,code_name,qc_result_type) VALUES ('QCFAIL','FAIL','FAIL');
INSERT INTO vicidial_qc_codes (code,code_name,qc_result_type) VALUES ('QCCANCEL','CANCEL','CANCEL');

INSERT INTO vicidial_statuses (status, status_name, selectable, human_answered, category, sale, dnc, customer_contact, not_interested, unworkable, scheduled_callback) VALUES ('QCFAIL', 'QC_FAIL_CALLBK', 'N', 'Y', 'QC', 'N', 'N', 'Y', 'N', 'N', 'Y');

INSERT INTO vicidial_configuration (id, name, value) VALUES (NULL, 'qc_database_version', '1638');
UPDATE vicidial_configuration set value='1766' where name='qc_database_version';

UPDATE system_settings set vdc_agent_api_active='1';

UPDATE system_settings SET db_schema_version='1331',db_schema_update_date=NOW() where db_schema_version < 1331;

ALTER TABLE system_settings ADD queuemetrics_socket VARCHAR(20) default 'NONE';
ALTER TABLE system_settings ADD queuemetrics_socket_url TEXT;

UPDATE system_settings SET db_schema_version='1332',db_schema_update_date=NOW() where db_schema_version < 1332;

CREATE TABLE vicidial_call_time_holidays (
holiday_id VARCHAR(30) PRIMARY KEY NOT NULL,
holiday_name VARCHAR(100) NOT NULL,
holiday_comments VARCHAR(255) default '',
holiday_date DATE,
holiday_status ENUM('ACTIVE','INACTIVE','EXPIRED') default 'INACTIVE',
ct_default_start SMALLINT(4) unsigned NOT NULL default '900',
ct_default_stop SMALLINT(4) unsigned NOT NULL default '2100',
default_afterhours_filename_override VARCHAR(255) default '',
user_group VARCHAR(20) default '---ALL---'
);

ALTER TABLE vicidial_call_times ADD ct_holidays TEXT default '';
UPDATE vicidial_call_times SET ct_holidays='' where ct_holidays is NULL;

UPDATE system_settings SET db_schema_version='1333',db_schema_update_date=NOW() where db_schema_version < 1333;

ALTER TABLE vicidial_lists ADD expiration_date DATE default '2099-12-31';

ALTER TABLE vicidial_campaigns ADD use_other_campaign_dnc VARCHAR(8) default '';

UPDATE system_settings SET db_schema_version='1334',db_schema_update_date=NOW() where db_schema_version < 1334;
