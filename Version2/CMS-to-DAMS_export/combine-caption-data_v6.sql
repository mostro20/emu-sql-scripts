USE `20211103_DAMS`;
SET SESSION group_concat_max_len = 1000000;
DROP PROCEDURE IF EXISTS ROWPERROW5;
DELIMITER //
CREATE PROCEDURE ROWPERROW5()
BEGIN
    TRUNCATE caption_data;
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
    WITH
        epartiesinfo AS (
            SELECT DISTINCT
                NULLIF(cre.PartiesSummaryData, '') AS PartiesSummaryData,
                NULLIF(cre.BioBirthDate, '') AS BioBirthDate,
                NULLIF(cre.BioDeathDate, '') AS BioDeathDate,
                NULLIF(cre.BioCulturalIdentity1, '') AS BioCulturalIdentity1,
                NULLIF(cre.Country, '') AS Country,
                NULLIF(cre.PartiesIRN, '') AS PartiesIRN,
                NULLIF(objirn.CreRole, '') AS CreRole,
                objirn.ObjectIRN AS ObjectIRN,
                objirn.ObjectsCreatorIRNs_key as ObjectsCreatorIRNs_key
            FROM Objects_attachedCreatorIRNS objirn
                INNER JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
                ORDER BY ObjectsCreatorIRNs_key ASC
        ),
        erightsinfo AS (
            SELECT DISTINCT
                r.RigAcknowledgement,
                r.ObjectIRN AS ObjectIRN
            FROM attachedRightsIRNS_csv r
            WHERE r.RigAcknowledgement IS NOT NULL AND r.RigAcknowledgement != ''
        )
    SELECT distinct
        e.irn AS cms_irn,
        e.TitObjectStatus AS object_type,
        e.TitAccessionNo AS accession_no,
        e.TitMainTitle AS title,
        e.CreDateCreated AS 'year',
        (SELECT group_concat(concat_ws(' ', ri1.RigAcknowledgement) order by ri1.ObjectIRN separator '\n') FROM erightsinfo ri1 WHERE ri1.ObjectIRN = e.irn) AS rights,
        (SELECT group_concat(concat_ws(' ', pi1.PartiesSummaryData, ' (', pi1.CreRole, ') ', ' b.', pi1.BioBirthDate, ' - ', pi1.BioDeathDate) order by pi1.PartiesIRN separator '\n') FROM epartiesinfo pi1 WHERE pi1.ObjectIRN = e.irn) AS creators,
        'place_created' AS place_created,
        CONCAT(e.PhyVerbatimMeasurementsA, ' ', e.PhyVerbatimMeasurementsB) AS dimensions,
        e.AccCreditLineLocal AS credit,
        CONCAT(e.PhyMediumText, ' ', e.PhySupport) AS media_statement,
        'digital fields' AS special_digital_meta,
        (SELECT group_concat(concat_ws(' ', e.TitMainTitle, ' ', e.CreDateCreated, ' ', pi2.PartiesSummaryData, ' (', pi2.CreRole, ') ', ' b.', pi2.BioBirthDate, '–', pi2.BioDeathDate) order by pi2.PartiesIRN separator '\n') FROM epartiesinfo pi2 WHERE pi2.ObjectIRN = e.irn) AS short_caption,
        CONCAT_WS(' ',
            (
                SELECT 
                group_concat(concat_ws(' ',
                pi3.PartiesSummaryData,
				CONCAT(IF(pi3.CreRole IS NULL or pi3.CreRole = '','','('),pi3.CreRole,IF(pi3.CreRole IS NULL or pi3.CreRole = '','',')')),CHAR(13),
                NULLIF(pi3.BioCulturalIdentity1, ''),
                pi3.Country, ' ',
                (CASE
                    WHEN LENGTH(pi3.BioBirthDate) > 1 AND LENGTH(pi3.BioDeathDate) < 1 THEN CONCAT('b.',pi3.BioBirthDate)
                    WHEN pi3.BioBirthDate LIKE 'c.' AND LENGTH(pi3.BioDeathDate) < 1 THEN pi3.BioBirthDate
                    WHEN pi3.BioBirthDate LIKE 'c.' AND LENGTH(pi3.BioDeathDate) > 1 THEN CONCAT(pi3.BioBirthDate,'–',pi3.BioDeathDate)
                    ELSE CONCAT(pi3.BioBirthDate,'–',pi3.BioDeathDate)
                END)                
                ) 
                order by pi3.PartiesIRN separator '\n')
            FROM epartiesinfo pi3
            WHERE pi3.ObjectIRN = e.irn
            ),
                CHAR(13),
                NULLIF(e.TitMainTitle, ''), ' ', NULLIF(e.CreDateCreated, ''), CHAR(13),
                NULLIF(e.PhyMediumText, ''), ' ', CONCAT(NULLIF(e.PhySupport, ''),IF(e.EdiImpression IS NULL or e.EdiImpression = '','',',')), NULLIF(e.EdiImpression, ''), CHAR(13),
                NULLIF(e.PhyVerbatimMeasurementsA, ''), ' ', NULLIF(e.PhyVerbatimMeasurementsB, ''), CHAR(13),
                (CASE
                    WHEN LENGTH(e.TitAccessionNo) > 1 THEN CONCAT('Acc. ', e.TitAccessionNo)
                    ELSE CONCAT('Temp no. ', e.TitPreviousNumber)
                END),
                CHAR(13),
                NULLIF(e.AccCreditLineLocal, ''), CHAR(13),
                (SELECT group_concat(concat_ws(' ', NULLIF(ri2.RigAcknowledgement, ''))order by ri2.ObjectIRN separator '\n') FROM erightsinfo ri2 WHERE ri2.ObjectIRN = e.irn)
            ) AS long_caption,
        AdmDateModified AS last_updated
    FROM ecatalogue e
        LEFT JOIN Objects_attachedCreatorIRNS objirn ON objirn.ObjectIRN = e.irn
        LEFT JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
        LEFT JOIN attachedRightsIRNS_csv rigirn ON rigirn.ObjectIRN = e.irn;
End
//
