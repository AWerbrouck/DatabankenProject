DROP FUNCTION IF EXISTS check_overlapping_inschrijving() CASCADE;
DROP TRIGGER IF EXISTS check_overlapping_inschrijving_trigger ON inschrijving;
CREATE FUNCTION check_overlapping_inschrijving()
	RETURNS trigger AS
$BODY$
DECLARE
BEGIN

	IF EXISTS(
			SELECT
				1
			FROM
				inschrijving i
					INNER JOIN openingstijd o
							   ON i.postcode = o.postcode AND i.naam = o.naam and i.tijdstip = o.starttijd
			WHERE
				  i.emailpersoon = new.emailpersoon
			  AND o.starttijd <= new.tijdstip
			  AND new.tijdstip < o.starttijd + o.duur
		) THEN
		RAISE EXCEPTION 'Inschijven mag niet voor activiteiten die overlappen % % % %', new.emailpersoon,new.tijdstip, new.naam, new.postcode;
	END IF;

	IF EXISTS(
			SELECT
				1
			FROM
				inschrijving i
					INNER JOIN openingstijd o
							   ON i.postcode = o.postcode AND i.naam = o.naam and i.tijdstip = o.starttijd
					INNER JOIN openingstijd o1
							   ON new.postcode = o1.postcode AND new.naam = o1.naam
			WHERE
			    new.tijdstip = o1.starttijd and
				  i.emailpersoon = new.emailpersoon
			  AND o.starttijd <= o1.starttijd + o1.duur
			  AND o1.starttijd + o1.duur <= o.starttijd + o.duur
		) THEN
		RAISE EXCEPTION 'Inschijven mag niet voor activiteiten die overlappen % % % ', new.tijdstip, new.naam, new.postcode;
	END IF;

	RETURN new;

END ;
$BODY$
	LANGUAGE plpgsql;

CREATE TRIGGER check_overlapping_inschrijving_trigger
	BEFORE INSERT
	ON inschrijving
	FOR EACH ROW
EXECUTE PROCEDURE check_overlapping_inschrijving();