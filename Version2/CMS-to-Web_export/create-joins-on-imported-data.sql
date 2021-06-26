/*Create the database via create-tables.collection-online.sql script*/
/*Remove the embedded, tabbed tables from the XML files, rename XML to match the table names*/
/*Use the import.php script to import all data*/
/*Import the CSVs as mapping tables*/

/*Initially alter the ecatalogue table and add an image URL - Sub Out DB name*/
ALTER TABLE `20210615_Web`.ecatalogue ADD ImageURL varchar(255) NULL;
ALTER TABLE `20210615_Web`.ecatalogue ADD DetRights varchar(255) NULL;
ALTER TABLE `20210615_Web`.eparties ADD ObjectRef TEXT NULL;
ALTER TABLE `20210615_Web`.enarratives ADD ObjectRef TEXT NULL;
ALTER TABLE `20210615_Web`.enarratives ADD PartiesRef TEXT NULL;

/*Create all necessary indexes*/
CREATE INDEX emultimedia_irn_IDX USING BTREE ON `20210615_Web`.emultimedia (irn);
CREATE INDEX ecatalogue_irn_IDX USING BTREE ON `20210615_Web`.ecatalogue (irn);
CREATE INDEX enarratives_NarrativeIRN_IDX USING BTREE ON `20210615_Web`.enarratives (NarrativeIRN);
CREATE INDEX eparties_PartiesIRN_IDX USING BTREE ON `20210615_Web`.eparties (PartiesIRN);
CREATE INDEX Narratives_AttachmentsIRNS_NarrativeIRN_IDX USING BTREE ON `20210615_Web`.Narratives_AttachmentsIRNS (NarrativeIRN,AuthorIRN,ContribIRN,MasterIRN);
CREATE INDEX Objects_CreatorIRNS_ObjectIRN_IDX USING BTREE ON `20210615_Web`.Objects_CreatorIRNS (ObjectIRN,CreatorIRN);
CREATE INDEX Objects_MultimediaIRNS_ObjectIRN_IDX USING BTREE ON `20210615_Web`.Objects_MultimediaIRNS (ObjectIRN,MultimediaIRN);

/*DEPENDING ON EMU EXPORT YOU WILL NEED TO DRAW IMAGES FROM EITHER THE MULTIMEDIA CSV OR OBJECT_MULTMEDIA CSV.*/
/*IF OBJECT_MULTMEDIA CSV - Now add image URL via the Objects_Multimedia Mapping table*/
USE `20210615_Web`;
UPDATE ecatalogue ec
JOIN Objects_MultimediaIRNS omi ON omi.ObjectIRN = ec.irn
JOIN emultimedia mm ON mm.irn = omi.MultimediaIRN
SET ec.ImageURL = Concat('/sites/default/files/', mm.MulIdentifier),
    ec.DetRights = mm.DetRights

/*IF MULTIMEDIA CSV - Now add image URL via the intermedia ecat_map Mapping table*/
UPDATE 
ecatalogue e
INNER JOIN ecat_map em ON e.irn = em.objectirn 
INNER JOIN MulMultimedia mm ON em.ecatalogueid = mm.ecatalogue_key 
SET
	e.ImageURL = CONCAT('/sites/default/files/',mm.Multimedia)
WHERE mm.ecatalogue_key IS NOT NULL or LENGTH(mm.ecatalogue_key)=0

/*and update the rights*/
USE `20210615_Web`;
UPDATE ecatalogue ec
JOIN Objects_MultimediaIRNS omi ON omi.ObjectIRN = ec.irn
JOIN emultimedia mm ON mm.irn = omi.MultimediaIRN
SET ec.DetRights = mm.DetRights

/*END PICK A PATH JOURNEY AND RETURN TO GLOBAL BUIL PATH*/

