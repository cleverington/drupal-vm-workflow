#!/bin/bash

# provision-redesign.sh
# This bash script needs to be executed to execute the needed actions
#   - for spinning up the current Moody's UTexas Drupal VM Platform tool.

# This script is configured for use on by Moody College of Communication
#   - Developers for creating test environments and has been tweaked to
#   - support global usage with the UTDK. It should not be used for
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
# However, because the VM may be powered-down and powered back up with no
#   - changes to the infrastructure / setup of the VM, Developers should have
#   - the option to NOT execute the script.#

# Define Variables
departments="development"

## Installing the Drupal 7 UTDK installations
echo "==========================================================================="
echo "Configuring local Drupal 7 UTDK installations."
echo "-- Creating temporary files"
git clone https://insert-your-drupal-installation-repo-here.git /var/tmp/utdrupalkit
git clone https://insert-your-drupal-sites-folder-repo-here.git /var/tmp/utdrupalkit/sites
echo "... done."
echo "====="
echo "-- Adding clean .htaccess file to repository"
cp -rp /var/tmp/redesign/settings-files/d7-default/.htaccess /var/tmp/utdrupalkit/.htaccess
mkdir /var/tmp/utdrupalkit/sites/default/files
cp -rp /var/www/redesign/settings-files/d7-default/files/.htaccess /var/tmp/utdrupalkit/sites/default/files/.htaccess
echo "... done."
echo "====="
echo "-- Adding Site Installation Files"
mkdir -p /var/www/public_html/d7

for utdk_redesign_folders in ${departments}
do
  echo "-- -- Adding directory for ${utdk_redesign_folders}"
  mkdir -p /var/www/public_html/d7/${utdk_redesign_folders}
  echo "====="
  echo "-- -- Creating UTDK Instance for ${utdk_redesign_folders}"
  cp -rp /var/tmp/utdrupalkit/* /var/www/public_html/d7/${utdk_redesign_folders}/
done

echo "==========================================================================="
echo "-- Configuring all site-folders...."

for default_settings in ${departments}
do
  echo "-- -- Configuring site-folder for ${default_settings}"
  cp -p /var/tmp/redesign/settings-files/d7-default/settings.php /var/www/public_html/d7/${default_settings}/sites/default/settings.php
  cp -p /var/tmp/redesign/settings-files/d7-default/default.settings.php /var/www/public_html/d7/${default_settings}/sites/default/
done

echo "...done."
echo "==========================================================================="

for configuring_redesign in ${departments}
do
  echo "==========================================================================="
  echo "-- Configuring ${configuring_redesign}...."
  cp -p /var/tmp/redesign/settings-files/d7/${configuring_redesign}/local-settings.php /var/www/public_html/d7/${configuring_redesign}/sites/default/
  cp -p /var/tmp/redesign/settings-files/d7-default/.htaccess /var/www/public_html/d7/${configuring_redesign}/sites/default/
  cp -p /var/tmp/redesign/settings-files/d7-default/.htaccess /var/www/public_html/d7/${configuring_redesign}/
  echo "...done."
  echo "==========================================================================="
done

# Leaving temporary files in place currently as an excellent place to run upgrades/upgrades.
#echo "Cleaning up temporary files."
#sudo rm -r /var/tmp/utdrupalkit
