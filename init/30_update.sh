#!/bin/bash

# determine latest remote version
jack_ver="$(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep browser_download_url | grep Mono | cut -d '"' -f 4)"
jackremote="$(echo $jack_ver | tr -d [=.=][:alpha:][=/=][=:=][:space:])"

# get local version
jacktest="$(mono /app/Jackett/JackettConsole.exe --version)"
jackcut1="$(echo $jacktest | tr -d [=.=][:alpha:][:space:])"
jacklocal=${jackcut1%0}

# test if we need to update
if [ "$jackremote" -gt "$jacklocal" ]; then
rm -rf /app/Jackett
curl -o /tmp/jacket.tar.gz -L "$jack_ver"
mkdir -p /app/Jackett
tar xvf /tmp/jacket.tar.gz -C /app/Jackett --strip-components=1
rm /tmp/jacket.tar.gz
fi

chown -R abc:abc /app
