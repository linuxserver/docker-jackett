[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/jackett](https://github.com/linuxserver/docker-jackett)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/jackett.svg)](https://microbadger.com/images/linuxserver/jackett "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/jackett.svg)](https://microbadger.com/images/linuxserver/jackett "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/jackett.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/jackett.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-jackett/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-jackett/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/jackett/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/jackett/latest/index.html)

[Jackett](https://github.com/Jackett/Jackett) works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.

[![jackett](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/jackett-banner.png)](https://github.com/Jackett/Jackett)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

Simply pulling `linuxserver/jackett` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=jackett \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -e RUN_OPTS=<run options here> `#optional` \
  -p 9117:9117 \
  -v <path to data>:/config \
  -v <path to blackhole>:/downloads \
  --restart unless-stopped \
  linuxserver/jackett
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  jackett:
    image: linuxserver/jackett
    container_name: jackett
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
      - RUN_OPTS=<run options here> #optional
    volumes:
      - <path to data>:/config
      - <path to blackhole>:/downloads
    ports:
      - 9117:9117
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 9117` | WebUI |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e RUN_OPTS=<run options here>` | Optionally specify additional arguments to be passed. EG. `--ProxyConnection=10.0.0.100:1234`. |
| `-v /config` | Where Jackett should store its config file. |
| `-v /downloads` | Path to torrent blackhole. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

The web interface is at `<your-ip>:9117` , configure various trackers and connections to other apps there.
More info at [Jackett](https://github.com/Jackett/Jackett).

Disable autoupdates in the webui to prevent jackett crashing, the image is refreshed when new versions are released.



## Support Info

* Shell access whilst the container is running: `docker exec -it jackett /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f jackett`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' jackett`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/jackett`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/jackett`
* Stop the running container: `docker stop jackett`
* Delete the container: `docker rm jackett`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start jackett`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/jackett`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **11.02.19:** - Add pipeline logic and multi arch.
* **11.06.18:** - Ensure root ownership of Jackett files.
* **13.12.17:** - Fix continuation lines.
* **17.04.17:** - Switch to using inhouse mono baseimage, ubuntu xenial based.
* **09.02.17:** - Rebase to alpine 3.5.
* **29.10.16:** - Call python2 from edge main to satisfy new mono dependency.
* **14.10.16:** - Add version layer information.
* **22.09.16:** - Remove autoupdate, tidy up Dockerfile.
* **10.09.16:** - Add layer badges to README.
* **28.08.16:** - Add badges to README.
* **06.08.16:** - Rebase to alpine linux for smaller image.
* **25.01.16:** - Initial Release.
