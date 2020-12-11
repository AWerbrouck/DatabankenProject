CREATE FUNCTION check_overlapping_opening()
RETURNS trigger AS
$BODY$
DECLARE
BEGIN

	IF EXISTS(SELECT 1 FROM openingstijd a WHERE
		(a.starttijd <= NEW.starttijd) AND
		(NEW.begintijdstip < a.begintijdstip + a.duur) AND
		a.activiteit = NEW.activiteit) THEN
		RAISE EXCEPTION 'opening time of resto %, begin period % and end period % overlaps with already existing opening time.', NEW.restonaam, NEW.begintijdstip, NEW.begintijdstip + NEW.duur;
	END IF;

	IF EXISTS(SELECT 1 FROM openingstijd a WHERE
		(r.begintijdstip < NEW.begintijdstip + NEW.duur) AND
		(NEW.begintijdstip + NEW.duur <= r.begintijdstip + r.duur) AND
		r.restonaam = NEW.restonaam) THEN
		RAISE EXCEPTION 'opening time of resto %, begin period % and end period % overlaps with already existing opening time.', NEW.restonaam, NEW.begintijdstip, NEW.begintijdstip + NEW.duur;
	END IF;

	IF EXISTS(SELECT 1 FROM openingstijd r WHERE
		(NEW.begintijdstip < r.begintijdstip) AND
		(NEW.begintijdstip + NEW.duur > r.begintijdstip + r.duur) AND
		r.restonaam = NEW.restonaam) THEN
		RAISE EXCEPTION 'opening time of resto %, begin period % and end period % overlaps with already existing opening time.', NEW.restonaam, NEW.begintijdstip, NEW.begintijdstip + NEW.duur;
	END IF;

	RETURN NEW;

END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_overlapping_opening_trigger
	BEFORE INSERT
		ON openingstijd
			FOR EACH ROW
				EXECUTE PROCEDURE check_overlapping_opening();