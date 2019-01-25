GEMSPEC = build/ruby/$(API_NAME).gemspec

RB_GEN_FILES = \
	$(GEMSPEC) \
	$(API:%=build/ruby/lib/%_pb.rb) \
	$(API:%=build/ruby/lib/%_services_pb.rb) \

GO_GEN_FILES = \
	$(API:%=build/go/%.pb.go)

ifndef API_NAME
API_NAME = jobteaser
endif
ifndef SPEC_NAME
SPEC_NAME = jobteaser-$(API_NAME)
endif
ifndef RB_GEMSPEC
define RB_GEMSPEC
lib = File.expand_path('../lib', __FILE__)
$$LOAD_PATH.unshift(lib) unless $$LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	spec.name = '$(SPEC_NAME)'
	spec.version = '$(shell cat VERSION)'
	spec.authors = ['Jobteaser']
	spec.email = ['dev@jobteaser.com']

	spec.summary = '$(API_NAME) files for ruby'
	spec.description = 'This gem contains generated protocol buffer files for ruby'

	spec.require_paths = ['lib']
end
endef
endif

export RB_GEMSPEC

$(GEMSPEC): VERSION
	@mkdir -p $(@D)
	@echo "$$RB_GEMSPEC" > $@

build/ruby/lib/%_pb.rb build/go/%.pb.go: %.proto
	@mkdir -p $(@D)
	@prototool generate $<

build/ruby/lib/%_services_pb.rb: %.proto
	@mkdir -p $(@D)
	@grpc_tools_ruby_protoc --grpc_out=build/ruby/lib/ $<

.PHONY: generate
generate: \
	$(RB_GEN_FILES) \
	$(GO_GEN_FILES)

.PHONY: lint
lint:
	@prototool lint

.PHONY: clean
clean:
	rm -rf build

.DEFAULT_GOAL := all

.PHONY: all
all: lint generate
