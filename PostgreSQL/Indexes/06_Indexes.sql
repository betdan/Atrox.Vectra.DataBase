DROP INDEX IF EXISTS ATROX.ix_atrox_application_co_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_application_co_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_application_co_id ON ATROX.atrox_application (co_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_application_co_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_application_co_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_function_co_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_function_co_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_function_co_id ON ATROX.atrox_function (co_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_function_co_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_function_co_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_menu_ap_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_menu_ap_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_menu_ap_id ON ATROX.atrox_menu (ap_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_menu_ap_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_ap_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_menu_parent_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_menu_parent_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_menu_parent_id ON ATROX.atrox_menu (mn_parent_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_menu_parent_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_parent_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_menu_screen_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_menu_screen_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_menu_screen_id ON ATROX.atrox_menu (mn_screen_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_menu_screen_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_screen_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_menu_main_function_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_menu_main_function_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_menu_main_function_id ON ATROX.atrox_menu (mn_main_function_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_menu_main_function_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_menu_main_function_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_user_co_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_user_co_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_user_co_id ON ATROX.atrox_user (co_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_user_co_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_user_co_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_user_role_us_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_user_role_us_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_user_role_us_id ON ATROX.atrox_user_role (us_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_user_role_us_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_user_role_us_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_user_role_ro_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_user_role_ro_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_user_role_ro_id ON ATROX.atrox_user_role (ro_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_user_role_ro_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_user_role_ro_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_role_co_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_role_co_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_role_co_id ON ATROX.atrox_role (co_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_role_co_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_role_co_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_role_function_ro_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_role_function_ro_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_role_function_ro_id ON ATROX.atrox_role_function (ro_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_role_function_ro_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_role_function_ro_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_role_function_fn_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_role_function_fn_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_role_function_fn_id ON ATROX.atrox_role_function (fn_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_role_function_fn_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_role_function_fn_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_screen_ap_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_screen_ap_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_screen_ap_id ON ATROX.atrox_screen (ap_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_screen_ap_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_ap_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_screen_current_version_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_screen_current_version_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_screen_current_version_id ON ATROX.atrox_screen (sc_current_version_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_screen_current_version_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_current_version_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_screen_function_sc_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_screen_function_sc_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_screen_function_sc_id ON ATROX.atrox_screen_function (sc_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_screen_function_sc_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_function_sc_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_screen_function_fn_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_screen_function_fn_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_screen_function_fn_id ON ATROX.atrox_screen_function (fn_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_screen_function_fn_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_function_fn_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_service_sc_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_service_sc_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_service_sc_id ON ATROX.atrox_service (sc_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_service_sc_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_sc_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_service_current_version_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_service_current_version_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_service_current_version_id ON ATROX.atrox_service (se_current_version_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_service_current_version_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_current_version_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_action_se_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_action_se_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_action_se_id ON ATROX.atrox_action (se_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_action_se_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_se_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_action_current_version_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_action_current_version_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_action_current_version_id ON ATROX.atrox_action (ac_current_version_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_action_current_version_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_current_version_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_action_parameter_ac_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_action_parameter_ac_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_action_parameter_ac_id ON ATROX.atrox_action_parameter (ac_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_action_parameter_ac_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_parameter_ac_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_screen_version_sc_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_screen_version_sc_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_screen_version_sc_id ON ATROX.atrox_screen_version (sc_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_screen_version_sc_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_version_sc_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_screen_version_vs_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_screen_version_vs_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_screen_version_vs_id ON ATROX.atrox_screen_version (vs_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_screen_version_vs_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_screen_version_vs_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_service_version_se_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_service_version_se_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_service_version_se_id ON ATROX.atrox_service_version (se_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_service_version_se_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_version_se_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_service_version_vs_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_service_version_vs_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_service_version_vs_id ON ATROX.atrox_service_version (vs_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_service_version_vs_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_service_version_vs_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_action_version_ac_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_action_version_ac_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_action_version_ac_id ON ATROX.atrox_action_version (ac_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_action_version_ac_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_version_ac_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ix_atrox_action_version_vs_id;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ix_atrox_action_version_vs_id>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE INDEX ix_atrox_action_version_vs_id ON ATROX.atrox_action_version (vs_id);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ix_atrox_action_version_vs_id>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ix_atrox_action_version_vs_id>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_company_co_code;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_company_co_code>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_company_co_code ON ATROX.atrox_company (co_code);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_company_co_code>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_company_co_code>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_application_ap_code;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_application_ap_code>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_application_ap_code ON ATROX.atrox_application (ap_code);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_application_ap_code>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_application_ap_code>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_screen_sc_code;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_screen_sc_code>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_screen_sc_code ON ATROX.atrox_screen (sc_code);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_screen_sc_code>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_screen_sc_code>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_function_fn_code;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_function_fn_code>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_function_fn_code ON ATROX.atrox_function (fn_code);$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_function_fn_code>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_function_fn_code>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_screen_one_enabled;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_screen_one_enabled>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_screen_one_enabled ON ATROX.atrox_screen_version (sc_id) WHERE vs_id = 2 AND sv_deleted = FALSE;$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_screen_one_enabled>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_screen_one_enabled>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_service_one_enabled;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_service_one_enabled>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_service_one_enabled ON ATROX.atrox_service_version (se_id) WHERE vs_id = 2 AND sv_deleted = FALSE;$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_service_one_enabled>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_service_one_enabled>>>';
END
$do$;

DROP INDEX IF EXISTS ATROX.ux_atrox_action_one_enabled;
DO $do$ BEGIN RAISE NOTICE '<<<DROPPED INDEX ATROX.ux_atrox_action_one_enabled>>>'; END $do$;

DO $do$
BEGIN
    EXECUTE $sql$CREATE UNIQUE INDEX ux_atrox_action_one_enabled ON ATROX.atrox_action_version (ac_id) WHERE vs_id = 2 AND av_deleted = FALSE;$sql$;
    RAISE NOTICE '<<<CREATED INDEX ATROX.ux_atrox_action_one_enabled>>>';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '<<<FAILED CREATING INDEX ATROX.ux_atrox_action_one_enabled>>>';
END
$do$;
