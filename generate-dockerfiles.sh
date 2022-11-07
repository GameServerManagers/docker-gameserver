#!/bin/bash

wget "https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/serverlist.csv"

echo -n "[" >"shortnamearray.txt"

while read line; do
  export shortname=$(echo "$line" | awk -F, '{ print $1 }')
  export servername=$(echo "$line" | awk -F, '{ print $2 }')
  export gamename=$(echo "$line" | awk -F, '{ print $3 }')
  export distro="ubuntu-22.04"
  touch "dockerfiles/Dockerfile.${shortname}"
  echo "Generating Dockerfile.${shortname} (${gamename})"
  j2 -f env Dockerfile.j2 >"dockerfiles/Dockerfile.${shortname}"
  echo -n "${shortname}," >>"shortnamearray.txt"
done <serverlist.csv
cat "shortnamearray.txt" | sed 's/.$//' | sed 's/.$//' >"shortname.txt"
echo -n "]" >>"shortname.txt"
