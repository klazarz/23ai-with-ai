--run as sys


drop user if exists ora23ai cascade;

create user ora23ai identified by ora23ai;

alter user ora23ai
   default tablespace users
   quota unlimited on users;

alter user ora23ai
   temporary tablespace temp;

grant connect,resource,db_developer_role,
   create mle
to ora23ai;

grant execute on javascript to ora23ai;

begin
   ords_admin.enable_schema(
      p_enabled             => true,
      p_schema              => 'ora23ai',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'ora23ai',
      p_auto_rest_auth      => null
   );
   commit;
end;
/


grant execute on utl_http to ora23ai;


begin
   dbms_network_acl_admin.append_host_ace(
      host => 'restcountries.com',
      ace  => xs$ace_type(
         privilege_list => xs$name_list('http'),
         principal_name => 'ora23ai',
         principal_type => xs_acl.ptype_db
      )
   );
end;
/



grant
   create any directory
to ora23ai;

grant
   create mining model
to ora23ai;


create or replace directory demo_py_dir as '/tmp';

grant read,write on directory demo_py_dir to ora23ai;




exit;