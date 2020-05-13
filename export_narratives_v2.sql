USE emu_export_v5;
SELECT 
en.NarTitle AS 'Title',
en.DesPurpose AS 'Purpose',
en.NarrativeIRN AS 'NarrativeIRN',
en.MasterIRN AS 'MasterIRN',
cds.Subjects AS 'Subjects',
cna.Authors AS 'Authors',
cns.Contributors AS 'Contributors',
coo.ecatalogue_key AS 'ecatalogue_key',
cpp.PartiesIRN AS 'PartiesIRN',
dt.DesType AS 'Narrative Type',
ee.EventSummaryData AS 'Linked Event',
pb.PublicationSummaryData AS 'Linked Publication',
en.NarNarrative AS 'Narrative'
FROM enarrati en
LEFT JOIN combine_dessubje cds ON cds.enarratives_key = en.enarratives_key
LEFT JOIN combine_narautho cna ON cna.enarratives_key = en.enarratives_key
LEFT JOIN combine_narcontr cns ON cns.enarratives_key = en.enarratives_key
RIGHT JOIN combine_ecat coo ON coo.enarratives_key = en.enarratives_key
LEFT JOIN combine_parparti cpp ON cpp.enarratives_key = en.enarratives_key
LEFT JOIN destype dt ON dt.enarratives_key = en.enarratives_key
LEFT JOIN eveevent ee ON ee.enarratives_key = en.enarratives_key
LEFT JOIN pubbibli pb ON pb.enarratives_key = en.enarratives_key
LIMIT 1000

