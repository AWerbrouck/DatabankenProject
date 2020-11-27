CREATE TABLE ToeristischeActiviteit
(
	toeristische_regio        varchar NOT NULL,
	activiteittype            varchar NOT NULL,
	openingstijd_ID           integer NOT NULL,
	PrijsPerPersoon           integer NOT NULL,
	straat                    varchar,
	postcode                  integer,
	activiteitnaam            varchar,
	gemeente                  VARCHAR NOT NULL,
	huisnummer                integer,
	beschrijving              varchar,
	activiteit_website        varchar,
	activiteit_telefoonnummer varchar,
	toegankelijkheids_ID      integer NOT NULL,
	PRIMARY KEY (postcode, activiteitnaam)
);

CREATE TABLE inschrijving
(
	emailpersoon varchar,
	postcode     varchar,
	naam         varchar,
	aantal       integer,
	bevestigd    boolean,
	tijdstip     timestamp,
	PRIMARY KEY (emailpersoon, postcode, naam)
);

CREATE TABLE boekingen
(
	emailpersoon varchar,
	hotel_id     varchar,
	tijdstip     timestamp,
	begin        timestamp,
	eind         timestimp,
	aantal       integer,
	PRIMARY KEY (emailpersoon, hotel_id)
);

CREATE TABLE kortingen
(
	activiteitnaam      varchar,
	activiteit_postcode varchar,
	hotelid             varchar,
	percentage_korting  varchar,
	PRIMARY KEY (activiteitnaam, activiteit_postcode, hotelid)

);

CREATE TABLE Openingstijd
(
	O_ID      integer,
	Eindtijd  time,
	Starttijd time,
	Datum     date,
	Postcode  integer,
	Naam      varchar,
	PRIMARY KEY (O_ID),
	CONSTRAINT fk_ToeristischeActiviteit
		FOREIGN KEY (Postcode, Naam)
			REFERENCES ToeristischeActiviteit (Postcode, Naam)
);

ALTER TABLE Openingstijd
	ADD CONSTRAINT validTijdCheck
		CHECK (Eindtijd > Starttijd);

CREATE TABLE Toegankelijkheidsinfo
(
	toegankelijkheids_ID integer NOT NULL,
	Info                 varchar NOT NULL,
	Naam                 varchar NOT NULL,
	Postcode             integer NOT NULL,
	PRIMARY KEY (toegankelijkheids_ID),
	CONSTRAINT fk_ToeristischeActiviteit,
	FOREIGN KEY (Postcode, Naam)
		REFERENCES ToeristischeActiviteit (Postcode, Naam)
);

CREATE TABLE Persoon
(
	Email      varchar,
	Voornaam   varchar NOT NULL,
	Achternaam varchar NOT NULL,
	PRIMARY KEY (Email)
);

CREATE TABLE Hotel
(
	Beschrijving varchar,
	Sterren      varchar,
	MinPrijs     integer,
	Email        varchar,
	H_ID         integer,
	Naam         varchar NOT NULL,
	Regio        varchar NOT NULL,
	Gemeente     varchar NOT NULL,
	Postcode     integer NOT NULL,
	Huisnummer   integer NOT NULL,
	Straat       varchar NOT NULL,
	PRIMARY KEY (H_ID)
);
