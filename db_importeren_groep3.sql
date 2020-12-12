--voeg ToeristischeActiviteiten toe

INSERT INTO ToeristischeActiviteit(toeristische_regio, activiteittype, openingstijd_ID, prijsperpersoon, straat, postcode, activiteitnaam, gemeente, huisnummer, beschrijving, activiteit_website, activiteit_telefoonnummer, activiteit_toegang_doof, activiteit_toegang_slechthorend, activiteit_toegang_mentaal, activiteit_toegang_motorisch, activiteit_toegang_blind, activiteit_toegang_slechtziend, activiteit_toegang_autisme)
(SELECT DISTINCT toeristische_regio, activiteittype, activiteit_prijs, straat, postcode, activiteitnaam, gemeente, huisnummer, beschrijving, activiteit_website, activiteit_telefoonnummer, activiteit_toegang_doof, activiteit_toegang_slechthorend, activiteit_toegang_mentaal, activiteit_toegang_motorisch, activiteit_toegang_blind, activiteit_toegang_slechtziend, activiteit_toegang_autisme FROM super_activiteitreservaties);


--voeg Personen toe

INSERT INTO Persoon(email, voornaam, achternaam)
(SELECT DISTINCT persoon_email, voornaam, achternaam FROM super_activiteitreservaties);


--voeg inschrijvingen toe

INSERT INTO inschrijving(emailpersoon, postcode, naam, aantal, bevestigd, tijdstip, persoon_doof, persoon_slechthorend, persoon_mentaal, persoon_motorisch, persoon_blind, persoon_slechtziend, persoon_autisme)
(SELECT DISTINCT persoon_email, postcode, activiteitnaam, aantal_personen, boeking_bevestigd, begintijdstip,persoon_doof, persoon_slechthorend, persoon_mentaal, persoon_motorisch, persoon_blind, persoon_slechtziend, persoon_autismepersoon_doof, persoon_slechthorend, persoon_mentaal, persoon_motorisch, persoon_blind, persoon_slechtziend, persoon_autisme FROM super_activiteitreservaties); 


--voeg hotel toe

INSERT INTO Hotel(beschrijving, sterren, minprijs, email, H_ID, naam, regio, gemeente, postcode, huisnummer, straat)
(SELECT DISTINCT hotel_beschrijving, aantal_sterren, minimumprijs, hotel_email, hotelid, hotelnaam, toeristische_regio, gemeente, postcode, huisnummer, straat FROM super_hotelboekingen);


--voeg persoon toe

INSERT INTO Persoon(email, voornaam, achternaam)
(SELECT DISTINCT persoon_email, voornaam, achternaam FROM super_hotelboekingen);


--voeg boeking toe

INSERT INTO boekingen(emailpersoon, hotel_id, tijdstip, begintijd, eindtijd, aantal, bevestigd)
(SELECT DISTINCT persoon_email, hotelid, boekingstijdstip, begindatum, einddatum, aantal_personen, boeking_bevestigd FROM super_hotelboekingen);


--voeg korting toe

INSERT INTO kortingen(activiteitnaam, activiteit_postcode, hotel_id, percentage_korting)
(SELECT DISTINCT activiteitnaam, activiteit_postcode, hotelid, percentage_korting FROM super_kortingen);
