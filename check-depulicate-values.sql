USE emu_export_v5;
select enarratives_key, count(*) as Count
from narautho
group by enarratives_key
having count(*) > 1