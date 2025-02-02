--run as sys
conn system/Welcome23ai@freepdb1

create user if not exists ora23ai identified by ora23ai;

alter user ora23ai
   default tablespace users
   quota unlimited on users;

alter user ora23ai
   temporary tablespace temp;

grant connect,resource,db_developer_role,
   create mle
to ora23ai;

grant execute on javascript to ora23ai;