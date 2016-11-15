set search_path to locatieserver, public;


--------------------------------------------------------
--  File created - 4 oct 2016
--  Author: Thomas Hoogerwerf
--  Last update: 25 oct 2016   
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Drop Views
--------------------------------------------------------

drop view if exists BAG_WOONPLAATSEN cascade;
drop view if exists BAG_GEMEENTEN;
drop view if exists BAG_PANDEN;
-- niet nodig vanwege de cascade bij bag_woonplaatsen: drop view if exists BAG_PAND_BIJ_ADRES;
-- niet nodig vanwege de cascade bij bag_woonplaatsen: drop view if exists BAG_ADRESSEN;

drop view if exists BAG_OPR_ACTUEELBESTAAND;
drop view if exists BAG_OPR_ACTUEEL;
drop view if exists BAG_NUM_ACTUEELBESTAAND;
drop view if exists BAG_NUM_ACTUEEL;
drop view if exists BAG_GEM_WPL_ACT_BST;
drop view if exists BAG_GEM_WPL_ACT;
drop view if exists GBA_GEMEENTEACTUEEL;
drop view if exists GBA_BAG_GEM_WPL_ACT_BST;
drop view if exists GBA_BAG_GEM_WPL;
drop view if exists BAG_WPL_ACTUEELBESTAAND;
drop view if exists BAG_WPL_ACTUEEL;
drop view if exists BAG_VPA_ACTUEEL;
drop view if exists BAG_VGD_ACTUEEL;
drop view if exists BAG_VBO_ACTUEELBESTAAND;
drop view if exists BAG_VBO_ACTUEEL;
drop view if exists BAG_LIG_ACTUEELBESTAAND;
drop view if exists BAG_LIG_ACTUEEL;
drop view if exists BAG_STA_ACTUEELBESTAAND;
drop view if exists BAG_STA_ACTUEEL;
drop view if exists BAG_PND_ACTUEELBESTAAND;
drop view if exists BAG_PND_ACTUEEL;


--------------------------------------------------------
--  DDL for DROP Tables
--------------------------------------------------------
drop table if exists GBA_T33_ALIAS ;
drop table if exists GBA_T33;
drop table if exists SUFFIX_AFK;
drop table if exists GEMEENTE;
--wsl drop table if exists GEMEENTE_WOONPLAATS;
drop table if exists PROVINCIE;
drop table if exists BAG_ADRES;
drop table if exists BAG_WOONPLAATS_ALIAS;


--------------------------------------------------------
--  DDL for DROP tables
--------------------------------------------------------

drop table if exists BAG_ADONEVENADRES;
drop table if exists BAG_LIGPLAATS;
drop table if exists BAG_NUMMERAANDUIDING;
drop table if exists BAG_OPENBARERUIMTE;
drop table if exists BAG_PAND;
drop table if exists BAG_STANDPLAATS;
drop table if exists BAG_VBOGEBRUIKSDOEL;
drop table if exists BAG_VBOPAND;
drop table if exists BAG_WOONPLAATS;
drop table if exists BAG_VERBLIJFSOBJECT;
drop table if exists BAG_GEMEENTE_WOONPLAATS;

-- niet nodig vanwege de cascade bij bag_woonplaatsen: drop materialized view if exists BAG_MV_ADRES;
-- geldt ook voor MV BAG_POSTCODES en BAG_OPENBARERUIMTES
drop type gebruiksdoelverblijfsobject;
drop type gemeentewoonplaatsstatus;
drop type ligplaatsstatus;
drop type nummeraanduidingstatus;
drop type openbareruimtestatus;
drop type openbareruimtetype;
drop type pandstatus;
drop type postcode;
drop type standplaatsstatus;
drop type typeadresseerbaarobject;
drop type verblijfsobjectstatus;
drop type woonplaatsstatus;
-- types
CREATE TYPE gebruiksdoelverblijfsobject AS ENUM
    ('woonfunctie', 'bijeenkomstfunctie', 'celfunctie', 
	 'gezondheidszorgfunctie', 'industriefunctie', 'kantoorfunctie', 
	 'logiesfunctie', 'onderwijsfunctie', 'sportfunctie', 
	 'winkelfunctie', 'overige gebruiksfunctie');

	
	
-- Type: gemeentewoonplaatsstatus

-- DROP TYPE gemeentewoonplaatsstatus;

CREATE TYPE gemeentewoonplaatsstatus AS ENUM
    ('voorlopig', 'definitief');


	
-- Type: ligplaatsstatus

-- DROP TYPE ligplaatsstatus;

CREATE TYPE ligplaatsstatus AS ENUM
    ('Plaats aangewezen', 'Plaats ingetrokken');


-- Type: nummeraanduidingstatus

-- DROP TYPE nummeraanduidingstatus;

CREATE TYPE nummeraanduidingstatus AS ENUM
    ('Naamgeving uitgegeven', 'Naamgeving ingetrokken');


-- Type: openbareruimtestatus

-- DROP TYPE openbareruimtestatus;

CREATE TYPE openbareruimtestatus AS ENUM
    ('Naamgeving uitgegeven', 'Naamgeving ingetrokken');


-- Type: openbareruimtetype

-- DROP TYPE openbareruimtetype;

CREATE TYPE openbareruimtetype AS ENUM
    ('Weg', 'Water', 'Spoorbaan', 'Terrein', 'Kunstwerk', 'Landschappelijk gebied', 'Administratief gebied');


-- Type: pandstatus

-- DROP TYPE pandstatus;

CREATE TYPE pandstatus AS ENUM
    ('Bouwvergunning verleend', 'Niet gerealiseerd pand', 'Bouw gestart', 'Pand in gebruik (niet ingemeten)', 'Pand in gebruik', 'Sloopvergunning verleend', 'Pand gesloopt', 'Pand buiten gebruik');

-- Type: postcode

-- DROP TYPE postcode;

CREATE TYPE postcode AS
(
	numerieke integer,
	alfanumerieke character varying(2)
);

-- Type: standplaatsstatus

-- DROP TYPE standplaatsstatus;

CREATE TYPE standplaatsstatus AS ENUM
    ('Plaats aangewezen', 'Plaats ingetrokken');


-- Type: typeadresseerbaarobject

-- DROP TYPE typeadresseerbaarobject;

CREATE TYPE typeadresseerbaarobject AS ENUM
    ('Verblijfsobject', 'Standplaats', 'Ligplaats');


-- Type: verblijfsobjectstatus

-- DROP TYPE verblijfsobjectstatus;

CREATE TYPE verblijfsobjectstatus AS ENUM
    ('Verblijfsobject gevormd', 'Niet gerealiseerd verblijfsobject', 'Verblijfsobject in gebruik (niet ingemeten)', 'Verblijfsobject in gebruik', 'Verblijfsobject ingetrokken', 'Verblijfsobject buiten gebruik');


-- Type: woonplaatsstatus

-- DROP TYPE woonplaatsstatus;

CREATE TYPE woonplaatsstatus AS ENUM
    ('Woonplaats aangewezen', 'Woonplaats ingetrokken');




-------------------------------------------------------
--  DDL for MV BAG_ADONEVENADRES
--------------------------------------------------------
create table bag_adonevenadres
as select * from bag.adresseerbaarobjectnevenadres where 1=2;
 --actueelbestaand;

--------------------------------------------------------
--  DDL for MV BAG_LIGPLAATS
--------------------------------------------------------
--create table bag_ligplaats 
--as select * from bag.ligplaats where 1=2; --actueelbestaand;

-- Table: ligplaats

-- DROP TABLE bag_ligplaats;

