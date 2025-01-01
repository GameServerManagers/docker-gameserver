#!/bin/bash

./fetch-game-data.sh

while read -r sname; do
  export gamename=$(yq ".include[strenv(shortname)].gamename" data/shortnamearray.json)
  export shortname=$sname
  echo "Generating Dockerfile.${shortname} (${gamename})"
  yq '.game=.include[env(shortname)]' data/shortnamearray.json | jinjanate --quiet -f json Dockerfile.j2 - > "dockerfiles/Dockerfile.${shortname}"
done < <(yq -r ".include| keys[]" data/shortnamearray.json )
