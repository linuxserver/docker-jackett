FROM lsiobase/mono
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_DATA_HOME="/config"
ENV XDG_CONFIG_HOME="/config"
ENV JACKETT_PRE_BUILD=0

# install wget
RUN apt-get update && \
 apt-get install -y wget

# install jackett
RUN mkdir -p /app/Jackett && \
 if [ $JACKETT_PRE_BUILD = 1 ]; \
 then \
    releases_url="https://api.github.com/repos/Jackett/Jackett/releases"; \
 else \
    releases_url="https://api.github.com/repos/Jackett/Jackett/releases/latest"; \
 fi && \
 jack_tag=$(curl -sX GET $releases_url | awk '/tag_name/{print $4;exit}' FS='[""]') && \
 wget https://github.com/Jackett/Jackett/releases/download/$jack_tag/Jackett.Binaries.Mono.tar.gz -O /tmp/jacket.tar.gz
RUN tar xf /tmp/jacket.tar.gz -C /app/Jackett --strip-components=1

# cleanup
RUN apt-get clean
RUN rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 9117