CREATE TABLE bag_ligplaats
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    officieel boolean,
    inonderzoek boolean,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    documentnummer character varying(20) COLLATE pg_catalog."default",
    documentdatum timestamp without time zone,
    hoofdadres numeric(16),
    ligplaatsstatus "ligplaatsstatus",
    actualiteitsdatum timestamp without time zone,
    geom_valid boolean,
    geovlak geometry(multipolygon, 28992),
    CONSTRAINT ligplaats_pkey PRIMARY KEY (gid)
)
;

-- Index: ligplaats_geovlak_sidx

-- DROP INDEX ligplaats_geovlak_sidx;

CREATE INDEX ligplaats_geovlak_sidx
    ON bag_ligplaats USING gist
    (geovlak)
    ;

-- Index: ligplaats_key

-- DROP INDEX ligplaats_key;

CREATE INDEX ligplaats_key
    ON bag_ligplaats USING btree
    (begindatumtijdvakgeldigheid, aanduidingrecordcorrectie, aanduidingrecordinactief, identificatie)
    ;

--------------------------------------------------------
--  DDL for Table BAG_NUMMERAANDUIDING
--------------------------------------------------------
--create table bag_nummeraanduiding
--as select * from bag.nummeraanduiding where 1=2; --actueelbestaand;
-- Table: nummeraanduiding

-- DROP TABLE bag_nummeraanduiding;

CREATE TABLE bag_nummeraanduiding
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    officieel boolean,
    inonderzoek boolean,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    documentnummer character varying(20) COLLATE pg_catalog."default",
    documentdatum timestamp without time zone,
    huisnummer numeric(5),
    huisletter character varying(1) COLLATE pg_catalog."default",
    huisnummertoevoeging character varying(4) COLLATE pg_catalog."default",
    postcode character varying(6) COLLATE pg_catalog."default",
    nummeraanduidingstatus "nummeraanduidingstatus",
    typeadresseerbaarobject "typeadresseerbaarobject",
    gerelateerdeopenbareruimte numeric(16),
    gerelateerdewoonplaats numeric(16),
    actualiteitsdatum timestamp without time zone,
    CONSTRAINT nummeraanduiding_pkey PRIMARY KEY (gid)
)
;


-- Index: nummeraanduiding_key

-- DROP INDEX nummeraanduiding_key;

CREATE INDEX nummeraanduiding_key
    ON bag_nummeraanduiding USING btree
    (begindatumtijdvakgeldigheid, aanduidingrecordcorrectie, aanduidingrecordinactief, identificatie)
    ;

-- Index: nummeraanduiding_postcode

-- DROP INDEX nummeraanduiding_postcode;

CREATE INDEX nummeraanduiding_postcode
    ON bag_nummeraanduiding USING btree
    (postcode COLLATE pg_catalog."default")
    ;
	
--------------------------------------------------------
--  DDL for Table BAG_OPENBARERUIMTE
--------------------------------------------------------
--create table bag_openbareruimte
--as select * from bag.openbareruimte where 1=2; --actueelbestaand;

-- Table: openbareruimte

-- DROP TABLE bag_openbareruimte;

CREATE TABLE bag_openbareruimte
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    officieel boolean,
    inonderzoek boolean,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    documentnummer character varying(20) COLLATE pg_catalog."default",
    documentdatum timestamp without time zone,
    openbareruimtenaam character varying(80) COLLATE pg_catalog."default",
    openbareruimtestatus "openbareruimtestatus",
    openbareruimtetype "openbareruimtetype",
    gerelateerdewoonplaats numeric(16),
    verkorteopenbareruimtenaam character varying(80) COLLATE pg_catalog."default",
    actualiteitsdatum timestamp without time zone,
    CONSTRAINT openbareruimte_pkey PRIMARY KEY (gid)
)
;


-- Index: openbareruimte_key

-- DROP INDEX openbareruimte_key;

CREATE INDEX openbareruimte_key
    ON bag_openbareruimte USING btree
    (begindatumtijdvakgeldigheid, aanduidingrecordcorrectie, aanduidingrecordinactief, identificatie)
    ;

-- Index: openbareruimte_naam

-- DROP INDEX openbareruimte_naam;

CREATE INDEX openbareruimte_naam
    ON bag_openbareruimte USING btree
    (openbareruimtenaam COLLATE pg_catalog."default")
    ;


--------------------------------------------------------
--  DDL for Table BAG_PAND
--------------------------------------------------------
--create table bag_pand
--as select * from bag.pand where 1=2; --actueelbestaand;

-- Table: pand

-- DROP TABLE bag_pand;

CREATE TABLE bag_pand
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    officieel boolean,
    inonderzoek boolean,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    documentnummer character varying(20) COLLATE pg_catalog."default",
    documentdatum timestamp without time zone,
    pandstatus "pandstatus",
    bouwjaar numeric(4),
    geom_valid boolean,
    actualiteitsdatum timestamp without time zone,
    geovlak geometry(polygonZ, 28992),
    CONSTRAINT pand_pkey PRIMARY KEY (gid)
);


-- Index: pand_geovlak_sidx

-- DROP INDEX pand_geovlak_sidx;

CREATE INDEX pand_geovlak_sidx
    ON bag_pand USING gist
    (geovlak)
    ;

--------------------------------------------------------
--  DDL for Table BAG_STANDPLAATS
--------------------------------------------------------
--create table bag_standplaats
--as select * from bag.standplaats where 1=2; --actueelbestaand;

-- Table: standplaats

-- DROP TABLE bag_standplaats;

CREATE TABLE bag_standplaats
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    officieel boolean,
    inonderzoek boolean,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    documentnummer character varying(20) COLLATE pg_catalog."default",
    documentdatum timestamp without time zone,
    hoofdadres numeric(16),
    standplaatsstatus "standplaatsstatus",
    actualiteitsdatum timestamp without time zone,
    geom_valid boolean,
    geovlak geometry(polygonZ, 28992),
    CONSTRAINT standplaats_pkey PRIMARY KEY (gid)
)
;

--------------------------------------------------------
--  DDL for Table BAG_VBOGEBRUIKSDOEL
--------------------------------------------------------
--create table bag_vbogebruiksdoel
--as select * from bag.verblijfsobjectgebruiksdoel where 1=2;  --actueelbestaand;

-- Table: verblijfsobjectgebruiksdoel

-- DROP TABLE verblijfsobjectgebruiksdoel;

CREATE TABLE bag_vbogebruiksdoel
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    actualiteitsdatum timestamp without time zone,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    gebruiksdoelverblijfsobject "gebruiksdoelverblijfsobject",
    CONSTRAINT verblijfsobjectgebruiksdoel_pkey PRIMARY KEY (gid)
)
;


--------------------------------------------------------
--  DDL for Table BAG_VBOPAND
--------------------------------------------------------
create table bag_vbopand
as select * from bag.verblijfsobjectpand where 1=2;  --actueelbestaand;

--------------------------------------------------------
--  DDL for Table BAG_WOONPLAATS
--------------------------------------------------------
--create table bag_woonplaats
--as select * from bag.woonplaats where 1=2; --actueelbestaand;

-- Table: woonplaats

-- DROP TABLE bag_woonplaats;

CREATE TABLE bag_woonplaats
(
    gid integer NOT NULL ,
    identificatie numeric(16),
    aanduidingrecordinactief boolean,
    aanduidingrecordcorrectie integer,
    officieel boolean,
    inonderzoek boolean,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    documentnummer character varying(20) COLLATE pg_catalog."default",
    documentdatum timestamp without time zone,
    woonplaatsnaam character varying(80) COLLATE pg_catalog."default",
    woonplaatsstatus "woonplaatsstatus",
    actualiteitsdatum timestamp without time zone,
    geom_valid boolean,
    geovlak geometry(multipolygon, 28992),
    CONSTRAINT woonplaats_pkey PRIMARY KEY (gid)
)
;



