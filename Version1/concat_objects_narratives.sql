USE beta_v2_objects;
SELECT
	cs.NarrativeIRN,
	GROUP_CONCAT(cs.ecatalogue_key SEPARATOR ';') AS 'ecatalogue_key'
FROM objobjec cs
GROUP BY cs.NarrativeIRN
LIMIT 2000;