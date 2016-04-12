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

# Installing the UT Drupal Kit Development Server
echo ===========================================================================
echo "Installing the UT Drupal Kit in /var/www/development for Testing Purposes"
echo "Username / Password: admin"
echo " "
drush make /var/www/redesign/makefiles/development.utexas.edu.make.yml utexas
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
sudo cp -r /var/tmp/multisite /var/www/d6/multisite
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/multisite/sites/advertising.utexas.edu /var/www/d6/multisite/sites/advertising.utexas.edu.multisite.vm
sudo ls -s /var/d6/multisite/sites/commstudies.utexas.edu /var/www/d6/multisite/sites/commstudies.utexas.edu.multisite.vm
sudo ls -s /var/d6/multisite/sites/csd.utexas.edu /var/www/d6/multisite/sites/csd.utexas.edu.multisite.vm
sudo ls -s /var/d6/multisite/sites/journalism.utexas.edu /var/www/d6/multisite/sites/journalism.utexas.edu.multisite.vm
sudo ls -s /var/d6/multisite/sites/moody.utexas.edu /var/www/d6/multisite/sites/moody.utexas.edu.multisite.vm
sudo ls -s /var/d6/multisite/sites/rtf.utexas.edu /var/www/d6/multisite/sites/rtf.utexas.edu.multisite.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring all site-folders...."
sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/advertising.utexas.edu/settings.php
sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/commstudies.utexas.edu/settings.php
sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/csd.utexas.edu/settings.php
sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/journalism.utexas.edu/settings.php
sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/moody.utexas.edu/settings.php
sudo cp /var/www/redesign/settings-files/d6-default/settings.php /var/www/d6/multisite/sites/rtf.utexas.edu/settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Advertising...."
sudo cp /var/www/redesign/settings-files/d6-multisite/advertising/local-settings.php /var/www/d6/multisite/sites/advertising.utexas.edu.multisite.vm/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Communication Studies...."
sudo cp /var/www/redesign/settings-files/d6-multisite/commstudies/local-settings.php /var/www/d6/multisite/sites/commstudies.utexas.edu.multisite.vm/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Communication Sciences & Disorders...."
sudo cp /var/www/redesign/settings-files/d6-multisite/csd/local-settings.php /var/www/d6/multisite/sites/csd.utexas.edu.multisite.vm/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Journalism...."
sudo cp /var/www/redesign/settings-files/d6-multisite/journalism/local-settings.php /var/www/d6/multisite/sites/journalism.utexas.edu.multisite.vm/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Moody Main Site...."
sudo cp /var/www/redesign/settings-files/d6-multisite/moody/local-settings.php /var/www/d6/multisite/sites/moody.utexas.edu.multisite.vm/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Radio, Television, & Film...."
cp /var/www/redesign/settings-files/d6-multisite/rtf/local-settings.php /var/www/d6/multisite/sites/rtf.utexas.edu.multisite.vm/local-settings.php
echo "...done."
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

# Advertising
echo ===========================================================================
echo "-- Initializing Advertising Site Installation generation..."
echo " "
sudo cp -r /var/tmp/multisite /var/www/d6/advertising
echo ===========================================================================
echo "-- Removing errata files from Advertising Single Site Instance...."
sudo rm -r /var/www/d6/advertising/sites/commstudies.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/journalism.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/advertising/sites/advertising.utexas.edu /var/www/d6/advertising/sites/advertising.utexas.edu.local.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring Advertising...."
sudo cp /var/www/redesign/settings-files/d6/advertising/local-settings.php /var/www/d6/advertising/sites/advertising.utexas.edu.local.vm/local-settings.php
echo "...done."
echo ===========================================================================

# Communication Studies
echo ===========================================================================
echo "-- Initializing Communication Studies Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/commstudies
echo ===========================================================================
echo "-- Removing errata files from Communication Studies Single Site Instance...."
sudo rm -r /var/www/d6/advertising/sites/advertising.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/journalism.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/commstudies/sites/commstudies.utexas.edu /var/www/d6/commstudies/sites/commstudies.utexas.edu.local.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring Communication Studies...."
sudo cp /var/www/redesign/settings-files/d6/commstudies/local-settings.php /var/www/d6/commstudies/sites/commstudies.utexas.edu.local.vm/local-settings.php
echo "...done."
echo ===========================================================================

# Communication Sciences & Disorders
echo ===========================================================================
echo "-- Initializing Communication Sciences & Disorders Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/csd
echo ===========================================================================
echo "-- Removing errata files from Communication Sciences & Disorders Single Site Instance...."
sudo rm -r /var/www/d6/advertising/sites/advertising.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/commstudies.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/journalism.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/multisite/csd/csd.utexas.edu /var/www/d6/csd/sites/csd.utexas.edu.local.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring Communication Sciences & Disorders...."
sudo cp /var/www/redesign/settings-files/d6/csd/local-settings.php /var/www/d6/csd/sites/csd.utexas.edu.local.vm/local-settings.php
echo "...done."
echo ===========================================================================

# Journalism
echo ===========================================================================
echo "-- Initializing Journalism Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/journalism
echo ===========================================================================
echo "-- Removing errata files from Journalism Single Site Instance...."
sudo rm -r /var/www/d6/advertising/sites/advertising.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/commstudies.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/journalism/sites/journalism.utexas.edu /var/www/d6/journalism/sites/journalism.utexas.edu.local.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring Journalism...."
sudo cp /var/www/redesign/settings-files/d6/journalism/local-settings.php /var/www/d6/journalism/sites/journalism.utexas.edu.local.vm/local-settings.php
echo "...done."
echo ===========================================================================

# Moody
echo ===========================================================================
echo "-- Initializing Moody Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/moody
echo ===========================================================================
echo "-- Removing errata files from Moody Single Site Instance...."
sudo rm -r /var/www/d6/advertising/sites/advertising.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/commstudies.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/journalism.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/moody/sites/moody.utexas.edu /var/www/d6/moody/sites/moody.utexas.edu.local.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring Moody...."
sudo cp /var/www/redesign/settings-files/d6/moody/local-settings.php /var/www/d6/moody/sites/moody.utexas.edu.local.vm/local-settings.php
echo "...done."
echo ===========================================================================

# Radio, Television, & Film
echo ===========================================================================
echo "-- Initializing Radio, Television, & Film Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/rtf
echo ===========================================================================
echo "-- Removing errata files from Radio, Television, & Film Single Site Instance...."
sudo rm -r /var/www/d6/advertising/sites/advertising.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/commstudies.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
sudo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "-- Adding sym-links for local development...."
sudo ls -s /var/d6/rtf/sites/rtf.utexas.edu /var/www/d6/rtf/sites/rtf.utexas.edu.local.vm
echo "...done."
echo " "
echo ===========================================================================
echo "-- Configuring Radio, Television, & Film...."
sudo cp /var/www/redesign/settings-files/d6/rtf/local-settings.php /var/www/d6/moody/sites/rtf.utexas.edu.local.vm/local-settings.php
echo "...done."
echo ===========================================================================
echo ===========================================================================
echo "Unless errors have been received, the Moody College Drupal 6 Individual Site installations are ready for configuration and database import/export."
echo ===========================================================================
echo " "
echo ===========================================================================
echo ===========================================================================


echo "Cleaning up temporary files."
sudo rm -r /var/tmp/multisite -y
