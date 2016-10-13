-- eerst alles droppen
drop schema bag cascade;
drop role bag;
-- opnieuw aanmaken
create role bag;
create schema BAG authorization bag;



