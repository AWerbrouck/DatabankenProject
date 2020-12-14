CREATE FUNCTION check_overlapping_boeking()
	RETURNS trigger AS
$BODY$
DECLARE
BEGIN

	IF EXISTS(
			SELECT
				1
			FROM
				boekingen b
			WHERE
				  b.emailpersoon = new.emailpersoon
			  AND b.hotel_id = new.hotel_id
			  AND b.begintijd <= new.begintijd
			  AND new.eindtijd <= b.eindtijd
		) THEN
		RAISE EXCEPTION 'yeet';
	END IF;

	IF EXISTS(
			SELECT
				1
			FROM
				boekingen b
			WHERE
				  b.emailpersoon = new.emailpersoon
			  AND b.hotel_id = new.hotel_id
			  AND b.begintijd <= new.begintijd
			  AND new.begintijd <= new.eindtijd
		) THEN
		RAISE EXCEPTION 'yeet';
	END IF;

	IF EXISTS(
			SELECT
				1
			FROM
				boekingen b
			WHERE
				  b.emailpersoon = new.emailpersoon
			  AND b.hotel_id = new.hotel_id
			  AND b.begintijd <= new.eindtijd
			  AND new.eindtijd <= b.eindtijd
		) THEN
		RAISE EXCEPTION 'yeet';
	END IF;

	RETURN new;

END ;
$BODY$
	LANGUAGE plpgsql;

CREATE TRIGGER check_overlapping_boeking_trigger
	BEFORE INSERT
	ON boekingen
	FOR EACH ROW
EXECUTE PROCEDURE check_overlapping_boeking();