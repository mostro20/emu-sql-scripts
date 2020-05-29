USE beta_v2_objects;
SELECT
	ds.CreatorIRN,
	GROUP_CONCAT(ds.ecatalogue_key SEPARATOR '; ') AS ecatalogue_key
FROM crecreat ds
WHERE LENGTH(ds.CreatorIRN > 1)
GROUP BY ds.CreatorIRN
LIMIT 1000;