#!/bin/bash


[[ ! -d /app/.config  ]] && mkdir -p /app/.config
[[ ! -d /config/Jackett ]] && mkdir -p /config/Jackett
[[ ! -L /app/.config/Jackett && -d /app/.config/Jackett ]] && rm -rf /app/.config/Jackett
[[ ! -L /app/.config/Jackett ]] && ln -s /config/Jackett  /app/.config/Jackett



chown -R abc:abc /app /config /downloads
