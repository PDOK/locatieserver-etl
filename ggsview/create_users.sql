-- drop van user
drop schema ggs_view cascade;
drop role ggs_view_role;

-- opnieuw aanmaken

create role ggs_view;
create schema ggs_view authorization ggs_view;

