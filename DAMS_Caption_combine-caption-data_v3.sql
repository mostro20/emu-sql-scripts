SET SESSION group_concat_max_len = 100000;
USE `20210412_CMS_DAMS`;
DROP PROCEDURE IF EXISTS ROWPERROW3;
DELIMITER //
CREATE PROCEDURE ROWPERROW3()
BEGIN
	DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
	SELECT COUNT(*) FROM ecatalogue INTO n;
	SET i=0;
	WHILE i<n DO 
	INSERT INTO caption_data
		(
		cms_irn, 
		object_type,
		accession_no,
		title,
		`year`,
		rights,
		creators,
		place_created,
		dimensions,
		credit,
		media_statement,
		special_digital_meta,
		short_caption,
		long_caption,
		last_updated
	) 
    SELECT DISTINCT
		e.irn AS cms_irn,
		e.TitObjectStatus AS object_type,
		e.TitAccessionNo AS accession_no,
		e.TitMainTitle AS title,
		e.CreDateCreated AS 'year',
		(SELECT
			group_concat(concat_ws(' ', NULLIF(r.RigAcknowledgement, ""))order by r.irn separator '\n')
			FROM ecatalogue e
			LEFT JOIN Objects_attachedRightsIRNS_csv rigirn ON rigirn.ObjectIRN = e.irn
			LEFT JOIN erights r ON rigirn.RightsIRN = r.irn
			WHERE e.irn = i	            
        ) AS rights,
		(
			SELECT
			group_concat(concat_ws(' ', NULLIF(cre.PartiesSummaryData, ""), ' b.', NULLIF(cre.BioBirthDate, ""), ' - ', NULLIF(cre.BioDeathDate, "")) order by cre.PartiesIRN separator '\n')
			FROM ecatalogue e
			LEFT JOIN Objects_attachedCreatorIRNS_csv objirn ON objirn.ObjectIRN = e.irn
			LEFT JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
			WHERE e.irn = i
		) AS creators,
		'place_created' AS place_created,
		CONCAT(e.PhyVerbatimMeasurementsA, ' ', e.PhyVerbatimMeasurementsB) AS dimensions,
		e.AccCreditLineLocal AS credit,
		CONCAT(e.PhyMediumText, ' ', e.PhySupport) AS media_statement,
		'digital fields' AS special_digital_meta,
		(
			SELECT
			group_concat(concat_ws(' ', NULLIF(e.TitMainTitle, ""), ' ', NULLIF(e.CreDateCreated, ""), ' ', NULLIF(cre.PartiesSummaryData, ""), ' b.', NULLIF(cre.BioBirthDate, ""), ' - ', NULLIF(cre.BioDeathDate, "")) order by cre.PartiesIRN separator '\n')
			FROM ecatalogue e
			LEFT JOIN Objects_attachedCreatorIRNS_csv objirn ON objirn.ObjectIRN = e.irn
			LEFT JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
			WHERE e.irn = i
		) AS short_caption,
		CONCAT_WS(' ',
			(
				SELECT
				group_concat(concat_ws(' ', NULLIF(cre.PartiesSummaryData, ""), CHAR(13),
				NULLIF(cre.BioCulturalIdentity1, ""),
				NULLIF(cre.Country, ""), ' ',  ' b.', NULLIF(cre.BioBirthDate, ""), ' - ', NULLIF(cre.BioDeathDate, "")) order by cre.PartiesIRN separator '\n')
				FROM ecatalogue e
				LEFT JOIN Objects_attachedCreatorIRNS_csv objirn ON objirn.ObjectIRN = e.irn
				LEFT JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
				WHERE e.irn = i
			),
			NULLIF(e.TitMainTitle, ""), ' ', NULLIF(e.CreDateCreated, ""), CHAR(13), 
			NULLIF(e.PhyMediumText, ""), ' ', NULLIF(e.PhySupport, ""), CHAR(13),
			NULLIF(e.PhyVerbatimMeasurementsA, ""), ' ', NULLIF(e.PhyVerbatimMeasurementsB, ""), CHAR(13),
			'Acc.', NULLIF(e.TitAccessionNo, ""), CHAR(13),
			'Temp no.', NULLIF(e.TitPreviousNumber, ""), CHAR(13),
			NULLIF(e.AccCreditLineLocal, ""), CHAR(13),
            (SELECT	group_concat(concat_ws(' ', NULLIF(r.RigAcknowledgement, ""))order by r.irn separator '\n')
			FROM ecatalogue e
			LEFT JOIN Objects_attachedRightsIRNS_csv rigirn ON rigirn.ObjectIRN = e.irn
			LEFT JOIN erights r ON rigirn.RightsIRN = r.irn
			WHERE e.irn = i    
			)
		) AS long_caption,
		DATE(NOW()) AS last_updated
		FROM ecatalogue e
        LEFT JOIN Objects_attachedCreatorIRNS_csv objirn ON objirn.ObjectIRN = e.irn
		LEFT JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
        LEFT JOIN Objects_attachedRightsIRNS_csv rigirn ON rigirn.ObjectIRN = e.irn
        LEFT JOIN erights r ON rigirn.RightsIRN = r.irn
		WHERE e.irn = i
        LIMIT 1;
	SET i = i + 1;
END WHILE;
End 
//
