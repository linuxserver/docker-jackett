[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/jackett
[![](https://images.microbadger.com/badges/version/linuxserver/jackett.svg)](https://microbadger.com/images/linuxserver/jackett "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/jackett.svg)](http://microbadger.com/images/linuxserver/jackett "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/jackett.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/jackett.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-jackett)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-jackett/)
[hub]: https://hub.docker.com/r/linuxserver/jackett/

Jackett works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.[Jackett](https://github.com/Jackett/Jackett)

[![jackett](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/jackett-banner.png)][jacketturl]
[jacketturl]: https://github.com/Jackett/Jackett

## Usage

```
docker create --name=jackett \
-v <path to data>:/config \
-v <path to blackhole>:/downloads \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 9117:9117 \
linuxserver/jackett
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 9117` - the port(s)
* `-v /config` - where Jackett should store its config file.
* `-v /downloads` - Path to torrent blackhole
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone EG. Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it jackett /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

The web interface is at `<your-ip>:9117` , configure various trackers and connections to other apps there.
More info at [Jackett](https://github.com/Jackett/Jackett).


## Info

* To monitor the logs of the container in realtime `docker logs -f jackett`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' jackett`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/jackett`

## Versions

+ **29.10.16:** Call python2 from edge main to satisfy new mono dependency.
+ **14.10.16:** Add version layer information.
+ **22.09.16:** Remove autoupdate, tidy up Dockerfile.
+ **10.09.16:** Add layer badges to README.
+ **28.08.16:** Add badges to README.
+ **06.08.16:** Rebase to alpine linux for smaller image.
+ **25.01.16:** Initial Release.
