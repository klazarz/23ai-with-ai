
####
#### load Oracle sample data and Moviestream data
####


#The init.sql to enable all users for ORDS
cat << EOF | tee init.sql > /dev/null
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
EOF

mkdir tmp

wget https://github.com/oracle-samples/db-sample-schemas/archive/refs/tags/v23.3.zip 

wget https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles/moviestreamload.zip 

unzip -o v23.3.zip -d /scripts/tmp/

unzip -o moviestreamload.zip -d /scripts/tmp/

#Remove accept and add positional substitution variables
cd /scripts/tmp/db-sample-schemas-23.3/human_resources && sed -i '/ACCEPT/d' hr_install.sql && sed -i 's/pass/1/g' hr_install.sql && sed -i 's/tbs/2/g' hr_install.sql && sed -i 's/overwrite_schema/3/g' hr_install.sql

cd /scripts/tmp/db-sample-schemas-23.3/sales_history && sed -i '/ACCEPT/d' sh_install.sql && sed -i 's/pass/1/g' sh_install.sql && sed -i 's/tbs/2/g' sh_install.sql && sed -i 's/overwrite_schema/3/g' sh_install.sql

cd /scripts/tmp/db-sample-schemas-23.3/customer_orders && sed -i '/ACCEPT/d' co_install.sql && sed -i 's/pass/1/g' co_install.sql && sed -i 's/tbs/2/g' co_install.sql && sed -i 's/overwrite_schema/3/g' co_install.sql

#Load data
cd /scripts/tmp/db-sample-schemas-23.3/human_resources/ && sql system/Welcome23ai@23ai:1521/freepdb1 @hr_install.sql Welcome23ai USERS YES

cd /scripts/tmp/db-sample-schemas-23.3/sales_history/  && sql system/Welcome23ai@23ai:1521/freepdb1 @sh_install.sql Welcome23ai USERS YES

cd /scripts/tmp/db-sample-schemas-23.3/customer_orders/  && sql system/Welcome23ai@23ai:1521/freepdb1 @co_install.sql Welcome23ai USERS YES


#Enable ORDS
cd /scripts/ && sql system/Welcome23ai@23ai:1521/freepdb1 @init.sql


cd /scripts/tmp/ && sql movie/Welcome23ai@23ai:1521/freepdb1 @movie_table_ddl.sql

cd /scripts/tmp/ && sql movie/Welcome23ai@23ai:1521/freepdb1 @movie_table_data.sql

cd /scripts/ && sql sys/Welcome23ai@23ai/freepdb1 as sysdba @0-init.sql

cd /scripts/ && sql ora23ai/ora23ai@23ai/freepdb1 @1-mle.sql

cd /scripts/ && sql ora23ai/ora23ai@23ai/freepdb1 @2-generic.sql

cd /scripts/ && sql ora23ai/ora23ai@23ai/freepdb1 @3-dv-init.sql

rm -rf /scripts/tmp

rm -f v23.3.zip

rm -f moviestreamload.zip

docker cp ./model/ALL-MINILM-L12-V2.onnx 23ai:/tmp/.


exec tail -f /dev/null