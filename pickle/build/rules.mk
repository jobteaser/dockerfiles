export

ifndef VERSION
VERSION := $(shell [ -f VERSION ] && cat VERSION || echo alpha)
endif

GIT_COMMIT := $(shell git rev-parse HEAD)
GIT_STATE := $(shell \
	[ `git status --porcelain 2>/dev/null | wc -l` -eq 0 ] \
	&& echo "clean"  || echo "dirty")
BUILD_DATE := $(shell date -u +%FT%TZ)

# services builds every services
services: $(SERVICES)
.PHONY: services

# Each service foo of SERVICES can be build by calling `make foo`
$(SERVICES):
	@docker-compose build $(OPTS) $@
.PHONY: $(SERVICES)

# generate everything
generate: go-generate
.PHONY: generate

# call go generate over all go sources
go-generate:
	@go generate -mod vendor ./...
.PHONY: go-generate

# generate a go files from a proto files
%.pb.go: %.proto
	@echo "Generating $@ from $<"
	@protoc --go_out=plugins=grpc:. $<

# Triggers the unit tests (go test)
unit-tests:
	@go test -mod vendor ./...
.PHONY: unit-tests

# Each service foo of SERVICES have a foo-tests target that run the integration tests (Gherkin cucumber)
$(SERVICES:%=%-tests):
	@docker-compose up \
	    --abort-on-container-exit \
	    --always-recreate-deps \
	    --exit-code-from $@ \
	$@ ; exit_code=$$? ; \
	if [ ! $$exit_code -eq 0 ] ; then \
	    docker-compose logs ; \
	    docker-compose logs $@ ; \
	    echo "FAILURE: $@ returned $$exit_code" ; \
	    exit $$exit_code ; \
	fi
.PHONY: $(SERVICES:%=%-tests)

# Each service foo of SERVICES have a foo-sh target that provide a shell inside the service.
# but without the service started. Once you are inside you can eventually run it manually.
# We are making use of aliases (which is not the case by default with 'run') to be abble
# to reach the test's dummy servers with their service name (service name from the docker-compose file)
$(SERVICES:%=%-sh) $(SERVICES:%=%-tests-sh):
	@docker-compose run --rm --use-aliases $(@:%-sh=%) sh
.PHONY: $(SERVICES:%=%-sh) $(SERVICES:%=%-tests-sh)

# Each service foo of SERVICES have a foo-force-build target that trigger a no-cache docker build
# for this service
$(SERVICES:%=%-force-build): ; @OPTS=--no-cache $(MAKE) $(@:%-force-build=%)
.PHONY: $(SERVICES:%=%-force-build)

# Each service foo of SERVICES can be up with target foo-up
$(SERVICES:%=%-up): ; @docker-compose up $(@:%-up=%)
.PHONY: $(SERVICES:%=%-up)

# Each service foo of SERVICES can be down with target foo-down
$(SERVICES:%=%-down): ; @docker-compose down $(@:%-down=%)
.PHONY: $(SERVICES:%=%-down)

# Each service foo of SERVICES have a foo-push-container to send the service
# image to its dedicated registry
$(SERVICES:%=%-push-container): ; @docker-compose push $(@:%-push-container=%)
.PHONY: $(SERVICES:%=%-push-container)

# up is used to up all the services
up: services ; docker-compose $@ $(SERVICES)
.PHONY: up

# down is used to down all
down: ; docker-compose down
.PHONY: down

# Helpful: targets foo-exec-sh and foo-tests-exec-sh for each service foo of SERVICES
# Calling those targets provides a shell inside an already running container.
$(SERVICES:%=%-exec-sh) $(SERVICES:%=%-tests-exec-sh): ; @docker-compose exec $(@:%-exec-sh=%) sh
.PHONY: $(SERVICES:%=%-exec-sh) $(SERVICES:%=%-tests-exec-sh)

# Remove every containers
clean-containers: ; @docker-compose rm -sf
.PHONY: clean-containers

# Remove every untracked file
clean-workspace: ; @git clean -fdx
.PHONY: clean-workspace

# Clean everything cleanable
clean-all: clean-containers clean-workspace
.PHONY: clean-all

.DEFAULT_GOAL := sh

sh:
	@docker run \
	  -it \
	  --rm \
	  -e BUILDER_VERSION=$(BUILDER_VERSION) \
	  -v $(BUILDER_CONTEXT)/cache:/.cache \
	  -v $(CURDIR):$(CURDIR) \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  -v $$HOME/.gitconfig:/root/.gitconfig \
	  -v $$HOME/.ssh:/root/.ssh \
	  -w $(CURDIR) \
	  $(BUILDER_IMAGE) sh
