ALTER TABLE vicidial_nanpa_prefix_codes ADD city VARCHAR(50) default '';
ALTER TABLE vicidial_nanpa_prefix_codes ADD state VARCHAR(2) default '';
ALTER TABLE vicidial_nanpa_prefix_codes ADD postal_code VARCHAR(10) default '';
ALTER TABLE vicidial_nanpa_prefix_codes ADD country VARCHAR(2) default '';

UPDATE system_settings SET db_schema_version='1136', version='2.2.0b0.5';

ALTER TABLE vicidial_users ADD delete_from_dnc ENUM('0','1') default '0';

ALTER TABLE vicidial_campaigns ADD vtiger_search_dead ENUM('DISABLED','ASK','RESURRECT') default 'ASK';
ALTER TABLE vicidial_campaigns ADD vtiger_status_call ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaigns MODIFY vtiger_screen_login ENUM('Y','N','NEW_WINDOW') default 'Y';
ALTER TABLE vicidial_campaigns MODIFY vtiger_create_call_record ENUM('Y','N','DISPO') default 'Y';

ALTER TABLE vicidial_statuses ADD sale ENUM('Y','N') default 'N';
ALTER TABLE vicidial_statuses ADD dnc ENUM('Y','N') default 'N';
ALTER TABLE vicidial_statuses ADD customer_contact ENUM('Y','N') default 'N';
ALTER TABLE vicidial_statuses ADD not_interested ENUM('Y','N') default 'N';
ALTER TABLE vicidial_statuses ADD unworkable ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaign_statuses ADD sale ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaign_statuses ADD dnc ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaign_statuses ADD customer_contact ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaign_statuses ADD not_interested ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaign_statuses ADD unworkable ENUM('Y','N') default 'N';

UPDATE system_settings SET db_schema_version='1137';

ALTER TABLE vicidial_users ADD email VARCHAR(100) default '';
ALTER TABLE vicidial_users ADD user_code VARCHAR(100) default '';
ALTER TABLE vicidial_users ADD territory VARCHAR(100) default '';

UPDATE system_settings SET db_schema_version='1138';

ALTER TABLE vicidial_campaigns ADD survey_third_digit VARCHAR(1) default '';
ALTER TABLE vicidial_campaigns ADD survey_third_audio_file VARCHAR(50) default 'US_thanks_no_contact';
ALTER TABLE vicidial_campaigns ADD survey_third_status VARCHAR(6) default 'NI';
ALTER TABLE vicidial_campaigns ADD survey_third_exten VARCHAR(20) default '8300';
ALTER TABLE vicidial_campaigns ADD survey_fourth_digit VARCHAR(1) default '';
ALTER TABLE vicidial_campaigns ADD survey_fourth_audio_file VARCHAR(50) default 'US_thanks_no_contact';
ALTER TABLE vicidial_campaigns ADD survey_fourth_status VARCHAR(6) default 'NI';
ALTER TABLE vicidial_campaigns ADD survey_fourth_exten VARCHAR(20) default '8300';

ALTER TABLE system_settings ADD enable_tts_integration ENUM('0','1') default '0';

CREATE TABLE vicidial_tts_prompts (
tts_id VARCHAR(50) PRIMARY KEY NOT NULL,
tts_name VARCHAR(100),
active ENUM('Y','N'),
tts_text TEXT
);

UPDATE system_settings SET db_schema_version='1139';

CREATE TABLE vicidial_call_menu (
menu_id VARCHAR(50) PRIMARY KEY NOT NULL,
menu_name VARCHAR(100),
menu_prompt VARCHAR(100),
menu_timeout SMALLINT(2) UNSIGNED default '10',
menu_timeout_prompt VARCHAR(100) default 'NONE',
menu_invalid_prompt VARCHAR(100) default 'NONE',
menu_repeat TINYINT(1) UNSIGNED default '0',
menu_time_check ENUM('0','1') default '0',
call_time_id VARCHAR(20) default '',
track_in_vdac ENUM('0','1') default '1'
);

CREATE TABLE vicidial_call_menu_options (
menu_id VARCHAR(50) NOT NULL,
option_value VARCHAR(20) NOT NULL default '',
option_description VARCHAR(255) default '',
option_route VARCHAR(20),
option_route_value VARCHAR(100),
option_route_value_context VARCHAR(100),
index (menu_id),
unique index menuoption (menu_id, option_value)
);

ALTER TABLE vicidial_inbound_dids MODIFY did_route ENUM('EXTEN','VOICEMAIL','AGENT','PHONE','IN_GROUP','CALLMENU') default 'EXTEN';
ALTER TABLE vicidial_inbound_dids ADD menu_id VARCHAR(50) default '';

UPDATE system_settings SET db_schema_version='1140';

ALTER TABLE system_settings ADD agentonly_callback_campaign_lock ENUM('0','1') default '1';

UPDATE system_settings SET db_schema_version='1141';

ALTER TABLE system_settings ADD sounds_central_control_active ENUM('0','1') default '0';
ALTER TABLE system_settings ADD sounds_web_server VARCHAR(15) default '127.0.0.1';
ALTER TABLE system_settings ADD sounds_web_directory VARCHAR(255) default '';

ALTER TABLE servers ADD sounds_update ENUM('Y','N') default 'N';

