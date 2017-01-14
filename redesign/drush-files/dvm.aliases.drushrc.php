<?php

/**
 * Drupal VM drush aliases.
 *
 * @see example.aliases.drushrc.php.
 */

// Development Server

$aliases['drupal-vm-workflow.dev'] = array(
  'uri' => 'drupal-vm-workflow.dev',
  'root' => '/var/www/public_html/development/web',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/development_vagrant.sql'
    ),
);
