
CREATE TABLE IF NOT EXISTS emultimedia (
    MulIdentifier TEXT,
    irn INT NOT NULL,
    AdmPublishWebNoPassword VARCHAR(255) NULL,
    MulCreator TEXT,
    DetRights TEXT,
    SummaryData TEXT
)  ENGINE=INNODB;
    
CREATE TABLE IF NOT EXISTS enarratives (
    DesGeographicLocation TEXT,
    NarDate TEXT,
    DesPurpose TEXT,
    DetNarrativeIdentifier TEXT,
    NarSource TEXT,
    NarTitle TEXT,
    DesType TEXT,
    DesSubjects TEXT,
    NarLanguage TEXT,
    NarPublisher TEXT,
    HieChildNarrativesDescription TEXT,
    NarrativePublishInternet VARCHAR(255) NULL,
    NarrativePublishIntranet VARCHAR(255) NULL,
    NarrativeIRN INT NOT NULL,
    NarrativeSummary TEXT,
    NarrativeRecordStatus TEXT,
    NarNarrative TEXT
    )  ENGINE=INNODB;   

CREATE TABLE IF NOT EXISTS ecatalogue (
    CrePlaceOfExecution TEXT,
    CreDateCreated TEXT,
    PhyMediumText TEXT,
    TitAccessionNo  VARCHAR(255) NULL,
    AccCreditLineLocal TEXT,
    TitMainTitle TEXT,
    PhyMediaCategory TEXT,
    CreSubjectClassification TEXT,
    CrePrinterPublisher TEXT,
    AdmPublishWebNoPassword VARCHAR(255) NULL,
    AdmPublishWebPassword VARCHAR(255) NULL,
    irn INT NOT NULL,
    SummaryData TEXT,
    SecRecordStatus TEXT,
    ObjectType TEXT,
    TitObjectStatus TEXT,
    TitCollectionStatus TEXT,
    TitObjectSubStatus TEXT,
    CreRole TEXT,
    PhyVerbatimMeasurementsA TEXT,
    PhyVerbatimMeasurementsB TEXT,
    CreEarliestDate TEXT,
    CreLatestDate TEXT,
    PhySupport TEXT,
    EdiImpression TEXT,
    TitDepartment VARCHAR(255) NULL,
    PhySecondaryMediaCategory TEXT,
    CrePeriodStyle TEXT
    )  ENGINE=INNODB;  

CREATE TABLE IF NOT EXISTS eparties(
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
    PartiesIRN INT NOT NULL,
    PartiesPartyType TEXT,
    PartiesPublishInternet VARCHAR(255) NULL,
    PartiesPublishIntranet VARCHAR(255) NULL,
    PartiesSummaryData TEXT,
    PartiesRecordStatus TEXT,
    BioCulturalIdentity1 TEXT
    )  ENGINE=INNODB; 