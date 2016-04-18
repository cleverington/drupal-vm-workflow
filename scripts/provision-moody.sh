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

echo "==========================================================================="
echo "Initializing..."
echo "-- Updating Drush Bash File."
sudo cp -rp /var/www/redesign/drush-files/moodyredesign.aliases.drushrc.php ~/.drush/

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
sudo mkdir -p /var/www/d6/multisite
sudo rm -rf /var/www/d6/multisite/*
sudo cp -rp /var/tmp/multisite/* /var/www/d6/multisite/
echo " "
echo "==========================================================================="
echo "-- Adding sym-links for local development...."

for sym_link_variable in ${departments}
do
  echo "-- -- Adding sym-link for ${sym_link_variable}"
  # Sym-link:  ln -s /path-destination/ /path-source/
  sudo ln -s /var/www/d6/multisite/sites/${sym_link_variable}.utexas.edu /var/www/d6/multisite/sites/${sym_link_variable}.utexas.edu.multisite.vm
done

echo "...done."
echo " "
echo "==========================================================================="
echo "-- Configuring all site-folders...."

for default_settings in ${departments}
do
  echo "-- -- Configuring site-folder for ${default_settings}"
  sudo cp -p /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/${default_settings}.utexas.edu/settings.php
done

echo "...done."
echo "==========================================================================="

for configuring_multisite in ${departments}
do
  echo "==========================================================================="
  echo "-- Configuring ${configuring_multisite}...."
  sudo cp -p /var/www/redesign/settings-files/d6-multisite/${configuring_multisite}/local-settings.php /var/www/d6/multisite/sites/${configuring_multisite}.utexas.edu/local-settings.php
  echo "...done."
  echo "==========================================================================="
done

echo "==========================================================================="
echo "Unless errors have been received, the Moody College Drupal 6 Multisite Installation is ready for configuration and database import/export."
echo "==========================================================================="
echo "Configuring MySQL Server for ${departments} in Multisite Installation"
echo "======="
for multisite_folder in ${departments}
do
  echo "-- Dropping tables (if any exist)"
  drush @moodyredesign.${multisite_folder}.utexas.edu.multisite.vm sql-drop -y
  echo "... done."
  echo "======="
  echo "-- Importing unedited SQL-Dumps from Live Server"
  drush @moodyredesign.${multisite_folder}.utexas.edu.multisite.vm sql-cli < /var/www/redesign/sql-dumps/${multisite_folder}_main_20160404.sql -y
  echo "... done."
  echo "======="
#  echo "-- Deleting SQL-Dump (to save HDD space)"
#  sudo rm /var/www/redesign/sql-dumps/${multisite_folder}_main_20160404.sql
#  echo "... done."
#  echo "======="
done
echo "==========================================================================="
# Add drush sql-cli commands
# Add drush dis commands for uninstalling cruft modules
# Add rm commands for deleting cruft modules
# Add drush dis commands for uninstalling site-wide Views 2 modules
# Add rm commands for deleting site-wide Views 2 module.
# Add git command for downloading Views site-wide 3 module.
# Add drush en command for enabling Views site-wide 3 module.
echo "==========================================================================="

# Installing the Moody College Drupal 6 Individual Site Instances
#
echo "Configuring local settings for Moody College Drupal 6 Individual Site installations."

echo "-- Cleaning up Multisite temporary files from Drupal 6 Multisite Installation."
sudo rm -r /var/tmp/multisite -y
echo "... done."

echo "-- Creating temporary files"
sudo mkdir -p /var/tmp/multisite
sudo cp -rp /var/www/d6/multisite/* /var/tmp/multisite/
echo "... done."

for configuring_d6_individual_site in ${departments}
do
  echo "==========================================================================="
  echo "-- Initializing ${configuring_d6_individual_site} site Installation generation..."
  echo " "
  echo "-- -- Removing cruft files for ${configuring_d6_individual_site}, if existing..."
  sudo rm -r /var/www/d6/${configuring_d6_individual_site}/sites/*
  echo "-- -- Moving files for ${configuring_d6_individual_site}"
  sudo mkdir -p /var/www/d6/${configuring_d6_individual_site}
  sudo cp -rp /var/tmp/multisite/* /var/www/d6/${configuring_d6_individual_site}
  echo "==========================================================================="
  echo "-- Removing errata files from ${configuring_d6_individual_site} site Instance...."
  sudo rm -r /var/www/d6/${configuring_d6_individual_site}/sites/*
  sudo mkdir -p /var/www/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu
  sudo cp -r /var/tmp/multisite/sites/${configuring_d6_individual_site}.utexas.edu/* /var/www/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu
  echo "...done."
  echo " "
  echo "==========================================================================="
  echo "-- Adding ${configuring_d6_individual_site} sym-links for local development...."
  # Sym-link:  ln -s /path-destination/ /path-source/
  sudo ln -s /var/www/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu.local.vm /var/www/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu
  echo "...done."
  echo " "
  echo "==========================================================================="
  echo "-- Configuring ${configuring_d6_individual_site} Local Settings...."
  sudo cp -p /var/www/redesign/settings-files/d6/${configuring_d6_individual_site}/local-settings.php /var/www/d6/${configuring_d6_individual_site}/sites/${configuring_d6_individual_site}.utexas.edu.local.vm/local-settings.php
  echo "...done."
  echo "==========================================================================="
  echo "==========================================================================="
done

echo "==========================================================================="
echo "Unless errors have been received, the Moody College Drupal 6 Single Site Installations are ready for configuration and database import/export."
echo "==========================================================================="
echo " "
echo "==========================================================================="
# Add drush sql-cli commands
# Add drush dis commands for uninstalling cruft modules
# Add rm commands for deleting cruft modules
# Add drush dis commands for uninstalling site-wide Views 2 modules
# Add rm commands for deleting site-wide Views 2 module.
# Add git command for downloading Views site-wide 3 module.
# Add drush en command for enabling Views site-wide 3 module.
echo "==========================================================================="

echo "Cleaning up temporary files."
sudo rm -r /var/tmp/multisite
sudo rm -r /var/tmp/multisite/*

# Installing the UT Drupal Kit Development Server
# echo "==========================================================================="
# echo "Installing the UT Drupal Kit in /var/www/development for Testing Purposes"
# echo "Username / Password: admin"
# echo " "
# cd /var/www
# drush make /var/www/redesign/makefiles/development.utexas.edu.make.yml development -y
# sleep 20s
# cd /var/scripts
# echo "==========================================================================="
# echo "==========================================================================="
# echo "==========================================================================="
# echo "Unless errors have been received, the UT Drupal Kit has been installed in the Development directory."
# echo "==========================================================================="
