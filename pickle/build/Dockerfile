ARG builder_image=jobteaser/coretech/pickle/builder:alpha
FROM ${builder_image} AS builder

WORKDIR /pickle

COPY . .

ARG main_folder
ARG version
ARG git_commit
ARG git_state
ARG build_date
RUN  go build \
  -o ${main_folder}-app \
  -mod vendor \
  -tags static \
  -ldflags ' \
  -s -extldflags "-static" \
  -X version.Version=${version} \
  -X version.GitCommit=${git_commit} \
  -X version.GitState=${git_state} \
  -X version.BuildDate=${build_date}' \
  ./${main_folder}

WORKDIR /build

ARG app_name=app
RUN cp /pickle/${main_folder}-app ./${app_name}

ARG migrations=/pickle/${main_folder}/migrations
RUN if [ -d ${migrations} ] ; then \
  cp -r ${migrations} ./migrations ; \
  fi

FROM alpine:3.8

RUN apk --no-cache add \
  ca-certificates \
  openssl

WORKDIR /app

COPY --from=builder /build .

ENV PATH=/app:${PATH}

ARG app_name=app
ENV APP=${app_name}

CMD $APP