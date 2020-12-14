DROP VIEW IF EXISTS prijs_activiteit CASCADE;

CREATE VIEW public.prijs_activiteit AS
SELECT
    i.emailpersoon,
    i.naam,
    i.postcode,
    i.tijdstip,
	( i.aantal::numeric * t.prijsperpersoon::numeric )::numeric AS totaal_prijs

FROM
	inschrijving i
		INNER JOIN toeristischeactiviteit t
				   ON i.postcode = t.postcode AND i.naam = t.activiteitnaam
