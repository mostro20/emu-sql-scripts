USE beta_v2_objects;
SELECT
	cs.ObjObjectsRef_key,
	GROUP_CONCAT(cs.ContributorSummaryData SEPARATOR ';') AS 'Subjects'
FROM narcontr cs
GROUP BY cs.ObjObjectsRef_key
LIMIT 1000;