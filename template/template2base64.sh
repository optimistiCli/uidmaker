#!/bin/bash

tar cf - conf INFO.template package.tgz scripts | bzip2 -9 | base64 > ../template.tar.bz2.b64

