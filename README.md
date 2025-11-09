# LinuxGSM Game Server Docker Image

<p align="center">
  <a href="https://linuxgsm.com"><img src="https://user-images.githubusercontent.com/4478206/197897104-bb718d2e-09a0-4f83-8e86-c829044750a9.jpg" alt="LinuxGSM"></a>
<br>
<a href="https://hub.docker.com/r/gameservermanagers/gameserver"><img src="https://img.shields.io/docker/pulls/gameservermanagers/gameserver.svg?style=flat-square&amp;logo=docker&amp;logoColor=white" alt="Docker Pulls"></a>
<a href="https://github.com/GameServerManagers/docker-gameserver/actions"><img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/GameServerManagers/docker-gameserver/docker-publish.yml?style=flat-square"></a>
<a href="https://www.codacy.com/gh/GameServerManagers/docker-gameserver/dashboard"><img src="https://img.shields.io/codacy/grade/42d400dcdd714ae080d77fcb40d00f1c?style=flat-square&logo=codacy&logoColor=white" alt="Codacy grade"></a>
<a href="https://developer.valvesoftware.com/wiki/SteamCMD"><img src="https://img.shields.io/badge/SteamCMD-000000?style=flat-square&amp;logo=Steam&amp;logoColor=white" alt="SteamCMD"></a>
<a href="https://github.com/GameServerManagers/docker-gameserver/blob/main/LICENSE"><img src="https://img.shields.io/github/license/gameservermanagers/docker-gameserver?style=flat-square" alt="MIT License"></a></p>

## About

LinuxGSM is a command-line tool for quick, simple deployment and management of Linux dedicated game servers. This container image builds weekly and is available on [Docker Hub](https://hub.docker.com/r/gameservermanagers/gameserver) as well as [GitHub Container Registry](https://github.com/GameServerManagers/docker-gameserver/pkgs/container/gameserver).

## Tags

For a list of available game servers visit [linuxgsm.com](https://linuxgsm.com) or the [serverlist.csv](https://github.com/GameServerManagers/LinuxGSM/blob/master/lgsm/data/serverlist.csv). For all tags see the [tags list](https://hub.docker.com/r/gameservermanagers/gameserver/tags) on Docker Hub.

## Usage

### docker-compose

Here is an example docker-compose configuration for the "csgoserver" using the image `gameservermanagers/gameserver:csgo`. Please note that the ports may vary depending on the specific game server. More docker-compose examples are available [here](https://github.com/GameServerManagers/docker-gameserver/tree/main/docker-compose).

```yaml
version: "3.4"
services:
  linuxgsm-csgo:
    image: gameservermanagers/gameserver:csgo
    # image: ghcr.io/gameservermanagers/gameserver:csgo
    container_name: csgoserver
    volumes:
      - /path/to/csgoserver:/data
    ports:
      - "27015:27015/tcp"
      - "27015:27015/udp"
      - "27020:27020/udp"
      - "27005:27005/udp"
    restart: unless-stopped
```

### Docker CLI

Alternatively, you can use the Docker CLI to run the container:

```bash
docker run -d \
  --name csgoserver \
  -v /path/to/csgoserver:/data \
  -p 27015:27015 \
  -p 27020:27020/udp \
  -p 27005:27005/udp \
  --restart unless-stopped \
  gameservermanagers/gameserver:csgo
```

### First Run

Before the first run, make sure to edit the docker-compose.yml file by changing the image tag and container_name to match your chosen game server. Upon the initial run, LinuxGSM will install the selected server and start running. The game server details will be displayed once the installation is complete.

### Game Server Ports

Each game server has specific port requirements. Therefore, after the initial run, you need to configure the appropriate ports in your docker-compose file. The required ports will be outputted after the installation process and every time the Docker container is started. Automation for this process is planned for the future.

> There are future plans to auto generate ports in the examples for you.

### Volumes

There are two types of persistent storage with Docker: volumes and bind mounts, both of which are compatible with this container. For more information on the differences between the two, please refer to the [Docker documentation](https://docs.docker.com/storage/).

Some game servers store files outside of the serverfiles directory, within other parts of the home directory. The `data` directory serves as the home directory for the LinuxGSM user and stores all game server files. Make sure to mount this directory to a persistent storage location.

### LinuxGSM User

This container uses gosu to run gameservers as the `linuxgsm` user instead of root. If you are using a bind mount for the data directory, ensure that the permissions are appropriately set.

### Run LinuxGSM commands

You can execute LinuxGSM commands within the container using the docker exec command. Here's an example to run the `./csgoserver details` command as the `linuxgsm` user:

```bash
docker exec -it --user linuxgsm csgoserver ./csgoserver details
```
