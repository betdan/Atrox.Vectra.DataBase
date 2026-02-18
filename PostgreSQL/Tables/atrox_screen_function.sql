DROP TABLE IF EXISTS ATROX.atrox_screen_function;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_screen_function>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_screen_function (
    sf_id BIGINT NOT NULL,
    sc_id BIGINT NOT NULL,
    fn_id BIGINT NOT NULL,
    sf_sequence INT NOT NULL,
    sf_created_at TIMESTAMP NOT NULL,
    sf_created_by BIGINT NOT NULL,
    sf_updated_at TIMESTAMP NOT NULL,
    sf_updated_by BIGINT NOT NULL,
    sf_deleted BOOLEAN NOT NULL,
    CONSTRAINT pk_atrox_screen_function PRIMARY KEY (sf_id),
    CONSTRAINT uq_atrox_screen_function UNIQUE (sc_id, fn_id),
    CONSTRAINT fk_atrox_screen_function_screen FOREIGN KEY (sc_id) REFERENCES ATROX.atrox_screen (sc_id),
    CONSTRAINT fk_atrox_screen_function_function FOREIGN KEY (fn_id) REFERENCES ATROX.atrox_function (fn_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_screen_function>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_screen_function>>>';
END
$do$;