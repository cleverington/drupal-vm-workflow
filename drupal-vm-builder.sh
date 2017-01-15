#!/bin/bash

# Altered from Drupal VM Tool created for Moody College project.

# provision-development.sh
# This bash script needs to be executed to execute the needed actions
#   - for spinning up the current Drupal VM Platform tool.

# Note - This scipt should only be ran from OUTSIDE of your Drupal VM.

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
# However, because the VM may be powered-down and powered back up with no
#   - changes to the infrastructure / setup of the VM, Developers should have
#   - the option to NOT execute the script.#

## Download the Drupal VM
echo "==========================================================================="
echo "This script will download and configure a copy of Jeff Geerling's Drupal VM."
echo "Are you sure?"
OPTIONS=("Yes" "No")
select opt in "${OPTIONS[@]}"
do
  case $opt in
    "Yes")
      echo "Downloading...."
      git clone https://github.com/geerlingguy/drupal-vm.git ~/drupal-vm-workflow/drupal-vm
      echo "....done."
      break
      ;;
    "No")
      return 0
      ;;
  esac
done

## Copy utexas Drupal VM config.yml File
SECOND_OPTIONS=("Drupal 7" "Drupal 8" "Quit")
echo "==========================================================================="
echo "Please selection Drupal VM Configuration:"
echo "(A fancy way of saying 'copy config.yml from the Git repo to the Drupal VM directory.)"
select opt in "${SECOND_OPTIONS[@]}"
do
  case $opt in
    "Drupal 7")
      echo "Copying...."
      echo cp -rp ~/drupal-vm-workflow/redesign/drupal-7/config.yml ~/drupal-vm-workflow/drupal-vm/config.yml
      echo "....done."
      break
      ;;
    "Drupal 8")
      echo "Copying...."
      cp -rp ~/drupal-vm-workflow/redesign/drupal-8/config.yml ~/drupal-vm-workflow/drupal-vm/config.yml
      echo "....done."
      break
      ;;
    "Quit")
      return 0
      ;;
  esac
done

## Creating the VM
echo "==========================================================================="
echo "Creating the VM"
echo "You will need to add your Drupal to ~/drupal-vm-workflow/development separately."
echo "Another great option is to edit ~/drupal-vm-workflow/redesign/scripts/provision-development.sh with your Git Repository and run the script!"
cd ~/drupal-vm-workflow/drupal-vm/
ansible-galaxy install -r provisioning/requirements.yml --force
vagrant up
