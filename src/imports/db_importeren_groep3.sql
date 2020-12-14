DROP TABLE IF EXISTS ToeristischeActiviteit CASCADE;
DROP TABLE IF EXISTS Persoon CASCADE;
DROP TABLE IF EXISTS Hotel CASCADE;
DROP TABLE IF EXISTS inschrijving CASCADE;
DROP TABLE IF EXISTS boekingen CASCADE;
DROP TABLE IF EXISTS kortingen CASCADE;
DROP TABLE IF EXISTS openingstijd CASCADE;
DROP TRIGGER IF EXISTS check_overlapping_opening_trigger ON openingstijd CASCADE;
DROP SEQUENCE IF EXISTS openingstijd_id_seq CASCADE;

CREATE TABLE ToeristischeActiviteit
(
	toeristische_regio              varchar NOT NULL,
	activiteittype                  varchar NOT NULL,
	PrijsPerPersoon                 varchar NOT NULL,
	straat                          varchar,
	postcode                        varchar,
	activiteitnaam                  varchar,
	gemeente                        VARCHAR NOT NULL,
	huisnummer                      varchar,
	beschrijving                    varchar,
	activiteit_website              varchar,
	activiteit_telefoonnummer       varchar,
	activiteit_toegang_doof         boolean,
	activiteit_toegang_slechthorend boolean,
	activiteit_toegang_mentaal      boolean,
	activiteit_toegang_motorisch    boolean,
	activiteit_toegang_blind        boolean,
	activiteit_toegang_slechtziend  boolean,
	activiteit_toegang_autisme      boolean,
	PRIMARY KEY (postcode, activiteitnaam)
);

CREATE TABLE Persoon
(
	Email      varchar,
	Voornaam   varchar NOT NULL,
	Achternaam varchar NOT NULL,
	PRIMARY KEY (Email) -- TODO
);

CREATE TABLE Hotel
(
	Beschrijving varchar,
	Sterren      varchar,
	MinPrijs     float,
	Email        varchar,
	H_ID         varchar,
	Naam         varchar NOT NULL,
	Regio        varchar NOT NULL,
	Gemeente     varchar NOT NULL,
	Postcode     varchar NOT NULL,
	Huisnummer   varchar NOT NULL,
	Straat       varchar NOT NULL,
	PRIMARY KEY (H_ID) -- TODO
);

CREATE TABLE inschrijving --TODO
(
	emailpersoon         varchar,
	postcode             varchar,
	naam                 varchar,
	aantal               integer,
	bevestigd            boolean,
	tijdstip             timestamp,
	persoon_doof         integer,
	persoon_slechthorend integer,
	persoon_mentaal      integer,
	persoon_motorisch    integer,
	persoon_blind        integer,
	persoon_slechtziend  integer,
	persoon_autisme      integer,
	PRIMARY KEY (emailpersoon, postcode, naam, tijdstip),
	CONSTRAINT fk_toeristischeactiviteit
		FOREIGN KEY (postcode, naam)
			REFERENCES ToeristischeActiviteit (postcode, activiteitnaam),
	CONSTRAINT fk_persoon
		FOREIGN KEY (emailpersoon)
			REFERENCES Persoon (email)

);



CREATE TABLE boekingen
(
	emailpersoon varchar,
	hotel_id     varchar,
	tijdstip     timestamp,
	begintijd    date,
	eindtijd     date,
	aantal       integer,
	bevestigd    boolean,
	PRIMARY KEY (emailpersoon, hotel_id, begintijd),
	CONSTRAINT fk_hotel
		FOREIGN KEY (hotel_id)
			REFERENCES Hotel (H_ID),
	CONSTRAINT fk_persoon
		FOREIGN KEY (emailpersoon)
			REFERENCES Persoon (email)
);

CREATE TABLE kortingen
(
	activiteitnaam      varchar,
	activiteit_postcode varchar,
	hotel_id            varchar,
	percentage_korting  varchar,
	PRIMARY KEY (activiteitnaam, activiteit_postcode, hotel_id),
	CONSTRAINT fk_hotel
		FOREIGN KEY (hotel_id)
			REFERENCES Hotel (H_ID),
	CONSTRAINT fk_toeristischeactiviteit
		FOREIGN KEY (activiteitnaam, activiteit_postcode)
			REFERENCES ToeristischeActiviteit (activiteitnaam, postcode)

);

CREATE SEQUENCE openingstijd_id_seq;

CREATE TABLE Openingstijd
(
	openingstijd_ID integer DEFAULT nextval('openingstijd_id_seq'),
	Starttijd       timestamp,
	duur           interval,
	Postcode        varchar,
	Naam            varchar,
	PRIMARY KEY (openingstijd_ID),
	CONSTRAINT fk_ToeristischeActiviteit
		FOREIGN KEY (Postcode, Naam)
			REFERENCES ToeristischeActiviteit (Postcode, activiteitnaam),
	CONSTRAINT validTijdCheck
		CHECK (starttijd + duur  > Starttijd)
);





--voeg ToeristischeActiviteiten toe

