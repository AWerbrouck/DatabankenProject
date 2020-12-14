CREATE TABLE super_activiteitreservaties
(
    activiteittype                  varchar,
    activiteitnaam                  varchar,
    straat                          varchar,
    huisnummer                      varchar,
    postcode                        varchar,
    gemeente                        varchar,
    toeristische_regio              varchar,
    activiteit_telefoonnummer       varchar,
    activiteit_website              varchar,
    beschrijving                    varchar,
    activiteit_toegang_doof         varchar,
    activiteit_toegang_slechthorend varchar,
    activiteit_toegang_mentaal      varchar,
    activiteit_toegang_motorisch    varchar,
    activiteit_toegang_blind        varchar,
    activiteit_toegang_slechtziend  varchar,
    activiteit_toegang_autisme      varchar,
    activiteit_prijs                varchar,
    begintijdstip                   varchar,
    duur                            varchar,
    voornaam                        varchar,
    achternaam                      varchar,
    persoon_email                   varchar,
	boeking_bevestigd				varchar,
    boekingstijdstip                varchar,
    aantal_personen                 varchar,
    persoon_doof                    varchar,
    persoon_slechthorend            varchar,
    persoon_mentaal                 varchar,
    persoon_motorisch                varchar,
    persoon_blind                   varchar,
    persoon_slechtziend             varchar,
    persoon_autisme                 varchar
);

CREATE TABLE super_hotelboekingen
(
    hotelid            varchar,
    hotelnaam          varchar,
    straat             varchar,
    huisnummer         varchar,
    postcode           varchar,
    gemeente           varchar,
    toeristische_regio varchar,
    hotel_email        varchar,
    hotel_beschrijving varchar,
    aantal_sterren     varchar,
    minimumprijs       varchar,
    voornaam           varchar,
    achternaam         varchar,
    persoon_email      varchar,
    boekingstijdstip   varchar,
	boeking_bevestigd  varchar,
    begindatum         varchar,
    einddatum          varchar,
    aantal_personen    varchar
);

CREATE TABLE super_kortingen
(
    activiteitnaam      varchar,
    activiteit_postcode varchar,
    hotelid             varchar,
    percentage_korting  varchar
);

