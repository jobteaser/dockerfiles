# Greeter Module

This module is a basic example that shows how to setup a project according to the pickle builder worflow.

## Workflow

At the very initial step after cloning this repository by running in your workspace you can see the underlying tree from this folder location:

```sh
$ tree -a
.
├── Makefile
├── README.md
├── docker-compose.yml
├── go.mod
└── greeter
    └── main.go
```

Use the following command:

```sh
$ make local
```

or more simply (because at the beginning there is only one target inside the [Makefile](Makefile)):

```sh
$ make
```

The builder *context* is imported from the `PICKLE_IMAGE` specified in the root [Makefile](Makefile) to the folder [./.builder](.builder). And now here is the new source tree.

```sh
$ tree -a
.
├── .builder
│   ├── Dockerfile
│   ├── README.md
│   └── rules.mk
├── .dockerignore
├── .gitignore
├── Makefile
├── README.md
├── docker-compose.yml
├── go.mod
└── greeter
    └── main.go
```

And from now, by calling:

```
$ make pickle-shell
```

or more simply (due to the final `-include $(BUILDER_CONTEXT)/rules.mk` directive of the [Makefile](Makefile) that now can include the file which defines the default target to `pickle-shell`):

```sh
$ make
```

A specific shell called `pickle-shell` is provided to ease the on-boarding of new comers to that example module named **github.com/jobteaser/dockerfiles/pickle/example**. This shell should be seen as an out-of-box suitable environment available immediately after cloning the repository.

For the purpose of this example. Our module is owning one only application called **greeter**

### Sum-up

So, to sum-up. At that point here should be what you did:

```sh
# Initial repository cloning
$ git clone git@github.com:jobteaser/dockerfiles.git
# go to the module location
$ cd pickle/example
# Import builder assets from choosed PICKLE_IMAGE container
$ make
# Instanciate the 'pickle-shell'
$ make
# Then...
$ make greeter
$ make greeter-up
...
```

## Applications configuration

### Adding a new application `foobar` to the example module

The procedure to add a new application to the module by using the current workflow has 2 parts:

#### File [Makefile](Makefile)

If you extend the `SERVICES` variable, then new targets will be available from the Makefile:

```Makefile
SERVICES += foobar
```

Provides additional targets (cf. [Makefile](Makefile) for details about the targets):

```
foobar-force-build      foobar-tests-exec-sh    foobar
foobar-push-container   foobar-tests-sh         foobar-down
foobar-sh               foobar-up               foobar-exec-sh
foobar-tests
```

These new targets require that you add configuration for this particular application (service) inside the file [docker-compose.yml](docker-compose.yml)

#### File [docker-compose.yml](docker-compose.yml)

The configuration bellow should be added to [docker-compose.yml](docker-compose.yml) and provides the minimal set of information. Some values are constants and depends on the configuration of the module. Others have to be adapted for that particular `foobar` service.

* `app_name`: name of the executable inside the service container after build
* `main_folder`: the path to the folder of the *main package* to build
* `image`: that value defines the registry of the builded image for distant storage

If you look the [docker-compose.yml](docker-compose.yml) file, you are going to see that those fields are the only few that are customized for a simple service.

```yaml
services:
  foobar:
    build:
      args:
        app_name: foobar
        build_date: ${BUILD_DATE}
        builder_image: ${DOCKER_REGISTRY:-jobteaser}/pickle/builder:${BUILDER_VERSION:-alpha}
        git_commit: ${GIT_COMMIT}
        git_state: ${GIT_STATE}
        main_folder: foobar
        version: ${VERSION:-alpha}
      context: .
      dockerfile: ${BUILDER_CONTEXT:-.builder}/Dockerfile
    container_name: foobar
    image: ${DOCKER_REGISTRY:-jobteaser}/foobar:${VERSION:-alpha}
```
