export

GIT_COMMIT := $(shell git rev-parse HEAD)
GIT_STATE := $(shell \
	[ `git status --porcelain 2>/dev/null | wc -l` -eq 0 ] \
	&& echo "clean"  || echo "dirty")
BUILD_DATE := $(shell date -u +%FT%TZ)

services: $(SERVICES)

# Manually trigger the proto based go generated sourcces
proto-go-generate: ; $(MAKE) $(GENERATED_GO_FROM_PROTO)

$(SERVICES): $(GENERATED_GO_FROM_PROTO)
	@docker-compose build $(OPTS) $@

# Those targets are using a builder container to call the go mod commands
go-mod-vendor go-mod-tidy: ; @cd src && go mod $(@:go-mod-%=%)

# Rule for building go sources from a proto file
%.pb.go: %.proto
	@echo "Generating $@ from $<"
	@protoc --go_out=plugins=grpc:. $<

# Triggers the unit tests (go test)
unit-tests: $(GENERATED_GO_FROM_PROTO)
	@cd src && go test -mod vendor ./...

# Each 'service' of SERVICES have a 'service'-tests target that run the integration tests (Gherkin cucumber)
$(SERVICES:%=%-tests): $(GENERATED_GO_FROM_PROTO)
	@docker-compose up            \
	    --abort-on-container-exit \
	    --always-recreate-deps    \
	    --exit-code-from $@       \
	$@ ; exit_code=$$? ;          \
	if [ ! $$exit_code -eq 0 ] ; then             \
	    docker-compose logs ;                     \
	    docker-compose logs $@ ;                  \
	    echo "FAILURE: $@ returned $$exit_code" ; \
	    exit $$exit_code ;                        \
	fi

# Each 'service' of SERVICES have a 'service'-sh target that provide a shell inside the service
# but without the service started. Once you are inside you can eventually run it manually
$(SERVICES:%=%-sh) $(SERVICES:%=%-tests-sh): $(GENERATED_GO_FROM_PROTO)
	@docker-compose run --rm --use-aliases $(@:%-sh=%) sh

# Each 'service' of SERVICES have a 'service'-force-build target that trigger a no-cache docker build
# for this service
$(SERVICES:%=%-force-build): ; @OPTS=--no-cache $(MAKE) $(@:%-force-build=%)

# Each 'service' of SERVICES have a 'service'-force-build target that trigger a no-cache docker build
$(SERVICES:%=%-up): ; @docker-compose up $(@:%-up=%)

# Each 'service' of SERVICES have a 'service'-down target that down this service
$(SERVICES:%=%-down): ; @docker-compose down $(@:%-down=%)

# Each 'service' of SERVICES have a 'service'-up target that up this service
$(SERVICES:%=%-push-container): ; @docker-compose push $(@:%-push-container=%)

# up is used to up all the services
up: services ; docker-compose $@ $(SERVICES)

# down is used to down all
down: ; docker-compose down

# Helpful: targets 'service'-exec-sh and 'service'-tests-exec-sh for each 'service' of SERVICES
$(SERVICES:%=%-exec-sh) $(SERVICES:%=%-tests-exec-sh): ; @docker-compose exec $(@:%-exec-sh=%) sh

# Run this target to remove the containers that can be instanciated by this makefile
clean-containers: ; @docker-compose rm -sf
clean-workspace: ; @git clean -fdx
clean-all: clean-containers clean-workspace
