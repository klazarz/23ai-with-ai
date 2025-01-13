BEGIN
 ords_admin.enable_schema(
  p_enabled => TRUE,
  p_schema => 'hr',
  p_url_mapping_type => 'BASE_PATH',
  p_url_mapping_pattern => 'hr',
  p_auto_rest_auth => NULL
 );
 commit;
END;
/

BEGIN
 ords_admin.enable_schema(
  p_enabled => TRUE,
  p_schema => 'sh',
  p_url_mapping_type => 'BASE_PATH',
  p_url_mapping_pattern => 'sh',
  p_auto_rest_auth => NULL
 );
 commit;
END;
/

BEGIN
 ords_admin.enable_schema(
  p_enabled => TRUE,
  p_schema => 'co',
  p_url_mapping_type => 'BASE_PATH',
  p_url_mapping_pattern => 'co',
  p_auto_rest_auth => NULL
 );
 commit;
END;
/

GRANT SODA_APP TO hr;

GRANT SODA_APP TO co;

GRANT SODA_APP TO sh;


CREATE USER admin IDENTIFIED BY "Welcome23ai";

GRANT DBA TO admin;

grant APEX_ADMINISTRATOR_ROLE to admin;

grant PDB_DBA to admin;

grant CDB_DBA to admin;


CREATE USER movie IDENTIFIED BY "Welcome23ai";

grant DB_DEVELOPER_ROLE to movie;

grant RESOURCE to movie;

grant CONNECT to movie;

grant unlimited tablespace to movie;


BEGIN
 ords_admin.enable_schema(
  p_enabled => TRUE,
  p_schema => 'admin',
  p_url_mapping_type => 'BASE_PATH',
  p_url_mapping_pattern => 'admin',
  p_auto_rest_auth => NULL
 );
 commit;
END;
/

BEGIN
 ords_admin.enable_schema(
  p_enabled => TRUE,
  p_schema => 'movie',
  p_url_mapping_type => 'BASE_PATH',
  p_url_mapping_pattern => 'movie',
  p_auto_rest_auth => NULL
 );
 commit;
END;
/

commit;

exit;
