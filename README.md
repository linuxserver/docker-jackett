![https://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/jackett

Jackett works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.[Jackett](https://github.com/Jackett/Jackett)

## Usage

```
docker create --name=jackett -v /etc/localtime:/etc/localtime:ro \
-v <path to data>:/config -v <path to blackhole>:/downloads \
-e PGID=<gid> -e PUID=<uid> -p 9117:9117 linuxserver/jackett
```

**Parameters**

* `-p 9117` - the port(s)
* `-v /etc/localtime` for timesync - *optional*
* `-v /config` - where Jackett should store its config file.
* `-v /downloads` - Path to torrent blackhole
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it jackett /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application

The web interface is at `<your-ip>:9117` , configure various trackers and connections to other apps there.
More info at [Jackett](https://github.com/Jackett/Jackett).


## Info

* To monitor the logs of the container in realtime `docker logs -f jackett`.



## Versions

+ **01.07.16:** Rebase to alpine linux for smaller image.
+ **25.01.16:** Initial Release.

