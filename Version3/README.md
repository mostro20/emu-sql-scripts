# Migrate Module

This is custom module based on [Aten Migrate Tutorial](https://atendesigngroup.com/articles/drupal-8-content-migrations-csv-spreadsheet). There is currently a conflict where Migrate Tools cannot be installed:

 * Drupal 9.1-x has a conflict between Drupal Core, Composer 2, and Drush 10.5 based on the dependency `semver`, which Migrate Tools needs at < v1.3, while everything else needs > 3.2.   
 * You can roll back to Drush 10.4.3 which composer and drush does not have a reliance on `composer/semver`, but this is needed by Drupal > 9.1.

As a result this module has never been run, and is based on the theoretical requirements. In theory the dependencies on this custom module would be:

 * Migrate Source CSV
 * Migrate Tools
 * Migrate Plus
 * Migrate in Drupal Core 
