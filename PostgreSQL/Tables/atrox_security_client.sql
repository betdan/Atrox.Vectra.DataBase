DROP TABLE IF EXISTS ATROX.atrox_security_client;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED TABLE ATROX.atrox_security_client>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE TABLE ATROX.atrox_security_client (
    client_id UUID NOT NULL,
    company_id UUID NOT NULL,
    client_name VARCHAR(150) NULL,
    api_key_hash VARCHAR(256) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NULL,
    last_used_at TIMESTAMP NULL,
    CONSTRAINT pk_atrox_security_client PRIMARY KEY (client_id)
);$sql$;
    RAISE NOTICE '<<<CREATED TABLE ATROX.atrox_security_client>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING TABLE ATROX.atrox_security_client>>>';
END
$do$;
