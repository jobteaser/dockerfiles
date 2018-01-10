#!/usr/bin/env bash

assert() {
  if [[ "$1" = "$2" ]]; then
    echo "."
  else
    echo "test failed -> assert(%s, %s)\n" "$1", "$2"
  fi
}

main() {

  local kubectl_version=$( docker run -it --rm "$1" /usr/bin/env sh -c "kubectl version --client --short" )
  assert "$kubectl_version" "Client version: v1.9.1"

  local helm_version=$( docker run -it --rm "$1" /usr/bin/env sh -c "helm version --client --short" )
  assert "$helm_version" "Client version: v2.7.2"

  local bash_version=$( docker run -it --rm "$1" /usr/bin/env sh -c "echo $BASH_VERSION" )
}

main "$@"