CREATE TABLE vicidial_user_territories (
user VARCHAR(20) NOT NULL,
territory VARCHAR(100) default '',
index (user),
unique index userterritory (user, territory)
);

UPDATE system_settings SET db_schema_version='1142';

ALTER TABLE system_settings ADD active_voicemail_server VARCHAR(15) default '';
ALTER TABLE system_settings ADD auto_dial_limit VARCHAR(5) default '4';

UPDATE system_settings SET db_schema_version='1143';

CREATE TABLE vicidial_territories (
territory_id MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
territory VARCHAR(100) default '',
territory_description VARCHAR(255) default '',
unique index uniqueterritory (territory)
);

ALTER TABLE vicidial_user_territories ADD level ENUM('TOP_AGENT','STANDARD_AGENT','BOTTOM_AGENT') default 'STANDARD_AGENT';

ALTER TABLE system_settings ADD user_territories_active ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1144';

ALTER TABLE servers ADD vicidial_recording_limit MEDIUMINT(8) default '60';

ALTER TABLE phones ADD phone_context VARCHAR(20) default 'default';

UPDATE system_settings SET db_schema_version='1145';

CREATE UNIQUE INDEX extenserver ON phones (extension, server_ip);

UPDATE system_settings SET db_schema_version='1146';

CREATE TABLE vicidial_override_ids (
id_table VARCHAR(50) PRIMARY KEY NOT NULL,
active ENUM('0','1') default '0',
value INT(9) default '0'
);

INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_users','0','1000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_campaigns','0','20000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_inbound_groups','0','30000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_lists','0','40000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_call_menu','0','50000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_user_groups','0','60000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_lead_filters','0','70000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('vicidial_scripts','0','80000');
INSERT INTO vicidial_override_ids(id_table,active,value) values('phones','0','100');

ALTER TABLE vicidial_campaigns MODIFY disable_alter_custphone ENUM('Y','N','HIDE') default 'Y';

UPDATE system_settings SET db_schema_version='1147';

CREATE TABLE vicidial_carrier_log (
uniqueid VARCHAR(20) PRIMARY KEY NOT NULL,
call_date DATETIME,
server_ip VARCHAR(15) NOT NULL,
lead_id INT(9) UNSIGNED,
hangup_cause TINYINT(1) UNSIGNED default '0',
dialstatus VARCHAR(16),
channel VARCHAR(100),
dial_time SMALLINT(2) UNSIGNED default '0',
index (call_date)
);

ALTER TABLE servers ADD carrier_logging_active ENUM('Y','N') default 'N';

UPDATE system_settings SET db_schema_version='1148';

ALTER TABLE vicidial_campaigns MODIFY adaptive_dropped_percentage VARCHAR(4) default '3';

INSERT INTO vicidial_statuses values('AB','Busy Auto','N','N','UNDEFINED','N','N','N','N','N');
INSERT INTO vicidial_statuses values('ADC','Disconnected Number Auto','N','N','UNDEFINED','N','N','N','N','Y');

UPDATE system_settings SET db_schema_version='1149';

ALTER TABLE vicidial_campaigns ADD drop_lockout_time VARCHAR(6) default '0';

UPDATE system_settings SET db_schema_version='1150';

ALTER TABLE vicidial_live_agents ADD agent_log_id INT(9) UNSIGNED default '0';

UPDATE system_settings SET db_schema_version='1151';

ALTER TABLE system_settings ADD allow_custom_dialplan ENUM('0','1') default '0';

ALTER TABLE vicidial_call_menu ADD custom_dialplan_entry TEXT;

ALTER TABLE phones ADD phone_ring_timeout SMALLINT(3) default '60';

UPDATE system_settings SET db_schema_version='1152';

ALTER TABLE vicidial_call_menu MODIFY menu_prompt VARCHAR(255);
ALTER TABLE vicidial_call_menu MODIFY menu_timeout_prompt VARCHAR(255) default 'NONE';
ALTER TABLE vicidial_call_menu MODIFY menu_invalid_prompt VARCHAR(255) default 'NONE';

ALTER TABLE vicidial_call_menu_options MODIFY option_route_value VARCHAR(255);

UPDATE system_settings SET db_schema_version='1153';

ALTER TABLE phones ADD conf_secret VARCHAR(20) default 'test';

UPDATE system_settings SET db_schema_version='1154';

ALTER TABLE vicidial_call_menu ADD tracking_group VARCHAR(20) default 'CALLMENU';

UPDATE system_settings SET db_schema_version='1155';

ALTER TABLE vicidial_inbound_groups MODIFY after_hours_message_filename VARCHAR(255) default 'vm-goodbye';
ALTER TABLE vicidial_inbound_groups MODIFY welcome_message_filename VARCHAR(255) default '---NONE---';
ALTER TABLE vicidial_inbound_groups MODIFY onhold_prompt_filename VARCHAR(255) default 'generic_hold';
ALTER TABLE vicidial_inbound_groups MODIFY hold_time_option_callback_filename VARCHAR(255) default 'vm-hangup';
ALTER TABLE vicidial_inbound_groups MODIFY agent_alert_exten VARCHAR(100) default 'ding';

UPDATE system_settings SET db_schema_version='1156';
