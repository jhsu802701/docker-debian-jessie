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

echo '*************'
echo 'ls -l /bin/sh'
ls -l /bin/sh
echo '/bin/sh should point to Bash instead of Dash'
echo 'If /bin/sh points to Dash, the commands to correct this are:'
echo 'sudo rm /bin/sh'
echo 'sudo ln -s /bin/bash /bin/sh'
echo '****************************'

ARRAY_PORTS=() # NOTE: Always has an even number of elements

while [ $# -gt 1 ]; do # If the number of port numbers is odd, the last one is ignored.
	ARRAY_PORTS+=($1 $2)
	shift # $2 becomes the new $1, $3 becomes the new $2, etc.
	shift # $2 becomes the new $1, $3 becomes the new $2, etc.
done

# echo "${ARRAY_PORTS[@]}" # Prints all elements of array

mkdir -p $ABBREV
mkdir -p $ABBREV/shared

# Copy files for using Docker image/container
cp $TGZ_FILE $ABBREV/$TGZ_FILE > /dev/null 2>&1
cp templates_use/* $ABBREV

# Get shared files
# min -> dev
# min -> dev -> hyde
# min -> dev -> rbenv-min

cp templates_shared/info-min.sh $ABBREV/shared # For all Docker images
cp templates_shared/README-host.txt $ABBREV/shared # For all Docker images
# For specific Docker images
if [ $ABBREV = 'min' ]
then
  mv $ABBREV/shared/info-min.sh $ABBREV/shared/info.sh
elif [ $ABBREV = 'dev' ]
then
  cp templates_shared/info-dev.sh $ABBREV/shared/info.sh
elif [ $ABBREV = 'hyde' ]
then
  cp templates_shared/info-dev.sh $ABBREV/shared
  cp templates_shared/info-hyde.sh $ABBREV/shared/info.sh
  cp templates_shared/test-hyde.sh $ABBREV/shared
elif [ $ABBREV = 'rbenv-min' ]
then
  cp templates_shared/info-dev.sh $ABBREV/shared
  cp templates_shared/info-rbenv-min.sh $ABBREV/shared/info.sh
  cp templates_shared/pg-reset.sh $ABBREV/shared
  cp templates_shared/pg-setup.sh $ABBREV/shared
elif [[ "$ABBREV" =~ "rbenv" ]]
then
  cp templates_shared/info-dev.sh $ABBREV/shared
  cp templates_shared/info-rbenv-min.sh $ABBREV/shared/
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
echo "cat ports.txt" >> $ABBREV/shared/info.sh
echo '--------------------------------' > $ABBREV/shared/ports.txt
echo 'PORT FORWARDING (Docker -> Host)' >> $ABBREV/shared/ports.txt
ARRAY_PORTS_TMP=("${ARRAY_PORTS[@]}")

for value in "${ARRAY_PORTS[@]}" ; do    #print the new array 
  echo "$value" 
done  

echo ${ARRAY_PORTS_TMP[1]}
# echo "${ARRAY_PORTS[@]}" # Prints all elements of array

echo ${#ARRAY_PORTS_TMP[@]}

while [ ${#ARRAY_PORTS_TMP[@]} -gt 1 ]; do # If the number of port numbers is odd, the last one is ignored.
  P0=${ARRAY_PORTS_TMP[0]}
  P1=${ARRAY_PORTS_TMP[1]}
  echo "$P0 -> $P1" >> $ABBREV/shared/ports.txt
  unset -v ARRAY_PORTS_TMP[0]
  unset -v ARRAY_PORTS_TMP[0]
done

echo '***************************************'
echo 'Enter the following command to proceed:'
echo "cd $ABBREV"