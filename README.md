# emu-sql-scripts
Set of scripts for taking emu exports and formatting them for the following:

* ingest into Drupal 8 and Tome Generated Static Website
* place into holding database for migration into the dynamic Drupal 8 website
* holding database for generating captions for the Fotoware DAMS

There are two versions of the process, the vast majority will be focused on Version 2. Version 1 will be documented for legacy and if the old beta websites need to be regenerated.

= Version 2 (Current) =

TODO: Setup instructions to use the new PHP Script that processes the XML exports and pushes them into the holding database.

= Version 1 (Legacy) =

These source files can be found in the Version 1 folder. Import all tables, note that when importing the larger tables all fields that are not IRN should be set to text.

1)	Concatenate the Object Subject Tables via: concat_subjects_objects.sql – Create table with same name
2)	Concatenate the Narrative Subject Tables via: concat_subjects_narratives.sql – Create table with same name
3)	Concatenate the Narrative Author tables via: concat_authors_narratives.json – Create table with same name
4)	Concatenate the Narrative Contributor tables via: concat_contributors_narratives.sql – Create table with same name
5)	Concatenate the Narrative Parties Reference tables via: concat_parties_narratives.sql – Create table with same name
6)	Concatenate the Objects Linked to Parties via: concat_parties_narratives.sql – Create table with the same name
7)	Concatenate the Narrative linked to objects via: concat_objects_narratives.sql
8)	Run all Export scripts ()
