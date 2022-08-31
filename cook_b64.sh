#!/bin/bash

if [ $(uname -s) != Darwin ]; then
    echo 'This script is macOS only, sorry' >&2
    exit 1
fi

COPYFILE_DISABLE=1 tar -C "$(realpath -- "$(dirname "$0")")/template" -cf - \
        conf \
        INFO.template \
        package.tgz \
        scripts \
    | bzip2 -9 \
    | base64 -b 80 \
    | pbcopy
