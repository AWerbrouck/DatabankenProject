-- insert into boekingen(
--                       emailpersoon,
--                       hotel_id,
--                       tijdstip,
--                       begintijd,
--                       eindtijd,
--                       aantal,
--                       bevestigd
--
--
-- )values(
-- 'chelsea.perrone@outlook.com','387237','2020-05-24 08:15:35.000000','2020-07-17','2020-09-06','7','true'
-- )','
--
-- insert into openingstijd(openingstijd_id,starttijd,duur,postcode,naam
--
--
--
-- )values('1','2020-08-07 09:00:00.000000','0 years 0 mons 0 days 8 hours 30 mins 0.00 secs','8570','Het Lijsternest: Streuvelshuis & schrijversresidentie')','
--
-- insert into kortingen(
--                       activiteitnaam,activiteit_postcode,hotel_id,percentage_korting
--
-- )VALUES (
-- 'La Belle','2440','218978','101'
-- )','


insert into inschrijving (emailpersoon,postcode,naam,aantal,bevestigd,tijdstip,persoon_doof,persoon_slechthorend,persoon_mentaal,persoon_motorisch,persoon_blind,persoon_slechtziend,persoon_autisme
)
values ('kwaku.sorbey@outlook.com','9770','Vinto','2','true','2020-08-04 11:30:00.000000','0','0','0','0','0','1','0')


-- DROP TABLE IF EXISTS ToeristischeActiviteit CASCADE','
-- DROP TABLE IF EXISTS Persoon CASCADE','
-- DROP TABLE IF EXISTS Hotel CASCADE','
-- DROP TABLE IF EXISTS inschrijving CASCADE','
-- DROP TABLE IF EXISTS boekingen CASCADE','
-- DROP TABLE IF EXISTS kortingen CASCADE','
-- DROP TABLE IF EXISTS openingstijd CASCADE','
-- DROP TRIGGER IF EXISTS check_overlapping_opening_trigger ON openingstijd CASCADE','
-- DROP SEQUENCE IF EXISTS openingstijd_id_seq CASCADE','
-- DROP FUNCTION IF EXISTS check_zelfde_regio() CASCADE','
-- DROP TRIGGER IF EXISTS check_zelfde_regio_trigger ON kortingen','
-- DROP FUNCTION IF EXISTS check_overlapping_opening() CASCADE','
-- DROP TRIGGER IF EXISTS check_overlapping_opening_trigger ON openingstijd','
-- DROP FUNCTION IF EXISTS check_overlapping_boeking() CASCADE','
-- DROP TRIGGER IF EXISTS check_overlapping_boeking_trigger ON boekingen','
-- DROP view IF EXISTS prijs_boeking cascade','
-- DROP VIEW IF EXISTS prijs_inschrijving CASCADE','
-- DROP VIEW IF EXISTS is_toegankelijk CASCADE','
