set search_path to locatieserver, public;
-- provincie
truncate table provincie;

insert into provincie
select provincienaam, geom from bestuurlijkegrenzen.provincies_sf;

-- gemeente
truncate table gemeente;

/*insert into gemeente
select gemeentecode as code,
          gemeentenaam,
          geovlak as geom 
   from bag.gemeente ;
*/

--gba_t33moet gevuld zijn met de meest recente T33
--Vullen van de gemeente tabel op basis van T33 en BAG gegevens van woonplaatsen
insert into gemeente 
select bgw.gemeentecode, 
(select gemeentenaam from gba_t33 
where gemeentecode=bgw.gemeentecode and datumeinde is null 
and (datumingang<to_char(now(), 'yyyymmdd') 
or datumingang is null)) ,
ST_Multi(ST_Union(bw.geovlak)) as geom 
from bag_gemeente_woonplaats bgw join bag_wpl_actueelbestaand bw on (bgw.woonplaatscode=bw.identificatie)  
where bgw.begindatumtijdvakgeldigheid < now() 
and (bgw.einddatumtijdvakgeldigheid is null 
or bgw.einddatumtijdvakgeldigheid  > now()) 
and bgw.status = 'definitief'  
group by gemeentecode;


--overige bag objecten
truncate table bag_gemeente_woonplaats;
insert into bag_gemeente_woonplaats select  gid,
 begindatumtijdvakgeldigheid,
 einddatumtijdvakgeldigheid,
 woonplaatscode,
 gemeentecode,
 cast(cast(status as varchar(100)) as gemeentewoonplaatsstatus) from bag.gemeente_woonplaats;

truncate table bag_verblijfsobject;

insert into bag_verblijfsobject select * from bag.verblijfsobject;

truncate table bag_woonplaats;
insert into bag_woonplaats select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
officieel,
inonderzoek,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
documentnummer,
documentdatum,
woonplaatsnaam,
cast(cast(woonplaatsstatus as varchar(100)) as woonplaatsstatus),
actualiteitsdatum,
geom_valid,
st_multi(geovlak) from bag.woonplaats;

truncate table bag_vbopand;
insert into bag_vbopand select * from bag.verblijfsobjectpand;

truncate table bag_vbogebruiksdoel;
insert into bag_vbogebruiksdoel select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
actualiteitsdatum,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
cast(cast(gebruiksdoelverblijfsobject as varchar(100)) as gebruiksdoelverblijfsobject) from bag.verblijfsobjectgebruiksdoel;

truncate table bag_standplaats;
insert into bag_standplaats select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
officieel,
inonderzoek,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
documentnummer,
documentdatum,
hoofdadres,
cast(cast(standplaatsstatus as varchar(100)) as standplaatsstatus),
actualiteitsdatum,
geom_valid,
geovlak from bag.standplaats;

truncate table bag_pand;
insert into bag_pand select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
officieel,
inonderzoek,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
documentnummer,
documentdatum,
cast(cast(pandstatus as varchar(100)) as pandstatus),
bouwjaar,
geom_valid,
actualiteitsdatum,
geovlak from bag.pand;

truncate table bag_openbareruimte;
insert into bag_openbareruimte select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
officieel,
inonderzoek,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
documentnummer,
documentdatum,
openbareruimtenaam,
cast(cast(openbareruimtestatus as varchar(100)) as openbareruimtestatus),
cast(cast(openbareruimtetype as varchar(100)) as openbareruimtetype),
gerelateerdewoonplaats,
verkorteopenbareruimtenaam,
actualiteitsdatum from bag.openbareruimte;

truncate table bag_nummeraanduiding;
insert into bag_nummeraanduiding select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
officieel,
inonderzoek,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
documentnummer,
documentdatum,
huisnummer,
huisletter,
huisnummertoevoeging,
postcode,
cast(cast(nummeraanduidingstatus as varchar(100)) as nummeraanduidingstatus),
cast(cast(typeadresseerbaarobject as varchar(100)) as typeadresseerbaarobject),
gerelateerdeopenbareruimte,
gerelateerdewoonplaats,
actualiteitsdatum from bag.nummeraanduiding;

