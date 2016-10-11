set search_path to bag, public;


--------------------------------------------------------
--  File created - 4 oct 2016   
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Drop SEQUENCE
--------------------------------------------------------
drop sequence if exists log_seq;
drop sequence if exists bron_seq;
drop sequence if exists BAG_GEMEENTE_WOONPLAATS_SEQ;
drop sequence if exists BAG_LIGPLAATS_SEQ;
drop sequence if exists BAG_NUMMERAANDUIDING_SEQ;
drop sequence if exists BAG_OPENBARERUIMTE_SEQ;
drop sequence if exists BAG_STANDPLAATS_SEQ;
drop sequence if exists BAG_VBOGEBRUIKSDOEL_SEQ;
drop sequence if exists BAG_VERBLIJFSOBJECT_SEQ;
drop sequence if exists BAG_WOONPLAATS_SEQ;

--------------------------------------------------------
--  DDL for Drop Views
--------------------------------------------------------

drop view if exists BAG_WOONPLAATSEN cascade;
drop view if exists BAG_OPR_ACTUEEL;
drop view if exists BAG_NUM_ACTUEELBESTAAND;
drop view if exists BAG_NUM_ACTUEEL;
drop view if exists BAG_LIG_ACTUEELBESTAAND;
drop view if exists BAG_LIG_ACTUEEL;
drop view if exists BAG_GEM_WPL_ACT_BST;
drop view if exists BAG_GEM_WPL_ACT;
drop view if exists BAG_GEMEENTEN;
drop view if exists BAG_PANDEN;
drop view if exists BAG_PAND_BIJ_ADRES;
drop view if exists BAG_ADRESSEN;
drop view if exists GBA_GEMEENTEACTUEEL;
drop view if exists GBA_BAG_GEM_WPL_ACT_BST;
drop view if exists GBA_BAG_GEM_WPL;
drop view if exists BAG_WPL_ACTUEELBESTAAND;
drop view if exists BAG_WPL_ACTUEEL;
drop view if exists BAG_VPA_ACTUEEL;
drop view if exists BAG_VGD_ACTUEEL;
drop view if exists BAG_VBO_ACTUEELBESTAAND;
drop view if exists BAG_VBO_ACTUEEL;
drop view if exists BAG_STA_ACTUEELBESTAAND;
drop view if exists BAG_STA_ACTUEEL;
drop view if exists BAG_PND_ACTUEELBESTAAND;
drop view if exists BAG_PND_ACTUEEL;
drop view if exists BAG_OPR_ACTUEELBESTAAND;


--------------------------------------------------------
--  DDL for DROP Tables
--------------------------------------------------------
drop table if exists GBA_T33_ALIAS ;
drop table if exists GBA_T33;
drop table if exists BAG_WOONPLAATS_ALIAS ;
drop table if exists REFRESH ;
drop table if exists SUFFIX_AFK;
drop table if exists BAG_LOG;
drop table if exists GEMEENTE;
drop table if exists PROVINCIE;
drop table if exists BAG_ADRES;
drop table if exists BAG_WOONPLAATS_ALIAS;


--------------------------------------------------------
--  DDL for DROP MV
--------------------------------------------------------

drop materialized view if exists BAG_ADONEVENADRES;
drop materialized view if exists BAG_LIGPLAATS;
drop materialized view if exists BAG_MV_ADRES;
drop materialized view if exists BAG_NUMMERAANDUIDING;
drop materialized view if exists BAG_OPENBARERUIMTE;
drop materialized view if exists BAG_PAND;
drop materialized view if exists BAG_STANDPLAATS;
drop materialized view if exists BAG_VBOGEBRUIKSDOEL;
drop materialized view if exists BAG_VBOPAND;
drop materialized view if exists BAG_WOONPLAATS;
drop materialized view if exists BAG_VERBLIJFSOBJECT;
drop materialized view if exists BAG_GEMEENTE_WOONPLAATS;


-------------------------------------------------------
--  DDL for MV BAG_ADONEVENADRES
--------------------------------------------------------

create materialized view bag_adonevenadres
as select * from bagactueel.adresseerbaarobjectnevenadres
;
 --actueelbestaand;

--------------------------------------------------------
--  DDL for MV BAG_GEMEENTE_WOONPLAATS
--------------------------------------------------------

 create materialized view BAG_GEMEENTE_WOONPLAATS 
  as select * from bagactueel.gemeente_woonplaats 
  ; --actueelbestaand;

--------------------------------------------------------
--  DDL for MV BAG_LIGPLAATS
--------------------------------------------------------

create materialized view bag_ligplaats 
as select * from bagactueel.ligplaats; --actueelbestaand;

--------------------------------------------------------
--  DDL for tabel BAG_ADRES
--    deze tabel wordt gevuld met alle hoofd- en neven
--    adressen.
--------------------------------------------------------
create table bag_adres (
SAMENSTELLING varchar(5 ), 
	ADRESOBJECTTYPEOMSCHRIJVING varchar(46 ), 
	NUM_ID NUMERIC(16 ), 
	NUM_INACTIEF CHAR(1 ), 
	NUM_BEGDAT NUMERIC(16,0), 
	TYPEADRESSEERBAAROBJECT varchar(20 ), 
	ADO_ID NUMERIC(16 ), 
	ADO_INACTIEF CHAR(1 ), 
	ADO_BEGDAT numeric, 
	ADO_STATUS varchar(80 ), 
	OPR_ID NUMERIC(16 ), 
	OPR_INACTIEF CHAR(1 ), 
	OPR_BEGDAT numeric(16,0), 
	WPL_ID numeric(4,0 ), 
	WPL_INACTIEF CHAR(1 ), 
	WPL_BEGDAT numeric(16,0), 
	OPENBARERUIMTENAAM varchar(80 ), 
	VERKORTEOPENBARERUIMTENAAM varchar(80 ), 
	OPENBARERUIMTETYPE varchar(40 ), 
	HUISNUMMER numeric(5,0), 
	HUISLETTER varchar(1 ), 
	HUISNUMMERTOEVOEGING varchar(4 ), 
	POSTCODE varchar(6 ), 
	WOONPLAATSNAAM varchar(80 ), 
	GEMEENTECODE numeric(4 ), 
	GEOPUNT GEOMETRY(point, 28992) , 
	X numeric, 
	Y numeric
)
;


--------------------------------------------------------
--  DDL for tabel GEMEENTE
--------------------------------------------------------

 CREATE TABLE GEMEENTE 
   (CODE NUMERIC(4,0), 
	GEMEENTENAAM VARCHAR(80),
	GEOM GEOMETRY (polygon, 28992) 
   ) 
  ;

--------------------------------------------------------
--  DDL for tabel PROVINCIE
--------------------------------------------------------
CREATE TABLE PROVINCIE
   (PROVINCIENAAM VARCHAR(25),
    GEOM GEOMETRY (polygon, 28992)
   )
  ;

