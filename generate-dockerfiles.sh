#!/bin/bash

echo "Fetching server list"
curl -o ./data/serverlist.csv "https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/serverlist.csv"

echo '{"include": {}}' > ./data/shortnamearray.json

# convert csv to json
while read line; do
  export shortname=$(echo "$line" | awk -F, '{ print $1 }')
  export servername=$(echo "$line" | awk -F, '{ print $2 }')
  export gamename=$(echo "$line" | awk -F, '{ print $3 }')
  export distro=$(echo "$line" | awk -F, '{ print $4 }')

  yq -iP '.include[strenv(shortname)]={"shortname": strenv(shortname),"servername": strenv(servername),"gamename": strenv(gamename),"distro": strenv(distro)}' ./data/shortnamearray.json -o json
done < <(tail -n +2 ./data/serverlist.csv)

echo "Found $(yq '.include | keys | length' ./data/shortnamearray.json) items"

while read sname; do
  export gamename=$(yq ".include[strenv(shortname)].gamename" data/shortnamearray.json)
  export shortname=$sname
  echo "Generating Dockerfile.${shortname} (${gamename})"
  yq '.game=.include[env(shortname)]' data/shortnamearray.json | jinjanate --quiet -f json Dockerfile.j2 - > "dockerfiles/Dockerfile.${shortname}"
done < <(yq -r ".include| keys[]" data/shortnamearray.json )
