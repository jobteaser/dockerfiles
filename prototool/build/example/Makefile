ifndef LOCAL_USER_ID
LOCAL_USER_ID := $(shell id -u)
endif

SHELL := docker run \
	--rm \
	-e RB_GEMSPEC \
	-v $(CURDIR):$(CURDIR) \
	-v $(CURDIR)/.builder:/host \
	-w $(CURDIR) \
	-e LOCAL_USER_ID=$(LOCAL_USER_ID) \
	jobteaser/prototool:alpha


API := hello/v1beta1/example

BUILDER_CONTEXT := $(CURDIR)/.builder

local:
	@cp -f /builder/README.md /builder/rules.mk /host

-include $(BUILDER_CONTEXT)/rules.mk
