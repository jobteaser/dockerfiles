# Pickle / builder

## Project shell

```sh
make sh
```

## Build

Build the applications containers.

According to your Makefile, if there is two services:

```Makefile
SERVICES := ricky
SERVICES += morty
````

Then it is possible to run

```sh
make ricky
make morty
...
```

## Tests

### Unit Tests

Unit tests for the entire code base.

```sh
make unit-tests
```

### Integration Tests

```sh
make morty-tests
...
```

## Push

Push an application image to its registry.

```sh
make morty-push-container
make ricky-push-container
...
