USE beta_v2_objects;
SELECT
	ds.ObjObjectsRef_key,
	GROUP_CONCAT(ds.PartiesIRN SEPARATOR '; ') AS PartiesIRN
FROM parparti ds
WHERE LENGTH(ds.PartiesIRN > 1)
GROUP BY ds.ObjObjectsRef_key
LIMIT 1000;