#!/bin/bash

./fetch-game-data.sh

while read -r sname; do
  export gamename=$(yq ".include[strenv(shortname)].gamename" data/shortnamearray.json)
  export shortname=$sname
  echo "Generating docker-compose-${shortname}.yml (${gamename})"
  yq '.game=.include[env(shortname)]' data/shortnamearray.json | jinjanate --quiet -f json docker-compose.yml.j2 - > "docker-compose/docker-compose-${shortname}.yml"
done < <(yq -r ".include| keys[]" data/shortnamearray.json )
