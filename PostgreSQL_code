CREATE TABLE ToeristischeActiviteit(
Regio varchar NOT NULL,
TypeActiviteit varchar NOT NULL,
O_ID integer NOT NULL,
PrijsPerPersoon integer NOT NULL,
Straat varchar,
Postcode integer,
Naam varchar
Gemeente varchar NOT NULL,
Huisnummer integer,
Beschrijving varchar,
Website varchar,
Tel varchar,
T_ID integer NOT NULL,
PRIMARY KEY (Postcode, Naam)
);

CREATE TABLE Openingstijd(
O_ID integer,
Eindtijd time,
Starttijd time,
Datum date,
Postcode integer,
Naam varchar,
PRIMARY KEY (O_ID),
CONSTRAINT fk_ToeristischeActiviteit
FOREIGN KEY(Postcode, Naam)
REFERENCES ToeristischeActiviteit(Postcode, Naam)
);

ALTER TABLE Openingstijd
ADD CONSTRAINT validTijdCheck
CHECK (Eindtijd > Starttijd);

CREATE TABLE Toegankelijkheidsinfo(
T_ID integer NOT NULL,
Info varchar NOT NULL,
Naam varchar NOT NULL,
Postcode integer NOT NULL,
PRIMARY KEY(T_ID),
CONSTRAINT fk_ToeristischeActiviteit
FOREIGN KEY(Postcode, Naam)
REFERENCES ToeristischeActiviteit(Postcode, Naam)
);

CREATE TABLE Persoon(
Email varchar,
Voornaam varchar NOT NULL,
Achternaam varchar NOT NULL,
PRIMARY KEY(Email)
);

CREATE TABLE Hotel(
Beschrijving varchar,
Sterren varchar,
MinPrijs integer,
Email varchar,
H_ID integer,
Naam varchar NOT NULL,
Regio varchar NOT NULL,
Gemeente varchar NOT NULL,
Postcode integer NOT NULL,
Huisnummer integer NOT NULL,
Straat varchar NOT NULL,
PRIMARY KEY(H_ID)
);
