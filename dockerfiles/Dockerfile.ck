#
# LinuxGSM Core Keeper Dockerfile
#
# https://github.com/GameServerManagers/docker-gameserver
#

FROM gameservermanagers/linuxgsm:ubuntu-22.04
LABEL maintainer="LinuxGSM <me@danielgibbs.co.uk>"
ENV GAMESERVER=ckserver

## Auto install game server requirements
RUN depshortname=$(curl --connect-timeout 10 -s https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/lgsm/data/ubuntu-22.04.csv |awk -v shortname="ck" -F, '$1==shortname {$1=""; print $0}') \
  && if [ -n "${depshortname}" ]; then \
  echo "**** Install ${depshortname} ****" \
  && apt-get update \
  && apt-get install -y ${depshortname} \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
  fi

HEALTHCHECK --interval=1m --timeout=1m --start-period=2m --retries=1 CMD /linuxgsm/entrypoint-healthcheck.sh || exit 1

RUN date > /build-time.txt

ENTRYPOINT ["/init"]
CMD [ "./entrypoint.sh" ]
