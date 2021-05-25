USE beta_v2_objects;
SELECT
	cs.ObjObjectsRef_key,
	GROUP_CONCAT(cs.DesSubjects SEPARATOR ';') AS 'Subjects'
FROM dessubje cs
GROUP BY cs.ObjObjectsRef_key
LIMIT 1000;