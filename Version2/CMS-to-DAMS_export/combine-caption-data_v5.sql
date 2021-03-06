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
                objirn.ObjectIRN AS ObjectIRN
            FROM Objects_attachedCreatorIRNS objirn
                INNER JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
        ),
        erightsinfo AS (
            SELECT DISTINCT
                r.RigAcknowledgement,
                r.irn,
                rigirn.ObjectIRN AS ObjectIRN
            FROM Objects_attachedRightsIRNS rigirn
                INNER JOIN erights r ON rigirn.RightsIRN = r.irn

            WHERE r.RigAcknowledgement IS NOT NULL AND r.RigAcknowledgement != ''
        )
    SELECT distinct
        e.irn AS cms_irn,
        e.TitObjectStatus AS object_type,
        e.TitAccessionNo AS accession_no,
        e.TitMainTitle AS title,
        e.CreDateCreated AS 'year',
        (SELECT group_concat(concat_ws(' ', ri1.RigAcknowledgement) order by ri1.irn separator '\n') FROM erightsinfo ri1 WHERE ri1.ObjectIRN = e.irn) AS rights,
        (SELECT group_concat(concat_ws(' ', pi1.PartiesSummaryData, ' (', pi1.CreRole, ') ', ' b.', pi1.BioBirthDate, ' - ', pi1.BioDeathDate) order by pi1.PartiesIRN separator '\n') FROM epartiesinfo pi1 WHERE pi1.ObjectIRN = e.irn) AS creators,
        'place_created' AS place_created,
        CONCAT(e.PhyVerbatimMeasurementsA, ' ', e.PhyVerbatimMeasurementsB) AS dimensions,
        e.AccCreditLineLocal AS credit,
        CONCAT(e.PhyMediumText, ' ', e.PhySupport) AS media_statement,
        'digital fields' AS special_digital_meta,
        (SELECT group_concat(concat_ws(' ', e.TitMainTitle, ' ', e.CreDateCreated, ' ', pi2.PartiesSummaryData, ' (', pi2.CreRole, ') ', ' b.', pi2.BioBirthDate, ' - ', pi2.BioDeathDate) order by pi2.PartiesIRN separator '\n') FROM epartiesinfo pi2 WHERE pi2.ObjectIRN = e.irn) AS short_caption,
        CONCAT_WS(' ',
            (SELECT group_concat(concat_ws(' ', pi3.PartiesSummaryData, ' (', pi3.CreRole, ') ', CHAR(13),NULLIF(pi3.BioCulturalIdentity1, ''),pi3.Country, ' ',  ' b.', pi3.BioBirthDate, ' - ', pi3.BioDeathDate) order by pi3.PartiesIRN separator '\n')
            FROM epartiesinfo pi3
            WHERE pi3.ObjectIRN = e.irn),
                NULLIF(e.TitMainTitle, ''), ' ', NULLIF(e.CreDateCreated, ''), CHAR(13),
                NULLIF(e.PhyMediumText, ''), ' ', NULLIF(e.PhySupport, ''), CHAR(13),
                NULLIF(e.PhyVerbatimMeasurementsA, ''), ' ', NULLIF(e.PhyVerbatimMeasurementsB, ''), CHAR(13),
                'Acc.', NULLIF(e.TitAccessionNo, ''), CHAR(13),
                'Temp no.', NULLIF(e.TitPreviousNumber, ''), CHAR(13),
                NULLIF(e.AccCreditLineLocal, ''), CHAR(13),
                (SELECT group_concat(concat_ws(' ', NULLIF(ri2.RigAcknowledgement, ''))order by ri2.irn separator '\n') FROM erightsinfo ri2 WHERE ri2.ObjectIRN = e.irn)
            ) AS long_caption,
        AdmDateModified AS last_updated
    FROM ecatalogue e
        LEFT JOIN Objects_attachedCreatorIRNS objirn ON objirn.ObjectIRN = e.irn
        LEFT JOIN eparties cre ON objirn.CreatorIRN = cre.PartiesIRN
        LEFT JOIN Objects_attachedRightsIRNS rigirn ON rigirn.ObjectIRN = e.irn
        LEFT JOIN erights r ON rigirn.RightsIRN = r.irn;
End
//