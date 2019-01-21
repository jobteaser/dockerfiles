ifndef DOCKER_REGISTRY
DOCKER_REGISTRY := jobteaser
endif

ifndef VERSION
VERSION := $(shell [ -f VERSION ] && cat VERSION || echo alpha)
endif

CONTEXTS := $(shell ls -d */|sed 's:/::')

define IMAGE
$(DOCKER_REGISTRY)/$(@:%-$(1)=%):$(VERSION)
endef

.PHONY: $(CONTEXTS:%=%-build)
$(CONTEXTS:%=%-build):
	@docker build -t $(call IMAGE,build) $(@:%-build=%)

.PHONY: $(CONTEXTS:%=%-push)
$(CONTEXTS:%=%-push):
	@docker push $(call IMAGE,push)

.PHONY: build-all
build-all: $(CONTEXTS:%=%-build)

DEFAULT_GOAL := build-all