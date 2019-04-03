# librdkafka in alpine

We use this image in multistage build to copy `librdkafka` to our final images.

# Tags

The tag is composed of the flavor of linux we used to build and the version of `librdkafka` e.g. `jobteaser/librdkafka:alpine-v1.0.0`.

# Example

```
FROM jobteaser/librdkafka:alpine-v1.0.0 as librdkafka
FROM golang:1.12

# ...

COPY --from=librdkafka /usr/include /usr/include
COPY --from=librdkafka /usr/lib /usr/lib

# ...

RUN make build
```
