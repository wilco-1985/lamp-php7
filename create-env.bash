#!/bin/bash

#colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

#vars
storageFile=".projects"
webRoot="/var/www/"
domain=".local"


if [[ ! -f $storageFile ]]
then
  touch $storageFile
fi

# Cast to lower
read -p "Subdomain of new project:" newProject
newProject=${newProject,,}

# Validate filename
valid='0-9a-z\-'
if [[ $newProject =~ [^$valid] ]]
  then
    printf "${RED}$newProject$domain is invalid!${NC}\n"
    exit 1
fi

# Check for duplicates in file
while IFS= read line
do
  # display $line or do something with $line
  if [[ $line == $newProject  ]]
    then
      printf "${RED}$newProject$domain is already in use!${NC}\n"
      exit 1
  fi  
done <"$storageFile"

# domain cant be empty. 
if [ "$newProject" != "" ]; then
  echo $newProject >> $storageFile
fi


# Cycle through all entries in projects file.
while IFS= read line
do
  # Check if project dir exists, else create. 
  if [ ! -d "$webRoot$line" ]; then
    printf "$webRoot$line creating dir\n"
    mkdir -p $webRoot$line
  fi  
  
  # add sub domain to apache config.
  printf "Update apache config TODO\n"
done <"$storageFile"
exit 1


# Restart container.
echo "Restarting docker containers:"
docker-compose up -d --build

printf "${GREEN}$newProject$domain created!${NC}\n"

