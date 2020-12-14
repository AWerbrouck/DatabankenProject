CREATE FUNCTION check_zelfde_regio()
	RETURNS trigger AS
$BODY$
DECLARE
BEGIN

	IF EXISTS(
			SELECT
				1
			FROM
				kortingen k
					INNER JOIN toeristischeactiviteit t
							   ON new.activiteit_postcode = t.postcode AND new.activiteitnaam = t.activiteitnaam
					INNER JOIN hotel h
							   ON new.hotel_id = h.h_id
			WHERE
				t.toeristische_regio != h.regio
		) THEN
		RAISE EXCEPTION 'A hotel can not give a discount on an activity that is not in the same region';
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