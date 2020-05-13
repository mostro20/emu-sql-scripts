SELECT
	emu_export_v5.ds.enarratives_key,
	GROUP_CONCAT(emu_export_v5.ds.ecatalogue_key SEPARATOR '; ') AS ecatalogue_key
FROM emu_export_v5.objobjec ds
WHERE LENGTH(emu_export_v5.ds.ecatalogue_key > 1)
GROUP BY emu_export_v5.ds.enarratives_key
LIMIT 1000;
