#!/bin/sh
echo "GIT_URI=$GIT_URI"
echo "GIT_BRANCH=$GIT_BRANCH"

[ ! -d "/home/repo" ] && cd /home && git clone -b $GIT_BRANCH $GIT_URI repo

[ ! -d "/home/repo" ] && echo "repo isn't cloned, cannot continue." && exit 1

cd /home/repo

git fetch --all
git fetch --prune
git reset --hard origin/$GIT_BRANCH
git submodule init && git submodule update
/bin/zola check && /bin/zola build --output-dir /home/out/site
