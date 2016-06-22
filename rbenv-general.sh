#!/bin/bash

ABBREV='rbenv-general'
OWNER='jhsu802701'
DISTRO='debian'
SUITE='jessie'
DOCKER_IMAGE="$OWNER/$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"
TGZ_FILE="$DISTRO-$SUITE-$ABBREV.tgz"

sh setup.sh $ABBREV $DOCKER_IMAGE $CONTAINER $TGZ_FILE '1080' '1080' '3000' '3000' '15432' '5432'