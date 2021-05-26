/*Create the database via create-tables.collection-online.sql script*/
/*Remove the embedded, tabbed tables from the XML files, rename XML to match the table names*/
/*Use the import.php script to import all data*/
/*Import the CSVs as mapping tables*/

/*Initially alter the ecatalogue table and add an image URL - Sub Out DB name*/
ALTER TABLE `20210526_Web`.ecatalogue ADD ImageURL varchar(255) NULL;
ALTER TABLE `20210526_Web`.ecatalogue ADD DetRights varchar(255) NULL;
ALTER TABLE `20210526_Web`.eparties ADD ObjectRef TEXT NULL;
ALTER TABLE `20210526_Web`.enarratives ADD ObjectRef TEXT NULL;
ALTER TABLE `20210526_Web`.enarratives ADD PartiesRef TEXT NULL;

/*Create all necessary indexes*/
CREATE INDEX emultimedia_irn_IDX USING BTREE ON `20210526_Web`.emultimedia (irn);
CREATE INDEX ecatalogue_irn_IDX USING BTREE ON `20210526_Web`.ecatalogue (irn);
CREATE INDEX enarratives_NarrativeIRN_IDX USING BTREE ON `20210526_Web`.enarratives (NarrativeIRN);
CREATE INDEX eparties_PartiesIRN_IDX USING BTREE ON `20210526_Web`.eparties (PartiesIRN);
CREATE INDEX Narratives_AttachmentsIRNS_NarrativeIRN_IDX USING BTREE ON `20210526_Web`.Narratives_AttachmentsIRNS (NarrativeIRN,AuthorIRN,ContribIRN,MasterIRN);
CREATE INDEX Objects_CreatorIRNS_ObjectIRN_IDX USING BTREE ON `20210526_Web`.Objects_CreatorIRNS (ObjectIRN,CreatorIRN);
CREATE INDEX Objects_MultimediaIRNS_ObjectIRN_IDX USING BTREE ON `20210526_Web`.Objects_MultimediaIRNS (ObjectIRN,MultimediaIRN);

/*Now add image URL via the Objects_Multimedia Mapping table*/
USE `20210526_Web`;
UPDATE ecatalogue ec
JOIN Objects_MultimediaIRNS omi ON omi.ObjectIRN = ec.irn
JOIN emultimedia mm ON mm.irn = omi.MultimediaIRN
SET ec.ImageURL = Concat('/sites/default/files/', mm.MulIdentifier),
    ec.DetRights = mm.DetRights

/* Add Objects to Parties */
SET SESSION group_concat_max_len = 1000000;
USE `20210526_Web`;
UPDATE eparties ep
SET ep.ObjectRef = (
	SELECT GROUP_CONCAT(DISTINCT cs.ObjectIRN SEPARATOR ';')
	FROM Objects_CreatorIRNS cs
	WHERE cs.CreatorIRN = ep.PartiesIRN
	GROUP BY cs.CreatorIRN
	)

/* Add objects to narratives - not current export is doing enarratives to eobjects direct, this may need to change*/
USE `20210526_Web`;
UPDATE enarratives en
JOIN ecatalogue ec ON ec.TitAccessionNo = en.DetNarrativeIdentifier
SET en.ObjectRef = ec.irn

/* Add authors to narratives */
SET SESSION group_concat_max_len = 1000000;
USE `20210526_Web`;
UPDATE enarratives en
SET en.PartiesRef = (
	SELECT GROUP_CONCAT(DISTINCT cs.AuthorIRN SEPARATOR ';')
	FROM Narratives_AttachmentsIRNS cs
    WHERE en.NarrativeIRN = ep.PartiesIRN
	GROUP BY cs.NarrativeIRN
	)