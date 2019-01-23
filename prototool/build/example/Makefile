MODULES := hello/v1beta1/example

define RB_GEMSPEC
lib = File.expand_path('../lib', __FILE__)
$$LOAD_PATH.unshift(lib) unless $$LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	spec.name = 'foo-example'
	spec.version = '$(VERSION)'
	spec.authors = ['foo']
	spec.email = ['foo@bar.com']

	spec.summary = 'foo files for ruby'
	spec.description = 'This gem contains generated protocol buffer files for ruby module foo'

	spec.require_paths = ['lib']
end
endef

export

BUILDER_IMAGE := jobteaser/prototool:alpha
BUILDER_CONTEXT := $(CURDIR)/.builder

define SHELL
	docker run
	--rm
	-v $(CURDIR)/.builder:/host
	-v $$PWD:$$PWD
	-w $$PWD
	-e RB_GEMSPEC
	--entrypoint=sh
	$(DOCKER_REGISTRY)/$(BUILDER_IMAGE)
endef
BUILDER_CONTEXT := $(CURDIR)/.builder

# Make a local copy of the builder image assets.
local:
	@cp -f /builder/README.md /builder/rules.mk /host

-include $(BUILDER_CONTEXT)/rules.mk