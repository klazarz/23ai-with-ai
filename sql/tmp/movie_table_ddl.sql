create table "MOVIE" (
    "MOVIE_ID"     number,
    "TITLE"        varchar2(200 byte),
    "BUDGET"       number,
    "GROSS"        number,
    "LIST_PRICE"   number,
    "GENRES"       json,
    "SKU"          varchar2(30 byte),
    "YEAR"         number,
    "OPENING_DATE" date,
    "VIEWS"        number,
    "CAST"         json,
    "CREW"         json,
    "STUDIO"       json,
    "MAIN_SUBJECT" varchar2(500 byte),
    "AWARDS"       json,
    "NOMINATIONS"  json,
    "RUNTIME"      number,
    "SUMMARY"      clob
)
no inmemory;

    create unique index "PK_MOVIE_ID" on
        "MOVIE" (
            "MOVIE_ID"
        );

alter table "MOVIE"
    add constraint "PK_MOVIE_ID" primary key ( "MOVIE_ID" )
        using index "PK_MOVIE_ID"
    enable;


exit;