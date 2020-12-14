--QUERY 1
--Tel totale aantal unieke boekingen die werden geregistreerd, zowel op hotels als toeristische activiteit
SELECT
COUNT(sub1.email)::integer AS unieke_boekingen_en_inschrijvingen
FROM
(	SELECT DISTINCT
	b.emailpersoon::varchar AS email,
	b.hotel_ID::varchar,
	b.begintijd::varchar,
	1::varchar
	FROM
	boekingen b	
    UNION
	SELECT DISTINCT
	i.emailpersoon::varchar AS email,
	i.postcode::varchar,
	i.naam::varchar,
	i.tijdstip::varchar
	FROM
	inschrijving i
) sub1;

--QUERY 2
--boeking en inschrijving???
--Aantal unieke personen die een boeking plaatste voor meer dan 1 persoon
SELECT
COUNT(sub2.emails)
FROM
(	SELECT DISTINCT sub1.email AS emails FROM (	SELECT DISTINCT
							i.emailpersoon::varchar as email,
							i.postcode::varchar,
							i.naam::varchar,
							i.tijdstip::varchar
							FROM
							inschrijving i
							WHERE
							i.aantal > 1
						       UNION
							SELECT DISTINCT
							b.emailpersoon::varchar as email,
							b.hotel_id::varchar,
							b.begintijd::varchar,
							'1'::varchar
							FROM
							boekingen b
							WHERE
							b.aantal > 1
						) sub1
) sub2;
		
--QUERY 3
--Tel het aantal unieke hotels
SELECT
COUNT(h.h_id)
FROM
hotel h;

--QUERY 4
--Tel aantal unieke activiteiten die faciliteiten voorzien voor mensen met een beperking
SELECT
COUNT(sub1.postcode)
FROM
(
	SELECT DISTINCT
	ta.postcode AS postcode,
	ta.activiteitnaam AS activiteitnaam
	FROM
	toeristischeactiviteit ta
	WHERE activiteit_toegang_doof = 'true'::boolean
	OR activiteit_toegang_slechthorend = 'true'::boolean
	OR activiteit_toegang_mentaal = 'true'::boolean
	OR activiteit_toegang_motorisch = 'true'::boolean
	OR activiteit_toegang_blind = 'true'::boolean
	OR activiteit_toegang_slechtziend = 'true'::boolean
	OR activiteit_toegang_autisme = 'true'::boolean
) sub1;


--QUERY 5
--2 keer slapen, 48 uur of 2 dagen (en dus mogelijks ook minder als 48u, bv inchecken op 13 dec en uitchecken op 14 dec (technisch gezien ook 2 dagen))
--Tel aantal unieke hotelboekingen die geboekt werden voor een periode/tijdspanne van 2 dagen of meer
SELECT
COUNT(sub1.emailpersoon)
FROM
(
	SELECT DISTINCT
	b.emailpersoon,
	b.hotel_id,
	b.begintijd
	FROM
	boekingen b
	WHERE
	b.eindtijd - b.begintijd >= 2
) sub1;


--QUERY 6
--De primary key uniek, of alleen de combinatie van starttijd en duur uniek, en dus onafhankelijk van de activiteit???
--Tel het aantal unieke openingsperiodes
SELECT
COUNT(openingstijd_ID)
FROM
openingstijd;
