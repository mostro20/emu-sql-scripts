# Field mapping EMu and MuseumPlus to DAMS Caption

This contains basic information for mapping the fields

## EMU Fields

|DAMS Caption Fields|EMu Fields|
|----|----------|
|cms_irn|e.irn|
|object_type|e.TitObjectStatus|
|accession_no|e.TitAccessionNo|
|title|e.TitMainTitle|
|`year`|e.CreDateCreated|
|rights|r.RigAcknowledgement|
|creators|p.PartiesSummaryData, ' b.', p.BioBirthDate, ' - ', p.BioDeathDate|
|place_created|not used|
|dimensions|e.PhyVerbatimMeasurementsA, ' ', e.PhyVerbatimMeasurementsB|
|credit|e.AccCreditLineLocal|
|media_statement|e.PhyMediumText, ' ', e.PhySupport|
|special_digital_meta|not used|
|short_caption|e.TitMainTitle, ' ', e.CreDateCreated, ' ', p.PartiesSummaryData, ' b.', p.BioBirthDate, ' - ', p.BioDeathDate|
|long_caption| CONCAT_WS(' ',
            (SELECT group_concat(concat_ws(' ', pi3.PartiesSummaryData, CHAR(13),NULLIF(pi3.BioCulturalIdentity1, ''),pi3.Country, ' ',  ' b.', pi3.BioBirthDate, ' - ', pi3.BioDeathDate) order by pi3.PartiesIRN separator '\n')
            FROM epartiesinfo pi3
            WHERE pi3.ObjectIRN = e.irn),
                NULLIF(e.TitMainTitle, ''), ' ', NULLIF(e.CreDateCreated, ''), CHAR(13),
                NULLIF(e.PhyMediumText, ''), ' ', NULLIF(e.PhySupport, ''), CHAR(13), + ADD SUPPORT
                NULLIF(e.PhyVerbatimMeasurementsA, ''), ' ', NULLIF(e.PhyVerbatimMeasurementsB, ''), CHAR(13),
                'Acc.', NULLIF(e.TitAccessionNo, ''), CHAR(13),
                'Temp no.', NULLIF(e.TitPreviousNumber, ''), CHAR(13),
                NULLIF(e.AccCreditLineLocal, ''), CHAR(13),
                (SELECT group_concat(concat_ws(' ', NULLIF(ri2.RigAcknowledgement, ''))order by ri2.irn separator '\n') FROM erightsinfo ri2 WHERE ri2.ObjectIRN = e.irn)|
|last_updated|last_upd

## MuseumPlus Fields

|DAMS Caption Fields|EMu Fields|
|----|----------|
|cms_irn|e.irn|_id|
|object_type|CONSTANT = Object|
|accession_no|Conditional IF DOMAIN = Collection THEN ObjObjectNumberCof.ObjObjectNumberGrp; IF DOMAIN = not collection THEN ObjTemporaryNumberCof.ObjTemporaryNumberGrp|
|title|ObjObjectTitleCof.ObjObjectTitleGrp|
|`year`|ONLY WITH CREATION AS TYPE ObjDateFol.ObjDateGrp|
|rights|ObjRightsRefGrp.ObjRightsRef|
|creators|CYCLE THROUGH RELATED PERSONS ONLY WITH ARTIST TYPE ObjPerAssociationFol.ObjPerAssociationRef (Person.NAME + Person.DOB + Person.DOD) + ObjPerAssociationRef.RoleCbx.ObjPerAssociationRef[RoleVoc]|
|place_created|ONLY WITH PLACE CREATED ObjGeograficFol.ObjGeograficGrp|
|dimensions|ObjDimAllGrp.PreviewDpl|
|credit|IF DOMAIN = Non Collection THEN (LOAN CREDIT) /n ObjCreditlineXpd.ObjCreditLineTxt;IF DOMAIN = Collection (from related Acquisition: AcqCreditlineXpd.AcqCreditlineTxt)|
|media_statement|ObjMaterialTechniqueXpd.ObjMaterialTechniqueTxt|
|special_digital_meta|not used|
|short_caption|ObjObjectTitleCof.ObjObjectTitleGrp, ' ', (ONLY WITH CREATION AS TYPE ObjDateFol.ObjDateGrp), ' ', (CYLCE THROUGH ALL RELATED PERSONS WITH "ARTIST" TYPE ObjPerAssociationFol.ObjPerAssociationRef (NAME + DOB + DOD)|
|long_caption| CYCLE THROUGH RELATED PERSONS ONLY WITH ARTIST TYPE ObjPerAssociationFol.ObjPerAssociationRef (Person.NAME + Person.DOB + Person.DOD) + ObjPerAssociationRef.RoleCbx.ObjPerAssociationRef[RoleVoc] + \n with each person.
ObjObjectTitleCof.ObjObjectTitleGrp + ONLY WITH CREATION AS TYPE ObjDateFol.ObjDateGrp + \n
ObjMaterialTechniqueXpd.ObjMaterialTechniqueTxt + ObjEditionNrXpd.ObjEditionNrTxt + \n
ObjDimAllGrp.PreviewDpl + \n
'Acc. No: ' + ObjObjectNumberCof.ObjObjectNumberGrp + \n
'Temp. No:' + ObjTemporaryNumberCof.ObjTemporaryNumberGrp + \n
IF DOMAIN = Non Collection THEN (LOAN CREDIT) /n ObjCreditlineXpd.ObjCreditLineTxt;IF DOMAIN = Collection (from related Acquisition: AcqCreditlineXpd.AcqCreditlineTxt)|
Rights: ObjRightsRefGrp.ObjRightsRef|
|last_updated|+ LAST UPDATED|