# Prototool

Prototool provides a build environment as a docker image `jobteaser/prototool`.

This can be used for making generation of API files based on proto either on a CI machine or locally
on a developper environment.

## Build environment

To create a build image locally `jobteaser/prototool:alpha`:

```sh
make
```

To build a custom version `jobteaser/prototool:custom`:

```sh
VERSION=custom make
```