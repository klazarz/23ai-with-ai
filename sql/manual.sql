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
          json_table ( co.data[*]
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
          json_table ( co.data[*]
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


create property graph countries_graph vertex tables ( country_list key ( id ) label country properties ( id,
                                                                                                         cca3,
                                                                                                         name ) ) edge tables ( borders as related key ( id ) source key ( source_id ) references country_list ( id ) destination key ( target_id ) references country_list ( id ) properties ( id,
                                                                                                                                                                                                                                                                                                relationship ) );


commit;