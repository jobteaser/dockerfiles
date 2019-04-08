# GLPI
## Description
This folder define the Dockerfile of [GLPI](https://glpi-project.org/). The current configuration is based on nginx and php-fpm. No database is installed inside the image.

The image embed also the [OCS Inventory](https://github.com/pluginsGLPI/ocsinventoryng) plugin

## Build
```
docker build -t glpi .
```

## Run
```
docker run -d --rm -p 8080:80 glpi
# go on localhost:8080 from your web browser
```

## Version
If you want to update the versions of the components the contributor should take care of the following items:
* `nginx:alpine` (in the import of the image) to manage nginx version.
* `GLPI_VERSION` to manage the glpi version.
* `OCS_INVENTORY_VERSION` to manage the OCS inventory plugin version.

## References
* [Setup](https://glpi-install.readthedocs.io/en/latest/install/index.html)
