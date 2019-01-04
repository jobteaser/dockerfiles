ARG DOCKER_REGISTRY=jobteaser
ARG BUILDER_VERSION=alpha
FROM ${DOCKER_REGISTRY}/coretech/pickle/builder:${BUILDER_VERSION} AS builder

WORKDIR /src
COPY src .

ARG main_folder
ARG VERSION
ARG GIT_COMMIT
ARG GIT_STATE
ARG BUILD_DATE
RUN  go build \
    -o ${main_folder}-app -mod vendor -tags static \
    -ldflags ' \
    -s -extldflags "-static" \
    -X version.Version=${VERSION} \
    -X version.GitCommit=${GIT_COMMIT} \
    -X version.GitState=${GIT_STATE} \
    -X version.BuildDate=${BUILD_DATE} \
    ' \
    ./${main_folder}

ARG migrations=./${main_folder}/migrations
ARG app_name=app
RUN mkdir -p /build \
    && cp /src/${main_folder}-app /build/${app_name} \
    && if [ -d ${migrations} ] ; then \
    cp -r ${migrations} /build/migrations ;\
    fi

FROM alpine:3.8

RUN apk --no-cache add \
    ca-certificates \
    openssl

WORKDIR /app

COPY --from=builder /build .
ENV PATH=/app:${PATH}
ARG app_name=app
CMD ["${app_name}"]
