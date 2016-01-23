#!/bin/bash

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0


# determine latest remote version
jackremote="$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}')"

# get local version
jacklocal="$(mono /app/Jackett/JackettConsole.exe --version | sed -e 's/.*t//' -e "s/\.0.*//")"

# test if we need to update
if [ "$jackremote" -gt "$jacklocal" ]; then
rm -rf /app/Jackett
curl -o /tmp/jacket.tar.gz -L "$jack_ver"
mkdir -p /app/Jackett
tar xvf /tmp/jacket.tar.gz -C /app/Jackett --strip-components=1
rm /tmp/jacket.tar.gz
fi

chown -R abc:abc /app