--------------------------------------------------------
--  DDL for Table BAG_VERBLIJFSOBJECT
--------------------------------------------------------
create table bag_verblijfsobject
as select * from bag.verblijfsobject where 1=2; --actueelbestaand;

--------------------------------------------------------
--  DDL for BAG_GEMEENTE_WOONPLAATS
--------------------------------------------------------
--create table bag_gemeente_woonplaats 
--as select * from bag.gemeente_woonplaats where 1=2; --actueelbestaand;


-- Table: bag_gemeente_woonplaats

-- DROP TABLE bag_gemeente_woonplaats;

CREATE TABLE bag_gemeente_woonplaats
(
    gid integer NOT NULL ,
    begindatumtijdvakgeldigheid timestamp without time zone,
    einddatumtijdvakgeldigheid timestamp without time zone,
    woonplaatscode numeric(4),
    gemeentecode numeric(4),
    status "gemeentewoonplaatsstatus",
    CONSTRAINT gemeente_woonplaats_pkey PRIMARY KEY (gid)
);


-- Index: gem_wpl_woonplaatscode_idx

-- DROP INDEX gem_wpl_woonplaatscode_idx;

CREATE INDEX gem_wpl_woonplaatscode_idx
    ON bag_gemeente_woonplaats USING btree
    (woonplaatscode)
    ;


--------------------------------------------------------
--  DDL for PROVINCIE
--    ook overnemen van BAG
--------------------------------------------------------
create table provincie 
as select provincienaam, geovlak as geom from bag.provincie where 1=2; 

--------------------------------------------------------
--  DDL for PROVINCIE
--    ook overnemen van BAG
--------------------------------------------------------
create table gemeente 
as select gemeentecode as code,
          gemeentenaam,
          geovlak as geom 
   from bag.gemeente where 1=2; 

--------------------------------------------------------
--  DDL voor alle extra tabellen die nodig zijn voor
--  locatieserver
--------------------------------------------------------
--  DDL for tabel GEMEENTE - vanuit BAG overnemen.
--------------------------------------------------------
/*CREATE TABLE GEMEENTE  (CODE NUMERIC(4,0), 
	GEMEENTENAAM VARCHAR(80),
	GEOM GEOMETRY (Multipolygon, 28992)  ) ;
*/
--------------------------------------------------------
--  DDL for tabel PROVINCIE - vanuit bag overnemen
--------------------------------------------------------
--CREATE TABLE PROVINCIE (PROVINCIENAAM VARCHAR(25),  GEOM GEOMETRY (MultiPolygon, 28992) );

--------------------------------------------------------
--  DDL for Table GBA_T33
--------------------------------------------------------
CREATE TABLE GBA_T33  (	ID NUMERIC(4,0), 
	GEMEENTECODE NUMERIC(4,0 ), 
	GEMEENTENAAM VARCHAR(40 ), 
	NIEUWE_CODE NUMERIC(4 ), 
	DATUMINGANG varchar(8), 
	DATUMEINDE varchar(8), 
	MUTID_BEGIN NUMERIC, 
	MUTID_WIJZIGING NUMERIC ) ;

--------------------------------------------------------
--  DDL for Table GBA_T33_ALIAS
--------------------------------------------------------
CREATE TABLE GBA_T33_ALIAS  (	ID numeric, 
	GEMEENTECODE NUMERIC(4,0 ), 
	ALIAS varchar(100 ), 
	DATUM_MUTATIE DATE ) ;
--------------------------------------------------------
--  DDL for Table BAG_WOONPLAATS_ALIAS
--------------------------------------------------------
CREATE TABLE BAG_WOONPLAATS_ALIAS  (	ID NUMERIC, 
	ALIAS VARCHAR(100), 
	DATUM_MUTATIE DATE, 
	IDENTIFICATIE NUMERIC(4) ) ;


--------------------------------------------------------
--  DDL for tabel BAG_ADRES
--    deze tabel wordt gevuld met alle hoofd- en neven
--    adressen door etl script.
--------------------------------------------------------
create table bag_adres (
SAMENSTELLING varchar(5 ), 
	ADRESOBJECTTYPEOMSCHRIJVING varchar(46 ), 
	NUM_ID NUMERIC(16 ), 
	NUM_INACTIEF BOOLEAN, 
	NUM_BEGDAT DATE, 
	TYPEADRESSEERBAAROBJECT varchar(20 ), 
	ADO_ID NUMERIC(16 ), 
	ADO_INACTIEF BOOLEAN, 
	ADO_BEGDAT DATE, 
	ADO_STATUS varchar(80 ), 
	OPR_ID NUMERIC(16 ), 
	OPR_INACTIEF BOOLEAN, 
	OPR_BEGDAT DATE, 
	WPL_ID numeric(4,0 ), 
	WPL_INACTIEF BOOLEAN, 
	WPL_BEGDAT DATE, 
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
--  DDL for tabel BAG_GEM_WPL_ACT_BST
--    deze table heeft de tabel GEMEENTE en PROVINCIES
--    nodig.
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_GEM_WPL_ACT_BST 
	(GEMEENTECODE, 
	 WOONPLAATSCODE, 
	 STATUS, 
	 BEGINDATUMTIJDVAKGELDIGHEID, 
	 EINDDATUMTIJDVAKGELDIGHEID, 
	 CODE, 
	 GEMEENTENAAM, 
	 PROVINCIENAAM, 
	 PROVINCIEAFKORTING, 
	 PROVINCIECODE) 
AS select gw.gemeentecode,
          gw.woonplaatscode, 
          gw.status, 
          gw.begindatumtijdvakgeldigheid, 
          gw.einddatumtijdvakgeldigheid, 
          g.code, 
          g.gemeentenaam, 
          p.provincienaam, 
          CASE p.provincienaam 
          		WHEN   'Overijssel'    THEN 'OV' 
          		WHEN   'Flevoland'     THEN 'FL'
          		WHEN   'Zuid-Holland'  THEN 'ZH'
	   		    WHEN   'Noord-Holland' THEN 'NH'
			    WHEN   'Noord-Brabant' THEN 'NB'
			    WHEN   'Limburg'       THEN 'LB'
			    WHEN   'Utrecht'       THEN 'UT'
			    WHEN   'Zeeland'       THEN 'ZL'
			    WHEN   'Gelderland'    THEN 'GD'
			    WHEN   'Groningen'     THEN 'GR'
			    WHEN   'Friesland'     THEN 'FR'
			    WHEN   'Drenthe'       THEN 'DR'       END  provincieafkorting,
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
	            WHEN   'Drenthe'          THEN 'PV22'      END   provinciecode
from bag_gemeente_woonplaats gw join gemeente g on (gw.gemeentecode=g.code),       
       provincie p 
where (gw.begindatumtijdvakgeldigheid < now()        
   and (gw.einddatumtijdvakgeldigheid is null or gw.einddatumtijdvakgeldigheid  > now() )
       and gw.status = 'definitief'       )
and ST_contains(p.geom, st_centroid(g.geom));



--------------------------------------------------------
--  DDL for View BAG_GEMEENTEN
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_GEMEENTEN (IDENTIFICATIE, GEMEENTECODE, GEMEENTENAAM, PROVINCIENAAM, PROVINCIEAFKORTING, PROVINCIECODE, BRON, GEOMETRIE_RD) 
AS select g.code identificatie,
g.code gemeentecode,
g.gemeentenaam,
p.provincienaam,     
CASE p.provincienaam 
                 WHEN   'Overijssel' THEN 'OV'                          
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
			     WHEN   'Drenthe' THEN 'DR'       END  provincieafkorting,
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
                 WHEN   'Drenthe'          THEN 'PV22'      END   provinciecode,
'BAG'::varchar(5) bron,
g.geom geometrie_rd
from gemeente g, provincie p
where st_contains(p.geom, st_centroid(g.geom))
;

--------------------------------------------------------
--  DDL for View BAG_GEM_WPL_ACT
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_GEM_WPL_ACT (GEMEENTECODE, WOONPLAATSCODE, STATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) 
AS SELECT gemeentecode     ,
          woonplaatscode     , 
          status     , 
          begindatumtijdvakgeldigheid     , 
          einddatumtijdvakgeldigheid  
     from bag_gemeente_woonplaats 
    where (begindatumtijdvakgeldigheid < now())        
           AND (einddatumtijdvakgeldigheid IS NULL or einddatumtijdvakgeldigheid  > now()) ;
 
--------------------------------------------------------
--  DDL for View BAG_LIG_ACTUEEL
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_LIG_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, LIGPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT GID,  
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
    WHERE ((((begindatumtijdvakgeldigheid <= now())  ) 
          AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  )))
          AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_LIG_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_LIG_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, LIGPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT ID,  
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
CREATE OR REPLACE VIEW BAG_NUM_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HUISNUMMER, HUISLETTER, HUISNUMMERTOEVOEGING, POSTCODE, NUMMERAANDUIDINGSTATUS, TYPEADRESSEERBAAROBJECT, GERELATEERDEOPENBARERUIMTE, GERELATEERDEWOONPLAATS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID)
AS SELECT GID,  
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
    WHERE ((((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  ))) 
      AND (aanduidingrecordinactief = 'N')  ;
--------------------------------------------------------
--  DDL for View BAG_NUM_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_NUM_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HUISNUMMER, HUISLETTER, HUISNUMMERTOEVOEGING, POSTCODE, NUMMERAANDUIDINGSTATUS, TYPEADRESSEERBAAROBJECT, GERELATEERDEOPENBARERUIMTE, GERELATEERDEWOONPLAATS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) 
AS SELECT ID,  
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
CREATE OR REPLACE VIEW BAG_OPR_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, OPENBARERUIMTENAAM, OPENBARERUIMTESTATUS, OPENBARERUIMTETYPE, GERELATEERDEWOONPLAATS, VERKORTEOPENBARERUIMTENAAM, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) 
AS SELECT GID,  
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
    WHERE (((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  ))
      AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_OPR_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_OPR_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, OPENBARERUIMTENAAM, OPENBARERUIMTESTATUS, OPENBARERUIMTETYPE, GERELATEERDEWOONPLAATS, VERKORTEOPENBARERUIMTENAAM, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID) 
