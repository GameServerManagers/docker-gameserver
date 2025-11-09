#!/bin/bash

curl -O "https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/serverlist.csv"

echo -n "{" >"shortnamearray.json"
echo -n "\"include\":[" >>"shortnamearray.json"

while read -r line; do
  shortname=$(echo "$line" | awk -F, '{ print $1 }')
  export shortname
  servername=$(echo "$line" | awk -F, '{ print $2 }')
  export servername
  gamename=$(echo "$line" | awk -F, '{ print $3 }')
  export gamename
  distro=$(echo "$line" | awk -F, '{ print $4 }')
  export distro
  touch "dockerfiles/Dockerfile-${shortname}"
  echo "Generating Dockerfile-${shortname} (${gamename})"
  jinjanate Dockerfile-j2 >"dockerfiles/Dockerfile-${shortname}"
  { printf '{"shortname":"%s"},' "$shortname"; } >>"shortnamearray.json"
done < <(tail -n +2 serverlist.csv)
sed -i '$ s/.$//' "shortnamearray.json"
echo -n "]" >>"shortnamearray.json"
echo -n "}" >>"shortnamearray.json"
rm serverlist.csv
