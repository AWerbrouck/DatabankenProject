--QUERY 1
--Tel totale aantal unieke boekingen die werden geregistreerd, zowel op hotels als toeristische activiteit
SELECT
COUNT(sub1.email) + COUNT(sub2.email)
FROM
(	SELECT DISTINCT
	b.emailpersoon AS email,
	b.hotel_ID,
	b.begintijd
	FROM
	boeking b	
) sub1,
(	SELECT DISTINCT
	i.emailpersoon AS email,
	i.postcode,
	i.naam,
	i.tijdstip
	FROM
	inschrijving i
) sub2;

--QUERY 2
