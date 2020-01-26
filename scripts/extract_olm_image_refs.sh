#!/bin/bash

# DISCLAIMER: I am sure there is a better way to do this. For eg: read in the
#             yaml files and parse / extract the image attribute.
#             Went with this approach as I needed something really quick
#             Also parsing 300+ yaml files was going to take time anyways.

SCRIPTPATH=`dirname "$(readlink -f "$0")"`

# EXCEPTIONs:
# The below manifest file has a comment in there which matches the exact
# pattern for a valid image. The file in question:
# fuse-apicurito/7.5.0/apicuritooperator.v7.5.0.clusterserviceversion.yaml

BAD_IMAGES='registry.redhat.io/fuse7-tech-preview/fuse-apicurito-operator:version'


grep -R " image: " ${SCRIPTPATH}/../manifests/ | awk '{print $3}' | sed -e 's/"//g' | grep -E '^\w+(\.\w+)+/' | less | sort | uniq | grep -v "${BAD_IMAGES}"

# sed -e 's/"//g' - strips out any " in the list of images
#                   there was one image that was put in doube quotes
#                   So much for consistency ah.

# grep -E '^\w+(\.\w+)+/'  - makes sure all the images match the pattern of a
#                            domain name. There are several comment lines in
#                            manifest yamls that have image: in them

