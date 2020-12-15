DROP VIEW IF EXISTS prijs_inschrijving CASCADE;

CREATE VIEW public.prijs_inschrijving AS
SELECT
    i.emailpersoon as emailpersoon,
    i.naam as naam_activiteit,
    i.postcode as postcode_activiteit,
    i.tijdstip as tijdstip_inchrijving,
	( i.aantal::numeric * t.prijsperpersoon::numeric )::numeric AS totaal_prijs

FROM
	inschrijving i
		INNER JOIN toeristischeactiviteit t
				   ON i.postcode = t.postcode AND i.naam = t.activiteitnaam
