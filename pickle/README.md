# Pickle / Builder

Pickle is a build environment which allows construction of modular go applications
that use kafka and grpc for communication.

The application containers [build configuration](build/Dockerfile) are
requiring the [context of the builder](Dockerfile).

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

The example is also used as a basic documentation for the workflow that is used with this builder (once it have been build).

## Custom builder

The standard installation (procedure upside) provides a 'docker + make' workable out-of-box shell for the developpers...

But, you can setup your own computer to be abble to call directly the builder tagets without running the dedicated `out-of-box` shell `pickle-shell` that comes with the builder.

#### install a go distribution (1.11.4 minimum recommended)

You need to have go installed since we are going to build go applications as well as running go programs that are comming from internet (`godogs` for test, `protoc-gen-go` for generation of *go* from *proto* files,... )
Based on your OS, follow the [online documentatin](https://golang.org/doc/install) to have this done.

#### install librdkafka-dev

This library is linked against to have kafka feature from go programms. And this is due to the fact that we are making usage of [confluent-kafka-go](https://github.com/confluentinc/confluent-kafka-go).

So, for ubuntu, installation can be done like that:

```sh
$ sudo apt install librdkafka-dev
```

#### install protoc

This executable program is going to use a plugin (`protoc-gen-go` for *go* code, see installation steps bellow) to produce *go* generated from input *proto*.

Pay attention to the fact that this program version must be aligned with the pluggin version. Both are available [here](https://github.com/protocolbuffers/protobuf/releases/tag/v3.6.1)

#### install the protoc-gen-go pluggin

Pay attention to the fact that this must be aligned with the `protoc` version that you did installled in the previous step. You can install a [released](https://github.com/protocolbuffers/protobuf/releases/tag/v3.6.1) version or by running:
```sh
go get -u github.com/golang/protobuf/protoc-gen-go
```

If your pluggin is not compatible with `protoc` you may experience fancy troubles like "no errors and incomplete code generation...". So be careful with this.