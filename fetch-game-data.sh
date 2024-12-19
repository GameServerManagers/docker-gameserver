#!/bin/bash

echo "Fetching server list"
curl -o ./data/serverlist.csv "https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/serverlist.csv"

echo '{"include": {}}' > ./data/shortnamearray.json

# convert csv to json
while read -r line; do
  export shortname=$(echo "$line" | awk -F, '{ print $1 }')
  export servername=$(echo "$line" | awk -F, '{ print $2 }')
  export gamename=$(echo "$line" | awk -F, '{ print $3 }')
  export distro=$(echo "$line" | awk -F, '{ print $4 }')

  yq -iP '.include[strenv(shortname)]={"shortname": strenv(shortname),"servername": strenv(servername),"gamename": strenv(gamename),"distro": strenv(distro)}' ./data/shortnamearray.json -o json
done < <(tail -n +2 ./data/serverlist.csv)

echo "Found $(yq '.include | keys | length' ./data/shortnamearray.json) items"
