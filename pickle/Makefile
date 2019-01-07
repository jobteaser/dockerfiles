ifndef DOCKER_REGISTRY
DOCKER_REGISTRY := jobteaser
endif

ifndef VERSION
VERSION := $(shell [ -f VERSION ] && cat VERSION || echo alpha)
endif

# Use this target to build the builder (default image version: alpha)
builder:
	@docker build -t $(DOCKER_REGISTRY)/pickle/builder:$(VERSION) .
.PHONY: builder