Current version: `golang:1.12.0-stretch` and `librdkafka-0.11.5`

# buildgo

Docker image used at JobTeaser to build golang related projects.

It is based on `golang:1.XX.XX-stretch` image with added `librdkafka-${LIBRDKAFKA_VERSION}` package as we use Kafka in our projects.

We rebuild `librdkafka` from scratch to use the right version working with `golang`.
