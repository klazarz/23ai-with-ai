#!/bin/bash

#if u can login with ora23ai, it means init.sh ran already
if ! sql ora23ai/ora23ai@23ai:1521/freepdb1 -e "exit"; then
    mkdir tmp

    wget https://github.com/oracle-samples/db-sample-schemas/archive/refs/tags/v23.3.zip 

    wget https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles/moviestreamload.zip 

    unzip -o v23.3.zip -d /scripts/tmp/

    unzip -o moviestreamload.zip -d /scripts/tmp/

    # Remove accept and add positional substitution variables
    cd /scripts/tmp/db-sample-schemas-23.3/human_resources && sed -i '/ACCEPT/d' hr_install.sql && sed -i 's/pass/1/g' hr_install.sql && sed -i 's/tbs/2/g' hr_install.sql && sed -i 's/overwrite_schema/3/g' hr_install.sql

    cd /scripts/tmp/db-sample-schemas-23.3/sales_history && sed -i '/ACCEPT/d' sh_install.sql && sed -i 's/pass/1/g' sh_install.sql && sed -i 's/tbs/2/g' sh_install.sql && sed -i 's/overwrite_schema/3/g' sh_install.sql

    cd /scripts/tmp/db-sample-schemas-23.3/customer_orders && sed -i '/ACCEPT/d' co_install.sql && sed -i 's/pass/1/g' co_install.sql && sed -i 's/tbs/2/g' co_install.sql && sed -i 's/overwrite_schema/3/g' co_install.sql

    # Load data
    cd /scripts/tmp/db-sample-schemas-23.3/human_resources/ && sql system/Welcome23ai@23ai:1521/freepdb1 @hr_install.sql Welcome23ai USERS YES

    cd /scripts/tmp/db-sample-schemas-23.3/sales_history/  && sql system/Welcome23ai@23ai:1521/freepdb1 @sh_install.sql Welcome23ai USERS YES

    cd /scripts/tmp/db-sample-schemas-23.3/customer_orders/  && sql system/Welcome23ai@23ai:1521/freepdb1 @co_install.sql Welcome23ai USERS YES

    # Enable ORDS
    cd /scripts/ && sql system/Welcome23ai@23ai:1521/freepdb1 @init.sql

    cd /scripts/tmp/ && sql movie/Welcome23ai@23ai:1521/freepdb1 @movie_table_ddl.sql

    cd /scripts/tmp/ && sql movie/Welcome23ai@23ai:1521/freepdb1 @movie_table_data.sql

    cd /scripts/ && sql sys/Welcome23ai@23ai/freepdb1 as sysdba @0-init.sql

    cd /scripts/ && sql sys/Welcome23ai@23ai/freepdb1 as sysdba @1-ollama.sql

    cd /scripts/ && sql ora23ai/ora23ai@23ai/freepdb1 @1-mle.sql

    cd /scripts/ && sql ora23ai/ora23ai@23ai/freepdb1 @2-generic.sql

    cd /scripts/ && sql ora23ai/ora23ai@23ai/freepdb1 @3-dv-init.sql

    rm -rf /scripts/tmp

    rm -f v23.3.zip

    rm -f moviestreamload.zip

    echo "Script executed successfully."
else
    echo "Script ran already."
fi
