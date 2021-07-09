  CREATE TABLE IF NOT EXISTS erights (
    RigAcknowledgement TEXT,
    irn INT NULL,
    SummaryData TEXT
  )  ENGINE=INNODB;

  CREATE TABLE IF NOT EXISTS eparties (
    NamFirst TEXT,
    NamLast TEXT,
    NamOrganisation TEXT,
    Country TEXT,
    BioBirthPlace TEXT,
    BioDeathPlace TEXT,
    BioBirthDate TEXT,
    BioDeathDate TEXT,
    UlaSource TEXT,
    UlaUlanIdNo TEXT,
    PartiesPurpose TEXT,
    PartiesIRN INT NULL,
    PartiesPartyType TEXT,
    PartiesPublishInternet VARCHAR(255) NULL,
    PartiesPublishIntranet VARCHAR(255) NULL,
    PartiesSummaryData TEXT,
    PartiesRecordStatus TEXT,
    BioCulturalIdentity1 TEXT
  )  ENGINE=INNODB;

  CREATE TABLE IF NOT EXISTS ecatalogue (
    irn INT NULL,
    TitMainTitle TEXT,
    CreDateCreated TEXT,
    PhyMedium_tab TEXT,
    PhySupport TEXT,
    EdiImpression TEXT,
    PhyVerbatimMeasurements TEXT,
    PhyVerbatimMeasurementsA TEXT,
    PhyVerbatimMeasurementsB TEXT,
    TitAccessionNo TEXT,
    PhyMediumText TEXT,
    AccCreditLineLocal TEXT,
    TitPreviousNumber TEXT,
    TitObjectStatus TEXT,
    TitPrimaryCreditLine TEXT,
    SummaryData TEXT,
    AdmDateModified TEXT,
    AdmTimeModified TEXT
  )  ENGINE=INNODB;

  CREATE TABLE IF NOT EXISTS emultimedia (
    MulIdentifier TEXT,
    irn INT NULL,
    AdmPublishWebNoPassword VARCHAR(255) NULL,
    MulCreator TEXT,
    DetRights TEXT,
    SummaryData TEXT
  )  ENGINE=INNODB;

  CREATE TABLE `caption_data` (
  `cms_id` int DEFAULT NULL,
  `cms_irn` int,
  `object_type` text,
  `accession_no` text,
  `title` text,
  `year` text,
  `rights` text,
  `creators` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `place_created` text,
  `dimensions` text,
  `credit` text,
  `media_statement` text,
  `special_digital_meta` text,
  `short_caption` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `long_caption` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `last_updated` text,
  `active` tinyint
) ENGINE=InnoDB;