--------------------------------------------------------
--  DDL for Table GBA_T33
--------------------------------------------------------

  CREATE TABLE GBA_T33 
   (	ID NUMERIC(4,0), 
	GEMEENTECODE NUMERIC(4,0 ), 
	GEMEENTENAAM VARCHAR(40 ), 
	NIEUWE_CODE VARCHAR(4 ), 
	DATUMINGANG date, 
	DATUMEINDE date, 
	MUTID_BEGIN NUMERIC, 
	MUTID_WIJZIGING NUMERIC
   ) 
  ;

--------------------------------------------------------
--  DDL for Table BAG_WOONPLAATS_ALIAS
--------------------------------------------------------

  CREATE TABLE BAG_WOONPLAATS_ALIAS 
   (	ID NUMERIC, 
	ALIAS VARCHAR(100), 
	DATUM_MUTATIE DATE, 
	IDENTIFICATIE NUMERIC(4)
   ) 
  ;

  
--------------------------------------------------------
--  DDL for tabel BAG_GEM_WPL_ACT_BST
--    deze table heeft de tabel GEMEENTE en PROVINCIES
--    nodig.
--------------------------------------------------------

   CREATE OR REPLACE VIEW BAG_GEM_WPL_ACT_BST (GEMEENTECODE, WOONPLAATSCODE, STATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, CODE, GEMEENTENAAM, PROVINCIENAAM, PROVINCIEAFKORTING, PROVINCIECODE) AS 
  select gw.gemeentecode
     , gw.woonplaatscode
     , gw.status
     , gw.begindatumtijdvakgeldigheid
     , gw.einddatumtijdvakgeldigheid
     , g.code
     , g.gemeentenaam
     , p.provincienaam
     , CASE p.provincienaam WHEN   'Overijssel' THEN 'OV'
                            WHEN   'Flevoland' THEN 'FL'
                            WHEN   'Zuid-Holland' THEN 'ZH'
	   		     WHEN   'Noord-Holland' THEN 'NH'
			     WHEN   'Noord-Brabant' THEN 'NB'
			     WHEN   'Limburg'    THEN 'LB'
			     WHEN   'Utrecht'    THEN 'UT'
			     WHEN   'Zeeland'    THEN 'ZL'
			     WHEN   'Gelderland' THEN 'GD'
			     WHEN   'Groningen' THEN 'GR'
			     WHEN   'Friesland' THEN 'FR'
			     WHEN   'Drenthe' THEN 'DR' 
        END  provincieafkorting,
       CASE p.provincienaam 
                      WHEN   'Overijssel'       THEN 'PV23' 
                      WHEN   'Flevoland'        THEN 'PV24' 
                      WHEN   'Zuid-Holland'     THEN 'PV28' 
                      WHEN   'Noord-Holland'    THEN 'PV27' 
                      WHEN   'Noord-Brabant'    THEN 'PV30' 
                      WHEN   'Limburg'          THEN 'PV31' 
                      WHEN   'Utrecht'          THEN 'PV26' 
                      WHEN   'Zeeland'          THEN 'PV29' 
                      WHEN   'Gelderland'       THEN 'PV25' 
                      WHEN   'Groningen'        THEN 'PV20' 
                      WHEN   'Friesland'        THEN 'PV21' 
                      WHEN   'Drenthe'          THEN 'PV22' 
       END   provinciecode
    from bag_gemeente_woonplaats gw join gemeente g on (gw.gemeentecode=g.code), 
        provincie p
   where (
           gw.begindatumtijdvakgeldigheid < now() 
         and 
           (gw.einddatumtijdvakgeldigheid is null
           or gw.einddatumtijdvakgeldigheid  > now() 
           )
         and gw.status = 'definitief'
         )
and ST_contains(p.geom, st_centroid(g.geom));



--------------------------------------------------------
--  DDL for View BAG_WOONPLAATSEN
--------------------------------------------------------

CREATE OR REPLACE  VIEW BAG_WOONPLAATSEN (IDENTIFICATIE, WOONPLAATSCODE, WOONPLAATSNAAM, GEMEENTENAAM, GEMEENTECODE, PROVINCIENAAM, PROVINCIECODE, PROVINCIEAFKORTING, WOONPLAATSALIASSEN, BRON, GEOMETRIE_RD) AS 
  select gw.woonplaatscode IDENTIFICATIE,
  gw.woonplaatscode ,
w.woonplaatsnaam,
gw.gemeentenaam,
gw.gemeentecode,
gw.provincienaam,
gw.provinciecode,
gw.provincieafkorting,
a.alias woonplaatsaliassen,
'BAG' bron,
w.geovlak geometrie_rd
from bagactueel.woonplaatsactueelbestaand w join bag_gem_wpl_act_bst gw  on (w.identificatie=gw.woonplaatscode)
   left outer join bag_woonplaats_alias a on (gw.woonplaatscode = a.identificatie)
;

--------------------------------------------------------
--  DDL for MV BAG_MV_ADRES
--------------------------------------------------------

create materialized view bag_mv_adres
as select --gid row_id,
 a.ado_id||'-'||a.num_id identificatie,
 a.ado_id adresseerbaarobject_id,
 a.typeadresseerbaarobject,
 a.num_id nummeraanduiding_id,
 a.opr_id openbareruimte_id,
 a.wpl_id woonplaatscode,
 a.openbareruimtenaam straatnaam,
 a.VERKORTEOPENBARERUIMTENAAM straatnaam_verkort,
 a.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.huisnummer||a.huisletter||nullif('-'||a.huisnummertoevoeging, '-') huis_nlt,
 a.postcode,
 substr(a.postcode, 1,4) postcodenummer,
 substr(a.postcode, 5,6) postcodeletter,
 a.woonplaatsnaam,
 g.woonplaatsaliassen, 
 g.gemeentenaam,
 g.gemeentecode,
 g.provincienaam,
 g.provinciecode,
 g.provincieafkorting,
 'BAG' bron,
 a.geopunt  geometrie_rd
from bag_adres a join bag_woonplaatsen g on (a.wpl_id=g.identificatie and a.gemeentecode=g.gemeentecode)
;
-- actueelbestaand;

-- de table BAG_ADRES wordt nu nog niet gevuld in bagactueel
-- misschieen in dit schema vullen en dan een MV eropzetten

--------------------------------------------------------
--  DDL for Table BAG_NUMMERAANDUIDING
--------------------------------------------------------

create materialized view bag_nummeraanduiding
as select * from bagactueel.nummeraanduiding; --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_OPENBARERUIMTE
--------------------------------------------------------

create materialized view bag_openbareruimte
as select * from bagactueel.openbareruimte; --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_PAND
--------------------------------------------------------

create materialized view bag_pand
as select * from bagactueel.pand; --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_STANDPLAATS
--------------------------------------------------------

create materialized view bag_standplaats
as select * from bagactueel.standplaats; --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_VBOGEBRUIKSDOEL
--------------------------------------------------------

create materialized view bag_vbogebruiksdoel
as select * from bagactueel.verblijfsobjectgebruiksdoel;  --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_VBOPAND
--------------------------------------------------------

