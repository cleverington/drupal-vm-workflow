<?php

/**
 * Drupal VM drush aliases.
 *
 * @see example.aliases.drushrc.php.
 */

// Development Server

$aliases['moody-redesign.dev'] = array(
  'uri' => 'moody-redesign.dev',
  'root' => '/var/www/public_html/development',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/development_vagrant.sql'
    ),
);

// Multisite Server

$aliases['advertising.utexas.edu.multisite.vm'] = array(
  'uri' => 'advertising.utexas.edu.multisite.vm',
  'root' => '/var/www/public_html/d6/multisite/sites/advertising.utexas.edu.multisite.vm',
  'path-aliases' => array(
    '%files' => 'sites/advertising.utexas.edu.multisite.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/advertising_vagrant.sql'
    ),
);

$aliases['commstudies.utexas.edu.multisite.vm'] = array(
  'uri' => 'commstudies.utexas.edu.multisite.vm',
  'root' => '/var/www/public_html/d6/multisite/sites/commstudies.utexas.edu.multisite.vm',
  'path-aliases' => array(
    '%files' => 'sites/commstudies.utexas.edu.multisite.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/commstudies_vagrant.sql'
    ),
);

$aliases['csd.utexas.edu.multisite.vm'] = array(
  'uri' => 'csd.utexas.edu.multisite.vm',
  'root' => '/var/www/public_html/d6/multisite/sites/csd.utexas.edu.multisite.vm',
  'path-aliases' => array(
    '%files' => 'sites/csd.utexas.edu.multisite.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/csd_vagrant.sql'
    ),
);

$aliases['journalism.utexas.edu.multisite.vm'] = array(
  'uri' => 'journalism.utexas.edu.multisite.vm',
  'root' => '/var/www/public_html/d6/multisite/sites/journalism.utexas.edu.multisite.vm',
  'path-aliases' => array(
    '%files' => 'sites/journalism.utexas.edu.multisite.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/journalism_vagrant.sql'
    ),
);

$aliases['moody.utexas.edu.multisite.vm'] = array(
  'uri' => 'moody.utexas.edu.multisite.vm',
  'root' => '/var/www/public_html/d6/multisite/sites/moody.utexas.edu.multisite.vm',
  'path-aliases' => array(
    '%files' => 'sites/moody.utexas.edu.multisite.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/moody_vagrant.sql'
    ),
);

$aliases['rtf.utexas.edu.multisite.vm'] = array(
  'uri' => 'rtf.utexas.edu.multisite.vm',
  'root' => '/var/www/public_html/d6/multisite/sites/rtf.utexas.edu.multisite.vm',
  'path-aliases' => array(
    '%files' => 'sites/rtf.utexas.edu.multisite.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/rtf_vagrant.sql'
    ),
);

// Single Site Instances

$aliases['advertising.utexas.edu.local.vm'] = array(
  'uri' => 'advertising.utexas.edu.local.vm',
  'root' => '/var/www/public_html/d6/advertising',
  'path-aliases' => array(
    '%files' => 'sites/advertising.utexas.edu.local.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/advertising_upgraded_vagrant.sql'
    ),
);

$aliases['commstudies.utexas.edu.local.vm'] = array(
  'uri' => 'commstudies.utexas.edu.local.vm',
  'root' => '/var/www/public_html/d6/commstudies',
  'path-aliases' => array(
    '%files' => 'sites/commstudies.utexas.edu.local.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/advertising_upgraded_vagrant.sql'
    ),
);

$aliases['csd.utexas.edu.local.vm'] = array(
  'uri' => 'csd.utexas.edu.local.vm',
  'root' => '/var/www/public_html/d6/csd',
  'path-aliases' => array(
    '%files' => 'sites/csd.utexas.edu.local.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/csd_upgraded_vagrant.sql'
    ),
);

$aliases['journalism.utexas.edu.local.vm'] = array(
  'uri' => 'journalism.utexas.edu.local.vm',
  'root' => '/var/www/public_html/d6/journalism',
  'path-aliases' => array(
    '%files' => 'sites/journalism.utexas.edu.local.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/journalism_upgraded_vagrant.sql'
    ),
);

$aliases['moody.utexas.edu.local.vm'] = array(
  'uri' => 'moody.utexas.edu.local.vm',
  'root' => '/var/www/public_html/d6/moody',
  'path-aliases' => array(
    '%files' => 'sites/moody.utexas.edu.local.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/moody_upgraded_vagrant.sql'
    ),
);

$aliases['rtf.utexas.edu.local.vm'] = array(
  'uri' => 'rtf.utexas.edu.local.vm',
  'root' => '/var/www/public_html/d6/rtf',
  'path-aliases' => array(
    '%files' => 'sites/rtf.utexas.edu.local.vm/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/rtf_upgraded_vagrant.sql'
    ),
);

// Moody's UTDK Drupal 7 Single Site Instances

$aliases['advertising.utexas.edu.redesign.vm'] = array(
  'uri' => 'advertising.utexas.edu.redesign.vm',
  'root' => '/var/www/public_html/d7/advertising',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/advertising_final_vagrant.sql'
    ),
);

$aliases['commstudies.utexas.edu.redesign.vm'] = array(
  'uri' => 'commstudies.utexas.edu.redesign.vm',
  'root' => '/var/www/public_html/d7/commstudies',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/commstudies_final_vagrant.sql'
    ),
);

$aliases['csd.utexas.edu.redesign.vm'] = array(
  'uri' => 'csd.utexas.edu.redesign.vm',
  'root' => '/var/www/public_html/d7/csd',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/csd_final_vagrant.sql'
    ),
);

$aliases['journalism.utexas.edu.redesign.vm'] = array(
  'uri' => 'journalism.utexas.edu.redesign.vm',
  'root' => '/var/www/public_html/d7/journalism',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/journalism_final_vagrant.sql'
    ),
);

$aliases['moody.utexas.edu.redesign.vm'] = array(
  'uri' => 'moody.utexas.edu.redesign.vm',
  'root' => '/var/www/public_html/d7/moody',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/moody_final_vagrant.sql'
    ),
);

$aliases['rtf.utexas.edu.redesign.vm'] = array(
  'uri' => 'rtf.utexas.edu.redesign.vm',
  'root' => '/var/www/public_html/d7/rtf',
  'path-aliases' => array(
    '%files' => 'sites/default/files',
    '%dump-dir' => '/var/tmp',
    '%dump' => '/var/tmp/rtf_final_vagrant.sql'
    ),
);