#!/bin/bash

# provision-redesign_files.sh
# This bash script needs to be executed to place necessary files
#   - for default UTDK installation.

# This script is meant for use on by Moody College of Communication
#   - Developers for creating test environments. It should not be used for
#   - creating or altering Production environments on UT Web.

# Further Notes:
#
# This script is temporary in nature, as the UT Drupal Kit used for
#   - the migration itself will be a specifically configured site-install
#   - maintained via a Git repository.

# Define Variables
departments="advertising commstudies csd journalism moody rtf"

echo "==========================================================================="
echo "Initializing..."
echo "-- Updating Drush Bash File."
cp -rp /var/www/redesign/drush-files/moodyredesign.aliases.drushrc.php ~/.drush/

# Temp Script for default 'files' placements for Drupal 7 installation
for utdk_redesign_files in ${departments}
do
  echo "-- -- Adding directory for ${utdk_redesign_files} files"
  mkdir -p /var/www/public_html/d7/${utdk_redesign_files}/sites/default/files
  echo "-- -- Editing files directory permissions"
  chmod -R 777 /var/www/public_html/d7/${utdk_redesign_files}/sites/default/files
  echo "====="
  echo "-- -- Copying files for ${utdk_redesign_files}"
  cp -rp /var/tmp/moody-d7/sites-utdk-basic-default-files/* /var/www/public_html/d7/${utdk_redesign_files}/sites/default/files
  drush @moodyredesign.${utdk_redesign_files}.utexas.edu.redesign.vm cc all
done

# Leaving temporary files in place currently as an excellent place to run upgrades/upgrades.
#echo "Cleaning up temporary files."
#sudo rm -r /var/tmp/utdrupalkit
