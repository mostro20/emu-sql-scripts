USE beta_v2_objects;
SELECT distinct
en.NarTitle AS 'Title',
en.NarrativeIRN AS 'NarrativeIRN',
cds.Subjects AS 'Subjects',
cna.Subjects AS 'Authors',
cns.Subjects AS 'Contributors',
cop.ecatalogue_key AS 'ecatalogue_key',
cpp.PartiesIRN AS 'PartiesIRN',
dt.DesType AS 'Narrative Type',
ee.EventSummaryData AS 'Linked Event',
pb.PublicationSummaryData AS 'Linked Publication',
en.DesPurpose AS 'Purpose',
en.NarNarrative AS 'Narrative'
FROM objobjec en
LEFT JOIN concat_subjects_narratives cds ON cds.ObjObjectsRef_key = en.ObjObjectsRef_key
LEFT JOIN concat_authors_narratives cna ON cna.ObjObjectsRef_key = en.ObjObjectsRef_key
LEFT JOIN concat_contributors_narratives cns ON cns.ObjObjectsRef_key = en.ObjObjectsRef_key
LEFT JOIN concat_parties_narratives cpp ON cpp.ObjObjectsRef_key = en.ObjObjectsRef_key
LEFT JOIN concat_objects_narratives cop ON cop.NarrativeIRN = en.NarrativeIRN
LEFT JOIN destype dt ON dt.ObjObjectsRef_key = en.ObjObjectsRef_key
LEFT JOIN eveevent ee ON ee.ObjObjectsRef_key = en.ObjObjectsRef_key
LEFT JOIN pubbibli pb ON pb.ObjObjectsRef_key = en.ObjObjectsRef_key
WHERE en.NarrativePublishInternet = 'Yes'
LIMIT 15000

