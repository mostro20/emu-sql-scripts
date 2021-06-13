# EMu Export to Drupal 9 and Fotoware DAMS

Set of scripts for taking emu exports and formatting them for the following:

* ingest into Drupal 9 and Tome Generated Static Website
* place into holding database for migration into the dynamic Drupal 9 website
* holding database for generating captions for the Fotoware DAMS

There are two versions of the process, the vast majority will be focused on Version 2. Version 1 will be documented for legacy and if the old beta websites need to be regenerated. Version 3 is intended to replace the Feeds ingest part of V2, and is in development.

## Version 3 (Dev)

This is a development Migrate file for Drupal. Due to Drush conflicts between Migrate Tools, and dependencies for Drush 10.5 and Drupal 9.1.10, this module has not been able to be run, so is a theoretical working file.

## Version 2 (Current)

There are four folders in the V2 process, one process is for exporting to our DAMS, the other to the Collection Beta website.

For the website import the process involves: cleaning the exported XML from CMS, creating holding MySQL tables, running the ImportPHP script, then importing via Drupal Feeds (see https://github.com/mostro20/d9_collection_build/tree/master/config - config starting with `feeds.*`). Note: V3 of this script will aim to replace the Feeds process with Drupal Migrate.

The following states the specifics within each of the processes.

### 1. Web folder: CMS-to-Web_export

Assumes that EMu (legacy CMS) has run an export report (see [Mapping](https://github.com/mostro20/emu-sql-scripts/blob/master/Version2/CMS-to-DAMS_export/mapping.md)). After this has been run: 

* Create holding database with `CMS-to-Web_export/create-tables-collection-online.sql`
* Import data from XML into new database with `CMS-to-Web_export/importXML.php`
* Follow the steps outlined in this file `CMS-to-Web_export/create-tables-collection-online.sql` - this is not a SQL file, but a bunch of sequential SQL commands to run, so follow comments rather than execute the file
* Export out CSV files for Objects, Creators, Narratives and Exhibitions and import via [Drupal feeds config](https://github.com/mostro20/d9_collection_build/tree/master/config).

In the above subsitute the name of the current database and connection credentials as appropriate.

### 2. DAMS folder: CMS-to-DAMS_export

Assumes that EMu (legacy CMS) has run an export report (see [Mapping](https://github.com/mostro20/emu-sql-scripts/blob/master/Version2/CMS-to-DAMS_export/mapping.md)). After this has been run: 

* Create holding database with `CMS-to-DAMS_export/create-tables-caption.sql`
* Import data from XML into new database with `CMS-to-DAMS_export/importXML.php`
* Create procedure to create formatted captions with `CMS-to-DAMS_export/create-tables-caption.sql`
* Execute procedure `CMS-to-DAMS_export/execute_procedure.sql`

In the above subsitute the name of the current database and connection credentials as appropriate.

## Version 1 (Legacy)

These source files can be found in the Version 1 folder. Import all tables, note that when importing the larger tables all fields that are not IRN should be set to text.

1. Concatenate the Object Subject Tables via: concat_subjects_objects.sql – Create table with same name
2. Concatenate the Narrative Subject Tables via: concat_subjects_narratives.sql – Create table with same name
3. Concatenate the Narrative Author tables via: concat_authors_narratives.json – Create table with same name
4. Concatenate the Narrative Contributor tables via: concat_contributors_narratives.sql – Create table with same name
5. Concatenate the Narrative Parties Reference tables via: concat_parties_narratives.sql – Create table with same name
6. Concatenate the Objects Linked to Parties via: concat_parties_narratives.sql – Create table with the same name
7. Concatenate the Narrative linked to objects via: concat_objects_narratives.sql
8. Run all Export scripts ()
