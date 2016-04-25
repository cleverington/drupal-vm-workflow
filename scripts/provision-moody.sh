#!/bin/bash

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

## Installing the Moody College Drupal 6 Multisite Instances
echo "==========================================================================="
echo "Configuring local settings for Moody College Drupal 6 Multisite installation."
echo "-- Creating temporary files"
sudo git clone https://comm-webmaster@bitbucket.org/moodycollegedevelopers/moody-multisite.git /var/tmp/multisite
echo "... done."
echo "====="
echo "-- Removing cruft files for Multisite Installation..."
sudo rm -r /var/tmp/multisite/.htaccess
echo "... done."
echo "====="
echo "-- Adding clean .htaccess file"
sudo cp -rp /var/www/redesign/settings-files/.htaccess /var/tmp/multisite/.htaccess
echo "... done."
echo "====="
echo "-- Adding Site Installation Files"
sudo mkdir -p /var/www/public_html/d6/multisite
sudo rm -rf /var/www/public_html/d6/multisite/*
sudo cp -rp /var/www/var/tmp/multisite/* /var/www/public_html/d6/multisite/
echo " "
echo "==========================================================================="
echo "-- Adding sym-links for local development...."

for sym_link_variable in ${departments}
do
  echo "-- -- Adding sym-link for ${sym_link_variable}"
  # Sym-link:  ln -s /path-destination/ /path-source/
  sudo ln -s /var/www/public_html/d6/multisite/sites/${sym_link_variable}.utexas.edu /var/www/public_html/d6/multisite/sites/${sym_link_variable}.utexas.edu.multisite.vm
done

echo "...done."
echo " "
echo "==========================================================================="
echo "-- Configuring all site-folders...."

for default_settings in ${departments}
do
  echo "-- -- Configuring site-folder for ${default_settings}"
  sudo cp -p /var/www/redesign/settings-files/d6-default/settings.php /var/www/public_html/d6/multisite/sites/${default_settings}.utexas.edu/settings.php
done

echo "...done."
echo "==========================================================================="

for configuring_multisite in ${departments}
do
  echo "==========================================================================="
  echo "-- Configuring ${configuring_multisite}...."
  sudo cp -p /var/www/redesign/settings-files/d6-multisite/${configuring_multisite}/local-settings.php /var/www/public_html/d6/multisite/sites/${configuring_multisite}.utexas.edu/local-settings.php
  echo "...done."
  echo "==========================================================================="
done
echo " "
echo " "
echo "==========================================================================="
echo "Creating separate instances of each sites."
echo "==========================================================================="

# Installing the Moody College Drupal 6 Individual Site Instances
#
echo "-- Configuring local settings for Moody College Drupal 6 Individual Site installations."
echo "====="
#echo "-- Cleaning up Multisite temporary files from Drupal 6 Multisite Installation."
#sudo rm -r /var/tmp/multisite
#echo "... done."

echo "-- Creating temporary files"
sudo mkdir -p /var/tmp/multisite
sudo cp -rp /var/www/public_html/d6/multisite/* /var/tmp/multisite/
echo "... done."

for configuring_d6_individual_site in ${departments}
do
  echo "==========================================================================="
  echo "-- Initializing ${configuring_d6_individual_site} site Installation generation..."
  echo " "
  echo "-- -- Removing cruft files for ${configuring_d6_individual_site}, if existing..."
  sudo rm -r /var/www/public_html/d6/${configuring_d6_individual_site}/sites/*
  echo "-- -- Moving files for ${configuring_d6_individual_site}"
  sudo mkdir -p /var/www/public_html/d6/${configuring_d6_individual_site}
  sudo cp -rp /var/tmp/multisite/* /var/www/public_html/d6/${configuring_d6_individual_site}
  echo "==========================================================================="
  echo "-- Removing errata files from ${configuring_d6_individual_site} site Instance...."
  sudo rm -r /var/www/public_html/d6/${configuring_d6_individual_site}/sites/*
  sudo mkdir -p /var/www/public_html/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu
  sudo cp -r /var/tmp/multisite/sites/${configuring_d6_individual_site}.utexas.edu/* /var/www/public_html/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu
  echo "...done."
  echo "-- Adding Moody errata files back into ${configuring_d6_individual_site} site Instance for multisite stability...."
  sudo mkdir -p /var/www/public_html/d6/${configuring_d6_individual_site}/sites/moody.utexas.edu
  sudo mkdir -p /var/www/public_html/d6/${configuring_d6_individual_site}/sites/all
  sudo cp -r /var/www/public_html/d6/multisite/sites/moody.utexas.edu/* /var/www/public_html/d6/${configuring_d6_individual_site}/sites/moody.utexas.edu
  sudo cp -r /var/www/public_html/d6/multisite/sites/all/* /var/www/public_html/d6/${configuring_d6_individual_site}/sites/all
  echo " "
  echo "==========================================================================="
  echo "-- Adding ${configuring_d6_individual_site} sym-links for local development...."
  # Sym-link:  ln -s /path-destination/ /path-source/
  sudo ln -s /var/www/public_html/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu /var/www/public_html/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu.local.vm
  sudo ln -s /var/www/public_html/d6/${configuring_d6_individual_site}/sites/moody.utexas.edu /var/www/public_html/d6/${configuring_d6_individual_site}/sites/moody.utexas.edu.local.vm
  sudo ln -s /var/www/public_html/d6/${configuring_d6_individual_site}/sites/moody.utexas.edu /var/www/public_html/d6/${configuring_d6_individual_site}/sites/default
  echo "...done."
  echo " "
  echo "==========================================================================="
  echo "-- Configuring ${configuring_d6_individual_site} Local Settings...."
  sudo cp -p /var/www/redesign/settings-files/d6/${configuring_d6_individual_site}/local-settings.php /var/www/public_html/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu.local.vm/local-settings.php
  echo "...done."
  echo "==========================================================================="
  echo "==========================================================================="
done

echo "==========================================================================="
echo "Unless errors have been received, the Moody College Drupal 6 Single Site Installations are ready for migration work, including CCK migration, Views migration, etc."
echo "==========================================================================="
echo "  "
echo "==========================================================================="

#echo " "
#echo "==========================================================================="
# Add drush sql-cli commands
# Add drush dis commands for uninstalling cruft modules
# Add rm commands for deleting cruft modules
# Add drush dis commands for uninstalling site-wide Views 2 modules
# Add rm commands for deleting site-wide Views 2 module.
# Add git command for downloading Views site-wide 3 module.
# Add drush en command for enabling Views site-wide 3 module.
echo "==========================================================================="

#echo "Cleaning up temporary files."
#sudo rm -r /var/tmp/multisite