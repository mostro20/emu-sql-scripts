# Importing the required libraries
import xml.etree.ElementTree as Xet
import pandas as pd
  
cols = ["CrePlaceOfExecution", "CreDateCreated", "PhyMediumText", "TitAccessionNo", "AccCreditLineLocal", "TitMainTitle", "PhyMediaCategory", "CrePrinterPublisher", "AdmPublishWebNoPassword", "AdmPublishWebPassword", "irn", "SummaryData", "SecRecordStatus", "ObjectType", "TitObjectStatus", "TitCollectionStatus", "TitObjectSubStatus", "PhyVerbatimMeasurementsA", "PhyVerbatimMeasurementsB", "CreEarliestDate", "CreLatestDate", "PhySupport", "EdiImpression", "TitDepartment", "PhySecondaryMediaCategory", "CrePeriodStyle"]
rows = []
  
# Parsing the XML file
xmlparse = Xet.parse('Objects_xmldata_210407.xml')
root = xmlparse.getroot()
for i in root:
    CrePlaceOfExecution = i.find("atom name=\"CrePlaceOfExecution\"").text    
    CreDateCreated = i.find("atom name=\"CreDateCreated\"").text
    
    PhyMediumText = i.find("PhyMediumText")
    if PhyMediumText is not None:
        PhyMediumText = PhyMediumText.text
    else:
        PhyMediumText = None

    TitAccessionNo = i.find("TitAccessionNo")
    if TitAccessionNo is not None:
        TitAccessionNo = TitAccessionNo.text
    else:
        TitAccessionNo = None

    AccCreditLineLocal = i.find("AccCreditLineLocal")
    if AccCreditLineLocal is not None:
        AccCreditLineLocal = AccCreditLineLocal.text
    else:
        AccCreditLineLocal = None    
    
    TitMainTitle = i.find("TitMainTitle")
    if TitMainTitle is not None:
        TitMainTitle = TitMainTitle.text
    else:
        TitMainTitle = None

    PhyMediaCategory = i.find("PhyMediaCategory")
    if PhyMediaCategory is not None:
        PhyMediaCategory = PhyMediaCategory.text
    else:
        PhyMediaCategory = None

    CrePrinterPublisher = i.find("CrePrinterPublisher")
    if CrePrinterPublisher is not None:
        CrePrinterPublisher = CrePrinterPublisher.text
    else:
        CrePrinterPublisher = None

    AdmPublishWebNoPassword = i.find("AdmPublishWebNoPassword")
    if AdmPublishWebNoPassword is not None:
        AdmPublishWebNoPassword = AdmPublishWebNoPassword.text
    else:
        AdmPublishWebNoPassword = None  

    AdmPublishWebPassword = i.find("AdmPublishWebPassword")
    if AdmPublishWebPassword is not None:
        AdmPublishWebPassword = AdmPublishWebPassword.text
    else:
        AdmPublishWebPassword = None

    irn = i.find("irn")
    if irn is not None:
        irn = irn.text
    else:
        irn = None 

    SummaryData = i.find("SummaryData")
    if SummaryData is not None:
        SummaryData = SummaryData.text
    else:
        SummaryData = None     
    
    SecRecordStatus = i.find("SecRecordStatus")
    if SecRecordStatus is not None:
        SecRecordStatus = SecRecordStatus.text
    else:
        SecRecordStatus = None 

    ObjectType = i.find("ObjectType")
    if ObjectType is not None:
        ObjectType = ObjectType.text
    else:
        ObjectType = None 

    TitObjectStatus = i.find("TitObjectStatus")
    if TitObjectStatus is not None:
        TitObjectStatus = TitObjectStatus.text
    else:
        TitObjectStatus = None 

    TitCollectionStatus = i.find("TitCollectionStatus")
    if TitCollectionStatus is not None:
        TitCollectionStatus = TitCollectionStatus.text
    else:
        TitCollectionStatus = None 

    TitObjectSubStatus = i.find("TitObjectSubStatus")
    if TitObjectSubStatus is not None:
        TitObjectSubStatus = TitObjectSubStatus.text
    else:
        TitObjectSubStatus = None 

    PhyVerbatimMeasurementsA = i.find("PhyVerbatimMeasurementsA")
    if PhyVerbatimMeasurementsA is not None:
        PhyVerbatimMeasurementsA = PhyVerbatimMeasurementsA.text
    else:
        PhyVerbatimMeasurementsA = None 

    PhyVerbatimMeasurementsB = i.find("PhyVerbatimMeasurementsB")
    if PhyVerbatimMeasurementsB is not None:
        PhyVerbatimMeasurementsB = PhyVerbatimMeasurementsB.text
    else:
        PhyVerbatimMeasurementsB = None 

    CreEarliestDate = i.find("CreEarliestDate")
    if CreEarliestDate is not None:
        CreEarliestDate = CreEarliestDate.text
    else:
        CreEarliestDate = None 

    CreLatestDate = i.find("CreLatestDate")
    if CreLatestDate is not None:
        CreLatestDate = CreLatestDate.text
    else:
        CreLatestDate = None 

    PhySupport = i.find("PhySupport")
    if PhySupport is not None:
        PhySupport = PhySupport.text
    else:
        PhySupport = None 

    EdiImpression = i.find("EdiImpression")
    if EdiImpression is not None:
        EdiImpression = EdiImpression.text
    else:
        EdiImpression = None 

    TitDepartment = i.find("TitDepartment")
    if TitDepartment is not None:
        TitDepartment = TitDepartment.text
    else:
        TitDepartment = None 

    PhySecondaryMediaCategory = i.find("PhySecondaryMediaCategory")
    if PhySecondaryMediaCategory is not None:
        PhySecondaryMediaCategory = PhySecondaryMediaCategory.text
    else:
        PhySecondaryMediaCategory = None 

    CrePeriodStyle = i.find("CrePeriodStyle")
    if CrePeriodStyle is not None:
        CrePeriodStyle = CrePeriodStyle.text
    else:
        CrePeriodStyle = None 

    rows.append({"CrePlaceOfExecution": CrePlaceOfExecution,
                    "CreDateCreated": CreDateCreated,
                    "PhyMediumText": PhyMediumText,
                    "TitAccessionNo": TitAccessionNo,
                    "AccCreditLineLocal": AccCreditLineLocal,
                    "TitMainTitle": TitMainTitle,
                    "PhyMediaCategory": PhyMediaCategory,
                    "CrePrinterPublisher": CrePrinterPublisher,
                    "AdmPublishWebNoPassword": AdmPublishWebNoPassword,
                    "AdmPublishWebPassword": AdmPublishWebPassword,
                    "irn": irn,
                    "SummaryData": SummaryData,
                    "SecRecordStatus": SecRecordStatus,
                    "ObjectType": ObjectType,
                    "TitObjectStatus": TitObjectStatus,
                    "TitCollectionStatus": TitCollectionStatus,
                    "TitObjectSubStatus": TitObjectSubStatus,
                    "PhyVerbatimMeasurementsA": PhyVerbatimMeasurementsA,
                    "PhyVerbatimMeasurementsB": PhyVerbatimMeasurementsB,
                    "CreEarliestDate": CreEarliestDate,
                    "CreLatestDate": CreLatestDate,
                    "PhySupport": PhySupport,
                    "EdiImpression": EdiImpression,
                    "TitDepartment": TitDepartment,
                    "PhySecondaryMediaCategory": PhySecondaryMediaCategory,
                    "CrePeriodStyle": CrePeriodStyle})
  
df = pd.DataFrame(rows, columns=cols)
  
# Writing dataframe to csv
df.to_csv('output.csv')