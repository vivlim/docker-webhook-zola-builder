#!/bin/sh
echo "GIT_URI=$GIT_URI"
echo "GIT_BRANCH=$GIT_BRANCH"
[ ! -z "$SITE_URI" ] && echo "SITE_URI=$SITE_URI"

[ ! -d "/home/repo" ] && cd /home && git clone -b $GIT_BRANCH $GIT_URI repo

[ ! -d "/home/repo" ] && echo "repo isn't cloned, cannot continue." && exit 1

cd /home/repo

git fetch --all
git fetch --prune
git reset --hard origin/$GIT_BRANCH
git submodule init && git submodule update

# patch config if SITE_URI is set
[ ! -z "$SITE_URI" ] && sed -i 's@^base_url.*@base_url = '"\"$SITE_URI"\"'@' ./config.toml

/bin/zola check && /bin/zola build --output-dir /home/out/site
