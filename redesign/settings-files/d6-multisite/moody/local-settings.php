<?php

$base_url = 'http://moody.utexas.edu.multisite.vm';

$conf['file_temporary_path'] = '/tmp';

$db_url = 'mysql://drupal:drupal@127.0.0.1:3306/moody_multi_db';
$db_prefix = '';

/* Secure Pages Settings */
$conf['securepages_basepath'] = "http://moody.utexas.edu.multisite.vm";
$conf['securepages_basepath_ssl'] = "https://moody.utexas.edu.multisite.vm";
$conf['securepages_switch'] = FALSE;