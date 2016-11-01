-- eerst alles droppen
drop schema locatieserver cascade;
drop role pdok_locatieserver_owner;
-- opnieuw aanmaken
create role pdok_locatieserver_owner;
create schema locatieserver;



