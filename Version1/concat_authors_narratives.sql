USE beta_v2_objects;
SELECT
	cs.ObjObjectsRef_key,
	GROUP_CONCAT(cs.AuthorSummaryData SEPARATOR ';') AS 'Subjects'
FROM narautho cs
GROUP BY cs.ObjObjectsRef_key
LIMIT 1000;