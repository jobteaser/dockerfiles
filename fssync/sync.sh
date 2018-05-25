#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

out() { printf '%b\n' "$@"; }
die() { out "$@"; exit 1; } >&2

usage() {
  cat << EOF
Synchronize the content of the local source directory to the local target one.

Usage: ./sync.sh [SOURCE] TARGET

Options:

  -h  Help about the command

Notes:
  - Without source directory, it synchronizes current directory content.
  - If the target directory does not exist, it is created with \`mkdir -p\` command.
EOF
}

parse_params() {
  while getopts ":h" opt; do
    case $opt in
      h)
        usage
        exit 0
        ;;
      \?)
        die "Invalid option: -${OPTARG}"
        ;;
      :)
        die "Option -${OPTARG} requires an argument."
        ;;
    esac
  done
  shift "$(($OPTIND -1))"
}


main() {
  parse_params "$@"

  TARGET_DIR="${2:-}"
  SOURCE_DIR="$1"
  if [[ -z "${TARGET_DIR}" ]];
  then
    TARGET_DIR="$1"
    SOURCE_DIR="$(pwd)"
  fi

  [[ -z "${TARGET_DIR}" ]] && die "$(usage)"
  [[ ! -d "${TARGET_DIR}" ]] && mkdir -p "${TARGET_DIR}"

  [[ ! -d "${SOURCE_DIR}" ]] && die "Source directory does not exist"

  pushd "${SOURCE_DIR}"
  trap 'popd' 0

  rsync --relative --quiet -vra "." "${TARGET_DIR}" &

  inotifywait -mr --timefmt '%FT%TZ' --format '%T %w %f %e' \
    -e close_write -e create -e delete "${SOURCE_DIR}" | \
    while read -r time dir file event; do

    # construct file path relative to current directory
    FILE="${dir//$(pwd)\//}${file}"

    if [[ "${event}" == *DELETE* ]];
    then
        out "I, [${time}] $(echo "${FILE}" | sha256sum) deleted and not synchronized"
    else
      rsync --progress --relative --quiet -vra "${FILE}" "${TARGET_DIR}" && \
        out "I, [${time}] $(echo "${FILE}" | sha256sum) synchronized"
    fi
  done
}

main "$@"
