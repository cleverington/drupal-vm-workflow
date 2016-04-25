#!/bin/bash
# provision-moody_db.sh

# This script is temporary
#
#


departments="advertising commstudies csd journalism moody rtf"



# This script will need to be executed by itself within the
#   - VM, therefore will need to be moved into a separate
#   - script, such as 'moody_db_provision.sh'.

echo "==========================================================================="
echo "Initializing..."
echo "-- Updating Drush Bash File."
sudo cp -rp /var/www/redesign/drush-files/moodyredesign.aliases.drushrc.php ~/.drush/
echo "...done."
echo "====="
echo "==========================================================================="
echo "Provisioning the separate instances for each site."
for initializing_databases in ${departments}
do
  echo "-- Initializing databases for ${initializing_databases}. (WARNING: This will cause errors.)"
  drush @moodyredesign.${initializing_databases}.utexas.edu.local.vm updb
  echo "...done."
  echo "====="
  echo "-- Clearing databases for import"
  drush @moodyredesign.${initializing_databases}.utexas.edu.local.vm -y sql-drop
  echo "...done."
  echo "====="
  echo "-- Importing databases"
  drush @moodyredesign.${initializing_databases}.utexas.edu.local.vm -y sql-cli < /var/www/redesign/sql-dumps/${initializing_databases}_main.sql
  echo "...done."
  echo "====="
  echo "-- Setting Garland as the default theme and default admin theme"
  drush @moodyredesign.${initializing_databases}.utexas.edu.local.vm vset theme_default garland
  drush @moodyredesign.${initializing_databases}.utexas.edu.local.vm vset admin_theme garland
  echo "...done."
  echo "====="
  echo "-- Activating imported database (WARNING: This may cause errors.)"
  drush @moodyredesign.${initializing_databases}.utexas.edu.local.vm updb
  echo "...done."
  echo "====="
done

echo "Disabling non-critical modules for all sites."
for disabling_modules in ${departments}
do
    echo "-- Disabling non-critical modules in Drupal 6 instance of ${disabling_modules}"
    drush @moodyredesign.${disabling_modules}.utexas.edu.local.vm pml --no-core --type=module --status=enabled --pipe > modules.txt
    cat modules.txt | xargs drush @moodyredesign.${disabling_modules}.utexas.edu.local.vm -y dis
    cat modules.txt | xargs drush @moodyredesign.${disabling_modules}.utexas.edu.local.vm -y en
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Placing all sites in 'offline' status to prepare for the upgrade"
for offline_sites in ${departments}
do
    echo "-- Setting ${offline_sites} offline"
    drush @moodyredesign.${offline_sites}.utexas.edu.local.vm vset maintenance_mode 1
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Deleting default.settings.php from all sites."
for deleting_old_default_settings in ${departments}
do
    echo "-- Disabling default.settings.php in Drupal 6 instance of ${deleting_old_default_settings}"
    sudo rm -p /var/www/public_html/d6/${deleting_old_default_settings}.utexas.edu.local.vm/sites/default/default.settings.php
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Making settings.php writable."
for make_settings_writable in ${departments}
do
    echo "-- Disabling default.settings.php in Drupal 6 instance of ${make_settings_writable}"
    sudo chmod 666 /var/www/public_html/d6/${make_settings_writable}.utexas.edu.local.vm/sites/default/settings.php
    sudo chmod 666 /var/www/public_html/d6/${make_settings_writable}.utexas.edu.local.vm/sites/moody.utexas.edu/settings.php
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Disabling and Uninstalling installation-wide modules not flagged for migration"
for remove_modules in ${departments}
do
    echo "-- Disabling and uninstalling better_formats in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall better_formats
    echo "-- Disabling and uninstalling boost in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall boost
    echo "-- Disabling and uninstalling db_maintenance in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall db_maintenance
    echo "-- Disabling and uninstalling imageapi in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall imageapi
    echo "-- Disabling and uninstalling imagecache in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall imagecache
    echo "-- Disabling and uninstalling imagefield in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall imagefield
    echo "-- Disabling and uninstalling jquery_ui in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall jquery_ui
    echo "-- Disabling and uninstalling nodewords in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall nodewords
    echo "-- Disabling and uninstalling nice_menus in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall nice_menus
    echo "-- Disabling and uninstalling noreqnewpass in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall noreqnewpass
    echo "-- Disabling and uninstalling opengraph_meta in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall opengraph_meta
    echo "-- Disabling and uninstalling override_node_options in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall override_node_options
    echo "-- Disabling and uninstalling quicktabs in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall quicktabs
    echo "-- Disabling and uninstalling revision_deletion in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall revision_deletion
    echo "-- Disabling and uninstalling shadowbox in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall shadowbox
    echo "-- Disabling and uninstalling views_slideshow in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall views_slideshow
    echo "-- Disabling and uninstalling views_slideshow_ddblock in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.local.vm uninstall views_slideshow_ddblock
    echo "===="
    echo "-- Updating database for uninstalled modules"
    drush @moodyredesign.${disabling_modules}.utexas.edu.local.vm updb
done

echo "Disabling and Uninstalling installation-wide modules not flagged for migration"
echo "-- Disabling and uninstalling feedblock in Drupal 6 instance of rtf"
drush @moodyredesign.rtf.utexas.edu.local.vm uninstall feedblock
echo "===="
echo "-- Updating database for uninstalled modules"
drush @moodyredesign.rtf.utexas.edu.local.vm updb
