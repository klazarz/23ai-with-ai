
begin
    -- Allow all hosts for HTTP/HTTP_PROXY
    dbms_network_acl_admin.append_host_ace(
        host =>'*',
        lower_port => 11434,
        upper_port => 11434,
        ace => xs$ace_type(
        privilege_list => xs$name_list('http', 'http_proxy'),
        principal_name => upper('ora23ai'),
        principal_type => xs_acl.ptype_db)
    );
end;
/





declare
jo json_object_t;
begin
jo := json_object_t();
jo.put('access_token', 'dummy');
dbms_vector_chain.create_credential(
credential_name => 'LLM_CRED',
params => json(jo.to_string));
end;
/



-- SELECT
-- dbms_vector.utl_to_embedding(
-- 'cat',
-- json('{
--   "provider"       : "ollama", 
--   "host"           : "local", 
--   "url"            : "http://ollama:11434/api/embeddings", 
--   "model"          : "llama3.2"
-- }')
-- )
-- FROM dual;



exit;