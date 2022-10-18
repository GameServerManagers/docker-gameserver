#
# LinuxGSM Base Dockerfile
#
# https://github.com/GameServerManagers/LinuxGSM-Docker
#

FROM gameservermanagers/linuxgsm:ubuntu-22.04

LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"

ENV DEBIAN_FRONTEND noninteractive
ENV GAMESERVER csgoserver
ENV LGSM_GITHUBUSER gameservermanagers
ENV LGSM_GITHUBREPO LinuxGSM
ENV LGSM_GITHUBBRANCH master

ARG USERNAME=linuxgsm
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "bash","./entrypoint.sh" ]
