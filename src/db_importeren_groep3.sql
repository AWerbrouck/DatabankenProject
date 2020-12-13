--voeg ToeristischeActiviteiten toe

INSERT INTO
	ToeristischeActiviteit(toeristische_regio, activiteittype, prijsperpersoon, straat, postcode, activiteitnaam,
						   gemeente, huisnummer, beschrijving, activiteit_website, activiteit_telefoonnummer,
						   activiteit_toegang_doof, activiteit_toegang_slechthorend, activiteit_toegang_mentaal,
						   activiteit_toegang_motorisch, activiteit_toegang_blind, activiteit_toegang_slechtziend,
						   activiteit_toegang_autisme)
	(SELECT DISTINCT
		 toeristische_regio,
		 activiteittype,
		 activiteit_prijs,
		 straat,
		 postcode,
		 activiteitnaam,
		 gemeente,
		 huisnummer,
		 beschrijving,
		 activiteit_website,
		 activiteit_telefoonnummer,
		 activiteit_toegang_doof::boolean,
		 activiteit_toegang_slechthorend::boolean,
		 activiteit_toegang_mentaal::boolean,
		 activiteit_toegang_motorisch::boolean,
		 activiteit_toegang_blind::boolean,
		 activiteit_toegang_slechtziend::boolean,
		 activiteit_toegang_autisme::boolean
	 FROM
		 super_activiteitreservaties);


--voeg openingstijd toe

INSERT INTO
	openingstijd(starttijd, duur, postcode, naam)
	(SELECT DISTINCT begintijdstip::timestamp, duur::interval, postcode, activiteitnaam
	 FROM super_activiteitreservaties);


--voeg Personen toe

INSERT INTO
	Persoon(email, voornaam, achternaam)
	(SELECT DISTINCT
		 persoon_email,
		 voornaam,
		 achternaam
	 FROM
		 super_activiteitreservaties
	 WHERE
		 NOT EXISTS(SELECT 1 from persoon p where p.email = persoon_email ));


--voeg inschrijvingen toe

INSERT INTO
	inschrijving(emailpersoon, postcode, naam, aantal, bevestigd, tijdstip, persoon_doof, persoon_slechthorend,
				 persoon_mentaal, persoon_motorisch, persoon_blind, persoon_slechtziend, persoon_autisme)
	(SELECT DISTINCT
		 persoon_email,
		 postcode,
		 activiteitnaam,
		 aantal_personen::integer,
		 boeking_bevestigd::boolean,
		 begintijdstip::timestamp,
		 persoon_doof::integer,
		 persoon_slechthorend::integer,
		 persoon_mentaal::integer,
		 persoon_motorisch::integer,
		 persoon_blind::integer,
		 persoon_slechtziend::integer,
		 persoon_autisme::integer
	 FROM
		 super_activiteitreservaties);


--voeg hotel toe

INSERT INTO
	Hotel(beschrijving, sterren, minprijs, email, H_ID, naam, regio, gemeente, postcode, huisnummer, straat)
	(SELECT DISTINCT
		 hotel_beschrijving,
		 aantal_sterren,
		 minimumprijs::float,
		 hotel_email,
		 hotelid,
		 hotelnaam,
		 toeristische_regio,
		 gemeente,
		 postcode,
		 huisnummer,
		 straat
	 FROM
		 super_hotelboekingen);


--voeg persoon toe

INSERT INTO
	Persoon(email, voornaam, achternaam)
	(SELECT DISTINCT persoon_email, voornaam, achternaam FROM super_hotelboekingen WHERE
		 NOT EXISTS(SELECT 1 from persoon p where p.email = persoon_email ));


--voeg boeking toe

INSERT INTO
	boekingen(emailpersoon, hotel_id, tijdstip, begintijd, eindtijd, aantal, bevestigd)
	(SELECT DISTINCT
		 persoon_email,
		 hotelid,
		 boekingstijdstip::timestamp,
		 begindatum::date,
		 einddatum::date,
		 aantal_personen,
		 boeking_bevestigd
	 FROM
		 super_hotelboekingen);


--voeg korting toe

INSERT INTO
	kortingen(activiteitnaam, activiteit_postcode, hotel_id, percentage_korting)
	(SELECT DISTINCT activiteitnaam, activiteit_postcode, hotelid, percentage_korting FROM super_kortingen);
