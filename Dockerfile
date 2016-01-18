FROM linuxserver/baseimage.mono

MAINTAINER Sparklyballs <sparkylballs@linuxserver.io>

ENV APTLIST="bzip2 libcurl4-openssl-dev wget"

# install packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \
jack_ver=$(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep browser_download_url | grep Mono  | cut -d '"' -f 4) && \
curl -o /tmp/jacket.tar.gz -L $jack_ver && \
mkdir -p /app/Jackett && \
tar xvf /tmp/jacket.tar.gz -C /app/Jackett --strip-components=1 && \

# clean up
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

# give abc a home folder
usermod -d /app abc

# ports and volumes
VOLUME /config /torrents
EXPOSE 9117

