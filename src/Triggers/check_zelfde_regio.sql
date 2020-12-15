CREATE FUNCTION check_zelfde_regio()
	RETURNS trigger AS
$BODY$
DECLARE
BEGIN

	IF EXISTS(
			SELECT
				1
			FROM
				toeristischeactiviteit t,
				hotel h
			WHERE
				  new.activiteit_postcode = t.postcode
			  AND new.activiteitnaam = t.activiteitnaam
			  AND new.hotel_id = h.h_id
			  AND t.toeristische_regio != h.regio
		) THEN
		RAISE EXCEPTION 'Hotel kan geen korting geven op een activiteit in een andere regio';
	END IF;
	RETURN new;
END;
$BODY$
	LANGUAGE plpgsql;

CREATE TRIGGER check_zelfde_regio_trigger
	BEFORE INSERT
	ON kortingen
	FOR EACH ROW
EXECUTE PROCEDURE check_zelfde_regio();