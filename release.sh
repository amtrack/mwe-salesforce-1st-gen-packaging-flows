#!/usr/bin/env bash

set -e

_help() {
  echo "release."
  echo ""
  echo "Usage:"
  echo "        release <metadata_directory>"
  echo ""
  echo "Options:"
  echo "        -h --help       Show help"
}

fullName="${fullName:-mwe_pack_flows}"
namespacePrefix="${namespacePrefix}"

_release() {
  metadata_directory="$1"
  rm -rf "${metadata_directory}"
  sfdx force:source:convert -r force-app/main -d "${metadata_directory}" -n "${fullName}"
  if [[ "${namespacePrefix}" != "" ]] && ! grep '<namespacePrefix>' "${metadata_directory}/package.xml" > /dev/null; then
    perl -p -i.pbak -e "s|<Package xmlns=\"http://soap.sforce.com/2006/04/metadata\">|<Package xmlns=\"http://soap.sforce.com/2006/04/metadata\">\n    <namespacePrefix>${namespacePrefix}</namespacePrefix>|g" "${metadata_directory}/package.xml"
    rm -rf "${metadata_directory}/package.xml.pbak"
  fi
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  set -eo pipefail
  if [[ "$TRACE" ]]; then
    set -x
  fi
  case $1 in
    -h|--help)
      _help; exit 0;
    ;;
    *)
      if [ $# -lt 1 ]; then
        _help; exit 1;
      fi
      _release "${@}"
    ;;
  esac
fi
