USE emu_export_v5;
SET SQL_SAFE_UPDATES = 0;
UPDATE objobjec
INNER JOIN check_ecat_irn ON objobjec.ObjectIRN = check_ecat_irn.ObjectIRN
SET objobjec.ecatalogue_key = check_ecat_irn.ecatalogue_key
