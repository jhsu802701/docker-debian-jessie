#!/bin/bash

ABBREV='dev'
OWNER='jhsu802701'
DISTRO='debian'
SUITE='stretch'
DOCKER_IMAGE="$OWNER/$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"
TGZ_FILE="$DISTRO-$SUITE-$ABBREV.tgz"

bash setup.sh $ABBREV $DOCKER_IMAGE $CONTAINER $TGZ_FILE
