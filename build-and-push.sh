#!/bin/sh

DOCKER_IMAGE="yleisradio/newrelic-cloudwatch"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 docker_image_tag" >&2
  exit 1
fi

docker build --no-cache -t "$DOCKER_IMAGE":"$1" .
docker push "$DOCKER_IMAGE":"$1"