/* Add Objects to Parties */
SET SESSION group_concat_max_len = 1000000;
USE `20210615_Web`;
UPDATE eparties ep
SET ep.ObjectRef = (
	SELECT GROUP_CONCAT(DISTINCT cs.ObjectIRN SEPARATOR ';')
	FROM Objects_CreatorIRNS cs
	WHERE cs.CreatorIRN = ep.PartiesIRN
	GROUP BY cs.CreatorIRN
	)

/* Add objects to narratives - not current export is doing enarratives to eobjects direct, this may need to change*/
USE `20210615_Web`;
UPDATE enarratives en
JOIN ecatalogue ec ON ec.TitAccessionNo = en.DetNarrativeIdentifier
SET en.ObjectRef = ec.irn

/* Add authors to narratives - needs work for join to parties*/
SET SESSION group_concat_max_len = 1000000;
USE `20210615_Web`;
UPDATE enarratives en
SET en.PartiesRef = (
	SELECT GROUP_CONCAT(DISTINCT cs.AuthorIRN SEPARATOR ';')
	FROM Narratives_AttachmentsIRNS cs
    WHERE en.NarrativeIRN = ep.PartiesIRN
	GROUP BY cs.NarrativeIRN
	)

/*Generator a creator list on the object*/
USE `20210615_Web`;
UPDATE 
	`20210615_Web`.ecatalogue e
INNER JOIN
	`20210615_Web`.Objects_CreatorIRNS ON Objects_CreatorIRNS.ObjectIRN = e.irn
SET e.CreRole = (
	SELECT
		GROUP_CONCAT(CONCAT(p.NamOrganisation, p.NamLast, ', ', p.NamFirst, ' - ', oc.CreRole) SEPARATOR '; ') AS 'CreRole'
	FROM `20210615_Web`.eparties p 
	INNER JOIN `20210615_Web`.Objects_CreatorIRNS oc ON p.PartiesIRN = oc.CreatorIRN
	WHERE oc.ObjectIRN = e.irn
	GROUP BY oc.ObjectIRN
)
WHERE e.irn = Objects_CreatorIRNS.ObjectIRN


/*ONCE FULLY EXECUTED NOW NEED TO QUERY DATA FOR FEEDS INGEST*/

/*Export Objects*/
SELECT
irn AS "ecatalogue_key",
TitAccessionNo AS "Accession No.",
AccCreditLineLocal AS "Credit Line",
TitMainTitle AS "Title",
CrePlaceOfExecution AS "Place of execution",
PhyMediaCategory AS "Medium",
PhyVerbatimMeasurementsA AS "Main measurement",
PhyVerbatimMeasurementsB AS "Secondary measurement",
CreDateCreated AS "Date Created",
CreEarliestDate AS "EarliestDate",
CreLatestDate AS "LatestDate",
PhySupport AS "Physical support",
EdiImpression AS "Edition",
TitDepartment AS "QAGOMA Department",
PhyMediaCategory AS "Primary Media",
PhySecondaryMediaCategory AS "Secondary Media",
ImageURL AS "URL",
ObjectType AS "Subjects",
PhyMediumText AS "MediumText",
DetRights AS "Rights",
CreRole AS "Creator List"
FROM ecatalogue
WHERE AdmPublishWebPassword LIKE 'Yes'

/*Export Parties*/
SELECT
NamFirst,
NamLast,
NamOrganisation,
Country,
BioBirthPlace,
BioDeathPlace,
BioBirthDate,
BioDeathDate,
PartiesIRN,
BioCulturalIdentity1,
ObjectRef,
CONCAT(NamFirst, ' ', NamLast, NamOrganisation) AS Title
FROM eparties
WHERE PartiesPublishInternet LIKE 'Yes'

/*Export Narratives*/
SELECT
NarDate,
DesPurpose,
NarTitle,
DesType,
DesSubjects,
NarrativeIRN,
NarNarrative,
ObjectRef,
PartiesRef
FROM enarratives
WHERE NarrativePublishInternet LIKE 'Yes'