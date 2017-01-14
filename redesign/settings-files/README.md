# settings-files.md

Custom settings.php files for specific instances should be placed here prior to executing the ```vagrant up``` command.




Expected file structure:
```
{{ settings-files }}:
 - default.settings.php
 - local-settings.php
 - settings.php
```

```
settings-files/
    - d7-default
        - files/
            - .htaccess
        - .htaccess
        - default.settings.php
        - settings.php
```
