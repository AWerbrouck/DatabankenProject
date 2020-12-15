DROP view IF EXISTS prijs_boeking cascade;

create view public.prijs_boeking as
SELECT
    b.emailpersoon as emailpersoon,
    h.naam as naam_hotel,
    b.tijdstip as tijdstip_boeking,
	(( b.eindtijd - b.begintijd)::integer * h.minprijs)::integer as totaal_prijs

FROM
	boekingen b
		INNER JOIN hotel h
				   ON b.hotel_id = h.h_id