# settings-files.md

Custom settings.php files for specific instances should be placed here prior to executing the ```vagrant up``` command.




Expected file structure:
```
{{ settings-fles }}:
 - default.settings.php
 - local-settings.php
 - settings.php
```

```
settings-files/
    - d6-multisite
        - advertising/
            - {{ settings-files }}
        - commstudies/
        - csd/
        - journalism/
        - moody/
        - rtf/
    - d6
        - advertising/
        - commstudies/
        - csd/
        - journalism/
        - moody/
        - rtf/
    - d7
        - advertising/
        - commstudies/
        - csd/
        - journalism/
        - moody/
        - rtf/        
```

