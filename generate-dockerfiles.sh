#!/bin/bash

wget "https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/serverlist.csv"

echo "{" >"shortnamearray.json"
echo "\"include\": [" >>"shortnamearray.json"

while read line; do
  export shortname=$(echo "$line" | awk -F, '{ print $1 }')
  export servername=$(echo "$line" | awk -F, '{ print $2 }')
  export gamename=$(echo "$line" | awk -F, '{ print $3 }')
  export distro="ubuntu-22.04"
  touch "dockerfiles/Dockerfile.${shortname}"
  echo "Generating Dockerfile.${shortname} (${gamename})"
  j2 -f env Dockerfile.j2 >"dockerfiles/Dockerfile.${shortname}"
  echo "{" >>"shortnamearray.json"
  echo -n "\"shortname\":" >>"shortnamearray.json"
  echo "\"${shortname}\"" >>"shortnamearray.json"
  echo "}," >>"shortnamearray.json"
done <serverlist.csv
sed -i '$ s/.$//' "shortnamearray.json"
echo "]" >>"shortnamearray.json"
echo -n "}" >>"shortnamearray.json"