#!/bin/bash

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0


# determine latest remote version
jack_remote="$(curl -sX GET  "https://api.github.com/repos/Jackett/Jackett/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]')"
# get local version
jack_local="$(mono /app/Jackett/JackettConsole.exe --version | sed -e 's/.*t//' -e "s/\.0.*//")"

# test if we need to update
if [ "${jack_remote//[!0-9]/}" -gt "${jack_local//[!0-9]/}" ]; then
rm -rf /app/Jackett
curl -o /tmp/jacket.tar.gz -L https://github.com/Jackett/Jackett/releases/download/"$jack_remote"/Jackett.Binaries.Mono.tar.gz
mkdir -p /app/Jackett
tar xvf /tmp/jacket.tar.gz -C /app/Jackett --strip-components=1
rm /tmp/jacket.tar.gz
fi

chown -R abc:abc /app


