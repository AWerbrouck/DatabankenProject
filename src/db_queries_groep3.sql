--QUERY 1
--Tel totale aantal unieke boekingen die werden geregistreerd, zowel op hotels als toeristische activiteit
SELECT
COUNT(sub1.email)
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