truncate table bag_ligplaats;
insert into bag_ligplaats 
select gid,
identificatie,
aanduidingrecordinactief,
aanduidingrecordcorrectie,
officieel,
inonderzoek,
begindatumtijdvakgeldigheid,
einddatumtijdvakgeldigheid,
documentnummer,
documentdatum,
hoofdadres,
cast(cast(ligplaatsstatus as varchar(100)) as ligplaatsstatus),
actualiteitsdatum,
geom_valid,
ST_Force2D(st_multi(geovlak))
 from bag.ligplaats;

truncate table bag_adonevenadres;
insert into bag_adonevenadres select * from bag.adresseerbaarobjectnevenadres;


truncate table bag_adres;
   
insert  /*+ APPEND */ into BAG_ADRES 
select 'vowh'::varchar(5) samenstelling ,
 'hoofdadres verblijfsobject in woonplaats'::varchar(46) adresobjecttypeomschrijving ,
 a.identificatie num_id ,
 a.aanduidingrecordinactief num_inactief ,
 a.begindatumtijdvakgeldigheid num_begdat ,
 a.typeadresseerbaarobject ,
 b.identificatie ado_id ,
 b.aanduidingrecordinactief ado_inactief,
 b.begindatumtijdvakgeldigheid ado_begdat ,
 b.verblijfsobjectstatus ado_status ,
 opr.identificatie opr_id ,
 opr.aanduidingrecordinactief opr_inactief ,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id ,
 wpl.aanduidingrecordinactief wpl_inactief ,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype ,
 a.huisnummer ,
 a.huisletter ,
 a.huisnummertoevoeging ,
 a.postcode ,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_Force2D(b.geopunt),
 ST_X(ST_FORCE2D(b.geopunt)), 
 ST_Y(ST_FORCE2D(b.geopunt)) 
 from bag_num_actueelbestaand          a 
inner join bag_vbo_actueelbestaand b    on ( b.hoofdadres = a.identificatie) 
left join bag_opr_actueelbestaand  opr  on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
where a.typeadresseerbaarobject = 'Verblijfsobject' and a.gerelateerdewoonplaats is null
;

--2e
insert /*+ APPEND */ into BAG_ADRES 
select 'v wh'::varchar(5) adresobjecttype,
 'hoofdadres verblijfsobject buiten woonplaats'::varchar(46) adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 b.identificatie ado_id,
 b.aanduidingrecordinactief ado_inactief,
 b.begindatumtijdvakgeldigheid ado_begdat,
 b.verblijfsobjectstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_Force2D(b.geopunt),
 ST_X(ST_Force2D(b.geopunt)), 
 ST_Y(ST_Force2D(b.geopunt))  
 from bag_num_actueelbestaand          a 
  inner join bag_vbo_actueelbestaand b   on ( b.hoofdadres = a.identificatie) 
  left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
  left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
  left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode)  
 where a.typeadresseerbaarobject = 'Verblijfsobject' and a.gerelateerdewoonplaats is not null
;


--3e
insert /*+ APPEND */ into BAG_ADRES 
select 'vown' adresobjecttype,
 'nevenadres verblijfsobject in woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 c.identificatie ado_id,
 c.aanduidingrecordinactief ado_inactief,
 c.begindatumtijdvakgeldigheid ado_begdat,
 c.verblijfsobjectstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_Force2D(c.geopunt),
 ST_X(ST_Force2D(c.geopunt)) AS x,
 ST_Y(ST_Force2D(C.geopunt)) AS y 
 from bag_num_actueelbestaand          a 
  inner join bag_adonevenadres  b   on ( b.nevenadres = a.identificatie and b.aanduidingrecordinactief = 'N') 
  inner join bag_vbo_actueelbestaand c   on ( c.identificatie = b.identificatie and c.aanduidingrecordinactief = b.aanduidingrecordinactief and c.begindatumtijdvakgeldigheid = b.begindatumtijdvakgeldigheid) 
  left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
  left join bag_wpl_actueelbestaand      wpl on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
  left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Verblijfsobject' and a.gerelateerdewoonplaats is null 
