USE beta_v2_objects;
SELECT DISTINCT
cpn.ecatalogue_key,
cc.CreatorSummaryData,
cc.CreatorIRN
FROM concat_objects_parties cpn
LEFT JOIN crecreat cc ON cc.CreatorIRN = cpn.CreatorIRN
WHERE CreatorPublishInternet = 'Yes'
LIMIT 10000
