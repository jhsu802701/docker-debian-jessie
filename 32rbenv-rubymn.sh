#!/bin/bash

ABBREV='rbenv-rubymn'
OWNER='jhsu802701'
DISTRO='debian'
SUITE='jessie'
DOCKER_IMAGE="$OWNER/32bit-$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-32bit-$DISTRO-$SUITE-$ABBREV"
TGZ_FILE="32bit-$DISTRO-$SUITE-$ABBREV.tgz"

sh setup.sh $ABBREV $DOCKER_IMAGE $CONTAINER $TGZ_FILE '1081' '1080' '3001' '3000' '15433' '5432'
