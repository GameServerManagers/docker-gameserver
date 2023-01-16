# LinuxGSM Game Server Docker Image

<p align="center">
  <a href="https://linuxgsm.com"><img src="https://user-images.githubusercontent.com/4478206/197897104-bb718d2e-09a0-4f83-8e86-c829044750a9.jpg" alt="LinuxGSM"></a>
<br>
<a href="https://hub.docker.com/r/gameservermanagers/gameserver"><img src="https://img.shields.io/docker/pulls/gameservermanagers/gameserver.svg?style=flat-square&amp;logo=docker&amp;logoColor=white" alt="Docker Pulls"></a>
<a href="https://github.com/GameServerManagers/docker-gameserver/actions"><img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/gameservermanagers/docker-gameserver/generate-dockerfiles.yml?style=flat-square"></a>
<a href="https://www.codacy.com/gh/GameServerManagers/docker-gameserver/dashboard"><img src="https://img.shields.io/codacy/grade/42d400dcdd714ae080d77fcb40d00f1c?style=flat-square&logo=codacy&logoColor=white" alt="Codacy grade"></a>
<a href="https://developer.valvesoftware.com/wiki/SteamCMD"><img src="https://img.shields.io/badge/SteamCMD-000000?style=flat-square&amp;logo=Steam&amp;logoColor=white" alt="SteamCMD"></a>
<a href="https://github.com/GameServerManagers/docker-gameserver/blob/main/LICENSE"><img src="https://img.shields.io/github/license/gameservermanagers/docker-gameserver?style=flat-square" alt="MIT License"></a></p>

## About

LinuxGSM is a command-line tool for quick, simple deployment and management of Linux dedicated game servers. This container image builds every game server daily and is available on [Docker Hub](https://hub.docker.com/r/gameservermanagers/gameserver) as well as [GitHub Container Registry](https://github.com/GameServerManagers/docker-gameserver/pkgs/container/gameserver).

## Tags

[Tags List](https://hub.docker.com/r/gameservermanagers/gameserver/tags)

## Usage

### docker-compose
Below is an example docker-compose for csgoserver. Ports will vary depending upon game server.
```
version: '3.4'
services:
linuxgsm:
  image: "ghcr.io/gameservermanagers/docker-gameserver:csgo"
  container_name: csgoserver
  environment:
    - GAMESERVER=csgoserver
    - LGSM_GITHUBUSER=GameServerManagers
    - LGSM_GITHUBREPO=LinuxGSM
    - LGSM_GITHUBBRANCH=master
  volumes:
    - /path/to/serverfiles:/linuxgsm/serverfiles
    - /path/to/log:/linuxgsm/log
    - /path/to/config-lgsm:/linuxgsm/lgsm/config-lgsm
  ports:
    - "27015:27015/tcp"
    - "27015:27015/udp"
    - "27020:27020/udp"
    - "27005:27005/udp"
  restart: unless-stopped
```
### First Run
Edit the docker-compose.yml file changing GAMESERVER= to the game server of choice. On first run linuxgsm will install your selected server and will start running. Once completed the game server details will be output.

### Game Server Ports
Each game server has its own port requirements. Becuase of this you will need to configure the correct ports in your docker-compose after first run. The required ports are output once installation is completed and everytime the docker container is started.

### Volumes
volumes are required to save persistant data for your game server. The example above covers a basic csgoserver however some game servers save files in other places. Please check all the correct locations are mounted to remove the risk of loosing save data.

Run LinuxGSM commands
Commands can be run just like standard LinuxGSM using the docker exec command.
```
docker exec -it csgoserver ./csgoserver details
```
