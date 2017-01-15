# config-files.md

> Note - See README.md in project-root

The Vagrantfile, make/composer, and config.yml files present should be copied into the drupal-vm/ directory 'as is', with no alterations.

Any changes to the Vagrantfile or config.yml files should be made **here**, _then)_ updated on the copy within the drupal-vm/ folder.

As Jeff Geerling routinely updates the Vagrant file with the kit, the file should routinely be verified for updates.

Current Vagrantfile Alterations:
================================

- Drupal 7: **None**
- Drupal 8: **None**

Drupal 7 Command:
=================
```
cp ~/drupal-vm-workflow/redesign/drupal-7/config.yml ~/drupal-vm-workflow/drupal-vm/config.yml
cp ~/drupal-vm-workflow/redesign/drupal-7/drupal.mak.yml ~/drupal-vm-workflow/drupal-vm/drupal.mak.yml
cp ~/drupal-vm-workflow/redesign/drupal-7/Vagrantfile ~/drupal-vm-workflow/drupal-vm/Vagrantfile
```

Drupal 8 Command:
=================
```
cp ~/drupal-vm-workflow/redesign/drupal-8/config.yml ~/drupal-vm-workflow/drupal-vm/config.yml
cp ~/drupal-vm-workflow/redesign/drupal-8/drupal.composer.json ~/drupal-vm-workflow/drupal-vm/rupal.composer.json
cp ~/drupal-vm-workflow/redesign/drupal-8/Vagrantfile ~/drupal-vm-workflow/drupal-vm/Vagrantfile
```
