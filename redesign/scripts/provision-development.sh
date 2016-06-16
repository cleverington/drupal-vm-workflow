#!/bin/bash

# provision-development.sh
# This bash script needs to be executed to execute the needed actions
#   - for spinning up the current Moody's UTexas Drupal VM Platform tool.

# Note - This scipt should only be ran from OUTSIDE of your Drupal VM.

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

## Installing the Drupal 7 UTDK installation
echo "==========================================================================="
echo "Configuring local Drupal 7 UTDK installation."
echo "-- Creating temporary files"
git clone https://insert-your-drupal-installation-repo-here.git ~/utexas-drupalvm-projects/development
git clone https://insert-your-drupal-sites-folder-repo-here.git ~/utexas-drupalvm-projects/development/sites
echo "... done."
echo "====="
echo "-- Adding clean .htaccess file to repository"
cp -rp ~/utexas-drupalvm-projects/redesign/settings-files/d7-default/.htaccess ~/utexas-drupalvm-projects/development/.htaccess
mkdir ~/utexas-drupalvm-projects/development/sites/default/files
cp -rp ~/utexas-drupalvm-projects/redesign/settings-files/d7-default/files/.htaccess ~/utexas-drupalvm-projects/development/sites/default/files/.htaccess
echo "... done."
echo "====="

echo "==========================================================================="
echo "-- Configuring site-folders...."
echo "-- -- Configuring site-folder for Development"
cp -p ~/utexas-drupalvm-projects/redesign/settings-files/d7-default/settings.php ~/utexas-drupalvm-projects/development/sites/default/settings.php
cp -p ~/utexas-drupalvm-projects/redesign/settings-files/d7-default/default.settings.php ~/utexas-drupalvm-projects/development/sites/default/
echo "...done."
echo "==========================================================================="

echo "==========================================================================="
echo "-- Configuring ${configuring_redesign}...."
cp -p ~/utexas-drupalvm-projects/redesign/settings-files/d7/development/local-settings.php ~/utexas-drupalvm-projects/development/sites/default/
echo "...done."
echo "==========================================================================="
