#!/bin/bash

# provision-redesign.sh
# This bash script needs to be executed to execute the needed actions
#   - for spinning up the current Moody College Tasks tool.

# This script is meant for use on by Moody College of Communication
#   - Developers for creating test environments. It should not be used for
#   - creating or altering Production environments on UT Web.

# Clearing Existing Content - Optional
#
# Script will need a number of 'Remove directory if it exists' caveats.
#   - Since everything is being loaded / tracked via a Git workflow, there
#   - is no issue with removing content/structure/etc. changes from the VM.
#   - Anything created on the VM should be created with the clear and present
#   - understanding that everything ON the VM will be deleted during the process.
#
# Optional - Allow Developer Opt-Out
#
# However, because the VM may be powerered-down and powered back up with no
#   - changes to the infrastructre / setup of the VM, Developers should have
#   - the option to NOT execute the script.#

# Define Variables
departments="advertising commstudies csd journalism moody rtf"

## Installing the Moody College Drupal 7 UTDK installations
echo "==========================================================================="
echo "Configuring local Moody College Drupal 7 UTDK installations."
echo "-- Creating temporary files"
sudo git clone https://comm-webmaster@bitbucket.org/moodycollegedevelopers/moody-redesign.git /var/tmp/utdrupalkit
sudo git clone https://comm-webmaster@bitbucket.org/moodycollegedevelopers/migration_theme.git /var/tmp/utdrupalkit/sites
echo "... done."
echo "====="
echo "-- Adding clean .htaccess file to respository"
sudo cp -rp /var/www/redesign/settings-files/d7-default/.htaccess /var/www/var/tmp/utdrupalkit/.htaccess
sudo cp -rp /var/www/redesign/settings-files/d7-default/sites/default/files/.htaccess /var/tmp/utdrupalkit/sites/default/files/.htaccess
echo "... done."
echo "====="
echo "-- Adding Site Installation Files"
sudo mkdir -p /var/www/public_html/d7

for utdk_redesign_folders in ${departments}
do
  echo "-- -- Adding directory for ${utdk_redesign_folders}"
  sudo mkdir -p /var/www/public_html/d7/${utdk_redesign_folders}
  echo "====="
  echo "-- -- Creating UTDK Instance for ${utdk_redesign_folders}"
  sudo cp -rp /var/tmp/utdrupalkit/* /var/www/public_html/d7/${utdk_redesign_folders}/
done

echo "==========================================================================="
echo "-- Configuring all site-folders...."

for default_settings in ${departments}
do
  echo "-- -- Configuring site-folder for ${default_settings}"
  sudo cp -p /var/www/redesign/settings-files/d7-default/settings.php /var/www/public_html/d7/${default_settings}/sites/default/settings.php
  sudo cp -p /var/www/redesign/settings-files/d7-default/default.settings.php /var/www/public_html/d7/${default_settings}/sites/default/
done

echo "...done."
echo "==========================================================================="

for configuring_redesign in ${departments}
do
  echo "==========================================================================="
  echo "-- Configuring ${configuring_redesign}...."
  sudo cp -p /var/www/redesign/settings-files/d7/${configuring_redesign}/local-settings.php /var/www/public_html/d7/${configuring_redesign}/sites/default/
  sudo cp -p /var/www/redesign/settings-files/d7-default/.htaccess /var/www/public_html/d7/${configuring_redesign}/sites/default/
  sudo cp -p /var/www/redesign/settings-files/d7-default/.htaccess /var/www/public_html/d7/${configuring_redesign}/
  echo "...done."
  echo "==========================================================================="
done

# Leaving temporary files in place currently as an excellent place to run upgrades/upgrades.
#echo "Cleaning up temporary files."
#sudo rm -r /var/tmp/utdrupalkit
