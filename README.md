# Moody College of Communication Tasks
## A Vagrant enabled automation tool for building, testing, migrating & reviewing Drupal 6 to Drupal 7 Migration tasks.

## Requirements
* Git (Apple Shipped is good enough)
* Python 2.7.11
* Vagrant 1.8.1
* Ansible 2.0.1.0
* grunt-cli v1.2.0
* Node.js v0.12.13
* npm 2.15.1
* Bower 1.7.2
* Composter version 1.0-dev (cdea645eabe658e08fb2f4e5b80bddbd61c3adef) 2016-02-24 13:07:17
* Drush 7.1.0


> Note that the Grunt Moody College of Communication Tasks tool is intended to be compatible with Node.js 0.12.9, npm 2.10.1, grunt-cli 0.1.13, grunt 0.4.5 & bower 1.4.1 as approved for usage withing the UT Drupal Kit 2.x.
>   In addition, the Tasks tool has only been tested 'Live' with Mac OS X El Capitan 10.11.3

> See [ITS | UT Drupal Kit | Forty Acres Theme - 7. Grunt workflow for using SASS in a sub-theme](https://wikis.utexas.edu/display/UTDK/Forty+Acres+Theme) for more details. (Access to the UT Web Developers Wiki is required.)

> See [Enterprise Systems Management | Vagrant Virtual Machines | Getting started with Vagrant](https://wikis.utexas.edu/display/itsyesm/Getting+started+with+Vagrant) for more details. (Access to the UT Web Developers Wiki is required.)

* Install _[Node.js v0.12.9](https://nodejs.org/en/blog/release/v0.12.9/ "Node.js v0.12.9")_
* Once _Node.js v0.12.9_ is installed, use _npm_ to install the most recent version of [grunt-cli](https://github.com/gruntjs/grunt-cli" "grunt-cli"), the Grunt command line interface, by running:
```
npm install -g grunt-cli
```

## Quickstart

#### Install Required Software

* Vagrant - https://www.vagrantup.com/downloads.html
* Homebrew (for other packages) - http://brew.sh/ 
* Node.js - https://nodejs.org/en/

```
brew tap homebrew/dupes
brew tap homebrew/versions

Python:
brew install python

PHP 5.4.40
brew tap homebrew/hombrew-php
 brew options php54
 brew install php56
 brew link php56 (if failed, get IT Support)

Grunt: (Technically unneeded, as it will be installed on the VM)
npm install -g grunt-cli

Git: (Unneeded)
brew install git

vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostmanager
sudo ansible-galaxy install -r provisioning/requirements.yml --force
```


Download copies of all UT Drupal Kit tools and plugins & Moody College Drupal 6 Multisite errata:
```
~/tar-bin
    - /features
        - utexas-content_type_team_member-7.x-1.1.zip
        - utexas-role_landing_page_editor-7.x-1.1.zip
        - utexas-role_site_builder-7.x-1.1.zip
        - utexas-role_site_manager-7.x-1.1.zip
        - utexas-role_standard_page_editor-7.x-1.1.zip
        - utexas-role_team_member_editor-7.x-1.1.zip
    - /modules
    - /profiles
        - utexas-7.x-2.2.tar.gz
    - /themes
```

#### The required commands, in order:  <These will eventually be scripted>
```
mkdir ~/moody-projects
cd ~/moody-projects
git clone git@bitbucket.org:crl2728/grunt-redesign.git .
(When asked, choose 'yes')
git submodule add git@github.com:geerlingguy/drupal-vm.git drupalvm/
cp ~/moody-projects/redesign/config-files/config.yml ~/moody-projects/drupalvm/config.yml
```

### Download SQL-Dumps for Migration
Copy SQL-Dumps from Box-Sync folder 'Moody_SQL_backups':
(See Moody Tech. Svcs. for access, if required.)
```
~/moody-projects/
    - /redesign
        - sql-dumps
            - advertising_main.sql
            - commstudies_main.sql
            - csd_main.sql
            - journalism_main.sql
            - moody_main.sql
            - rtf_main.sql
```
> Note - '/moody-projects/' is **required** to be the root project directory.

>   Deviation from using /moody-projects/ requires the 'vagrant_synced_folders' variable to be edited within the ```config.yml``` file.

#### Download Site Files
> **Note:** This task should only be performed once. Git should be used for all other changes.
##### Download Active Moody Drupal 6 Multisite Installation
```
vagrant ssh
sudo source /var/scripts/provision-moody.sh
sudo source /var/scripts/provision-moody_db.sh

```

##### Download Active Moody Upgraded Drupal 7 Installation Locally
* Eventually, this line-item task will also ```scp``` downloading of a 'completed' Drupal 7 clean upgrade of each Moody College of Communication site.

*_placeholder_*


##### Download Active Moody UTDK Multisite Installation
```
vagrant ssh
sudo source /var/scripts/provision-redesign.sh
sudo source /var/scripts/provision-redesign_files.sh

```

#### Turn on the Virtual Server and Update
```
cd drupalvm/ && vagrant up
sudo yum upgrade -y
```

Once Vagrant finishes build the VM, Drupal needs to be installed for the various projects using the now headless Virtual Machine.
In addition, the databases *must* be configured to give Global permission to the ```drupal``` user. See **Troubleshooting**

> Note - This migration / redesign automation tool requires retrieval of Source Code via Git, ensuring all work can be completed at any machine, anywhere.
> It requires running a specialized script (moody-build.sh or similar) into the /scripts/ folder to pull down a copy of the required content into the /development/, /redesign/, and /multisite directories prior to vagrant up.

>   Users must follow the commands as outlined because a password is currently required for accessing the Git repository.

###  Future Tasks for moody-build.sh Script:
* Allow the User to select between two tasks (Redesign Development or Migration Work), and then:
  * Migration Work - Copy the config.yml file from /redesign/config-files/migration-config.yml to /drupalvm/config.yml for use in the VM
  * Migration Work - Copy the config.yml file from /redesign/config-files/development-config.yml to /drupalvm/config.yml for use in the VM

###  To Access the VM:
```
vagrant ssh
cd /var/www/public_html/
```

See config.yml for database information.

### To re-provision Moody Drupal 6 Multisite Installation and Moody Drupal 6 Single Site Installations:
```
vagrant ssh
source /var/scripts/provision-moody.sh
source /var/scripts/provision-moody_db.sh
```
When prompted, enter the required Comm-Webmaster password to pull down a copy of the required Git repository.

### To re-provision the Moody Drupal 7 Single Site Installations:
```
vagrant ssh
source /var/scripts/provision-redesign.sh
source /var/scripts/provision-redeisng_files.sh
```
When prompted, enter the required Comm-Webmaster password to pull down a copy of the required Git repository.

### (Pending) To provision the Moody Digital Asset Library:
**Required:** The Moody Drupal 7 Single Site Installations must be provisioned prior to attempting to provision the Digital Asset Library.
```
vagrant ssh
source /var/scripts/provision-DAL.sh
```
When prompted, enter the required Comm-Webmaster password to pull down a copy of the required Git repository.


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

### Software Packages Available
In addition to the base software required for any functional LAMP-stack, the MoodyVM is provisioned with a few other useful developer tools, which can be altered within the ```config.yml``` file:
```
# Add any extra apt or yum packages you would like installed.
extra_packages:
  - unzip
  - nano
  - links
```

* **unzip**
  * ```unzip``` is a tool for 'unzipping' compressed files and directories such as Zip files and tar-balls. It is a requirement for the MoodyVM and should not be removed. The necessary files downloaded by the Developer via the ```~/tarb-bin``` directory are all tar-balls, for example, which require the ```unzip``` package.
* **nano**
  * ```nano``` is a text-editor similar to Vim (vi) with a much simpler User Interface, including on-screen instructions for commands.
* **links**
  *```links``` is an *extremely* simple text-based web-browser.
  * *Shortcut Keys*
    * **g**: open an address
    * **Left Navigation Arrow**: back page
    * **Right Navigation Arrow**: Activate Link / Next Page
    * **Up/Down Navigation Arrow**: Navigate Through Page


## Editing the Project

Because some files shared between projects, such as the local-settings.php files and Drupal-VM generated files will never be necessary within the Git Repository, changes should be completed using the ```git diff``` patching functionality.

This is especially true when applying changes to UT Web. By using the 'patch' functionality, only the specific changes to specific files are made, whereas using the ```git pull``` functionality pulls down complete copies of every single file and compares them to the files on the server. By using patches, changes are done in KB instead of MB, which can greatly reduce the digital overhead on UT Web.

The project root will always be known as '6.x-?.x' (for Drupal 6) or '7.x-?.x' (for Drupal 7), with various Branches and Forks eventually created based on Project needs. Currently the project root for both projects is 'master', but this is temporary.

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

#### Example: Apply A Patch on the MoodyVM
> Note - Always run ```git status``` on the server prior to applying any patches.

```
scp ~/moody-projects/config_changes_YYYY-MM-DD.patch vagrant@moody-redesign.dev/var/tmp/config_changes_YYYY-MM-DD.patch
cd ~/moody-projects/drupalvm/
vagrant ssh
cd /var/tmp/utdrupalkit/
git apply -v /var/tmp/config_changes_YYYY-MM-DD.patch
sudo rm -R sites/

Clean Up:
rm /var/tmp/config_changes_YYYY-MM-DD.patch
```
Once finished patching, copy the updated files into each folder.


#### Example: Apply A Patch on UT Web Servers
> Note - Always run ```git status``` on the server prior to applying any patches.

```
scp ~/moody-projects/config_changes_YYYY-MM-DD.patch utw10xxx@panel.utweb.utexas.edu://home/utweb/utw10xxx/public_html/config_changes_YYYY-MM-DD.patch
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

## Troubleshooting

The Vagrantbox is not an alpha/omega solution for provisioning needs and sometimes there are issues with accessing needed information and tools.

For example, when creating a new Vagrantbox (```vagrant halt && vagrant destroy && vagrant up```), the SSH RSA key changes. This change makes the connection seem 'insecure', getting scary messages back about a ```Man in the Middle Attack!!!```. In most cases (though not all, obviously), there is no man-in-the-middle attack. The change is simply because, upon generating a new Virtualmachine, you have generated a new insecure/public RSA key as well.

#### Updating RSA Key for Known_Hosts
To gain access to provisioning access (such as connecting via SSH to the MySQL databases), delete the currently listed ```known_host``` for the Vagrantbox:
* Using a Text Editor (such as Sublime), edit the known_hosts file located at ~/.ssh/known_hosts
* Delete the line with the moody-redesign.dev virtualbox (192.168.88.88)
* Re-run ```vagrant up``` from the ````~/moody-projects/drupalvm``` directory

#### Updating User Tables
Within the current draft version of the installation, the ```drupal``` user is not being granted ANY priveleges within any database except the Development database (```drupal```).

Until a script can be used to correct the issue during VM generation, Developers must manually grant priveleges within all databases.

The easiest method to do this is either using the MySQL CLI or through a simple DBA program such as Sequel Pro.

See http://docs.drupalvm.com/en/latest/extras/mysql/ for instructions.

The global priveleges for the drupal user should only need to be altered once for the entire MySQL instance.

## Additional Resources
* [Mac OS X Setup Guide by Sourabh Bajaj](http://sourabhbajaj.com/mac-setup/ "Mac OS X Setup Guide by Sourabh Bajaj")
The Mac OS X Setup Guide has step-by-step instructions for installing many of the necessary tools for mastering the Moody Tasks such as:
  * Homebrew
  * PIP
  * Python (non-Apple version)
  * Git (non-Apple version)
  * iTerm2 (It's just prettier)
  * zsh (Its smoother than Bash)
  * Oh-My-Zsh (Prettiest Terminal coloration out there)
  * Sublime Text 3 (PHPStorm is a great tool, but nothing beats PHPStorm for straight content editing.)
