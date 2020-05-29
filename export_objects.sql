USE beta_v2_objects;
SELECT DISTINCT
ec.ecatalogue_key,
ec.TitAccessionNo AS 'Accession No.',
ec.AccCreditLineLocal AS 'Credit Line',
ec.TitMainTitle AS 'Title',
ec.CrePlaceOfExecution AS 'Place of execution',
ec.PhyMediumText AS 'Medium',
ec.PhyVerbatimMeasurementsA  AS 'Main measurement',
ec.PhyVerbatimMeasurementsB  AS 'Secondary measurement',
ec.CreDateCreated  AS 'Date Created',
ec.CreEarliestDate AS EarliestDate,
ec.CreLatestDate AS LatestDate,
ec.PhySupport AS 'Physical support',
ec.EdiImpression AS 'Edition',
ec.TitDepartment AS 'QAGOMA Department',
ec.PhyMediaCategory 'Primary Media',
ec.PhySecondaryMediaCategory 'Secondary Media',
ec.LocLevel1 'QAGOMA Location',
Concat('/sites/default/files/', SUBSTRING_INDEX(Multimedia, '\\', -1), '') AS 'URL',
cso.Subjects AS 'Subjects',
ec.PhyMediumText AS 'MediumText'
FROM ecatalog ec
LEFT JOIN mulmulti mm ON ec.ecatalogue_key = mm.ecatalogue_key
LEFT JOIN concat_subjects_objects cso ON ec.ecatalogue_key = cso.ecatalogue_key
WHERE LENGTH(mm.Multimedia) > 0
AND mm.MMPublishInternet = 'Yes'
AND ec.AdmPublishWebNoPassword = 'Yes'
LIMIT 10000