create materialized view bag_vbopand
as select * from bagactueel.verblijfsobjectpand;  --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_VERBLIJFSOBJECT
--------------------------------------------------------

create materialized view bag_verblijfsobject
as select * from bagactueel.verblijfsobject; --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_WOONPLAATS
--------------------------------------------------------

create materialized view bag_woonplaats
as select * from bagactueel.woonplaats; --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_WOONPLAATS_ALIAS
--------------------------------------------------------
/*
  CREATE TABLE BAG_WOONPLAATS_ALIAS 
   (	ID numeric, 
	ALIAS varchar(100 ), 
	DATUM_MUTATIE DATE, 
	IDENTIFICATIE varchar(4 )
   ) 
  ;
  */
--------------------------------------------------------
--  DDL for MV GBA_T33
--------------------------------------------------------
/*
create materialized view gba_t33
as select * from bagactueel.gba_t33;
*/
--------------------------------------------------------
--  DDL for Table GBA_T33_ALIAS
--------------------------------------------------------

  CREATE TABLE GBA_T33_ALIAS 
   (	ID numeric, 
	GEMEENTECODE NUMERIC(4,0 ), 
	ALIAS varchar(100 ), 
	DATUM_MUTATIE DATE
   ) 
  ;
--------------------------------------------------------
--  DDL for MV GEMEENTE
--------------------------------------------------------

--create materialized view GEMEENTE
--as select * from bagactueel.GEMEENTE;


--------------------------------------------------------
--  DDL for MV PROVINCIE
--------------------------------------------------------

--create materialized view PROVINCIE
--as select * from bagactueel.PROVINCIE;



--------------------------------------------------------
--  DDL for Table REFRESH
--------------------------------------------------------

   CREATE TABLE refresh 
    (REFRESH numeric, 
     COMMENTS varchar(200)
    );
    insert into refresh values (0, 'INITITEEL');
    commit;

--------------------------------------------------------
--  DDL for View BAG_GEMEENTEN
--------------------------------------------------------

 CREATE OR REPLACE VIEW BAG_GEMEENTEN (IDENTIFICATIE, GEMEENTECODE, GEMEENTENAAM, PROVINCIENAAM, PROVINCIEAFKORTING, PROVINCIECODE, BRON, GEOMETRIE_RD) AS 
  select g.code identificatie,
  g.code gemeentecode,
g.gemeentenaam,
p.provincienaam,
       CASE p.provincienaam WHEN   'Overijssel' THEN 'OV'
                            WHEN   'Flevoland' THEN 'FL'
                            WHEN   'Zuid-Holland' THEN 'ZH'
	   		     WHEN   'Noord-Holland' THEN 'NH'
			     WHEN   'Noord-Brabant' THEN 'NB'
			     WHEN   'Limburg'    THEN 'LB'
			     WHEN   'Utrecht'    THEN 'UT'
			     WHEN   'Zeeland'    THEN 'ZL'
			     WHEN   'Gelderland' THEN 'GD'
			     WHEN   'Groningen' THEN 'GR'
			     WHEN   'Friesland' THEN 'FR'
			     WHEN   'Drenthe' THEN 'DR' 
        END  provincieafkorting,
       CASE p.provincienaam 
                      WHEN   'Overijssel'       THEN 'PV23' 
                      WHEN   'Flevoland'        THEN 'PV24' 
                      WHEN   'Zuid-Holland'     THEN 'PV28' 
                      WHEN   'Noord-Holland'    THEN 'PV27' 
                      WHEN   'Noord-Brabant'    THEN 'PV30' 
                      WHEN   'Limburg'          THEN 'PV31' 
                      WHEN   'Utrecht'          THEN 'PV26' 
                      WHEN   'Zeeland'          THEN 'PV29' 
                      WHEN   'Gelderland'       THEN 'PV25' 
                      WHEN   'Groningen'        THEN 'PV20' 
                      WHEN   'Friesland'        THEN 'PV21' 
                      WHEN   'Drenthe'          THEN 'PV22' 
       END   provinciecode,
'BAG' bron,
g.geom geometrie_rd
from gemeente g, provincie p
where st_contains(p.geom, st_centroid(g.geom))
;

--------------------------------------------------------
--  DDL for View BAG_GEM_WPL_ACT
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_GEM_WPL_ACT (GEMEENTECODE, WOONPLAATSCODE, STATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) AS 
  SELECT gemeentecode
       , woonplaatscode
       , status
       , begindatumtijdvakgeldigheid
       , einddatumtijdvakgeldigheid
    from bag_gemeente_woonplaats
   where (
           begindatumtijdvakgeldigheid < now()) 
         AND 
           (einddatumtijdvakgeldigheid IS NULL
           or einddatumtijdvakgeldigheid  > now()) 
           
         ;
 
 
 
