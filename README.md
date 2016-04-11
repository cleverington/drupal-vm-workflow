# Grunt Moody College of Communication Tasks
## A Grunt automation tool for building, testing, migrating & reviewing Drupal 6 to Drupal 7 Migration tasks.

## Requirements

> Note that the Grunt Moody College of Communication Tasks tool is inteneded to be compatible with Node.js 0.12.9, npm 2.10.1, grunt-cli 0.1.13, grunt 0.4.5 & bower 1.4.1 as approved for usage withing the UT Drupal Kit 2.x. 

> See [ITS | UT Drupal Kit | Forty Acres Theme - 7. Grunt workflow for using SASS in a sub-theme](https://wikis.utexas.edu/display/UTDK/Forty+Acres+Theme) for more details. (Access to the UT Web Developers Wiki is required.)

* Install _[Node.js v0.12.9](https://nodejs.org/en/blog/release/v0.12.9/ "Node.js v0.12.9")_
* Once _Node.js v0.12.9_ is installed, use _npm_ to install the most recent version of [grunt-cli](https://github.com/gruntjs/grunt-cli" "grunt-cli"), the Grunt command line interface, by running:
```
npm install -g grunt-cli
```

## Quickstart
There is not currently a 'quick-start' method to use for the Grunt Moody College of Communication Tasks tool.

Here are the required commands, in order, however:
```
mkdir ~/moody-projects
cd ~/moody-projects
git clone git@bitbucket.org:crl2728/grunt-redesign.git .
(When asked, choose 'yes')
git submodule add git@github.com:geerlingguy/drupal-vm.git drupalvm/
cp ~/moody-projects/redesign/config-files/config.yml ~/moody-projects/drupalvm/config.yml
cd drupalvm/ && vagrant up
```
> Note - '/moody-projects/' is required to be the root of the directory, based on current configuration.
>   Deviation from using /moody-projects/ requires the 'vagrant_synced_folders' variable to be edited.
>   Though, currently, the 'vagrant_synced_folders' variable must me configured due to development needs for VM.

Once Vagrant finishes build the VM, Drupal needs to be installed for the various projects using the now headless Virtual Machine.

The following directories have been copied over 'as-is' from 
> Note - This will eventually be updated to actually pull down the Source Code via Git, ensuring all work can be completed at any machine, anywhere.
> It requires adding a specialized script (moody.sh or similar) into the /scripts/ folder to pull down a copy of the required content into the /development/, /redesign/, and /multisite (does not yet exist) directories prior to vagrant up.
> This script would then include all of the required commands, so instead of 'vagrant up', the VM would be created by running the script.

###  Tasks for moody-redesign.sh Script:
* Create the ~/moody-project directory, if none exists
* Clone a copy of the grunt-redesign project, if it does not exist
* Clone a copy of the drupal-vm project, if it does not exist
* Copy the config.yml file from /redesign/config-files/config.yml to /drupalvm/config.yml for use in the VM
* Run vagrant up
* Copy /var/www/redesign/settings-files/d6-multisite/*/local-settings.php to /var/www/d6/multisite/sites/*/local-settings.php
* Copy /var/www/redesign/settings-files/d6/*/local-settings.php to /var/www/d6/*/sites/*/local-settings.php 
* Copy /var/www/redesign/settings-files/d7/*/local-settings.php to /var/www/d7/*/sites/*/local-settings.php

###  To Access the VM:
```
vagrant ssh
cd /var/www/
```

### To Access/Edit the Local Copy of the Moody Drupal 6 Multisite Instance:
```
cd /var/www/d6/multisite/
```

See config.yml for database information.

## Features
This project is built using the tools of the Grunt, Ansible, Vagrant, and Drupal communities to provide a streamlined and scripted method for automating a number of complicated, yet repetitive PHP & Drupal tasks executed during Development.

This project is **not** meant for use in the creation and development of the *final* Production environment, as it is not configured with any level of security.

The final project should be created separately in a folder by itself, with Configuration Management performed using this VM in conjunction with the Features Module as outlined by Drupalize.Me:
[Drupalize.Me | Drupal Deployment With Features and Drush](https://drupalize.me/videos/introduction-drupal-features-module?p=1170 "Drupal Deployment With Features and Drush")

- Build a Moody customized Drupal VM using the associated makefiles as available within the /redesign/makefiles/ directory;
- Within the Vagrant enabled VM, build each of the following sites for usage in the Moody Migration Project:
 - Drupal 6 Multisite (Adv., CommStu., CSD, Journ., Moody, RTF)
 - Drupal 6 Single-Site Instances for: Adv., CommStu., CSD, Journ., Moody, RTF
 - Drupal 7 (UT Drupal Kit 2.x) Single-Site instances for:  Adv., CommStu., CSD, Journ., RTF
  - Add/Update modules required for Moody College, but unavailable within the UT Drupal Kit (as necessary)
 - Drupal 7 (UT Drupal Kit 2.x) Multisite instances for:  Moody, Strauss (*pending*), Faculty (*pending*), and Research (*pending*);
  - Add/Update modules required for Moody College, but unavailable within the UT Drupal Kit (as necessary)
- Import clean database dumps from the Quality server (updated to the Production server only during the *final* run;
- Perform required Upgrade Tasks on each Drupal 6 Single-site Installation:
 - Upgrade CCK tables on each database
 - Upgrade from Views 6.x-2.x to Views 6.x-3.x
 - Update-in-place from Drupal 6.x to Drupal 7.x
 - Uninstall & Delete Drupal 6 modules
 - Install Drupal 7 version of required modules
 - Update-in-place for Drupal 7 modules
- Create *new* database dumps from the upgraded Drupal 6 single-site instances;
- Perform migration from upgraded Drupal 6 single-site instances to UTexas Drupal 7 instances
- Test 'new' UTexas Drupal 7 instances for broken links, etc.
- Using Drush:
 - Add/Update modules required for Moody College, but unavailable within the UT Drupal Kit.

## Editing the Project

Because some files shared between projects, such as the local-settings.php files and Drupal-VM generated files will never be necessary within the Git Repository, changes should be completed using the ```git diff``` patching functionality.

This is especially true when applying changes to UT Web. By using the 'patch' functionality, only the specific changes to specific files are made, whereas using the ```git pull``` functionality pulls down complete copies of every single file and compares them to the files on the server. By using patches, changes are done in KB instead of MB, which can greatly reduce the digital overhead on UT Web. 

The project root will always be known as 'master', with various Branches and Forks eventually created based on Project needs.

### Example Workflow 
#### Changes are made to ~/moody-project/redesign/config-files/config.yml from branch 'master':
```
git branch config_changes
git checkout config_changes
git status (To see required files for git add)
git add * (Only use * if adding ALL changes. Else use the files path/name instead.)
git commit -m "Write a commit message every time."
git diff master > config_changes_YYYY-MM-DD.patch
```

#### Test the Patch
```
git checkout master
git apply -v config_changes_YYYY-MM-DD.patch

If successful, clear master and all changes to get ready for more edits:
git reset --hard HEAD
```

If the patch was successfully applied to 'master', then move to the next step.
 
#### Submit Patch for Approval
```
git push origin config_changes
```

#### Apply A Patch on UT Web Servers
> Note - Always run ```git status``` on the server prior to applying any patches.

```
scp ~/moody-project/config_changes_YYYY-MM-DD.patch utw10xxx@panel.utweb.utexas.edu://home/utweb/utw10xxx/public_html/config_changes_YYYY-MM-DD.patch
ssh utw10xxx@panel.utweb.utexas.edu
cd public_html/
git apply -v config_changes_YYYY-MM-DD.patch

Clean Up:
rm config_changes_YYYY-MM-DD.patch
```


> Note - The following is currently non-functional, see the QuickStart Guide.

## Usage
To build the Moody College of Communication site testing-platform, run ```grunt```

### Special Flags
- ```quiet```: Suppress desktop notifications
- ```notify```: Request a desktop notification, despite timing or environment settings.