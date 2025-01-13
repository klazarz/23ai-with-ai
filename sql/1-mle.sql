create or replace mle module fetch_module 
        language javascript as

        import "mle-js-fetch";
    
        export async function fetch_data(url) {
    
        const response = await fetch(url);
        const data = await response.json();
    
        const jsonData = Array.isArray(data) ? { data: data } : data;

        return jsonData;
    };

/


create or replace function get_data(
    p_url varchar2
) 
return json
as mle module fetch_module
signature 'fetch_data(string)';
/





--create table to hold the JSON
drop table if exists countries;

-- CREATE TABLE countries
--   (data JSON);


create json collection table countries;



-- load json
insert into countries ( data )
   select get_data('https://restcountries.com/v3.1/all');


select *
  from countries;



drop table if exists country_list;

create table country_list (
   id   number
      generated always as identity ( start with 1 increment by 1 ),
   cca3 varchar(3) primary key,
   name varchar2(30)
);

--load data
insert into country_list (
   cca3,
   name
)
   select jt.*
     from countries co,
          json_table ( co.data.data[*]
             columns (
                "CC3" varchar2 ( 3 ) path '$.cca3',
                "NAME" varchar2 ( 30 ) path '$.name.common'
             )
          )
       as jt;



drop table if exists borders;

create table borders (
   id           number
      generated always as identity ( start with 1 increment by 1 )
   not null
      constraint ccrel_pk primary key,
   source_id    number,
   cca3         varchar2(3),
   target_id    number,
   border       varchar2(3),
   relationship varchar2(20)
);



insert into borders (
   cca3,
   border,
   relationship
)
   select jt.cca3,
          jt.border,
          'neighbour'
     from countries co,
          json_table ( co.data.data[*]
             columns (
                "CCA3" varchar2 ( 3 ) path '$.cca3',
                "BORDERS" clob format json path '$.borders',
                nested path '$.borders[*]'
                   columns (
                      "BORDER" varchar2 ( 20 ) path '$'
                   )
             )
          )
       as jt
    where jt.border is not null;




select *
  from borders;

update borders b
   set
   b.source_id = c.id
  from country_list c
 where c.cca3 = b.cca3;

update borders b
   set
   b.target_id = c.id
  from country_list c
 where c.cca3 = b.border;

commit;


begin
   dbms_vector.drop_onnx_model(
      model_name => 'demo_model',
      force      => true
   );
   dbms_vector.load_onnx_model(
      directory  => 'DEMO_PY_DIR',
      file_name  => 'ALL-MINILM-L12-V2.onnx',
      model_name => 'demo_model'
   );
end;
/











exit;