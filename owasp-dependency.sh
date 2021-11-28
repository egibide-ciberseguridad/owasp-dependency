#!/bin/sh

# https://hub.docker.com/r/owasp/dependency-check

DC_VERSION="latest"
DC_DIRECTORY=$HOME/OWASP-Dependency-Check
DC_PROJECT="dependency-check scan: $(pwd)"
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"

# https://stackoverflow.com/a/48348531
export MSYS_NO_PATHCONV=1

if [ ! -d "$DATA_DIRECTORY" ]; then
  echo "Initially creating persistent directory: $DATA_DIRECTORY"
  mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
  echo "Initially creating persistent directory: $CACHE_DIRECTORY"
  mkdir -p "$CACHE_DIRECTORY"
fi

# Make sure we are using the latest version
docker pull owasp/dependency-check:$DC_VERSION

docker run --rm \
  -e user=$(whoami) \
  -u $(id -u $(whoami)):$(id -g $(whoami)) \
  --volume $(pwd):/src:z \
  --volume "$DATA_DIRECTORY":/usr/share/dependency-check/data:z \
  --volume $(pwd)/odc-reports:/report:z \
  owasp/dependency-check:$DC_VERSION \
  --scan /src \
  --format "ALL" \
  --project "$DC_PROJECT" \
  --out /report
# Use suppression like this: (where /src == $pwd)
# --suppression "/src/security/dependency-check-suppression.xml"
