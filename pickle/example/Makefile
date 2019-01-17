SERVICES := greeter

export BUILDER_VERSION := alpha
export BUILDER_CONTEXT := $(CURDIR)/.builder

PICKLE_IMAGE := jobteaser/pickle/builder:$(BUILDER_VERSION)

# Make a local copy of the builder image assets.
local:
	@docker run --rm -v $(CURDIR)/.builder:/host $(PICKLE_IMAGE) \
	  cp -f /builder/Dockerfile /builder/README.md /builder/rules.mk /host

-include $(BUILDER_CONTEXT)/rules.mk