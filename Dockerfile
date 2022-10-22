#
# LinuxGSM Counter Strike: Global Offensive Dockerfile
#
# https://github.com/GameServerManagers/docker-csgoserver
#

FROM gameservermanagers/linuxgsm:ubuntu-22.04

LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"

ENV GAMESERVER csgoserver

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "bash","./entrypoint.sh" ]
