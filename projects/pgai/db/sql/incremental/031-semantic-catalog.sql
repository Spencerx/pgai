
create table ai.semantic_catalog
( id int4 not null primary key generated by default as identity 
, catalog_name name not null unique check (catalog_name ~ '^[a-z][a-z_0-9]*$')
, obj_table name[2] not null check(array_length(fact_table, 1) = 2)
, sql_table name[2] not null check(array_length(fact_table, 1) = 2)
, fact_table name[2] not null check(array_length(fact_table, 1) = 2)
);

create table ai.semantic_catalog_embedding
( id int4 not null primary key generated by default as identity
, semantic_catalog_id int4 not null references ai.semantic_catalog (id) on delete cascade
, embedding_name name not null check (embedding_name ~ '^[a-z][a-z_0-9]*$')
, config jsonb not null check (jsonb_typeof(config) = 'object')
, unique (semantic_catalog_id, embedding_name)
);
