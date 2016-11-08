-- eerst alles droppen
drop schema locatieserver cascade;
drop role pdok_locatieserver_owner;
-- opnieuw aanmaken
create role pdok_locatieserver_owner with login;
create schema locatieserver;
GRANT USAGE ON SCHEMA BAG TO PDOK_OWNER;
GRANT SELECT ON ALL TABLES IN SCHEMA BAG TO PDOK_OWNER;



