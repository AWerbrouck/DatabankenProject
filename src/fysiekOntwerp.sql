CREATE TABLE ToeristischeActiviteit
(
	toeristische_regio              varchar NOT NULL,
	activiteittype                  varchar NOT NULL,
	openingstijd_ID                 integer NOT NULL,
	PrijsPerPersoon                 integer NOT NULL,
	straat                          varchar,
	postcode                        varchar,
	activiteitnaam                  varchar,
	gemeente                        VARCHAR NOT NULL,
	huisnummer                      varchar,
	beschrijving                    varchar,
	activiteit_website              varchar,
	activiteit_telefoonnummer       varchar,
	activiteit_toegang_doof         varchar,
	activiteit_toegang_slechthorend varchar,
	activiteit_toegang_mentaal      varchar,
	activiteit_toegang_motorisch    varchar,
	activiteit_toegang_blind        varchar,
	activiteit_toegang_slechtziend  varchar,
	activiteit_toegang_autisme      varchar,
	PRIMARY KEY (postcode, activiteitnaam)
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
	H_ID         varchar,
	Naam         varchar NOT NULL,
	Regio        varchar NOT NULL,
	Gemeente     varchar NOT NULL,
	Postcode     varchar NOT NULL,
	Huisnummer   varchar NOT NULL,
	Straat       varchar NOT NULL,
	PRIMARY KEY (H_ID)
);

CREATE TABLE inschrijving
(
	emailpersoon         varchar,
	postcode             varchar,
	naam                 varchar,
	aantal               integer,
	bevestigd            boolean,
	tijdstip             timestamp,
	persoon_doof         varchar,
	persoon_slechthorend varchar,
	persoon_mentaal      varchar,
	persoon_motorisch    varchar,
	persoon_blind        varchar,
	persoon_slechtziend  varchar,
	persoon_autisme      varchar,
	PRIMARY KEY (emailpersoon, postcode, naam),
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
	begintijd    timestamp,
	eindtijd     timestamp,
	aantal       integer,
	bevestigd    boolean,
	PRIMARY KEY (emailpersoon, hotel_id),
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

CREATE TABLE Openingstijd
(
	openingstijd_ID varchar,
	Eindtijd        timestamp,
	Starttijd       timestamp,
	Datum           date,
	Postcode        varchar,
	Naam            varchar,
	PRIMARY KEY (openingstijd_ID),
	CONSTRAINT fk_ToeristischeActiviteit
		FOREIGN KEY (Postcode, Naam)
			REFERENCES ToeristischeActiviteit (Postcode, activiteitnaam),
	CONSTRAINT validTijdCheck
		CHECK (Eindtijd > Starttijd)
);
