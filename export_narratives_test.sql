USE emu_export_v5;
SELECT 
en.NarTitle AS 'Title',
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
en.DesPurpose AS 'Purpose',
en.NarNarrative AS 'Narrative'
FROM emu_export_v5.enarrati en
LEFT JOIN emu_export_v5.combine_dessubje cds ON cds.enarratives_key = en.enarratives_key
LEFT JOIN emu_export_v5.combine_narautho cna ON cna.enarratives_key = en.enarratives_key
LEFT JOIN emu_export_v5.combine_narcontr cns ON cns.enarratives_key = en.enarratives_key
RIGHT JOIN emu_export_v5.combine_objobjec coo ON coo.enarratives_key = en.enarratives_key
LEFT JOIN emu_export_v5.combine_parparti cpp ON cpp.enarratives_key = en.enarratives_key
LEFT JOIN emu_export_v5.destype dt ON dt.enarratives_key = en.enarratives_key
LEFT JOIN emu_export_v5.eveevent ee ON ee.enarratives_key = en.enarratives_key
LEFT JOIN emu_export_v5.pubbibli pb ON pb.enarratives_key = en.enarratives_key
LIMIT 1000

