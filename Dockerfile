#
# LinuxGSM Counter Strike: Global Offensive Dockerfile
#
# https://github.com/GameServerManagers/docker-csgoserver
#

FROM gameservermanagers/linuxgsm:ubuntu-22.04

ENV GAMESERVER csgoserver
ENV SHORTNAME csgo
ENV DISTRO ubuntu-22.04

## Auto install game server requirements
RUN depshortname=$(curl --connect-timeout 10 -s https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/v22.2.1/lgsm/data/${DISTRO}.csv |awk -v shortname="${SHORTNAME}" -F, '$1==shortname {$1=""; print $0}') \
    && if [ -n "${depshortname}" ]; then \
    echo "**** Install ${depshortname} ****" \
    && apt-get update \
    && apt-get install -y ${depshortname} \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    fi

LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "bash","./entrypoint.sh" ]