INSERT INTO
	ToeristischeActiviteit(toeristische_regio, activiteittype, prijsperpersoon, straat, postcode, activiteitnaam,
						   gemeente, huisnummer, beschrijving, activiteit_website, activiteit_telefoonnummer,
						   activiteit_toegang_doof, activiteit_toegang_slechthorend, activiteit_toegang_mentaal,
						   activiteit_toegang_motorisch, activiteit_toegang_blind, activiteit_toegang_slechtziend,
						   activiteit_toegang_autisme)
	(SELECT DISTINCT
		 toeristische_regio,
		 activiteittype,
		 activiteit_prijs,
		 straat,
		 postcode,
		 activiteitnaam,
		 gemeente,
		 huisnummer,
		 beschrijving,
		 activiteit_website,
		 activiteit_telefoonnummer,
		 activiteit_toegang_doof::boolean,
		 activiteit_toegang_slechthorend::boolean,
		 activiteit_toegang_mentaal::boolean,
		 activiteit_toegang_motorisch::boolean,
		 activiteit_toegang_blind::boolean,
		 activiteit_toegang_slechtziend::boolean,
		 activiteit_toegang_autisme::boolean
	 FROM
		 super_activiteitreservaties);


--voeg openingstijd toe

INSERT INTO
	openingstijd(starttijd, duur, postcode, naam)
	(SELECT DISTINCT
		 begintijdstip::timestamp,
		 duur::interval,
		 postcode,
		 activiteitnaam
	 FROM
		 super_activiteitreservaties);


--voeg Personen toe

INSERT INTO
	Persoon(email, voornaam, achternaam)
	(SELECT DISTINCT
		 persoon_email,
		 voornaam,
		 achternaam
	 FROM
		 super_activiteitreservaties
	 WHERE
		 NOT EXISTS(SELECT 1 FROM persoon p WHERE p.email = persoon_email));


--voeg inschrijvingen toe


--voeg hotel toe

INSERT INTO
	Hotel(beschrijving, sterren, minprijs, email, H_ID, naam, regio, gemeente, postcode, huisnummer, straat)
	(SELECT DISTINCT
		 hotel_beschrijving,
		 aantal_sterren,
		 minimumprijs::float,
		 hotel_email,
		 hotelid,
		 hotelnaam,
		 toeristische_regio,
		 gemeente,
		 postcode,
		 huisnummer,
		 straat
	 FROM
		 super_hotelboekingen);


--voeg persoon toe

INSERT INTO
	Persoon(email, voornaam, achternaam)
	(SELECT DISTINCT
		 persoon_email,
		 voornaam,
		 achternaam
	 FROM
		 super_hotelboekingen
	 WHERE
		 NOT EXISTS(SELECT 1 FROM persoon p WHERE p.email = persoon_email));


--voeg boeking toe
INSERT INTO
	inschrijving(emailpersoon, postcode, naam, aantal, bevestigd, tijdstip, persoon_doof, persoon_slechthorend,
				 persoon_mentaal, persoon_motorisch, persoon_blind, persoon_slechtziend, persoon_autisme)
	(SELECT DISTINCT
		 persoon_email,
		 postcode,
		 activiteitnaam,
		 aantal_personen::integer,
		 boeking_bevestigd::boolean,
		 begintijdstip::timestamp,
		 persoon_doof::integer,
		 persoon_slechthorend::integer,
		 persoon_mentaal::integer,
		 persoon_motorisch::integer,
		 persoon_blind::integer,
		 persoon_slechtziend::integer,
		 persoon_autisme::integer
	 FROM
		 super_activiteitreservaties);

INSERT INTO
	boekingen(emailpersoon, hotel_id, tijdstip, begintijd, eindtijd, aantal, bevestigd)
	(SELECT DISTINCT
		 persoon_email,
		 hotelid,
		 boekingstijdstip::timestamp,
		 begindatum::date,
		 einddatum::date,
		 aantal_personen::integer,
		 boeking_bevestigd::boolean
	 FROM
		 super_hotelboekingen);


--voeg korting toe

INSERT INTO
	kortingen(activiteitnaam, activiteit_postcode, hotel_id, percentage_korting)
	(SELECT DISTINCT activiteitnaam, activiteit_postcode, hotelid, percentage_korting FROM super_kortingen);



-- INSERT INTO
-- 	Hotel(H_ID)
-- 	(SELECT DISTINCT
-- 		 hotelid
-- 	 FROM
-- 		 super_kortingen
-- 	 WHERE
-- 		 NOT EXISTS(SELECT 1 from hotel h where h.h_id = hotelid ));

-- INSERT INTO
-- 	toeristischeactiviteit(postcode, activiteitnaam)
-- 	(SELECT DISTINCT
-- 		 activiteit_postcode,
-- 	     activiteitnaam
-- 	 FROM
-- 		 super_kortingen spa
-- 	 WHERE
-- 		 NOT EXISTS(SELECT 1 from toeristischeactiviteit t where t.postcode = spa.activiteit_postcode AND t.activiteitnaam = spa.activiteitnaam));


