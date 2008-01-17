ALTER TABLE vicidial_closer_log ADD xfercallid INT(9) UNSIGNED;

ALTER TABLE vicidial_campaign_server_stats ENGINE=HEAP;

ALTER TABLE live_channels ENGINE=HEAP;

ALTER TABLE live_sip_channels ENGINE=HEAP;

ALTER TABLE parked_channels ENGINE=HEAP;

ALTER TABLE server_updater ENGINE=HEAP;

ALTER TABLE web_client_sessions ENGINE=HEAP;


ALTER TABLE vicidial_campaigns MODIFY lead_order VARCHAR(30);

DROP index user on vicidial_users;
ALTER TABLE vicidial_users MODIFY user VARCHAR(20) NOT NULL;
CREATE UNIQUE INDEX user ON vicidial_users (user);
ALTER TABLE vicidial_users MODIFY pass VARCHAR(20) NOT NULL;
ALTER TABLE vicidial_users MODIFY user_level TINYINT(2) NOT NULL default '1';

 CREATE TABLE vicidial_user_closer_log (
user VARCHAR(20),
campaign_id VARCHAR(20),
event_date DATETIME,
blended ENUM('1','0') default '0',
closer_campaigns TEXT,
index (user),
index (event_date)
);




ALTER TABLE vicidial_users ADD qc_enabled ENUM('1','0') default '0';
ALTER TABLE vicidial_users ADD qc_user_level INT(2) default '1';
ALTER TABLE vicidial_users ADD qc_pass ENUM('1','0') default '0';
ALTER TABLE vicidial_users ADD qc_finish ENUM('1','0') default '0';
ALTER TABLE vicidial_users ADD qc_commit ENUM('1','0') default '0';

ALTER TABLE vicidial_user_groups ADD qc_allowed_campaigns TEXT;
ALTER TABLE vicidial_user_groups ADD qc_allowed_inbound_groups TEXT;
