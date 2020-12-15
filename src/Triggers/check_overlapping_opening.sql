DROP FUNCTION IF EXISTS check_overlapping_opening() CASCADE;
DROP TRIGGER IF EXISTS check_overlapping_opening_trigger ON openingstijd;
CREATE FUNCTION check_overlapping_opening()
	RETURNS trigger AS
$BODY$
DECLARE
BEGIN

	IF EXISTS(SELECT
				  1
			  FROM
				  openingstijd a
			  WHERE
					( a.starttijd <= NEW.starttijd )
				AND ( NEW.starttijd < a.starttijd + a.duur )
				AND ( a.naam = NEW.naam )
				AND a.postcode = new.postcode) THEN
		RAISE EXCEPTION 'openingstijden van zelfde activiteiten mogen niet overlappen';
	END IF;

	IF EXISTS(SELECT
				  1
			  FROM
				  openingstijd a
			  WHERE
					( a.starttijd < NEW.starttijd + NEW.duur )
				AND ( NEW.starttijd + NEW.duur <= a.starttijd + a.duur )
				AND ( a.naam = NEW.naam )
				AND a.postcode = new.postcode) THEN
		RAISE EXCEPTION 'openingstijden van zelfde activiteiten mogen niet overlappen';
	END IF;

	IF EXISTS(SELECT
				  1
			  FROM
				  openingstijd a
			  WHERE
					( NEW.starttijd < a.starttijd )
				AND ( NEW.starttijd + NEW.duur > a.starttijd + a.duur )
				AND ( a.naam = NEW.naam )
				AND ( a.postcode = new.postcode )) THEN
		RAISE EXCEPTION 'openingstijden van zelfde activiteiten mogen niet overlappen';
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