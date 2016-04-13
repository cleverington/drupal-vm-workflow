#!/bin/bash -e

# provision-moody.sh
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



# Installing the UT Drupal Kit Development Server
echo ===========================================================================
echo "Installing the UT Drupal Kit in /var/www/development for Testing Purposes"
echo "Username / Password: admin"
echo " "
cd /var/www
drush make /var/www/redesign/makefiles/development.utexas.edu.make.yml utexas -y
sleep 20s
cd /var/scripts
echo ===========================================================================
echo ===========================================================================
echo ===========================================================================
echo "Unless errors have been received, the UT Drupal Kit has been installed in the Development directory."
echo ===========================================================================


# Installing the Moody College Drupal 6 Multisite Instances
echo ===========================================================================
echo "Configuring local settings for Moody College Drupal 6 Multisite installation."
echo " "
echo "-- Creating temporary files"
sudo git clone git@bitbucket.org:utexas-its-mdus/moody.git /var/tmp/multisite
echo "-- Adding Site Installation Files"
sudo mkdir /var/www/d6/multisite
sudo cp -r /var/tmp/multisite /var/www/d6/
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."

for sym_link_variable in departments
do
  sudo ln -s /var/d6/multisite/sites/$sym_link_variable.utexas.edu /var/www/d6/multisite/sites/$sym_link_variable.utexas.edu.multisite.vm
done

echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring all site-folders...."

for default_settings in departments
do
  sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/$default_settings.utexas.edu/settings.php
done

echo "...done."
echo ===========================================================================

for configuring_multisite in departments
do
  echo ===========================================================================
  echo "-- Configuring $configuring_multisite...."
  sudo cp /var/www/redesign/settings-files/d6-multisite/advertising/local-settings.php /var/www/d6/multisite/sites/$configuring_multisite.utexas.edu.multisite.vm/local-settings.php
  echo "...done."
echo ===========================================================================
done

echo ===========================================================================
echo "Unless errors have been received, the Moody College Drupal 6 Installation is ready for configuration and database import/export."
echo ===========================================================================
echo " "
echo ===========================================================================
# Add drush sql-cli commands
# Add drush dis commands for uninstalling cruft modules
# Add rm commands for deleting cruft modules
# Add drush dis commands for uninstalling site-wide Views 2 modules
# Add rm commands for deleting site-wide Views 2 module.
# Add git command for downloading Views site-wide 3 module.
# Add drush en command for enabling Views site-wide 3 module.
echo ===========================================================================

# Installing the Moody College Drupal 6 Individual Site Instances
#
echo "Configuring local settings for Moody College Drupal 6 Individual Site installations."

for configuring_d6_individual_site in departments
do
  echo ===========================================================================
  echo "-- Initializing $configuring_d6_individual_site site Installation generation..."
  echo " "
  sudo mkdir /var/www/d6/$configuring_d6_individual_site
  sudo cp -r /var/tmp/multisite/* /var/www/d6/$configuring_d6_individual_site
  echo ===========================================================================
  echo "-- Removing errata files from $configuring_d6_individual_site site Instance...."
  sudo rm -r /var/www/d6/advertising/sites/*
  sudo mkdir /var/www/d6/$configuring_d6_individual_site/sites/$configuring_d6_individual_site.utexas.edu.local.vm
  sudo cp -r /var/tmp/multisite/sites/$configuring_d6_individual_site/$configuring_d6_individual_site.utexas.edu.local.vm/* /var/www/d6/$configuring_d6_individual_site/sites/$configuring_d6_individual_site.utexas.edu.local.vm
  echo "...done."
  echo " "
  echo ===========================================================================
  echo "-- Adding sym-links for local development...."
  sudo ln -s /var/d6/$configuring_d6_individual_site/sites/$configuring_d6_individual_site.utexas.edu /var/www/d6/$configuring_d6_individual_site/sites/$configuring_d6_individual_site.utexas.edu.local.vm
  echo "...done."
  echo " "
  echo ===========================================================================
  echo "-- Configuring Advertising...."
  sudo cp /var/www/redesign/settings-files/d6/$configuring_d6_individual_site/local-settings.php /var/www/d6/$configuring_d6_individual_site/sites/$configuring_d6_individual_site.utexas.edu.local.vm/local-settings.php
  echo "...done."
  echo ===========================================================================
  echo ===========================================================================
done

echo "Cleaning up temporary files."
sudo rm -r /var/tmp/multisite -y
