CREATE FUNCTION check_duplicate_persoon()
	RETURNS trigger AS
$BODY$
DECLARE
BEGIN
	IF EXISTS(
	    select 1 from persoon p where p.email = new.email
		) THEN
	END IF;
END;
$BODY$
	LANGUAGE plpgsql;

CREATE TRIGGER check_duplicate_persoon_trigger
	BEFORE INSERT
	ON persoon
	FOR EACH ROW
EXECUTE PROCEDURE check_duplicate_persoon();