USE emu_export_v5;
SELECT
	ds.enarratives_key,
	GROUP_CONCAT(ds.ContributorSummaryData SEPARATOR '; ') AS Contributors
FROM narcontr ds
WHERE LENGTH(ds.ContributorSummaryData > 1)
GROUP BY ds.enarratives_key
LIMIT 1000;