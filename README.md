# Dockerfiles

Various Dockerfiles used by our tech team

## Build

Each  folder `foo` contains a `foo/Dockerfile` that have an associated public automated-build on [dockerhub/jobteaser](https://hub.docker.com/u/jobteaser/) build that provide the latest image `jobteaser/foo:latest`.

It is also possible for a developper to build locally the images.

### Default

```sh
make foo-build
```

By default `jobteaser/foo:alpha` is build based on the file that must exist `foo/Dockerfiles`.

### Custom

```sh
DOCKER_REGISTRY=custom VERSION=dev make foo
```

Builds the image `custom/foo:dev` based on the file that must exist `foo/Dockerfiles`.
