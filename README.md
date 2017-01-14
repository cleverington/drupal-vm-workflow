# Moody's UTexas Drupal VM Platform
## A Vagrant enabled automation tool for building, testing, migrating & reviewing Drupal 7 & Drupal 8 tasks.

## Warning!

After a great deal of research, NFS is not currently supported on the utexas network unless your Firewall is completely secured with a software like http://www.murusfirewall.com/.

Rsync is recommended.

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

> Note that the Moody's UTexas Drupal VM Platform tool is intended to be compatible with Node.js 0.12.9, npm 2.10.1, grunt-cli 0.1.13, grunt 0.4.5 & bower 1.4.1 as approved for usage within the UT Drupal Kit 2.x.
>   In addition, the Tasks tool has only been tested 'Live' with Mac OS X El Capitan 10.11.3

> See [ITS | UT Drupal Kit | Forty Acres Theme - 7. Grunt workflow for using SASS in a sub-theme](https://wikis.utexas.edu/display/UTDK/Forty+Acres+Theme) for more details. (Access to the UT Web Developers Wiki is required.)

> See [Enterprise Systems Management | Vagrant Virtual Machines | Getting started with Vagrant](https://wikis.utexas.edu/display/itsyesm/Getting+started+with+Vagrant) for more details. (Access to the UT Web Developers Wiki is required.)

* Install _[Node.js v0.12.9](https://nodejs.org/en/blog/release/v0.12.9/ "Node.js v0.12.9")_
* Once _Node.js v0.12.9_ is installed, use _npm_ to install the most recent version of [grunt-cli](https://github.com/gruntjs/grunt-cli" "grunt-cli"), the Grunt command line interface, by running:
```
npm install -g grunt-cli
```

## Recommendations
* Sublime Text 3 **OR** Atom.io **OR** Brackets.io
* PHPStorm
* iTerm2
* Sequel Pro
* FileZilla

## Quickstart
> **Note:** Despite the Drupal VM being 'baseline' configured for PHP 7.0, this config.yml file is configured for PHP 5.6.

Until June 2016, the Drupal VM supported versions of PHP prior to 5.6.

With the release of the Drupal VM 3.0, **PHP 5.6** is the lowest version supported. Developers should carefully test changes/configuration/code/etc. on a development server prior to pushing any changes to Production

### Current Directory Structure
```
~/drupal-vm-workflow
  composer.json
  development/
    ...
    sites/
    index.php
  redesign/
    config-files/
    drush-files/
    makefiles/
    scripts/
    settings-files/
      d7/
        development/
        other-sites-as-needed/
      d7-default/
        files/
      d8/

~/tar-bin
    - /features
    - /modules
    - /profiles
    - /themes
```

### (Pending) Composer Directory Structure (for Drupal 8, so it will be a while)
```
~/drupal-vm-workflow
  composer.json
  config/
    config.yml
    local.config.yml
    Vagrantfile.local
  docroot/
    ...
    sites/
    index.php
  vendor/
    ...
    geerlingguy/
      drupal-vm/
```

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

```


Download copies of all UT Drupal Kit tools and plugins errata:
```
~/tar-bin
    - /features
        - utexas-content_type_team_member-7.x-1.1.zip
        - utexas-role_landing_page_editor-7.x-1.1.zip
        - utexas-role_site_builder-7.x-1.1.zip
        - utexas-role_site_manager-7.x-1.1.zip
        - utexas-role_standard_page_editor-7.x-1.1.zip
        - utexas-role_team_member_editor-7.x-1.1.zip
        - your-features.zip
    - /modules
        - your-modules.zip
    - /profiles
        - utexas-7.x-2.2.tar.gz
    - /themes
        - your-forty-acres-subthemes.zip
```

#### Installation Instructions
```
git clone https://bitbucket.org/crl2728/drupal-vm-workflow.git ~/drupal-vm-workflow
(When asked, choose 'yes')
cd ~/drupal-vm-workflow/
source utexas-vm-builder.sh

```

### Download SQL-Dumps for Migration
Copy SQL-Dumps from any SQL-Dumps available:

```
~/drupal-vm-workflow/
    - /redesign
        - sql-dumps
```
> **Note:** - '/drupal-vm-workflow/' is **required** to be the root project directory.

>   Deviation from using /drupal-vm-workflow/ requires the 'vagrant_synced_folders' variable to be edited within the ```config.yml``` file along with a few other changes throughout the yaml file.

#### Download Site Files
> **Note:** This task should only be performed once. Git should be used for all other changes.


##### Download Active Git Repository of UTDK Installation
> **Note:** This will eventually be scripted, as shown, but requires using Git clone as shown, for now.
```
git clone <your-drupal-repository-here>.git ~/drupal-vm-workflow/development
```

Alternatively, you can edit ~/drupal-vm-workflow/redesign/scripts/provision-development.sh with your repo information and run the following command:
```
source ~/drupal-vm-workflow/redesign/scripts/provision-development.sh
```

#### Turn on the Virtual Server and Update
```
cd ~/drupal-vm-workflow/drupal-vm/ && vagrant up
vagrant ssh
sudo yum upgrade -y
```

Once Vagrant finishes build the VM, Drupal needs to be installed for the various projects using the now headless Virtual Machine.
In addition, the databases *must* be configured to give Global permission to the ```drupal``` user. See **Troubleshooting**

> Note - This migration / redesign automation tool requires retrieval of Source Code via Git, ensuring all work can be completed at any machine, anywhere.
> It requires running a specialized script (development.sh or similar) into the /scripts/ folder to pull down a copy of the required content into the /development/, /redesign/, and /multisite directories prior to vagrant up.

>   Users must follow the commands as outlined because a password is currently required for accessing the Git repository.

###  Future Tasks for development.sh Script:
* Allow the User to select between two tasks (Redesign Development or Migration Work), and then:
  * Migration Work - Copy the config.yml file from /redesign/config-files/migration-config.yml to /drupal-vm/config.yml for use in the VM
  * Migration Work - Copy the config.yml file from /redesign/config-files/development-config.yml to /drupal-vm/config.yml for use in the VM

###  To Access the VM:
```
vagrant ssh
cd /var/www/public_html/
```

See config.yml for database information.

### To re-provision the Drupal Single Site Installations:
> **Note:** This script is not built yet, but will require manipulation by Users to function properly.

```
vagrant ssh
source /var/scripts/provision-redesign.sh
source /var/scripts/provision-redesign_files.sh
```


## Features
This project is built using the tools of the Grunt, Ansible, Vagrant, and Drupal communities to provide a streamlined and scripted method for automating a number of complicated, yet repetitive PHP & Drupal tasks executed during Development.

This project is **not** meant for use in the creation and development of the *final* Production environment, as it is not configured with any level of security.

> **To Reiterate:** The Drupal VM is in NO way secure and the **SSH Key** included within the VM should not be added to ANY accounts because it is the standard key used by millions of users.

The final project should be created separately in a folder by itself, with Configuration Management performed using this VM in conjunction with the Features Module as outlined by Drupalize.Me:
[Drupalize.Me | Drupal Deployment With Features and Drush](https://drupalize.me/videos/introduction-drupal-features-module?p=1170 "Drupal Deployment With Features and Drush")

- Build a customized Drupal VM using the associated makefiles as available within the /redesign/makefiles/ directory;

### Software Packages Available
In addition to the base software required for any functional LAMP-stack, the Drupal VM is provisioned with a few other useful developer tools, which can be altered within the ```config.yml``` file:
```
# Add any extra apt or yum packages you would like installed.
extra_packages:
  - unzip
  - nano
  - links
```

* **unzip**
  * ```unzip``` is a tool for 'unzipping' compressed files and directories such as Zip files and tar-balls. It is a requirement for Moody's Utexas Projects VM and should not be removed. The necessary files downloaded by the Developer via the ```~/tar-bin``` directory are all tar-balls, for example, which require the ```unzip``` package.
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

Git Projects in Drupal should always be known as '6.x-?.x' (for Drupal 6), '7.x-?.x' (for Drupal 7), and '8.x-?.x' with various Branches and Forks eventually created based on Project needs. Currently the project root for both projects is 'master', but this is temporary.

### Example Workflow
#### Changes are made to ~/drupal-vm-workflow/redesign/config-files/config.yml from branch 'master':
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

#### Example: Apply A Patch on the Development VM
> Note - Always run ```git status``` on the server prior to applying any patches.

```
scp ~/drupal-vm-workflow/config_changes_YYYY-MM-DD.patch vagrant@utexas-drupalvm.dev/var/tmp/config_changes_YYYY-MM-DD.patch
cd ~/drupal-vm-workflow/drupal-vm/
vagrant ssh
cd /var/tmp/
git apply -v /var/tmp/config_changes_YYYY-MM-DD.patch
sudo rm -R sites/

Clean Up:
rm /var/tmp/config_changes_YYYY-MM-DD.patch
```
Once finished patching, copy the updated files into each folder.


#### Example: Apply A Patch on UT Web Servers
> Note - Always run ```git status``` on the server prior to applying any patches.

```
scp ~/utexas-drupalvm/config_changes_YYYY-MM-DD.patch utw10xxx@panel.utweb.utexas.edu://home/utweb/utw10xxx/public_html/config_changes_YYYY-MM-DD.patch
ssh utw10xxx@panel.utweb.utexas.edu
cd public_html/
git apply -v config_changes_YYYY-MM-DD.patch

Clean Up:
rm config_changes_YYYY-MM-DD.patch
```


> Note - The following is currently non-functional, see the QuickStart Guide.

## Troubleshooting

The Vagrantbox is not an alpha/omega solution for provisioning needs and sometimes there are issues with accessing needed information and tools.

For example, when creating a new Vagrantbox (```vagrant halt && vagrant destroy && vagrant up```), the SSH RSA key changes. This change makes the connection seem 'insecure', getting scary messages back about a ```Man in the Middle Attack!!!```. In most cases (though not all, obviously), there is no man-in-the-middle attack. The change is simply because, upon generating a new Virtual Machine, you have generated a new insecure/public RSA key as well.

As a reminder though, these keys aren't safe. Even the 'generation' in the D-VM tends to recreate existing keys.

### NFS vs RSYNC

Sometimes NFS is wonky and/or hard to configure (especially on Windows machines). If you do not have Administrative access, it is best to simply use rsync for syncing files to the Drupal VM.

### FileZilla

Select *SFTP - SSH File Transfer Protocol* as the connection type.

#### General Tab
| Label  | Input  |
| :-------------: |:-------------:|
| **Host**  | 127.0.0.1 *OR* utexas-drupalvm.dev**  |
| **Port**  | Leave blank  |
|   |   |
| **Logon Type**  | Key file  |
| **User**  | vagrant  |
| **SSH Key**  | *See below*  |

#### Advanced Tab
| Label  | Input  |
| :-------------: |:-------------:|
| **Default local directory**  | ~/drupal-vm-workflow/  |
| **Default remote directory**  | /var/www/development  |

### Sequel Pro

Select *SSH* as the connection type.

| Label  | Input  |
| :-------------: |:-------------:|
| **MySQL Host**  | 127.0.0.1 *OR* utexas-drupalvm.dev**  |
| **Username**  | root  |
| **Password**  | same  |
| **Database**  | drupal  |
| **Port**  | Leave blank  |
|   |   |
| **SSH Host**  | 192.168.88.90  |
| **SSH User**  | vagrant  |
| **SSH Key**  | *See below*  |

#### SSH Key for Sequel Pro

The **COMPLETELY UNSECURE** key is located at `~/.vagrant.d/insecure_private_key` and can be found by:
* clicking the picture of the key,
* checking *Show hidden files*,
* navigating to user-root (`~/`), and
* selecting the folder `/.vagrant.d/`

> **Note:** The basic Drupal VM configuration uses 192.168.88.88 instead of 192.168.88.90.

#### Updating RSA Key for Known_Hosts
To gain access to provisioning access (such as connecting via SSH to the MySQL databases), delete the currently listed ```known_host``` for the Vagrantbox:
* Using a Text Editor (such as Sublime), edit the known_hosts file located at ~/.ssh/known_hosts
* Delete the line with the utexas-drupalvm.dev virtualbox (192.168.88.89)
* Re-run ```vagrant up``` from the ```~/utexas-drupalvm/drupal-vm``` directory

#### Updating User Tables
Within the current draft version of the installation, the ```drupal``` user is not being granted ANY privileges within any database except the Development database (```drupal```).

Until a script can be used to correct the issue during VM generation, Developers must manually grant privileges within all databases.

The easiest method to do this is either using the MySQL CLI or through a simple DBA program such as Sequel Pro.

See http://docs.drupalvm.com/en/latest/extras/mysql/ for instructions.

The global priveleges for the drupal user should only need to be altered once for the entire MySQL instance.

## Additional Resources
* [Mac OS X Setup Guide by Sourabh Bajaj](http://sourabhbajaj.com/mac-setup/ "Mac OS X Setup Guide by Sourabh Bajaj")
The Mac OS X Setup Guide has step-by-step instructions for installing many of the necessary tools for mastering the Tasks such as:
  * Homebrew
  * PIP
  * Python (non-Apple version)
  * Git (non-Apple version)
  * iTerm2 (It's just prettier)
  * zsh (Its smoother than Bash)
  * Oh-My-Zsh (Prettiest Terminal coloration out there)
  * Sublime Text 3 (PHPStorm is a great tool, but nothing beats a well configured Sublime Text 3 for straight content editing.)
