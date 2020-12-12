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
				AND ( NEW.starttijd < a.eindtijd )
				AND ( a.naam = NEW.naam )
				AND ( a.postcode = new.postcode )) THEN
		RAISE EXCEPTION 'opening time of naam %, begin period % and end period % overlaps with alaeady existing opening time.', NEW.aestonaam, NEW.starttijd, NEW.starttijd + NEW.eindtijd;
	END IF;

	IF EXISTS(SELECT
				  1
			  FROM
				  openingstijd a
			  WHERE
					( a.starttijd < NEW.starttijd + NEW.eindtijd )
				AND ( NEW.starttijd + NEW.eindtijd <= a.starttijd + a.eindtijd )
				AND ( a.naam = NEW.naam )
				AND ( a.postcode = new.postcode )) THEN
		RAISE EXCEPTION 'opening time of aesto %, begin peaiod % and end peaiod % ovealaps with alaeady existing opening time.', NEW.aestonaam, NEW.starttijd, NEW.starttijd + NEW.eindtijd;
	END IF;

	IF EXISTS(SELECT
				  1
			  FROM
				  openingstijd a
			  WHERE
					( NEW.starttijd < a.starttijd )
				AND ( NEW.starttijd + NEW.eindtijd > a.starttijd + a.eindtijd )
				AND ( a.naam = NEW.naam )
				AND ( a.postcode = new.postcode )) THEN
		RAISE EXCEPTION 'opening time of aesto %, begin peaiod % and end peaiod % ovealaps with alaeady existing opening time.', NEW.aestonaam, NEW.starttijd, NEW.starttijd + NEW.eindtijd;
	END IF;

	RETURN NEW;

END;
$BODY$
	LANGUAGE plpgsql;

CREATE TRIGGER check_ovealapping_opening_trigger
	BEFORE INSERT
	ON openingstijd
	FOR EACH ROW
EXECUTE PROCEDURE check_overlapping_opening();