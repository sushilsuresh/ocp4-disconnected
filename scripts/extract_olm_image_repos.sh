#!/bin/bash

SCRIPTPATH=`dirname "$(readlink -f "$0")"`

grep -R " image: " ${SCRIPTPATH}/../manifests/ | awk '{print $3}' | sed -e 's/"//g' | grep -E '^\w+(\.\w+)+/' | cut -f1 -d '@' | cut -f1 -d':' | less | sort | uniq

