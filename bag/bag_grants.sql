grant select on bag.bag_adressen to ggs_view_role;

create or replace synonym ggs_view.bag_adressen for bag.bag_adressen;

grant select on bag.bag_panden to ggs_view_role;

create or replace synonym ggs_view.bag_panden for bag.bag_panden;

grant select on bag.bag_woonplaatsen to ggs_view_role;

create or replace synonym ggs_view.bag_woonplaatsen for bag.bag_woonplaatsen;

grant select on bag.bag_gemeenten to ggs_view_role;

create or replace synonym ggs_view.bag_gemeenten for bag.bag_gemeenten;

grant select on bag.bag_pand_bij_adres to ggs_view_role;

create or replace synonym ggs_view.bag_pand_bij_adres for bag.bag_pand_bij_adres;

grant execute on street_abv to ggs_view_role;

create or replace synonym ggs_view.street_abv for bag.street_abv;

grant execute on sdo_wkt to ggs_view_role;

create or replace synonym ggs_view.sdo_wkt for bag.sdo_wkt;

grant insert, update, delete, select on refresh to bag_stage;
