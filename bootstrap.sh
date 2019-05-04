#!/bin/sh

# Download and install the latest version of docker
mkdir -p /tmp/docker
curl https://download.docker.com/mac/stable/Docker.dmg -s -o /tmp/docker/Docker.dmg
hdiutil attach /tmp/docker/Docker.dmg
cp -r /Volumes/Docker/Docker.app /Applications
hdiutil detach /Volumes/Docker
rm -rf /tmp/docker/Docker.dmg
open -a "Docker"

# Download and install the 1Password CLI
mkdir -p /tmp/1pw
curl https://cache.agilebits.com/dist/1P/op/pkg/v0.5.5/op_darwin_amd64_v0.5.5.zip -s -o /tmp/1pw/1password.zip
unzip /tmp/1pw/1password.zip
