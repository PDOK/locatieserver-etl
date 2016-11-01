grant select on locatieserver.bag_adressen to pdok_locatieserver_owner;

grant select on locatieserver.bag_panden to pdok_locatieserver_owner;

grant select on locatieserver.bag_woonplaatsen to pdok_locatieserver_owner;

grant select on locatieserver.bag_gemeenten to pdok_locatieserver_owner;

grant select on locatieserver.bag_pand_bij_adres to pdok_locatieserver_owner;

grant select on locatieserver.bag_postcodes to pdok_locatieserver_owner;

/*
grant execute on street_abv to pdok_locatieserver_owner;

create or replace synonym pdok_locatieserver_owner.street_abv for locatieserver.street_abv;

grant execute on sdo_wkt to pdok_locatieserver_owner;

create or replace synonym pdok_locatieserver_owner.sdo_wkt for locatieserver.sdo_wkt;

*/