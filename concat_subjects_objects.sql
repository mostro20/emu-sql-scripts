USE beta_v2_objects;
SELECT
	cs.ecatalogue_key,
	GROUP_CONCAT(cs.CreSubjectClassification SEPARATOR ';') AS 'Subjects'
FROM CreSubje cs
GROUP BY cs.ecatalogue_key
LIMIT 1000;