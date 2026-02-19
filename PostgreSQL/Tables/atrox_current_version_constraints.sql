ALTER TABLE ATROX.atrox_screen
DROP CONSTRAINT IF EXISTS fk_atrox_screen_current_version;

ALTER TABLE ATROX.atrox_screen
ADD CONSTRAINT fk_atrox_screen_current_version
FOREIGN KEY (sc_current_version_id) REFERENCES ATROX.atrox_screen_version (sv_id);

ALTER TABLE ATROX.atrox_service
DROP CONSTRAINT IF EXISTS fk_atrox_service_current_version;

ALTER TABLE ATROX.atrox_service
ADD CONSTRAINT fk_atrox_service_current_version
FOREIGN KEY (se_current_version_id) REFERENCES ATROX.atrox_service_version (sv_id);

ALTER TABLE ATROX.atrox_action
DROP CONSTRAINT IF EXISTS fk_atrox_action_current_version;

ALTER TABLE ATROX.atrox_action
ADD CONSTRAINT fk_atrox_action_current_version
FOREIGN KEY (ac_current_version_id) REFERENCES ATROX.atrox_action_version (av_id);
