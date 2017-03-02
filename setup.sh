#!/bin/bash
# Parameter 1: abbreviation
# Parameter 2: Docker image
# Parameter 3: *.tgz file
# Parameters 4 and 5: 1st guest port number and corresponding host port number
# Parameters 6 and 7: 2nd guest port number and corresponding host port number
# Parameters 8 and 9: 3rd . . . .
# Parameters 10 and 11: . . . .

ABBREV=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.
DOCKER_IMAGE=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.
CONTAINER=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.
TGZ_FILE=$1
shift # $2 becomes the new $1, $3 becomes the new $2, etc.

# Remaining parameters are port numbers

ARRAY_PORTS=() # NOTE: Always has an even number of elements
i=0
while [ $# -gt 1 ]; do # If the number of port numbers is odd, the last one is ignored.
  # ARRAY_PORTS+=($1 $2)
  ARRAY_PORTS[i]=$1
  ARRAY_PORTS[i+1]=$2
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  i=$((i+2))
done

# echo "All elements of ARRAY_PORTS: ${ARRAY_PORTS[@]}"
# echo "Number of elements in ARRAY_PORTS: ${#ARRAY_PORTS[@]}"

mkdir -p $ABBREV
mkdir -p $ABBREV/shared

# Copy files for using Docker image/container
cp $TGZ_FILE $ABBREV/$TGZ_FILE > /dev/null 2>&1
cp templates_use/* $ABBREV

cp templates_shared/info-min.sh $ABBREV/shared # For all Docker images
cp templates_shared/README-host.txt $ABBREV/shared # For all Docker images
# For specific Docker images
if [ $ABBREV = 'min' ]
then
  mv $ABBREV/shared/info-min.sh $ABBREV/shared/info.sh
elif [ $ABBREV = 'dev' ]
then
  cp templates_shared/info-dev.sh $ABBREV/shared/info.sh
elif [ $ABBREV = 'rbenv-jekyll' ]
then
  cp templates_shared/info-dev.sh $ABBREV/shared
  cp templates_shared/info-rbenv-jekyll.sh $ABBREV/shared/info.sh
  cp templates_shared/pg-reset.sh $ABBREV/shared
  cp templates_shared/pg-setup.sh $ABBREV/shared
  cp templates_shared/test-jekyll.sh $ABBREV/shared
  cp templates_shared/test-jekyll.sh $ABBREV/shared
  cp templates_shared/create-jekyll.sh $ABBREV/shared
elif [[ "$ABBREV" =~ "rbenv" ]]
then
  cp templates_shared/info-dev.sh $ABBREV/shared
  cp templates_shared/info-rbenv-general.sh $ABBREV/shared/info.sh
  cp templates_shared/pg-reset.sh $ABBREV/shared
  cp templates_shared/pg-setup.sh $ABBREV/shared
  cp templates_shared/test-rails-sq.sh $ABBREV/shared
  cp templates_shared/test-rails-pg.sh $ABBREV/shared
fi

# Fill in DOCKER_IMAGE and CONTAINER parameters
fill_in_params () {
  FILE_TO_UPDATE=$1
  # NOTE: Using \ instead of / as delimiter in sed command
  sed -i.bak "s|<DOCKER_IMAGE>|$DOCKER_IMAGE|g" $FILE_TO_UPDATE
  sed -i.bak "s|<CONTAINER>|$CONTAINER|g" $FILE_TO_UPDATE
  rm $FILE_TO_UPDATE.bak
}

for FILE in `ls $ABBREV/*.sh`
do
  fill_in_params $FILE
done

for FILE in `ls $ABBREV/shared/*.sh`
do
  fill_in_params $FILE
done

# Provide port numbers in shared/ports.txt file
# Provide port numbers when running the info.sh script
# Provide port numbers in copy_new.sh
echo '' >> $ABBREV/shared/info.sh
echo 'cat ports.txt' >> $ABBREV/shared/info.sh
echo '--------------------------------' > $ABBREV/shared/ports.txt
echo 'PORT FORWARDING (Host -> Docker)' >> $ABBREV/shared/ports.txt

i=0
LEN_ARRAY_PORTS=${#ARRAY_PORTS[@]}
INDEX_LAST=$((LEN_ARRAY_PORTS-1))
PORT_STRING=''
while [ $((i+1)) -le $((INDEX_LAST)) ]; do # If the number of port numbers is odd, the last one is ignored.
  P0=${ARRAY_PORTS[i]}
  P1=${ARRAY_PORTS[i+1]}
  PORT_STRING+=" -p $P0:$P1"
  echo "$P0 -> $P1" >> $ABBREV/shared/ports.txt
  i=$((i+2))
done

sed -i.bak "s/#PORT_SPECIFICATIONS_HERE/$PORT_STRING/g" $ABBREV/copy_new.sh
rm $ABBREV/copy_new.sh.bak

# Provide Docker image and container names when running the info.sh script
echo '---------------------------' > $ABBREV/shared/docker.txt
echo "Docker Image: $DOCKER_IMAGE" >> $ABBREV/shared/docker.txt
echo '----------------------------' >> $ABBREV/shared/docker.txt
echo "Docker Container: $CONTAINER" >> $ABBREV/shared/docker.txt
echo '----------------------------' >> $ABBREV/shared/docker.txt
echo '' >> $ABBREV/shared/info.sh
echo 'cat docker.txt' >> $ABBREV/shared/info.sh

echo '***************************************'
echo 'Enter the following command to proceed:'
echo "cd $ABBREV"
