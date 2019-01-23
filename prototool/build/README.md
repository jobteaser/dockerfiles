# Prototool / builder

## Build

Build the files generated from protocol buffer modules.

According to your Makefile, if there is two modules:

```Makefile
MODULES := \
    my/v1beta1/first_module \
    my/v2beta3/second_module \
````

Then,

```sh
make generate
```

produces a `build` folder that contains the generated files for:

* go

    build/go/my/v1beta1/first_module.pb.go
    build/go/my/v2beta3/second_module.pb.go

* ruby

    build/ruby/lib/my/v1beta1/first_module_pb.rb
    build/ruby/lib/my/v1beta1/first_module_services_pb.rb
    build/ruby/proto.gemspec

    build/ruby/lib/my/v1beta1/first_module_pb.rb
    build/ruby/lib/my/v2beta3/second_module_services_pb.rb
    build/ruby/proto.gemspec