SELECT
	emu_export_v3.oo.ecatalogue_key,
    emu_export_v5.ds.ObjectIRN
FROM emu_export_v5.objobjec ds
INNER JOIN emu_export_v3.obj_ecatalog oo ON emu_export_v3.oo.irn = emu_export_v5.ds.ObjectIRN
LIMIT 2000;
