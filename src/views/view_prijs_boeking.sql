DROP view IF EXISTS prijs_boeking cascade;

create view public.prijs_boeking as
SELECT
    b.emailpersoon,
    h.naam,
    b.tijdstip,
	(( b.eindtijd - b.begintijd)::integer * h.minprijs)::integer as totaal_prijs

FROM
	boekingen b
		INNER JOIN hotel h
				   ON b.hotel_id = h.h_id