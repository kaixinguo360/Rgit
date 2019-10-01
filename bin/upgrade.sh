#!/bin/bash
#i:Upgrade RGit to latest version
#u:Usage: rgit upgrade

cd $RGIT_ROOT

git fetch --all && \
git reset --hard origin/master && \
git pull && \
git clean -fd
