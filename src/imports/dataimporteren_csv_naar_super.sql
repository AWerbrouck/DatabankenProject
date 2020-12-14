--change path relative to local csv files

COPY super_activiteitreservaties(activiteittype, activiteitnaam, straat, huisnummer, postcode, gemeente, toeristische_regio, activiteit_telefoonnummer, activiteit_website, beschrijving, activiteit_toegang_doof, activiteit_toegang_slechthorend, activiteit_toegang_mentaal, activiteit_toegang_motorisch, activiteit_toegang_blind, activiteit_toegang_slechtziend, activiteit_toegang_autisme, activiteit_prijs, begintijdstip, duur, voornaam, achternaam, persoon_email, boeking_bevestigd, aantal_personen, persoon_doof, persoon_slechthorend, persoon_mentaal, persoon_motorisch, persoon_blind, persoon_slechtziend, persoon_autisme)
FROM '../data/activiteitreservaties.csv'
DELIMITER ';'
CSV HEADER;

COPY super_hotelboekingen(hotelid, hotelnaam, straat, huisnummer, postcode, gemeente, toeristische_regio, hotel_email, hotel_beschrijving, aantal_sterren, minimumprijs, voornaam, achternaam, persoon_email, boekingstijdstip, boeking_bevestigd, begindatum, einddatum, aantal_personen)
FROM '../data/hotelboekingen.csv'
DELIMITER ';'
CSV HEADER;

COPY super_kortingen(activiteitnaam, activiteit_postcode, hotelid, percentage_korting)
FROM '../data/kortingen.csv'
DELIMITER ';'
CSV HEADER; 