AS SELECT ID,  
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
CREATE OR REPLACE VIEW BAG_PND_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, PANDSTATUS, BOUWJAAR, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT GID,  
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
    WHERE ((((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  )))
      AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_PND_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_PND_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, PANDSTATUS, BOUWJAAR, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT ID,  
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
      AND pandstatus             <> 'Pand gesloopt';
--------------------------------------------------------
--  DDL for View BAG_STA_ACTUEEL
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_STA_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, STANDPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT GID, 
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
    WHERE ((((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  )))
      AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_STA_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_STA_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, STANDPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT ID,  
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
CREATE OR REPLACE VIEW BAG_VBO_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, VERBLIJFSOBJECTSTATUS, OPPERVLAKTEVERBLIJFSOBJECT, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOPUNT, GEOVLAK) 
AS SELECT GID,  
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
    WHERE ((((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  )))
      AND (aanduidingrecordinactief = 'N');
--  AND ((verblijfsobject.geom_valid             IS NULL)
--  OR (verblijfsobject.geom_valid                = 't'));
--------------------------------------------------------
--  DDL for View BAG_VBO_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_VBO_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, HOOFDADRES, VERBLIJFSOBJECTSTATUS, OPPERVLAKTEVERBLIJFSOBJECT, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOPUNT, GEOVLAK) 
AS SELECT ID,  
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
CREATE OR REPLACE VIEW BAG_VGD_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEBRUIKSDOELVERBLIJFSOBJECT) 
AS SELECT GID,  
          identificatie,  
          aanduidingrecordinactief,  
          aanduidingrecordcorrectie,  
          begindatumtijdvakgeldigheid,  
          einddatumtijdvakgeldigheid,  
          gebruiksdoelverblijfsobject
     FROM bag_vbogebruiksdoel 
    WHERE (((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  ))
      AND (aanduidingrecordinactief = 'N');
-------------------------------------------------------
--  DDL for View BAG_VPA_ACTUEEL
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_VPA_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GERELATEERDPAND) 
AS SELECT GID,  
          identificatie,  
          aanduidingrecordinactief,  
          aanduidingrecordcorrectie,  
          begindatumtijdvakgeldigheid,  
          einddatumtijdvakgeldigheid,  
          gerelateerdpand
     FROM bag_vbopand 
    WHERE (((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   >= now())  )) 
      AND (aanduidingrecordinactief = 'N');

