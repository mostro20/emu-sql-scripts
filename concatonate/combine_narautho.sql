USE emu_export_v5;
SELECT
	ds.enarratives_key,
	GROUP_CONCAT(ds.AuthorSummaryData SEPARATOR '; ') AS Authors
FROM narautho ds
WHERE LENGTH(ds.AuthorSummaryData > 1)
GROUP BY ds.enarratives_key
LIMIT 1000;