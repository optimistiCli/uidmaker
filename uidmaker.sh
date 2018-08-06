#!/bin/bash

NEWUSER="$1"

run () {
    if [ -z "$NEWUSER" ] ; then
        echo 'Error: no username' >&2
        exit 1
    fi

    # TODO: Check bash version

    # TODO: Check if username is valid

    # TODO: Check base64 for -d or -D option

    CURDIR="$(pwd)"

    PKGNAME="uidmaker_${NEWUSER}"

    TEMPDIR="$(mktemp -d "/tmp/${PKGNAME}.XXXX")"

    TIMESTAMP="$(date -u '+%Y%m%d-%H:%M:%S')"

    cd "$TEMPDIR"

    base64 -d | tar xjf -

    find . -name '*.template' | while IFS='' read -d $'\n' T ; do
        T="$(realpath "$T")"
        D="$(realpath "${T%%.template}")"
        sed "s/%s/$NEWUSER/g" < "$T" \
            | sed "s/%n/$PKGNAME/g" \
            | sed "s/%d/$TIMESTAMP/g" > "$D"
        rm "$T"
    done

    SPK="$(realpath "${CURDIR}/${PKGNAME}.spk")"
    tar cf "$SPK" *

    cd "$CURDIR"

    rm -rf "$TEMPDIR"
}

run << EOB64
QlpoOTFBWSZTWd72Zw8ABfv/////////////////////////////////////////////4A0fD5e9
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
h4A=
EOB64
