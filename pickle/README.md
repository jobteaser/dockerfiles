# Pickle / Builder

Pickle is a build environment which allows construction of modular go applications
that use kafka and grpc for communication.

The application containers [build configuration](build/Dockerfile) are
requiring the [context of the builder](Dockerfile). Custom distributions are
not supported by the current documentation.

## Developper prerequisites

* [docker](https://docs.docker.com/compose/install/)
* [make](https://www.gnu.org/software/make/manual/make.html)

## Build the builder

```sh
make builder
```

Constructs the builder docker image.

## Example

A basic project construct that makes use of the builder is viewable [Here](example).
