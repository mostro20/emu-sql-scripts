-- `20210615_Web`.Narratives_AttachmentsIRNS definition

CREATE TABLE `Narratives_AttachmentsIRNS` (
  `Group1_key` int DEFAULT NULL,
  `enarratives_key` int DEFAULT NULL,
  `NarrativeIRN` int DEFAULT NULL,
  `AuthorIRN` int DEFAULT NULL,
  `ContribIRN` int DEFAULT NULL,
  `RelPartiesIRN` int DEFAULT NULL,
  `MasterIRN` int DEFAULT NULL,
  `EventsIRN` int DEFAULT NULL,
  `DocIRN` int DEFAULT NULL,
  `ObjectIRN` int DEFAULT NULL,
  `SubIRN` varchar(1) DEFAULT NULL,
  KEY `Narratives_AttachmentsIRNS_NarrativeIRN_IDX` (`NarrativeIRN`,`MasterIRN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- `20210615_Web`.Objects_CreatorIRNS definition

CREATE TABLE `Objects_CreatorIRNS` (
  `ObjectsCreatorIRNs_key` int DEFAULT NULL,
  `ecatalogue_key` int DEFAULT NULL,
  `ObjectIRN` int DEFAULT NULL,
  `CreatorIRN` int DEFAULT NULL,
  `CreRole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  KEY `Objects_CreatorIRNS_ObjectIRN_IDX` (`ObjectIRN`,`CreatorIRN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- `20210615_Web`.Objects_MultimediaIRNs definition

CREATE TABLE `Objects_MultimediaIRNs` (
  `ObjectMultimedia_key` int DEFAULT NULL,
  `ecatalogue_key` int DEFAULT NULL,
  `ObjectIRN` int DEFAULT NULL,
  `MultimediaIRN` int DEFAULT NULL,
  KEY `Objects_MultimediaIRNs_ObjectIRN_IDX` (`ObjectIRN`,`MultimediaIRN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- `20210615_Web`.Objects_RightsIRNs definition

CREATE TABLE `Objects_RightsIRNs` (
  `Copyright_key` int DEFAULT NULL,
  `ecatalogue_key` int DEFAULT NULL,
  `objectirn` int DEFAULT NULL,
  `RigAcknowledgement` varchar(231) DEFAULT NULL,
  `rightsirn` int DEFAULT NULL,
  KEY `Objects_RightsIRNs_objectirn_IDX` (`objectirn`,`rightsirn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;