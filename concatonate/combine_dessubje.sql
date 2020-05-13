USE emu_export_v5;
SELECT
	ds.enarratives_key,
	GROUP_CONCAT(ds.DesSubjects SEPARATOR '; ') AS Subjects
FROM dessubje ds
WHERE LENGTH(ds.DesSubjects > 1)
GROUP BY ds.enarratives_key
LIMIT 1000;