--------------------------------------------------------
--  DDL for View BAG_WPL_ACTUEEL
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_WPL_ACTUEEL (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, WOONPLAATSNAAM, WOONPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT GID,  
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
    WHERE ((((begindatumtijdvakgeldigheid <= now())  )
      AND ((einddatumtijdvakgeldigheid IS NULL) OR (einddatumtijdvakgeldigheid   > now())  )))
      AND (aanduidingrecordinactief = 'N');
--------------------------------------------------------
--  DDL for View BAG_WPL_ACTUEELBESTAAND
--------------------------------------------------------
CREATE OR REPLACE VIEW BAG_WPL_ACTUEELBESTAAND (ID, IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, OFFICIEEL, INONDERZOEK, DOCUMENTNUMMER, DOCUMENTDATUM, WOONPLAATSNAAM, WOONPLAATSSTATUS, BEGINDATUMTIJDVAKGELDIGHEID, EINDDATUMTIJDVAKGELDIGHEID, GEOVLAK) 
AS SELECT ID,  
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
CREATE OR REPLACE VIEW GBA_BAG_GEM_WPL (GBA_GEMEENTECODE, GBA_GEMEENTENAAM, GBA_DATUMINGANG, GBA_DATUMEINDE, REL_GEMEENTECODE, REL_WOONPLAATSCODE, REL_STATUS, REL_BEGINDATUMTIJDVAK, REL_EINDDATUMTIJDVAK, BAG_WOONPLAATSCODE, BAG_WOONPLAATSNAAM, BAG_WOONPLAATSSTATUS, BAG_BEGINDATUMTIJDVAK, BAG_EINDDATUMTIJDVAK, BAG_WPL_GEOVLAK) 
AS select g.gemeentecode   , 
          g.gemeentenaam   , 
          g.datumingang   , 
          g.datumeinde   , 
          gw.gemeentecode   , 
          gw.woonplaatscode   , 
          gw.status   ,
          gw.begindatumtijdvakgeldigheid   , 
          gw.einddatumtijdvakgeldigheid   , 
          w.identificatie   , 
          w.woonplaatsnaam   , 
          w.woonplaatsstatus   ,
          w.begindatumtijdvakgeldigheid   ,
          w.einddatumtijdvakgeldigheid   , 
          w.geovlak
     from bag_wpl_actueelbestaand w     
     	  join BAG_GEMEENTE_WOONPLAATS gw on (gw.woonplaatscode = w.identificatie)
     	    join gba_t33 g on (g.gemeentecode = gw.gemeentecode);
--------------------------------------------------------
--  DDL for View GBA_BAG_GEM_WPL_ACT_BST
--------------------------------------------------------
CREATE OR REPLACE VIEW GBA_BAG_GEM_WPL_ACT_BST (GBA_GEMEENTECODE, GBA_GEMEENTENAAM, GBA_DATUMINGANG, GBA_DATUMEINDE, REL_GEMEENTECODE, REL_WOONPLAATSCODE, REL_STATUS, REL_BEGINDATUMTIJDVAK, REL_EINDDATUMTIJDVAK, BAG_WOONPLAATSCODE, BAG_WOONPLAATSNAAM, BAG_WOONPLAATSSTATUS, BAG_BEGINDATUMTIJDVAK, BAG_EINDDATUMTIJDVAK, BAG_WPL_GEOVLAK) 
AS select g.gemeentecode   , 
          g.gemeentenaam   , 
          g.datumingang   , 
          g.datumeinde   , 
          gw.gemeentecode   , 
          gw.woonplaatscode   , 
          gw.status   , 
          gw.begindatumtijdvakgeldigheid   , 
          gw.einddatumtijdvakgeldigheid   , 
          w.identificatie   , 
          w.woonplaatsnaam   , 
          w.woonplaatsstatus   , 
          w.begindatumtijdvakgeldigheid   , 
          w.einddatumtijdvakgeldigheid   , 
          w.geovlak
     from bag_wpl_actueelbestaand w     
     	  join BAG_GEMEENTE_WOONPLAATS gw on (gw.woonplaatscode = w.identificatie)
     	    join gba_t33 g on (g.gemeentecode = gw.gemeentecode);
--------------------------------------------------------
--  DDL for View GBA_GEMEENTEACTUEEL
--------------------------------------------------------
CREATE OR REPLACE VIEW GBA_GEMEENTEACTUEEL (GEMEENTECODE, GEMEENTENAAM, NIEUWE_CODE, DATUMINGANG, DATUMEINDE) 
AS SELECT DISTINCT gemeentecode     , 
                   gemeentenaam     , 
                   nieuwe_code     , 
                   datumingang     , 
                   datumeinde  
     from gba_t33 
    where (datumingang < to_char(now(), 'yyyymmdd') OR datumingang IS NULL)
      AND (datumeinde  > to_char(now(), 'yyyymmdd') OR datumeinde IS NULL)       ;

--------------------------------------------------------
-- DDL's voor ontsluiting van gegevens voor locatieserver


--------------------------------------------------------
--  DDL for View BAG_PANDEN
--------------------------------------------------------
CREATE OR REPLACE  VIEW BAG_PANDEN (IDENTIFICATIE, OFFICIEEL, INONDERZOEK, BEGINDATUMTIJDVAKGELDIGHEID, DOCUMENTNUMMER, DOCUMENTDATUM, PANDSTATUS, BOUWJAAR, BRON, GEOMETRIE_RD) 
AS select 
IDENTIFICATIE,
OFFICIEEL,
INONDERZOEK,
BEGINDATUMTIJDVAKGELDIGHEID,
DOCUMENTNUMMER,
DOCUMENTDATUM,
PANDSTATUS,
BOUWJAAR,
'BAG'::varchar(5) bron,
geovlak geometrie_rd			
from bag_pnd_actueelbestaand;				

--------------------------------------------------------
--  DDL for View BAG_WOONPLAATSEN
--------------------------------------------------------
CREATE OR REPLACE  VIEW BAG_WOONPLAATSEN (IDENTIFICATIE, WOONPLAATSCODE, WOONPLAATSNAAM, GEMEENTENAAM, GEMEENTECODE, PROVINCIENAAM, PROVINCIECODE, PROVINCIEAFKORTING, WOONPLAATSALIASSEN, BRON, GEOMETRIE_RD) 
AS select /*+ ORDERED */ gw.woonplaatscode IDENTIFICATIE, 
gw.woonplaatscode,
w.woonplaatsnaam,
gw.gemeentenaam,
gw.gemeentecode,
gw.provincienaam,
gw.provinciecode,
gw.provincieafkorting,
a.alias woonplaatsaliassen,
'BAG'::varchar(10) bron,
w.geovlak geometrie_rd 
from bag_wpl_actueelbestaand w join bag_gem_wpl_act_bst gw  on (w.identificatie=gw.woonplaatscode)   left outer join bag_woonplaats_alias a on (gw.woonplaatscode = a.identificatie);



--------------------------------------------------------
--  DDL for MV BAG_MV_ADRES
--------------------------------------------------------

create materialized view bag_mv_adres 
as select 
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
 'BAG'::varchar(5) bron,
 a.geopunt  geometrie_rd 
from bag_adres a join bag_woonplaatsen g on (a.wpl_id=g.identificatie and a.gemeentecode=g.gemeentecode)
;
-- actueelbestaand;

-- de table BAG_ADRES wordt gevuld in locatieserver etl
-- 

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
CREATE OR REPLACE  VIEW BAG_PAND_BIJ_ADRES (IDENTIFICATIE, PANDSTATUS, BOUWJAAR, ADRESSEERBAAROBJECT_ID, BRON, GEOMETRIE_RD) 
AS select pab.identificatie,
          pab.pandstatus,
          pab.bouwjaar,
          a.adresseerbaarobject_id,
          'BAG'::varchar(5) bron,
          pab.geovlak geometrie_rd
     from bag_pnd_actueelbestaand pab 
          join bag_vbopand vp on (vp.gerelateerdpand=pab.identificatie 
                                  and (((vp.begindatumtijdvakgeldigheid <= now())  )
                                  and ((vp.einddatumtijdvakgeldigheid is null) OR (vp.einddatumtijdvakgeldigheid   > now())  )))
                                  and (vp.aanduidingrecordinactief = 'N')                      
            join bag_mv_adres a on (a.adresseerbaarobject_id=vp.identificatie);
						

--------------------------------------------------------
--  DDL for View SUFFIX_AFKORTINGEN
--------------------------------------------------------

 CREATE TABLE SUFFIX_AFK  (	ID numeric, 
	SUFFIX_VOLLEDIG varchar(64 ), 
	SUFFIX_AFKORTING varchar(32 ) ) ;

Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('1','straat$','str');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('2','weg$','wg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('3','pad$','pd');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('4','park$','prk');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('5','dijk$','dk');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('6','bungalowpark$','bglwprk');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('7','boulevard$','blvd');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('8','dreef$','dr');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('9','drift$','dr');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('10','dwarsstraat$','dwstr');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('11','dwarsweg$','dwwg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('12','gracht$','gr');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('13','haven$','hvn');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('14','kade$','kd');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('15','kanaal$','kan');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('16','laan$','ln');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('17','laantje$','ln');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('18','leane$','ln');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('19','loane$','ln');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('20','plaats$','plts');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('21','plantsoen$','plnts');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('22','plein$','pln');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('23','polder$','pldr');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('24','polderdijk$','pldrdk');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('25','polderweg$','pldrwg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('26','singel$','sngl');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('27','steech$','stg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('28','steeg$','stg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('29','straatje$','str');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('30','straatweg$','strwg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('31','strjitte$','str');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('32','voetpad$','vtpd');

Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('101','str$','straat');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('102','wg$','weg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('103','pd$','pad');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('104','prk$','park');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('105','dk$','dijk');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('106','bglwprk$','bungalowpark');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('107','blvd$','boulevard');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('108','dr$','dreef');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('110','dwstr$','dwarsstraat');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('111','dwwg$','dwarsweg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('112','gr$','gracht');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('113','hvn$','haven');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('114','kd$','kade');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('115','kan$','kanaal');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('116','ln$','laan');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('120','plts$','plaats');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('121','plnts$','plantsoen');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('122','pln$','plein');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('123','pldr$','polder');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('124','pldrdk$','polderdijk');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('125','pldrwg$','polderweg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('126','sngl$','singel');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('128','stg$','steeg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('130','strwg$','straatweg');
Insert into SUFFIX_AFK (ID,SUFFIX_VOLLEDIG,SUFFIX_AFKORTING) values ('132','vtpd$','voetpad');




--------------------------------------------------------
--  DDL for Index BAG_ADA_IDX1
--------------------------------------------------------
CREATE INDEX BAG_ADA_IDX1 ON BAG_ADONEVENADRES (GID) ;

--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX0
--------------------------------------------------------
CREATE INDEX BAG_LIG_IDX0 ON BAG_LIGPLAATS (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) ;
--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX1
--------------------------------------------------------
CREATE INDEX BAG_LIG_IDX1 ON BAG_LIGPLAATS (HOOFDADRES);

--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX2
--------------------------------------------------------
CREATE INDEX BAG_LIG_IDX2 ON BAG_LIGPLAATS (IDENTIFICATIE);

--------------------------------------------------------
--  DDL for Index BAG_LIG_IDX3
--------------------------------------------------------
CREATE INDEX BAG_LIG_IDX3 ON BAG_LIGPLAATS (GID) ;

--------------------------------------------------------
--  DDL for Index BAG_LIGPLAATS_GEOVLAK_SPIX
--------------------------------------------------------
CREATE INDEX BAG_LIGPLAATS_GEOVLAK_SPIX ON BAG_LIGPLAATS  USING GIST (GEOVLAK)  ;

--------------------------------------------------------
--  DDL for Index BAG_MV_ADRES_ADOID
--------------------------------------------------------
CREATE INDEX BAG_MV_ADRES_ADOID ON BAG_MV_ADRES (ADRESSEERBAAROBJECT_ID);

--------------------------------------------------------
--  DDL for Index BAG_MV_ADRES_GEOM_SPIX
--------------------------------------------------------
CREATE INDEX BAG_MV_ADRES_GEOM_SPIX ON BAG_MV_ADRES  USING GIST (GEOMETRIE_RD)  ;

--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX0
--------------------------------------------------------
CREATE INDEX BAG_NUM_IDX0 ON BAG_NUMMERAANDUIDING (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID) ;

--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX1
--------------------------------------------------------
CREATE INDEX BAG_NUM_IDX1 ON BAG_NUMMERAANDUIDING (IDENTIFICATIE) ;

--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX2
--------------------------------------------------------
CREATE INDEX BAG_NUM_IDX2 ON BAG_NUMMERAANDUIDING (NUMMERAANDUIDINGSTATUS)   ;

--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX3
--------------------------------------------------------
CREATE INDEX BAG_NUM_IDX3 ON BAG_NUMMERAANDUIDING (EINDDATUMTIJDVAKGELDIGHEID)  ;

--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX4
--------------------------------------------------------
CREATE INDEX BAG_NUM_IDX4 ON BAG_NUMMERAANDUIDING (TYPEADRESSEERBAAROBJECT)   ;

--------------------------------------------------------
--  DDL for Index BAG_NUM_IDX5
--------------------------------------------------------
CREATE INDEX BAG_NUM_IDX5 ON BAG_NUMMERAANDUIDING (GID)  ;

--------------------------------------------------------
--  DDL for Index BAG_OPR_IDX0
--------------------------------------------------------
CREATE INDEX BAG_OPR_IDX0 ON BAG_OPENBARERUIMTE (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID)   ;

--------------------------------------------------------
--  DDL for Index BAG_OPR_IDX1
--------------------------------------------------------
CREATE INDEX BAG_OPR_IDX1 ON BAG_OPENBARERUIMTE (IDENTIFICATIE)   ;

--------------------------------------------------------
--  DDL for Index BAG_OPR_IDX2
--------------------------------------------------------
CREATE INDEX BAG_OPR_IDX2 ON BAG_OPENBARERUIMTE (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_PAND_GEOVLAK_SPIX
--------------------------------------------------------
CREATE INDEX BAG_PAND_GEOVLAK_SPIX ON BAG_PAND   USING GIST (GEOVLAK) ;

--------------------------------------------------------
--  DDL for Index BAG_PND_IDX0
--------------------------------------------------------
CREATE INDEX BAG_PND_IDX0 ON BAG_PAND (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID)   ;

--------------------------------------------------------
--  DDL for Index BAG_PND_IDX1
--------------------------------------------------------
CREATE INDEX BAG_PND_IDX1 ON BAG_PAND (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_STA_IDX0
--------------------------------------------------------
CREATE INDEX BAG_STA_IDX0 ON BAG_STANDPLAATS (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID)   ;

--------------------------------------------------------
--  DDL for Index BAG_STA_IDX1
--------------------------------------------------------
CREATE INDEX BAG_STA_IDX1 ON BAG_STANDPLAATS (HOOFDADRES)   ;

--------------------------------------------------------
--  DDL for Index BAG_STA_IDX2
--------------------------------------------------------
CREATE INDEX BAG_STA_IDX2 ON BAG_STANDPLAATS (IDENTIFICATIE)   ;

--------------------------------------------------------
--  DDL for Index BAG_STA_IDX3
--------------------------------------------------------
CREATE INDEX BAG_STA_IDX3 ON BAG_STANDPLAATS (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_STANDPLAATS_GEOVLAK_SPIX
--------------------------------------------------------
CREATE INDEX BAG_STANDPLAATS_GEOVLAK_SPIX ON BAG_STANDPLAATS   USING GIST (GEOVLAK) ;

--------------------------------------------------------
--  DDL for Index BAG_VBOGEBRUIKSDOEL_IDX0
--------------------------------------------------------
CREATE INDEX BAG_VBOGEBRUIKSDOEL_IDX0 ON BAG_VBOGEBRUIKSDOEL (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, GEBRUIKSDOELVERBLIJFSOBJECT)   ;

--------------------------------------------------------
--  DDL for Index BAG_VBOGEBRUIKSDOEL_IDX1
--------------------------------------------------------
CREATE INDEX BAG_VBOGEBRUIKSDOEL_IDX1 ON BAG_VBOGEBRUIKSDOEL (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_VBO_GEOPUNT_SPIX
--------------------------------------------------------
CREATE INDEX BAG_VBO_GEOPUNT_SPIX ON BAG_VERBLIJFSOBJECT   USING GIST (GEOPUNT) ;

--------------------------------------------------------
--  DDL for Index BAG_VBO_GEOVLAK_SPIX
--------------------------------------------------------
CREATE INDEX BAG_VBO_GEOVLAK_SPIX ON BAG_VERBLIJFSOBJECT  USING GIST (GEOVLAK) ;

--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX0
--------------------------------------------------------
CREATE INDEX BAG_VBO_IDX0 ON BAG_VERBLIJFSOBJECT (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID)   ;

--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX1
--------------------------------------------------------
CREATE INDEX BAG_VBO_IDX1 ON BAG_VERBLIJFSOBJECT (HOOFDADRES)    ;

--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX2
--------------------------------------------------------
CREATE INDEX BAG_VBO_IDX2 ON BAG_VERBLIJFSOBJECT (IDENTIFICATIE)   ;

--------------------------------------------------------
--  DDL for Index BAG_VBO_IDX3
--------------------------------------------------------
CREATE INDEX BAG_VBO_IDX3 ON BAG_VERBLIJFSOBJECT (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_VBOPAND_IDX0
--------------------------------------------------------
CREATE INDEX BAG_VBOPAND_IDX0 ON BAG_VBOPAND (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID, GERELATEERDPAND)   ;

--------------------------------------------------------
--  DDL for Index BAG_VBOPAND_IDX1
--------------------------------------------------------
CREATE INDEX BAG_VBOPAND_IDX1 ON BAG_VBOPAND (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_WOONPLAATS_ALIAS_PK
--------------------------------------------------------
CREATE UNIQUE INDEX BAG_WOONPLAATS_ALIAS_PK ON BAG_WOONPLAATS_ALIAS (ID)   ;

--------------------------------------------------------
--  DDL for Index BAG_WOONPLAATS_GEOVLAK_SPIX
--------------------------------------------------------
CREATE INDEX BAG_WOONPLAATS_GEOVLAK_SPIX ON BAG_WOONPLAATS   USING GIST (GEOVLAK) ;

--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX1
--------------------------------------------------------
CREATE INDEX BAG_WPL_IDX1 ON BAG_WOONPLAATS (IDENTIFICATIE, AANDUIDINGRECORDINACTIEF, AANDUIDINGRECORDCORRECTIE, BEGINDATUMTIJDVAKGELDIGHEID)   ;

--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX2
--------------------------------------------------------
CREATE INDEX BAG_WPL_IDX2 ON BAG_WOONPLAATS (IDENTIFICATIE)   ;

--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX3
--------------------------------------------------------
CREATE INDEX BAG_WPL_IDX3 ON BAG_WOONPLAATS (GID)   ;

--------------------------------------------------------
--  DDL for Index BAG_WPL_IDX4
--------------------------------------------------------
CREATE INDEX BAG_WPL_IDX4 ON BAG_WOONPLAATS (WOONPLAATSNAAM)   ;

--------------------------------------------------------
--  DDL for Index GEMEENTE_SPIDX
--------------------------------------------------------
CREATE INDEX GEMEENTE_SPIDX ON GEMEENTE   USING GIST (GEOM) ; 

-- DDL voor index gemeente_code
create index gemeente_code on gemeente(code);   

--------------------------------------------------------
--  DDL for Index PROVINCIE_SPIDX
--------------------------------------------------------
create index provincie_spidx on provincie   USING GIST (GEOM) ;

--------------------------------------------------------
--  DDL for Index INDEX1
--------------------------------------------------------
CREATE INDEX INDEX1 ON BAG_MV_ADRES (TYPEADRESSEERBAAROBJECT)   ;

--------------------------------------------------------
--  DDL for Index SYS_C0010535
--------------------------------------------------------
CREATE UNIQUE INDEX SYS_C0010535 ON GBA_T33_ALIAS (ID)   ;

-- extra indexen
create index gba_t33_gemeentecode on gba_t33(gemeentecode);

create index bag_gem_wpl_gemeentecode on bag_gemeente_woonplaats(gemeentecode);

create index bag_gem_wpl_wplcode on bag_gemeente_woonplaats(woonplaatscode);
  
--------------------------------------------------------
--  Constraints for Table BAG_ADONEVENADRES
--------------------------------------------------------
/*ALTER TABLE BAG_ADONEVENADRES ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_LIGPLAATS
--------------------------------------------------------
/*ALTER TABLE BAG_LIGPLAATS ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_LIGPLAATS ADD CHECK (officieel in ('N','J')) DISABLE;ALTER TABLE BAG_LIGPLAATS ADD CHECK (inonderzoek in ('N','J')) DISABLE;ALTER TABLE BAG_LIGPLAATS ADD CHECK (ligplaatsStatus in (                                      'Plaats aangewezen',                                      'Plaats ingetrokken')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_MV_ADRES
--------------------------------------------------------
-- ALTER TABLE BAG_MV_ADRES ADD CONSTRAINT BAG_MV_ADRES_PK PRIMARY KEY (ADRESSEERBAAROBJECT_ID);
-- dit leverde problemen op met nieuwe BAG levering van 1 januari 2015 





--------------------------------------------------------
--  Constraints for Table BAG_NUMMERAANDUIDING
--------------------------------------------------------
/*ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (officieel in ('N','J')) DISABLE;ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (inonderzoek in ('N','J')) DISABLE;ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (typeAdresseerbaarObject in ('Verblijfsobject',                                                                          'Standplaats',                                                                          'Ligplaats')) DISABLE;ALTER TABLE BAG_NUMMERAANDUIDING ADD CHECK (nummeraanduidingStatus in ('Naamgeving uitgegeven', 'Naamgeving ingetrokken')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_OPENBARERUIMTE
--------------------------------------------------------
/*ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (officieel in ('N','J')) DISABLE;ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (inonderzoek in ('N','J')) DISABLE;ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (openbareruimtestatus in ('Naamgeving uitgegeven', 'Naamgeving ingetrokken')) DISABLE;ALTER TABLE BAG_OPENBARERUIMTE ADD CHECK (openbareruimtetype in ('Weg',                                                                    'Water',                                                                    'Spoorbaan',                                                                    'Terrein',                                                                    'Kunstwerk',                                                                    'Landschappelijk gebied',                                                                    'Administratief gebied')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_PAND
--------------------------------------------------------
/*ALTER TABLE BAG_PAND ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_PAND ADD CHECK (officieel in ('N','J')) DISABLE;ALTER TABLE BAG_PAND ADD CHECK (inonderzoek in ('N','J')) DISABLE;ALTER TABLE BAG_PAND ADD CHECK (pandStatus in ('Bouwvergunning verleend',                                                'Niet gerealiseerd pand',                                                'Bouw gestart',                                                'Pand in gebruik (niet ingemeten)',                                                'Pand in gebruik',                                                'Sloopvergunning verleend',                                                'Pand gesloopt',                                                'Pand buiten gebruik')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_STANDPLAATS
--------------------------------------------------------
/*ALTER TABLE BAG_STANDPLAATS ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_STANDPLAATS ADD CHECK (officieel in ('N','J')) DISABLE;ALTER TABLE BAG_STANDPLAATS ADD CHECK (inonderzoek in ('N','J')) DISABLE;ALTER TABLE BAG_STANDPLAATS ADD CHECK (standplaatsStatus in (                                      'Plaats aangewezen',                                      'Plaats ingetrokken')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_VBOGEBRUIKSDOEL
--------------------------------------------------------
/*ALTER TABLE BAG_VBOGEBRUIKSDOEL ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_VBOGEBRUIKSDOEL ADD CHECK (gebruiksdoelVerblijfsobject in (                                                  'woonfunctie',                                                  'bijeenkomstfunctie',                                                  'celfunctie',                                                  'gezondheidszorgfunctie',                                                  'industriefunctie',                                                  'kantoorfunctie',                                                  'logiesfunctie',                                                  'onderwijsfunctie',                                                  'sportfunctie',                                                  'winkelfunctie',                                                  'overige gebruiksfunctie')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_VBOPAND
--------------------------------------------------------
/*ALTER TABLE BAG_VBOPAND ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_VERBLIJFSOBJECT
--------------------------------------------------------
/*ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (aanduidingRecordInactief in ('N','J')) DISABLE;ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (officieel in ('N','J')) DISABLE;ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (inonderzoek in ('N','J')) DISABLE;ALTER TABLE BAG_VERBLIJFSOBJECT ADD CHECK (verblijfsobjectStatus in (                                            'Verblijfsobject gevormd',                                            'Niet gerealiseerd verblijfsobject',                                            'Verblijfsobject in gebruik (niet ingemeten)',                                            'Verblijfsobject in gebruik',                                            'Verblijfsobject ingetrokken',                                            'Verblijfsobject buiten gebruik')) DISABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_WOONPLAATS
--------------------------------------------------------
/*ALTER TABLE BAG_WOONPLAATS ADD CHECK (aanduidingRecordInactief in ('N','J')) ENABLE;ALTER TABLE BAG_WOONPLAATS ADD CHECK (officieel in ('N','J')) ENABLE;ALTER TABLE BAG_WOONPLAATS ADD CHECK (inonderzoek in ('N','J')) ENABLE;ALTER TABLE BAG_WOONPLAATS ADD CHECK (woonplaatsstatus in ('Woonplaats aangewezen', 'Woonplaats ingetrokken')) ENABLE;
*/
--------------------------------------------------------
--  Constraints for Table BAG_WOONPLAATS_ALIAS
--------------------------------------------------------
/*ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (ID NOT NULL ENABLE);ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (ALIAS NOT NULL ENABLE);ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (DATUM_MUTATIE NOT NULL ENABLE);ALTER TABLE BAG_WOONPLAATS_ALIAS MODIFY (IDENTIFICATIE NOT NULL ENABLE);ALTER TABLE BAG_WOONPLAATS_ALIAS ADD CONSTRAINT BAG_WOONPLAATS_ALIAS_PK PRIMARY KEY (ID)   ;
*/
--------------------------------------------------------
--  Constraints for Table GBA_T33_ALIAS
--------------------------------------------------------
/*ALTER TABLE GBA_T33_ALIAS ADD PRIMARY KEY (ID)   ;
*/
	 
--------------------------------------------------------
--  DDL for Function SDO_WKT
--------------------------------------------------------
/*
 create or replace function sdo_wkt (p_geometry in sdo_geometry,p_keer    IN numeric)
return varchar asv_wkt varchar(4000);
beginif (p_geometry is null) thenreturn null;end if;if (p_keer=0) then-- niet omdraaienv_wkt:='POINT ('||p_geometry.sdo_point.x||' '||p_geometry.sdo_point.y||')';else-- wel omdraaienv_wkt:='POINT ('||p_geometry.sdo_point.y||' '||p_geometry.sdo_point.x||')';end if;return v_wkt;
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
 type word_type   is table of varchar(32) index by varchar(64);
 v_words  word_type;    
 v_street varchar(64);
 v_woord  varchar(64);
 i varchar(64);
 cursor s_a is select suffix_volledig, suffix_afkorting from suffix_afk order by id;
begin
 v_street := p_street;
 for rec in s_a loop v_words(rec.suffix_volledig) := rec.suffix_afkorting;
 end loop;
 
 i := v_words.first;

 while i is not null loopv_woord := i||'$|'||i||'([ -])';if (regexp_like(p_street, v_woord )) then v_street := regexp_replace (v_street, v_woord, v_words(i)||'\1');end if;i := v_words.next(i);
 end loop;
return v_street;
end street_abv;
/
*/




--------------------------------------------------------
--  DDL for TYPES
--------------------------------------------------------
/*
create or replace type varchar_ntt is table of varchar(4000)
/
*/


comment on table BAG_ADONEVENADRES is 'nevenadressen van adresseerbare objecten (ligplaatsen, standplaatsen en verblijfsobjecten). Inclusief historie en status';
comment on table BAG_GEMEENTE_WOONPLAATS is 'combinatie van woonplaatsen en gemeenten, alleen codes, geen namen. Inclusief historie en status';
comment on table BAG_LIGPLAATS is 'ligplaatsen. Inclusief historie en status';
comment on materialized view BAG_MV_ADRES is 'Alle bag adressen, wordt opgebouwd uit een aantal queries';
comment on table BAG_NUMMERAANDUIDING is 'nummeraanduidingen. Inclusief historie en status';
comment on table BAG_OPENBARERUIMTE is 'Openbareruimtes (wegen, parken, gebieden, etc). Inclusief historie en status';
comment on table BAG_PAND is 'Panden. Inclusief historie en status';
comment on table BAG_STANDPLAATS is 'Standplaatsen. Inclusief historie en status';
comment on table BAG_VBOGEBRUIKSDOEL is 'Gebruiksdoel van de verblijfsobjecten. Inclusief historie en status';
comment on table BAG_VBOPAND is 'Combinatie verblijfsobject en pand. Inclusief historie en status';
comment on table BAG_VERBLIJFSOBJECT is 'Verblijfsobjecten. Inclusief historie en status';
comment on table BAG_WOONPLAATS is 'Woonplaatsen. Inclusief historie en status';
comment on table BAG_WOONPLAATS_ALIAS is 'Woonplaatsaliassen. Toegevoegd voor LS2.0. Wordt alleen gevuld voor woonplaatsen die een alias hebben.';
comment on table GEMEENTE is 'Tabel wordt gevuld met geaggregeerde woonplaats op actuele t33 gemeentenamen door ETL_BAG';
comment on table PROVINCIE is 'Provincies, wordt gevuld vanuit pdok.provincies door ETL_PDOK. Wordt gebruikt in bag_gemeente_woonplaats';


--------------------------------------------------------
--  DDL for BAG_POSTCODES
--------------------------------------------------------

create materialized view BAG_POSTCODES 
as 
select 
openbareruimte_id as identificatie,
openbareruimte_id,
openbareruimtetype,
straatnaam,
straatnaam_verkort,
postcode,
postcodenummer,
postcodeletter,
woonplaatscode, 
woonplaatsnaam, 
gemeentecode, 
gemeentenaam, 
provincienaam, 
provinciecode, 
provincieafkorting, 
straatnaam || ', ' ||coalesce(nullif(postcode || ' ', ' '), '') || woonplaatsnaam     as weergavenaam,
'postcode'::varchar as type,
'BAG'::varchar as bron,
st_centroid(st_collect(geometrie_rd)) geometrie_rd 
from bag_mv_adres 
group by openbareruimte_id, openbareruimtetype, straatnaam, straatnaam_verkort, postcode, postcodenummer, postcodeletter, woonplaatsnaam, woonplaatscode, gemeentenaam, gemeentecode, provincienaam, provinciecode, provincieafkorting;

CREATE INDEX BAG_POSTCODES_SPIDX on BAG_POSTCODES   USING GIST (GEOMETRIE_RD) ; 


create materialized view BAG_OPENBARERUIMTES 
as 
select 
openbareruimte_id as identificatie, 
openbareruimte_id, 
openbareruimtetype, 
straatnaam, 
straatnaam_verkort, 
woonplaatscode, 
woonplaatsnaam, 
gemeentecode, 
gemeentenaam, 
provincienaam, 
provinciecode, 
provincieafkorting, 
straatnaam || ', '  || woonplaatsnaam     as weergavenaam,
'openbareruimte'::varchar(8) as type,
'BAG'::varchar as bron,
st_centroid(st_collect(geometrie_rd)) geometrie_rd 
from locatieserver.bag_mv_adres 
group by openbareruimte_id, 
openbareruimtetype, 
straatnaam, 
straatnaam_verkort, 
woonplaatsnaam, 
woonplaatscode, 
gemeentenaam, 
gemeentecode, 
provincienaam, 
provinciecode, 
provincieafkorting;

CREATE INDEX BAG_OPENBARERUIMTES_SPIDX on BAG_OPENBARERUIMTES   USING GIST (GEOMETRIE_RD) ; 


-- privileges
grant select on bag_adressen        to pdok_locatieserver_owner;
grant select on bag_gemeenten       to pdok_locatieserver_owner;
grant select on bag_woonplaatsen    to pdok_locatieserver_owner;
grant select on bag_panden          to pdok_locatieserver_owner;
grant select on bag_pand_bij_adres  to pdok_locatieserver_owner;
grant select on bag_postcodes       to pdok_locatieserver_owner;
grant select on bag_openbareruimtes to pdok_locatieserver_owner;


