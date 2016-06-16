<?php

/**
 * Drupal VM drush aliases.
 *
 * @see example.aliases.drushrc.php.
 */

// Development Server

$aliases['utexas-drupalvm-projects.dev'] = array(
  'uri' => 'utexas-drupalvm-projects.dev',
  'root' => '/var/www/public_html/development',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/development_vagrant.sql'
    ),
);
