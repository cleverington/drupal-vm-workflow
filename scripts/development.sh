# development.sh

# This script is a temporary tool being provisioned to automate
#   the upgrade for each site of Views from Views 2.x to Views 3.x
#



echo "Configuring MySQL Server for ${departments} in Multisite Installation"



Once the Multisite Servers are Far enough along, a SQL-Dump can be done on the each Drupal instance to 'prepare' a working setup from the multisite to the Single Site.

Thinking on this aspect, the /multisite/ directory needs to be copied back to the /var/tmp/multisite/ directory once configuration is complete.

for single_site_folder in ${departments}
do
  echo "-- Configuring MySQL Server for ${departments} in Single Site Installations"
  echo "Dropping tables (if any exist)"
  drush @moody-redesign.${multisite_folder}.utexas.edu.multisite.vm sql-cli sql-drop -y
  drush @moody-redesign.${multisite_folder}.utexas.edu.multisite.vm sql-cli < /var/www/redesign/${single_site_folder}_main_20160404.sql
done



run commands:
- Import database (sql-drop + sql-cli)
- disable views
- delete non-required views modules
  - views_slideshow
  - views_slideshow_ddblock
- download views
  - drush pm-download views sites/all/modules/--select -1
- update database


Needs to go in the readme.

The .htaccess file needs to be copied from server to server.

Zend OpCache backflow needs to be added into the script as well because it is not inherent in the Drupal VM.