--------------------------------------------------------
--  DDL for View BAG_LIG_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_LIG_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, LIGPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    hoofdadres,
    ligplaatsstatus,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM bag_ligplaats
  WHERE ((((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    )))
  AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_LIG_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_LIG_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, LIGPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    hoofdadres,
    ligplaatsstatus,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM BAG_LIG_ACTUEEL
  where (ligplaatsstatus         <> 'Plaats ingetrokken');
--------------------------------------------------------
--  DDL for View BAG_NUM_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_NUM_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HUISNUMMER, HUISLETTER, HUISNUMMERTOEVOEGING, POSTCODE, NUMMERAANDUIDINGSTATUS, TYPEADRESSEERBAAROBJECT, GERELATEERDEOPENBARERUIMTE, GERELATEERDEWOONPLAATS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    huisnummer,
    huisletter,
    huisnummertoevoeging,
    postcode,
    nummeraanduidingstatus,
    typeadresseerbaarobject,
    gerelateerdeopenbareruimte,
    gerelateerdewoonplaats,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid
  FROM bag_nummeraanduiding
  WHERE ((((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    )))
  AND (aanduidingrecordinactief = 'N')
    ;
--------------------------------------------------------
--  DDL for View BAG_NUM_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_NUM_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HUISNUMMER, HUISLETTER, HUISNUMMERTOEVOEGING, POSTCODE, NUMMERAANDUIDINGSTATUS, TYPEADRESSEERBAAROBJECT, GERELATEERDEOPENBARERUIMTE, GERELATEERDEWOONPLAATS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    huisnummer,
    huisletter,
    huisnummertoevoeging,
    postcode,
    nummeraanduidingstatus,
    typeadresseerbaarobject,
    gerelateerdeopenbareruimte,
    gerelateerdewoonplaats,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid
  FROM BAG_NUM_ACTUEEL
  where nummeraanduidingstatus <> 'Naamgeving ingetrokken';
--------------------------------------------------------
--  DDL for View BAG_OPR_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_OPR_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, OPENBARERUIMTENAAM, OPENBARERUIMTESTATUS, OPENBARERUIMTETYPE, GERELATEERDEWOONPLAATS, VERKORTEOPENBARERUIMTENAAM, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    openbareruimtenaam,
    openbareruimtestatus,
    openbareruimtetype,
    gerelateerdewoonplaats,
    verkorteopenbareruimtenaam,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid
  FROM bag_openbareruimte
  WHERE (((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    ))
  AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_OPR_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_OPR_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, OPENBARERUIMTENAAM, OPENBARERUIMTESTATUS, OPENBARERUIMTETYPE, GERELATEERDEWOONPLAATS, VERKORTEOPENBARERUIMTENAAM, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    openbareruimtenaam,
    openbareruimtestatus,
    openbareruimtetype,
    gerelateerdewoonplaats,
    verkorteopenbareruimtenaam,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid
  FROM BAG_OPR_ACTUEEL
  WHERE (openbareruimtestatus    <> 'Naamgeving ingetrokken');

--------------------------------------------------------
--  DDL for View BAG_PND_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_PND_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, PANDSTATUS, BOUWJAAR, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    pandstatus,
    bouwjaar,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM bag_pand
  WHERE ((((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    )))
  AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_PND_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_PND_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, PANDSTATUS, BOUWJAAR, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    pandstatus,
    bouwjaar,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM bag_pnd_actueel
  where pandstatus             <> 'Niet gerealiseerd pand'
  AND pandstatus              <> 'Pand gesloopt';
--------------------------------------------------------
--  DDL for View BAG_STA_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_STA_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, STANDPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    hoofdadres,
    standplaatsstatus,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM bag_standplaats
  WHERE ((((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    )))
  AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_STA_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_STA_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, STANDPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    hoofdadres,
    standplaatsstatus,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM BAG_STA_ACTUEEL
  where standplaatsstatus       <> 'Plaats ingetrokken';
--------------------------------------------------------
--  DDL for View BAG_VBO_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_VBO_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, VERBLIJFSOBJECTSTATUS, OPPERVLAKTEVERBLIJFSOBJECT, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOPUNT, GEOVLAK) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    hoofdadres,
    verblijfsobjectstatus,
    oppervlakteverblijfsobject,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geopunt,
    geovlak
  FROM bag_verblijfsobject
  WHERE ((((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    )))
  AND (aanduidingrecordinactief = 'N')
--  AND ((verblijfsobject.geom_valid             IS NULL)
--  OR (verblijfsobject.geom_valid                = 't'))
  ;
--------------------------------------------------------
--  DDL for View BAG_VBO_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_VBO_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, VERBLIJFSOBJECTSTATUS, OPPERVLAKTEVERBLIJFSOBJECT, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOPUNT, GEOVLAK) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    hoofdadres,
    verblijfsobjectstatus,
    oppervlakteverblijfsobject,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geopunt,
    geovlak
  FROM BAG_VBO_ACTUEEL
  where ((verblijfsobjectstatus  <> 'Niet gerealiseerd verblijfsobject')
  AND (verblijfsobjectstatus   <> 'Verblijfsobject ingetrokken'));
--------------------------------------------------------
--  DDL for View BAG_VGD_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_VGD_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEBRUIKSDOELVERBLIJFSOBJECT) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    gebruiksdoelverblijfsobject
  FROM bag_vbogebruiksdoel 
  WHERE (((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    ))
  AND (aanduidingrecordinactief = 'N');
-------------------------------------------------------
--  DDL for View BAG_VPA_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_VPA_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GERELATEERDPAND) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    gerelateerdpand
  FROM bag_vbopand 
  WHERE (((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   >= now())
    ))
  AND (aanduidingrecordinactief = 'N');

--------------------------------------------------------
--  DDL for View BAG_WPL_ACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_WPL_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, WOONPLAATSNAAM, WOONPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT GID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    woonplaatsnaam,
    woonplaatsstatus,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM bag_woonplaats
  WHERE ((((begindatumtijdvakgeldigheid <= now())
    )
  AND ((einddatumtijdvakgeldigheid IS NULL)
  OR (einddatumtijdvakgeldigheid   > now())
    )))
  AND (aanduidingrecordinactief = 'N')
  ;
--------------------------------------------------------
--  DDL for View BAG_WPL_ACTUEELBESTAAND
--------------------------------------------------------

  CREATE OR REPLACE VIEW BAG_WPL_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, WOONPLAATSNAAM, WOONPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) AS 
  SELECT ID,
    identificatie,
    aanduidingrecordinactief,
    aanduidingrecordcorrectie,
    officieel,
    inonderzoek,
    documentnummer,
    documentdatum,
    woonplaatsnaam,
    woonplaatsstatus,
    begindatumtijdvakgeldigheid,
    einddatumtijdvakgeldigheid,
    geovlak
  FROM BAG_WPL_ACTUEEL  
  WHERE woonplaatsstatus        <> 'Woonplaats ingetrokken';
--------------------------------------------------------
--  DDL for View GBA_BAG_GEM_WPL
--------------------------------------------------------

  CREATE OR REPLACE VIEW GBA_BAG_GEM_WPL (GBA_GEMEENTECODE, GBA_GEMEENTENAAM, GBA_DATUMINGANG, GBA_DATUMEINDE, REL_GEMEENTECODE, REL_WOONPLAATSCODE, REL_STATUS, REL_BEGINDATUMTIJDVAK, REL_EINDDATUMTIJDVAK, BAG_WOONPLAATSCODE, BAG_WOONPLAATSNAAM, BAG_WOONPLAATSSTATUS, BAG_BEGINDATUMTIJDVAK, BAG_EINDDATUMTIJDVAK, BAG_WPL_GEOVLAK) AS 
  select g.gemeentecode
     , g.gemeentenaam
     , g.datumingang
     , g.datumeinde
     , gw.gemeentecode
     , gw.woonplaatscode
     , gw.status
     , gw.begindatumtijdvakgeldigheid
     , gw.einddatumtijdvakgeldigheid
     , w.identificatie
     , w.woonplaatsnaam
     , w.woonplaatsstatus
     , w.begindatumtijdvakgeldigheid
     , w.einddatumtijdvakgeldigheid
     , w.geovlak
  from bag_wpl_actueelbestaand w
       join BAG_GEMEENTE_WOONPLAATS gw on (
         gw.woonplaatscode = w.identificatie)
       join gba_t33 g on (
         g.gemeentecode = gw.gemeentecode);
--------------------------------------------------------
--  DDL for View GBA_BAG_GEM_WPL_ACT_BST
--------------------------------------------------------

  CREATE OR REPLACE VIEW GBA_BAG_GEM_WPL_ACT_BST (GBA_GEMEENTECODE, GBA_GEMEENTENAAM, GBA_DATUMINGANG, GBA_DATUMEINDE, REL_GEMEENTECODE, REL_WOONPLAATSCODE, REL_STATUS, REL_BEGINDATUMTIJDVAK, REL_EINDDATUMTIJDVAK, BAG_WOONPLAATSCODE, BAG_WOONPLAATSNAAM, BAG_WOONPLAATSSTATUS, BAG_BEGINDATUMTIJDVAK, BAG_EINDDATUMTIJDVAK, BAG_WPL_GEOVLAK) AS 
  select g.gemeentecode
     , g.gemeentenaam
     , g.datumingang
     , g.datumeinde
     , gw.gemeentecode
     , gw.woonplaatscode
     , gw.status
     , gw.begindatumtijdvakgeldigheid
     , gw.einddatumtijdvakgeldigheid
     , w.identificatie
     , w.woonplaatsnaam
     , w.woonplaatsstatus
     , w.begindatumtijdvakgeldigheid
     , w.einddatumtijdvakgeldigheid
     , w.geovlak
  from bag_wpl_actueelbestaand w
       join BAG_GEMEENTE_WOONPLAATS gw on (
         gw.woonplaatscode = w.identificatie)
       join gba_t33 g on (
         g.gemeentecode = gw.gemeentecode);
--------------------------------------------------------
--  DDL for View GBA_GEMEENTEACTUEEL
--------------------------------------------------------

  CREATE OR REPLACE VIEW GBA_GEMEENTEACTUEEL (GEMEENTECODE, GEMEENTENAAM, NIEUWE_CODE, DATUMINGANG, DATUMEINDE) AS 
  SELECT DISTINCT
         gemeentecode
       , gemeentenaam
       , nieuwe_code
       , datumingang
       , datumeinde
    from gba_t33
   where (
           datumingang < now() 
           OR datumingang IS NULL) 
         AND 
           (datumeinde  > now() 
           OR datumeinde IS NULL)
         ;

--------------------------------------------------------
--  DDL for View BAG_ADRESSEN
--------------------------------------------------------

CREATE OR REPLACE VIEW BAG_ADRESSEN as
select a.identificatie,
 a.adresseerbaarobject_id,
 a.nummeraanduiding_id,
 a.openbareruimte_id,
 a.woonplaatscode,
 a.straatnaam,
 a.straatnaam_verkort,
 a.openbareruimtetype,
 a.huisnummer,
 a.huisletter,
 a.huisnummertoevoeging,
 a.huis_nlt,
 a.postcode,
 a.postcodenummer,
 a.postcodeletter,
 a.woonplaatsnaam,
 a.woonplaatsaliassen, 
 a.gemeentenaam,
 a.gemeentecode,
 a.provincienaam,
 a.provinciecode,
 a.provincieafkorting,
 a.bron,
 a.geometrie_rd
from bag_mv_adres a;


--------------------------------------------------------
--  DDL for View BAG_PAND_BIJ_ADRES
--------------------------------------------------------

   CREATE OR REPLACE  VIEW BAG_PAND_BIJ_ADRES (IDENTIFICATIE, PANDSTATUS, BOUWJAAR, ADRESSEERBAAROBJECT_ID, BRON, GEOMETRIE_RD) AS 
  select pab.identificatie,
pab.pandstatus,
pab.bouwjaar,
a.adresseerbaarobject_id,
'BAG' bron,
pab.geovlak geometrie_rd
from
bag_pnd_actueelbestaand pab join bag_vbopand vp on (vp.gerelateerdpand=pab.identificatie and
(((vp.begindatumtijdvakgeldigheid <= now())
    )
  and ((vp.einddatumtijdvakgeldigheid is null)
  OR (vp.einddatumtijdvakgeldigheid   > now())
    )))
  and (vp.aanduidingrecordinactief = 'N')
                        join bag_mv_adres a on (a.adresseerbaarobject_id=vp.identificatie);
						
--------------------------------------------------------
--  DDL for View BAG_PANDEN
--------------------------------------------------------

 CREATE OR REPLACE  VIEW BAG_PANDEN (IDENTIFICATIE, OFFICIEEL, INONDERZOEK, BEGINDATUMTIJDVAKGELDIGHEID, DOCUMENTNUMMER, DOCUMENTDATUM, PANDSTATUS, BOUWJAAR, BRON, GEOMETRIE_RD) AS 
  select 
IDENTIFICATIE,
OFFICIEEL,
INONDERZOEK,
BEGINDATUMTIJDVAKGELDIGHEID,
DOCUMENTNUMMER,
DOCUMENTDATUM,
PANDSTATUS,
BOUWJAAR,
'BAG' bron,
geovlak geometrie_rd			
from bag_pnd_actueelbestaand;				

--------------------------------------------------------
--  DDL for View BAG_WOONPLAATSEN
--------------------------------------------------------

  CREATE OR REPLACE  VIEW BAG_WOONPLAATSEN (IDENTIFICATIE, WOONPLAATSCODE, WOONPLAATSNAAM, GEMEENTENAAM, GEMEENTECODE, PROVINCIENAAM, PROVINCIECODE, PROVINCIEAFKORTING, WOONPLAATSALIASSEN, BRON, GEOMETRIE_RD) AS 
  select /*+ ORDERED */ gw.woonplaatscode IDENTIFICATIE,
  gw.woonplaatscode ,
w.woonplaatsnaam,
gw.gemeentenaam,
gw.gemeentecode,
gw.provincienaam,
gw.provinciecode,
gw.provincieafkorting,
a.alias woonplaatsaliassen,
'BAG' bron,
w.geovlak geometrie_rd
from bag_wpl_actueelbestaand w join bag_gem_wpl_act_bst gw  on (w.identificatie=gw.woonplaatscode)
     left outer join bag_woonplaats_alias a on (gw.woonplaatscode = a.identificatie);


--------------------------------------------------------
--  DDL for View SUFFIX_AFKORTINGEN
--------------------------------------------------------

 CREATE TABLE BAG.SUFFIX_AFK 
   (	ID numeric, 
	SUFFIX_VOLLEDIG varchar(64 ), 
	SUFFIX_AFKORTING varchar(32 )
   ) ;

Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('1','straat$','str');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('2','weg$','wg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('3','pad$','pd');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('4','park$','prk');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('5','dijk$','dk');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('6','bungalowpark$','bglwprk');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('7','boulevard$','blvd');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('8','dreef$','dr');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('9','drift$','dr');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('10','dwarsstraat$','dwstr');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('11','dwarsweg$','dwwg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('12','gracht$','gr');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('13','haven$','hvn');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('14','kade$','kd');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('15','kanaal$','kan');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('16','laan$','ln');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('17','laantje$','ln');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('18','leane$','ln');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('19','loane$','ln');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('20','plaats$','plts');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('21','plantsoen$','plnts');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('22','plein$','pln');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('23','polder$','pldr');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('24','polderdijk$','pldrdk');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('25','polderweg$','pldrwg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('26','singel$','sngl');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('27','steech$','stg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('28','steeg$','stg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('29','straatje$','str');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('30','straatweg$','strwg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('31','strjitte$','str');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('32','voetpad$','vtpd');

Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('101','str$','straat');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('102','wg$','weg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('103','pd$','pad');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('104','prk$','park');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('105','dk$','dijk');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('106','bglwprk$','bungalowpark');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('107','blvd$','boulevard');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('108','dr$','dreef');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('110','dwstr$','dwarsstraat');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('111','dwwg$','dwarsweg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('112','gr$','gracht');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('113','hvn$','haven');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('114','kd$','kade');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('115','kan$','kanaal');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('116','ln$','laan');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('120','plts$','plaats');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('121','plnts$','plantsoen');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('122','pln$','plein');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('123','pldr$','polder');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('124','pldrdk$','polderdijk');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('125','pldrwg$','polderweg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('126','sngl$','singel');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('128','stg$','steeg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('130','strwg$','straatweg');
Insert into BAG.SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('132','vtpd$','voetpad');



--------------------------------------------------------
--  DML for all spatial indexes
--------------------------------------------------------
/*delete from user_sdo_geom_metadata;

insert into user_sdo_geom_metadata values ('BAG_ADONEVENADRES','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_ADRESSEN','GEOMETRIE_RD', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_GEMEENTEN','GEOMETRIE_RD', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_LIGPLAATS','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_LIG_ACTUEEL','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_LIG_ACTUEELBESTAAND','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_MV_ADRES','GEOMETRIE_RD', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_PAND','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_PANDEN','GEOMETRIE_RD', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_PAND_BIJ_ADRES','GEOMETRIE_RD', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_PND_ACTUEEL','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_PND_ACTUEELBESTAAND','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_STANDPLAATS','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_STA_ACTUEEL','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_STA_ACTUEELBESTAAND','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_VBO_ACTUEEL','GEOPUNT', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_VBO_ACTUEEL','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_VBO_ACTUEELBESTAAND','GEOPUNT', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_VBO_ACTUEELBESTAAND','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_VERBLIJFSOBJECT','GEOPUNT', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_VERBLIJFSOBJECT','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_WOONPLAATS','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_WOONPLAATSEN','GEOMETRIE_RD', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_WPL_ACTUEEL','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('BAG_WPL_ACTUEELBESTAAND','GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('GBA_BAG_GEM_WPL','BAG_WPL_GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('GBA_BAG_GEM_WPL_ACT_BST','BAG_WPL_GEOVLAK', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('GEMEENTE','GEOM', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);
insert into user_sdo_geom_metadata values ('PROVINCIE','GEOM', sdo_dim_array(sdo_dim_element('X', 0, 300000, 0.05),sdo_dim_element('Y', 280000, 625000, 0.05)), 28992);

commit;
*/
--------------------------------------------------------
--  DDL for Index BAG_ADA_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_ADA_IDX1 ON BAG_ADONEVENADRES (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_LIG_IDX0 ON BAG_LIGPLAATS (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
  ;
--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_LIG_IDX1 ON BAG_LIGPLAATS (HOOFDADRES) 
  ;
--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX2
--------------------------------------------------------

  CREATE INDEX BAG_LIG_IDX2 ON BAG_LIGPLAATS (IDENTIFICATIE) 
  ;
--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX3
--------------------------------------------------------

  CREATE INDEX BAG_LIG_IDX3 ON BAG_LIGPLAATS (GID) 
  ;
--------------------------------------------------------
--  DDL for Index BAG_LIGPLAATS_GEOVLAK_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_LIGPLAATS_GEOVLAK_SPIX ON BAG_LIGPLAATS 
   USING GIST (GEOVLAK)  ;
--------------------------------------------------------
--  DDL for Index BAG_MV_ADRES_ADOID
--------------------------------------------------------

  CREATE INDEX BAG_MV_ADRES_ADOID ON BAG_MV_ADRES (ADRESSEERBAAROBJECT_ID) 
  ;
--------------------------------------------------------
--  DDL for Index BAG_MV_ADRES_GEOM_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_MV_ADRES_GEOM_SPIX ON BAG_MV_ADRES 
   USING GIST (GEOMETRIE_RD)  ;
--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_NUM_IDX0 ON BAG_NUMMERAANDUIDING (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_NUM_IDX1 ON BAG_NUMMERAANDUIDING (IDENTIFICATIE) 
   ;
--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX2
--------------------------------------------------------

  CREATE INDEX BAG_NUM_IDX2 ON BAG_NUMMERAANDUIDING (NUMMERAANDUIDINGSTATUS) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX3
--------------------------------------------------------

  CREATE INDEX BAG_NUM_IDX3 ON BAG_NUMMERAANDUIDING (EINDDATUMTIJDVAKGELDIGHEID) 
   ;
--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX4
--------------------------------------------------------

  CREATE INDEX BAG_NUM_IDX4 ON BAG_NUMMERAANDUIDING (TYPEADRESSEERBAAROBJECT) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX5
--------------------------------------------------------

  CREATE INDEX BAG_NUM_IDX5 ON BAG_NUMMERAANDUIDING (GID) 
   ;
--------------------------------------------------------
--  DDL for Index BAG_OPR_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_OPR_IDX0 ON BAG_OPENBARERUIMTE (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_OPR_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_OPR_IDX1 ON BAG_OPENBARERUIMTE (IDENTIFICATIE) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_OPR_IDX2
--------------------------------------------------------

  CREATE INDEX BAG_OPR_IDX2 ON BAG_OPENBARERUIMTE (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_PAND_GEOVLAK_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_PAND_GEOVLAK_SPIX ON BAG_PAND  
   USING GIST (GEOVLAK) ;
--------------------------------------------------------
--  DDL for Index BAG_PND_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_PND_IDX0 ON BAG_PAND (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_PND_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_PND_IDX1 ON BAG_PAND (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_STA_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_STA_IDX0 ON BAG_STANDPLAATS (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_STA_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_STA_IDX1 ON BAG_STANDPLAATS (HOOFDADRES) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_STA_IDX2
--------------------------------------------------------

  CREATE INDEX BAG_STA_IDX2 ON BAG_STANDPLAATS (IDENTIFICATIE) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_STA_IDX3
--------------------------------------------------------

  CREATE INDEX BAG_STA_IDX3 ON BAG_STANDPLAATS (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_STANDPLAATS_GEOVLAK_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_STANDPLAATS_GEOVLAK_SPIX ON BAG_STANDPLAATS  
   USING GIST (GEOVLAK) ;
--------------------------------------------------------
--  DDL for Index BAG_VBOGEBRUIKSDOEL_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_VBOGEBRUIKSDOEL_IDX0 ON BAG_VBOGEBRUIKSDOEL (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, GEBRUIKSDOELVERBLIJFSOBJECT) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_VBOGEBRUIKSDOEL_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_VBOGEBRUIKSDOEL_IDX1 ON BAG_VBOGEBRUIKSDOEL (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_VBO_GEOPUNT_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_VBO_GEOPUNT_SPIX ON BAG_VERBLIJFSOBJECT  
   USING GIST (GEOPUNT) ;
--------------------------------------------------------
--  DDL for Index BAG_VBO_GEOVLAK_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_VBO_GEOVLAK_SPIX ON BAG_VERBLIJFSOBJECT 
   USING GIST (GEOVLAK) ;
--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_VBO_IDX0 ON BAG_VERBLIJFSOBJECT (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_VBO_IDX1 ON BAG_VERBLIJFSOBJECT (HOOFDADRES) 
     ;
--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX2
--------------------------------------------------------

  CREATE INDEX BAG_VBO_IDX2 ON BAG_VERBLIJFSOBJECT (IDENTIFICATIE) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX3
--------------------------------------------------------

  CREATE INDEX BAG_VBO_IDX3 ON BAG_VERBLIJFSOBJECT (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_VBOPAND_IDX0
--------------------------------------------------------

  CREATE INDEX BAG_VBOPAND_IDX0 ON BAG_VBOPAND (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, GERELATEERDPAND) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_VBOPAND_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_VBOPAND_IDX1 ON BAG_VBOPAND (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_WOONPLAATS_ALIAS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX BAG_WOONPLAATS_ALIAS_PK ON BAG_WOONPLAATS_ALIAS (ID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_WOONPLAATS_GEOVLAK_SPIX
--------------------------------------------------------

  CREATE INDEX BAG_WOONPLAATS_GEOVLAK_SPIX ON BAG_WOONPLAATS  
   USING GIST (GEOVLAK) ;
--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX1
--------------------------------------------------------

  CREATE INDEX BAG_WPL_IDX1 ON BAG_WOONPLAATS (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX2
--------------------------------------------------------

  CREATE INDEX BAG_WPL_IDX2 ON BAG_WOONPLAATS (IDENTIFICATIE) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX3
--------------------------------------------------------

  CREATE INDEX BAG_WPL_IDX3 ON BAG_WOONPLAATS (GID) 
    ;
--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX4
--------------------------------------------------------

  CREATE INDEX BAG_WPL_IDX4 ON BAG_WOONPLAATS (WOONPLAATSNAAM) 
    ;
--------------------------------------------------------
--  DDL for Index GEMEENTE_SPIDX
--------------------------------------------------------

  CREATE INDEX GEMEENTE_SPIDX ON GEMEENTE  
   USING GIST (GEOM) ;
   
-- DDL voor index gemeente_code
create index gemeente_code on gemeente(code);
    
   
--------------------------------------------------------
--  DDL for Index PROVINCIE_SPIDX
--------------------------------------------------------
  create index provincie_spidx on provincie  
   USING GIST (GEOM) ;
--------------------------------------------------------
--  DDL for Index INDEX1
--------------------------------------------------------

  CREATE INDEX INDEX1 ON BAG_MV_ADRES (TYPEADRESSEERBAAROBJECT) 
    ;
--------------------------------------------------------
--  DDL for Index SYS_C0010535
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C0010535 ON GBA_T33_ALIAS (ID) 
    ;

-- extra indexen
create index gba_t33_gemeentecode on gba_t33(gemeentecode);

create index bag_gem_wpl_gemeentecode on bag_gemeente_woonplaats(gemeentecode);

create index bag_gem_wpl_wplcode on bag_gemeente_woonplaats(woonplaatscode);

    
--------------------------------------------------------
--  Constraints for Table BAG_ADONEVENADRES
--------------------------------------------------------
/*
  ALTER TABLE BAG_ADONEVENADRES ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_LIGPLAATS
--------------------------------------------------------
/*
  ALTER TABLE BAG_LIGPLAATS ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_LIGPLAATS ADD CHECK (officieel in ('N','J')) DISABLE;
  ALTER TABLE BAG_LIGPLAATS ADD CHECK (inonderzoek in ('N','J')) DISABLE;
  ALTER TABLE BAG_LIGPLAATS ADD CHECK (ligplaatsStatus in (
                                        'Plaats aangewezen',
                                        'Plaats ingetrokken')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_MV_ADRES
--------------------------------------------------------
-- ALTER TABLE BAG_MV_ADRES ADD CONSTRAINT BAG_MV_ADRES_PK PRIMARY KEY (ADRESSEERBAAROBJECT_ID);
-- dit leverde problemen op met nieuwe BAG levering van 1 januari 2015 





--------------------------------------------------------
--  Constraints for Table BAG_NUMMERAANDUIDING
--------------------------------------------------------
/*
  ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (officieel in ('N','J')) DISABLE;
  ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (inonderzoek in ('N','J')) DISABLE;
  ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (typeAdresseerbaarObject in ('Verblijfsobject',
                                                                            'Standplaats',
                                                                            'Ligplaats')) DISABLE;
  ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (nummeraanduidingStatus in ('Naamgeving uitgegeven', 'Naamgeving ingetrokken')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_OPENBARERUIMTE
--------------------------------------------------------
/*
  ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (officieel in ('N','J')) DISABLE;
  ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (inonderzoek in ('N','J')) DISABLE;
  ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (openbareruimtestatus in ('Naamgeving uitgegeven', 'Naamgeving ingetrokken')) DISABLE;
  ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (openbareruimtetype in ('Weg',
                                                                      'Water',
                                                                      'Spoorbaan',
                                                                      'Terrein',
                                                                      'Kunstwerk',
                                                                      'Landschappelijk gebied',
                                                                      'Administratief gebied')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_PAND
--------------------------------------------------------
/*
  ALTER TABLE BAG_PAND ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_PAND ADD CHECK (officieel in ('N','J')) DISABLE;
  ALTER TABLE BAG_PAND ADD CHECK (inonderzoek in ('N','J')) DISABLE;
  ALTER TABLE BAG_PAND ADD CHECK (pandStatus in ('Bouwvergunning verleend',
                                                  'Niet gerealiseerd pand',
                                                  'Bouw gestart',
                                                  'Pand in gebruik (niet ingemeten)',
                                                  'Pand in gebruik',
                                                  'Sloopvergunning verleend',
                                                  'Pand gesloopt',
                                                  'Pand buiten gebruik')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_STANDPLAATS
--------------------------------------------------------
/*
  ALTER TABLE BAG_STANDPLAATS ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_STANDPLAATS ADD CHECK (officieel in ('N','J')) DISABLE;
  ALTER TABLE BAG_STANDPLAATS ADD CHECK (inonderzoek in ('N','J')) DISABLE;
  ALTER TABLE BAG_STANDPLAATS ADD CHECK (standplaatsStatus in (
                                        'Plaats aangewezen',
                                        'Plaats ingetrokken')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_VBOGEBRUIKSDOEL
--------------------------------------------------------
/*
  ALTER TABLE BAG_VBOGEBRUIKSDOEL ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_VBOGEBRUIKSDOEL ADD CHECK (gebruiksdoelVerblijfsobject in (
                                                    'woonfunctie',
                                                    'bijeenkomstfunctie',
                                                    'celfunctie',
                                                    'gezondheidszorgfunctie',
                                                    'industriefunctie',
                                                    'kantoorfunctie',
                                                    'logiesfunctie',
                                                    'onderwijsfunctie',
                                                    'sportfunctie',
                                                    'winkelfunctie',
                                                    'overige gebruiksfunctie')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_VBOPAND
--------------------------------------------------------
/*
  ALTER TABLE BAG_VBOPAND ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_VERBLIJFSOBJECT
--------------------------------------------------------
/*
  ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
  ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (officieel in ('N','J')) DISABLE;
  ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (inonderzoek in ('N','J')) DISABLE;
  ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (verblijfsobjectStatus in (
                                              'Verblijfsobject gevormd',
                                              'Niet gerealiseerd verblijfsobject',
                                              'Verblijfsobject in gebruik (niet ingemeten)',
                                              'Verblijfsobject in gebruik',
                                              'Verblijfsobject ingetrokken',
                                              'Verblijfsobject buiten gebruik')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_WOONPLAATS
--------------------------------------------------------
/*
  ALTER TABLE BAG_WOONPLAATS ADD CHECK (aanduidingRecordInactief in ('N','J')) ENABLE;
  ALTER TABLE BAG_WOONPLAATS ADD CHECK (officieel in ('N','J')) ENABLE;
  ALTER TABLE BAG_WOONPLAATS ADD CHECK (inonderzoek in ('N','J')) ENABLE;
  ALTER TABLE BAG_WOONPLAATS ADD CHECK (woonplaatsstatus in ('Woonplaats aangewezen', 'Woonplaats ingetrokken')) ENABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_WOONPLAATS_ALIAS
--------------------------------------------------------
/*
  ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (ID NOT NULL ENABLE);
  ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (ALIAS NOT NULL ENABLE);
  ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (DATUM_MUTATIE NOT NULL ENABLE);
  ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (IDENTIFICATIE NOT NULL ENABLE);
  ALTER TABLE BAG_WOONPLAATS_ALIAS ADD CONSTRAINT BAG_WOONPLAATS_ALIAS_PK PRIMARY KEY (ID)
     ;
*/
--------------------------------------------------------
--  Constraints for Table GBA_T33_ALIAS
--------------------------------------------------------
/*
  ALTER TABLE GBA_T33_ALIAS ADD PRIMARY KEY (ID)
     ;
*/
	 
--------------------------------------------------------
--  DDL for Function SDO_WKT
--------------------------------------------------------
/*
 create or replace function sdo_wkt (p_geometry in sdo_geometry,p_keer    IN numeric)
return varchar as
  v_wkt varchar(4000);
begin
  if (p_geometry is null) then
  return null;
  end if;
  
  if (p_keer=0) then
  -- niet omdraaien
  v_wkt:='POINT ('||p_geometry.sdo_point.x||' '||p_geometry.sdo_point.y||')';
  else
  -- wel omdraaien
  v_wkt:='POINT ('||p_geometry.sdo_point.y||' '||p_geometry.sdo_point.x||')';
  end if;
  return v_wkt;
end sdo_wkt;
/
*/
--------------------------------------------------------
--  DDL for Function STREET_ABV	
--------------------------------------------------------
/*
create or replace function street_abv (p_street IN varchar)
return varchar
as
 type word_type
     is table of varchar(32) index by varchar(64);
 v_words  word_type;    
 v_street varchar(64);
 v_woord  varchar(64);
 i varchar(64);
 cursor s_a is select suffix_volledig, suffix_afkorting from suffix_afk order by id;
begin
 v_street := p_street;
 for rec in s_a loop
   v_words(rec.suffix_volledig) := rec.suffix_afkorting;
 end loop;
 
 i := v_words.first;

 while i is not null loop
  v_woord := i||'$|'||i||'([ -])';
  if (regexp_like(p_street, v_woord )) then
   v_street := regexp_replace (v_street, v_woord, v_words(i)||'\1');
  end if;
  i := v_words.next(i);
 end loop;
return v_street;
end street_abv;
/
*/


--------------------------------------------------------
--  DDL for SEQUENCE LOG_SEQ
--------------------------------------------------------
create sequence LOG_SEQ increment by 1
;

create sequence bron_seq increment by 1
;

create sequence bag_gemeente_woonplaats_seq increment by 1
;

create sequence bag_openbareruimte_seq increment by 1
;

create sequence bag_nummeraanduiding_seq increment by 1
;

create sequence bag_woonplaats_seq increment by 1
;

create sequence bag_verblijfsobject_seq increment by 1
;

create sequence bag_vbogebruiksdoel_seq increment by 1
;

create sequence bag_ligplaats_seq increment by 1
;

create sequence bag_standplaats_seq increment by 1
;

--------------------------------------------------------
--  DDL for TYPES
--------------------------------------------------------
/*
create or replace type varchar_ntt is table of varchar(4000)
/
*/


-- DDL for BAG_LOG
CREATE TABLE BAG_LOG 
         ( ID              numeric
         , MESSAGE_TYPE    varchar(10 )
         , niveau          numeric
         , OMSCHRIJVING    varchar(4000 ))
		 ;


comment on materialized view BAG_ADONEVENADRES is 'nevenadressen van adresseerbare objecten (ligplaatsen, standplaatsen en verblijfsobjecten). Inclusief historie en status';
comment on materialized view BAG_GEMEENTE_WOONPLAATS is 'combinatie van woonplaatsen en gemeenten, alleen codes, geen namen. Inclusief historie en status';
comment on materialized view bag_ligplaats is 'liplaatsen. Inclusief historie en status';
comment on table BAG_LOG is 'logging tabel voor het laden en verwerken van bagactueel gegevens.';
comment on materialized view BAG_MV_ADRES is 'Alle bag adressen, wordt opgebouwd uit een aantal queries';
comment on materialized view BAG_NUMMERAANDUIDING is 'nummeraanduidingen. Inclusief historie en status';
comment on materialized view BAG_OPENBARERUIMTE is 'Openbareruimtes (wegen, parken, gebieden, etc). Inclusief historie en status';
comment on materialized view BAG_PAND is 'Panden. Inclusief historie en status';
comment on materialized view BAG_STANDPLAATS is 'Standplaatsen. Inclusief historie en status';
comment on materialized view BAG_VBOGEBRUIKSDOEL is 'Gebruiksdoel van de verblijfsobjecten. Inclusief historie en status';
comment on materialized view BAG_VBOPAND is 'COmbinatei verblijfsobject en pand. Inclusief historie en status';
comment on materialized view BAG_VERBLIJFSOBJECT is 'Verblijfsobjecten. Inclusief historie en status';
comment on materialized view BAG_WOONPLAATS is 'Woonplaatsen. Inclusief historie en status';
comment on table BAG_WOONPLAATS_ALIAS is 'Woonplaatsaliassen. Toegevoegd voor LS2.0. Wordt alleen gevuld voor woonplaatsen die een alias hebben.';
comment on table GEMEENTE is 'Tabel wordt gevuld met geaggregeerde woonplaats op actuele t33 gemeentenamen door ETL_BAG';
comment on table PROVINCIE is 'Provincies, wordt gevuld vanuit pdok.provincies door ETL_PDOK. Wordt gebruikt in bag_gemeente_woonplaats';
