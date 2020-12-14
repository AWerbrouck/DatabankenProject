DROP VIEW IF EXISTS is_toegankelijk CASCADE;
CREATE VIEW public.is_toegankelijk AS
(
SELECT
	CASE
		WHEN ( persoon_doof > 0 AND activiteit_toegang_doof = FALSE )
			OR ( persoon_slechthorend > 0 AND activiteit_toegang_slechthorend = 'false' )
			OR ( persoon_mentaal > 0 AND activiteit_toegang_mentaal = 'false' )
			OR ( persoon_motorisch > 0 AND activiteit_toegang_motorisch = FALSE )
			OR ( persoon_blind > 0 AND activiteit_toegang_blind = FALSE )
			OR ( persoon_autisme > 0 AND activiteit_toegang_autisme = FALSE )
			OR ( persoon_slechtziend > 0 AND activiteit_toegang_slechtziend = FALSE )
			THEN 'ontoegankelijk'
		WHEN ( persoon_doof > 0 AND activiteit_toegang_doof IS NULL )
			OR ( persoon_slechthorend > 0 AND activiteit_toegang_slechthorend IS NULL )
			OR ( persoon_mentaal > 0 AND activiteit_toegang_mentaal IS NULL )
			OR ( persoon_motorisch > 0 AND activiteit_toegang_motorisch IS NULL )
			OR ( persoon_blind > 0 AND activiteit_toegang_blind IS NULL )
			OR ( persoon_autisme > 0 AND activiteit_toegang_autisme IS NULL )
			OR ( persoon_slechtziend > 0 AND activiteit_toegang_slechtziend IS NULL )
			THEN 'onbekend'
		ELSE 'toegankelijk'
	END AS toegankelijkheid,
	i1.emailpersoon,
	t2.activiteitnaam,
	t2.postcode,
	i1.tijdstip
FROM
	inschrijving i1
		INNER JOIN toeristischeactiviteit t2
				   ON t2.postcode = i1.postcode AND t2.activiteitnaam = i1.naam
WHERE
	(
			( persoon_doof > 0 )
			OR ( persoon_slechthorend > 0 )
			OR ( persoon_mentaal > 0 )
			OR ( persoon_motorisch > 0 )
			OR ( persoon_blind > 0 )
			OR ( persoon_slechtziend > 0 )
			OR ( persoon_autisme > 0 )
	)
	order by tijdstip
)