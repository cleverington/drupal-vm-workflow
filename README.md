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

## Features
This project is built using the tools of the Grunt community to provide a streamlined and scripted method for automating a number of complicated, yet repetitive PHP & Drupal tasks executed during Development.

This project is **not** meant for use in the creation and development of the *final* Production environment, as it is not configured with any level of security. 

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

## Usage
To build the Moody College of Communication site testing-platform, run ```grunt```.

### Special Flags
- ```quiet```: Suppress desktop notifications
- ```notify```: Request a desktop notification, despite timing or environment settings.