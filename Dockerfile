#
# LinuxGSM Minecraft: Java Edition Dockerfile
#
# https://github.com/GameServerManagers/docker-mcserver
#

FROM gameservermanagers/linuxgsm:ubuntu-22.04

LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"

ENV GAMESERVER mcserver

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "bash","./entrypoint.sh" ]
