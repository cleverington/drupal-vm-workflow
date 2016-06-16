#!/bin/bash
# provision-moody_db.sh

# This script is temporary
#
#


departments="advertising commstudies csd journalism moody rtf"



# This script will need to be executed by itself within the
#   - VM, therefore will need to be moved into a separate
#   - script, such as 'moody_db_provision.sh'.

# Drush expects to have a live and bootstrapped site to work with for almost all functionality.
#   - Because of this limitation, many commands must be run from the 'root' directory of EACH site
#   - within the multisite installation.
#
# Non-critical modules, for example, must be disabled in 'each' folder within the $departments list.

echo "==========================================================================="
echo "Initializing..."
echo "-- Updating Drush Bash File."
sudo cp -rp /var/www/redesign/drush-files/moodyredesign.aliases.drushrc.php ~/.drush/
echo "...done."
echo "====="
echo "==========================================================================="

echo "Disabling non-critical modules for all sites."
for disabling_modules in ${departments}
do
    echo "-- Disabling non-critical modules in Drupal 6 instance of ${disabling_modules}"
    cd /var/www/public_html/d6/multisite/sites/{disabling_modules}.utexas.edu.multisite.vm
    drush @moodyredesign.${disabling_modules}.utexas.edu.multisite.vm pml --no-core --type=module --status=enabled --pipe > modules.txt
    cat modules.txt | xargs drush @moodyredesign.${disabling_modules}.utexas.edu.multisite.vm -y dis
    cat modules.txt | xargs drush @moodyredesign.${disabling_modules}.utexas.edu.multisite.vm -y en
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Placing all sites in 'offline' status to prepare for the upgrade"
for offline_sites in ${departments}
do
    echo "-- Setting ${offline_sites} offline"
    drush @moodyredesign.${offline_sites}.utexas.edu.multisite.vm vset maintenance_mode 1
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Deleting default.settings.php from all sites."
for deleting_old_default_settings in ${departments}
do
    echo "-- Disabling default.settings.php in Drupal 6 instance of ${deleting_old_default_settings}"
    sudo rm -p /var/www/public_html/d6/${deleting_old_default_settings}.utexas.edu.multisite.vm/sites/default/default.settings.php
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Making settings.php writable."
for make_settings_writable in ${departments}
do
    echo "-- Disabling default.settings.php in Drupal 6 instance of ${make_settings_writable}"
    sudo chmod 666 /var/www/public_html/d6/${make_settings_writable}.utexas.edu.multisite.vm/sites/default/settings.php
    sudo chmod 666 /var/www/public_html/d6/${make_settings_writable}.utexas.edu.multisite.vm/sites/moody.utexas.edu/settings.php
done
echo "...done."
echo "====="
echo "==========================================================================="

echo "Disabling and Uninstalling installation-wide modules not flagged for migration"
for remove_modules in ${departments}
do
    echo "-- Disabling and uninstalling better_formats in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall better_formats
    echo "-- Disabling and uninstalling boost in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall boost
    echo "-- Disabling and uninstalling db_maintenance in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall db_maintenance
    echo "-- Disabling and uninstalling imageapi in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall imageapi
    echo "-- Disabling and uninstalling imagecache in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall imagecache
    echo "-- Disabling and uninstalling imagefield in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall imagefield
    echo "-- Disabling and uninstalling jquery_ui in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall jquery_ui
    echo "-- Disabling and uninstalling nodewords in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall nodewords
    echo "-- Disabling and uninstalling nice_menus in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall nice_menus
    echo "-- Disabling and uninstalling noreqnewpass in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall noreqnewpass
    echo "-- Disabling and uninstalling opengraph_meta in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall opengraph_meta
    echo "-- Disabling and uninstalling override_node_options in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall override_node_options
    echo "-- Disabling and uninstalling quicktabs in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall quicktabs
    echo "-- Disabling and uninstalling revision_deletion in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall revision_deletion
    echo "-- Disabling and uninstalling shadowbox in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall shadowbox
    echo "-- Disabling and uninstalling views_slideshow in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall views_slideshow
    echo "-- Disabling and uninstalling views_slideshow_ddblock in Drupal 6 instance of ${remove_modules}"
    drush @moodyredesign.${remove_modules}.utexas.edu.multisite.vm uninstall views_slideshow_ddblock
    echo "===="
    echo "-- Updating database for uninstalled modules"
    drush @moodyredesign.${disabling_modules}.utexas.edu.multisite.vm updb
done

echo "Disabling and Uninstalling installation-wide modules not flagged for migration"
echo "-- Disabling and uninstalling feedblock in Drupal 6 instance of rtf"
drush @moodyredesign.rtf.utexas.edu.multisite.vm uninstall feedblock
echo "===="
echo "-- Updating database for uninstalled modules"
drush @moodyredesign.rtf.utexas.edu.multisite.vm updb
