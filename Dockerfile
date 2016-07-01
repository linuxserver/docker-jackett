FROM lsiobase/alpine
MAINTAINER sparklyballs

ENV HOME="/config"

# change abc home folder
RUN \
 usermod -d /app abc

# install build-dependencies
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	tar && \

# install jackett
 mkdir -p \
	/app/Jackett && \
 jack_tag=$(curl -sX GET "https://api.github.com/repos/Jackett/Jackett/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
	/tmp/jacket.tar.gz -L \
	https://github.com/Jackett/Jackett/releases/download/$jack_tag/Jackett.Binaries.Mono.tar.gz && \
 tar xvf /tmp/jacket.tar.gz -C \
	/app/Jackett --strip-components=1 && \

# uninstall build dependencies
 apk del --purge \
	build-dependencies && \

# cleanup
 rm -rf /tmp/*

# install runtime packages
RUN \
 apk add --no-cache \
	libcurl && \
 apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing \
	mono

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 9117
