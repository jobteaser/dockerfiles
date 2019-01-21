ifndef DOCKER_REGISTRY
DOCKER_REGISTRY := jobteaser
endif

ifndef VERSION
VERSION := $(shell [ -f VERSION ] && cat VERSION || echo alpha)
endif

# Use this target to build the builder (default image version: alpha)
.PHONY: build
build:
	@docker build -t $(DOCKER_REGISTRY)/prototool:$(VERSION) .