;


-- 4e

insert /*+ APPEND */ into BAG_ADRES 
select 'v wn' adresobjecttype,
 'nevenadres verblijfsobject buiten woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 c.identificatie ado_id,
 c.aanduidingrecordinactief ado_inactief,
 c.begindatumtijdvakgeldigheid ado_begdat,
 c.verblijfsobjectstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam , 
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_Force2D(c.geopunt),
 ST_X(ST_Force2D(c.geopunt)) AS x,
 ST_Y(ST_Force2D(C.geopunt)) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_adonevenadres  b   on ( b.nevenadres = a.identificatie and b.aanduidingrecordinactief = 'N') 
   inner join bag_vbo_actueelbestaand c   on ( c.identificatie = b.identificatie and c.aanduidingrecordinactief = b.aanduidingrecordinactief and c.begindatumtijdvakgeldigheid = b.begindatumtijdvakgeldigheid) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Verblijfsobject' and a.gerelateerdewoonplaats is not null 
;


-- 5e

insert /*+ APPEND */ into BAG_ADRES 
select 'lowh' adresobjecttype,
 'hoofdadres ligplaats in woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 b.identificatie ado_id,
 b.aanduidingrecordinactief ado_inactief,
 b.begindatumtijdvakgeldigheid ado_begdat,
 b.ligplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(b.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_lig_actueelbestaand       b   on ( b.hoofdadres = a.identificatie) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Ligplaats' and a.gerelateerdewoonplaats is null 
;


-- 6e l wh

insert /*+ APPEND */ into BAG_ADRES 
select 'l wh' adresobjecttype,
 'hoofdadres ligplaats buiten woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 b.identificatie ado_id,
 b.aanduidingrecordinactief ado_inactief,
 b.begindatumtijdvakgeldigheid ado_begdat,
 b.ligplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(b.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_lig_actueelbestaand       b   on ( b.hoofdadres = a.identificatie) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Ligplaats' and a.gerelateerdewoonplaats is not null 
;


--7e lown

insert /*+ APPEND */ into BAG_ADRES 
select 'lown' adresobjecttype,
 'nevenadres ligplaats in woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 c.identificatie ado_id,
 c.aanduidingrecordinactief ado_inactief,
 c.begindatumtijdvakgeldigheid ado_begdat,
 c.ligplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(c.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_adonevenadres       b   on ( b.nevenadres = a.identificatie and b.aanduidingrecordinactief = 'N') 
   inner join bag_lig_actueelbestaand c   on ( c.identificatie = b.identificatie and c.aanduidingrecordinactief = b.aanduidingrecordinactief and c.begindatumtijdvakgeldigheid = b.begindatumtijdvakgeldigheid) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand  wpl on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Ligplaats' and a.gerelateerdewoonplaats is null 
;


--8e l wn

insert /*+ APPEND */ into BAG_ADRES 
select 'l wn' adresobjecttype,
 'nevenadres ligplaats buiten woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 c.identificatie ado_id,
 c.aanduidingrecordinactief ado_inactief,
 c.begindatumtijdvakgeldigheid ado_begdat,
 c.ligplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(c.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_adonevenadres  b   on ( b.nevenadres = a.identificatie and b.aanduidingrecordinactief = 'N') 
   inner join bag_lig_actueelbestaand       c   on ( c.identificatie = b.identificatie and c.aanduidingrecordinactief = b.aanduidingrecordinactief and c.begindatumtijdvakgeldigheid = b.begindatumtijdvakgeldigheid) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Ligplaats' and a.gerelateerdewoonplaats is not null 
;


--9e sowh

insert /*+ APPEND */ into BAG_ADRES 
select 'sowh' adresobjecttype,
 'hoofdadres standplaats in woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 b.identificatie ado_id,
 b.aanduidingrecordinactief ado_inactief,
 b.begindatumtijdvakgeldigheid ado_begdat,
 b.standplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(b.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_sta_actueelbestaand     b   on ( b.hoofdadres = a.identificatie) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Standplaats' and a.gerelateerdewoonplaats is null 
;


--10e 

insert /*+ APPEND */ into BAG_ADRES 
select 's wh' adresobjecttype,
 'hoofdadres standplaats buiten woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 b.identificatie ado_id,
 b.aanduidingrecordinactief ado_inactief,
 b.begindatumtijdvakgeldigheid ado_begdat,
 b.standplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(b.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(b.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_sta_actueelbestaand     b   on ( b.hoofdadres = a.identificatie) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode)  
where a.typeadresseerbaarobject = 'Standplaats' and a.gerelateerdewoonplaats is not null 
;


--11e sown

insert /*+ APPEND */ into BAG_ADRES 
select 'sown' adresobjecttype,
 'nevenadres standplaats in woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 c.identificatie ado_id,
 c.aanduidingrecordinactief ado_inactief,
 c.begindatumtijdvakgeldigheid ado_begdat,
 c.standplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(c.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_adonevenadres  b   on ( b.nevenadres = a.identificatie and b.aanduidingrecordinactief = 'N') 
   inner join bag_sta_actueelbestaand     c   on ( c.identificatie = b.identificatie and c.aanduidingrecordinactief = b.aanduidingrecordinactief and c.begindatumtijdvakgeldigheid = b.begindatumtijdvakgeldigheid) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode)  
where a.typeadresseerbaarobject = 'Standplaats' and a.gerelateerdewoonplaats is null 
;


--12e 

insert /*+ APPEND */ into BAG_ADRES 
select 's wn' adresobjecttype,
 'nevenadres standplaats buiten woonplaats' adresobjecttypeomschrijving,
 a.identificatie num_id,
 a.aanduidingrecordinactief num_inactief,
 a.begindatumtijdvakgeldigheid num_begdat,
 a.typeadresseerbaarobject,
 c.identificatie ado_id,
 c.aanduidingrecordinactief ado_inactief,
 c.begindatumtijdvakgeldigheid ado_begdat,
 c.standplaatsstatus ado_status,
 opr.identificatie opr_id,
 opr.aanduidingrecordinactief opr_inactief,
 opr.begindatumtijdvakgeldigheid opr_begdat ,
 wpl.identificatie wpl_id,
 wpl.aanduidingrecordinactief wpl_inactief,
 wpl.begindatumtijdvakgeldigheid wpl_begdat ,
 opr.openbareruimtenaam ,
 CASE WHEN LENGTH(opr.openbareruimtenaam) <= 25 THEN opr.openbareruimtenaam
      ELSE opr.verkorteopenbareruimtenaam END AS verkorteopenbareruimtenaam ,
 opr.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.postcode,
 wpl.woonplaatsnaam ,
 gem.gemeentecode,
 ST_PointOnSurface(ST_Force2D(c.geovlak)),
 ST_X(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS x,
 ST_Y(ST_PointOnSurface(ST_Force2D(c.geovlak))) AS y 
 from bag_num_actueelbestaand          a 
   inner join bag_adonevenadres  b   on ( b.nevenadres = a.identificatie and b.aanduidingrecordinactief = 'N') 
   inner join bag_sta_actueelbestaand     c   on ( c.identificatie = b.identificatie and c.aanduidingrecordinactief = b.aanduidingrecordinactief and c.begindatumtijdvakgeldigheid = b.begindatumtijdvakgeldigheid) 
   left join bag_opr_actueelbestaand  opr on ( opr.identificatie = a.gerelateerdeopenbareruimte) 
   left join bag_wpl_actueelbestaand      wpl  on ( wpl.identificatie = opr.gerelateerdewoonplaats) 
   left join bag_gem_wpl_act_bst gem on (wpl.identificatie=gem.woonplaatscode) 
 where a.typeadresseerbaarobject = 'Standplaats' and a.gerelateerdewoonplaats is not null 
;


commit;



--refreshen van MV's
--BAG_MV_ADRES  
REFRESH MATERIALIZED VIEW BAG_MV_ADRES;

REFRESH MATERIALIZED VIEW BAG_POSTCODES;

REFRESH MATERIALIZED VIEW BAG_OPENBARERUIMTES;



