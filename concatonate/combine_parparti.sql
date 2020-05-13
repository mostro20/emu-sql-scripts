USE emu_export_v5;
SELECT
	ds.enarratives_key,
	GROUP_CONCAT(ds.PartiesIRN SEPARATOR '; ') AS PartiesIRN
FROM parparti ds
WHERE LENGTH(ds.PartiesIRN > 1)
GROUP BY ds.enarratives_key
LIMIT 1000;