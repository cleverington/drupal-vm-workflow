#!/bin/zsh

# provision-moody.sh
# This bash script needs to be executed to execute the needed actions for spinning up the current Moody College Tasks tool.

# This script is meant for use on by Moody College of Communication
# Developers for creating test environments. It should not be used for
# creating or altering Production environments on UT Web.

echo ===========================================================================
echo "Installing the UT Drupal Kit in /var/www/development"
drush make /var/www/redesign/makefiles/development.utexas.edu.make.yml /var/www/development
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
echo git clone git@bitbucket.org:utexas-its-mdus/moody.git /var/tmp/multisite
echo "-- Adding Site Installation Files"
echo cp -r /var/tmp/multisite /var/www/d6/multisite
echo " "
echo ===========================================================================
echo "-- Configuring Advertising...."
cp /var/www/redesign/settings-files/d6-multisite/advertising/local-settings.php /var/www/d6/multisite/sites/advertising.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Communication Studies...."
cp /var/www/redesign/settings-files/d6-multisite/commstudies/local-settings.php /var/www/d6/multisite/sites/commstudies.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Communication Sciences & Disorders...."
cp /var/www/redesign/settings-files/d6-multisite/csd/local-settings.php /var/www/d6/multisite/sites/csd.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Journalism...."
cp /var/www/redesign/settings-files/d6-multisite/journalism/local-settings.php /var/www/d6/multisite/sites/journalism.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Moody Main Site...."
cp /var/www/redesign/settings-files/d6-multisite/moody/local-settings.php /var/www/d6/multisite/sites/moody.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "-- Configuring Radio, Television, & Film...."
cp /var/www/redesign/settings-files/d6-multisite/rtf/local-settings.php /var/www/d6/multisite/sites/rtf.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "Unless errors have been received, the Moody College Drupal 6 Installation is ready for configuration and database import/export."
echo ===========================================================================
echo " "
echo ===========================================================================
echo ===========================================================================

# Installing the Moody College Drupal 6 Individual Site Instances
echo "Configuring local settings for Moody College Drupal 6 Individual Site installations."
# Advertising
echo ===========================================================================
echo "Initializing Advertising Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/advertising
echo ===========================================================================
echo "Removing errata files from Advertising Single Site Instance...."
echo rm -r /var/www/d6/advertising/sites/commstudies.utexas.edu
echo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
echo rm -r /var/www/d6/advertising/sites/journalism.utexas.edu
echo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
echo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "Advertising...."
cp /var/www/redesign/settings-files/d6/advertising/local-settings.php /var/www/d6/advertising/sites/advertising.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
# Communication Studies
echo ===========================================================================
echo "Initializing Communication Studies Site Installation generation..."
echo " "
echo cp -r /var/tmp/multisite /var/www/d6/commstudies
echo ===========================================================================
echo "Removing errata files from Communication Studies Single Site Instance...."
echo rm -r /var/www/d6/advertising/sites/advertising.utexas.edu
echo rm -r /var/www/d6/advertising/sites/csd.utexas.edu
echo rm -r /var/www/d6/advertising/sites/journalism.utexas.edu
echo rm -r /var/www/d6/advertising/sites/moody.utexas.edu
echo rm -r /var/www/d6/advertising/sites/rtf.utexas.edu
echo "...done."
echo " "
echo ===========================================================================
echo "Communication Studies...."
cp /var/www/redesign/settings-files/d6/commstudies/local-settings.php /var/www/d6/commstudies/sites/commstudies.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "Communication Sciences & Disorders...."
cp /var/www/redesign/settings-files/d6/csd/local-settings.php /var/www/d6/csd/sites/csd.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "Journalism...."
cp /var/www/redesign/settings-files/d6/journalism/local-settings.php /var/www/d6/journalism/sites/journalism.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "Moody Main Site...."
cp /var/www/redesign/settings-files/d6/moody/local-settings.php /var/www/d6/moody/sites/moody.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "Radio, Television, & Film...."
cp /var/www/redesign/settings-files/d6/rtf/local-settings.php /var/www/d6/rtf/sites/rtf.utexas.edu.local/local-settings.php
echo "...done."
echo ===========================================================================
echo "Unless errors have been received, the Moody College Drupal 6 Installation is ready for configuration and database import/export."
echo ===========================================================================
echo " "
echo ===========================================================================
echo ===========================================================================
