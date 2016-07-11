#!/bin/sh

DOCKER_IMAGE="yleisradio/newrelic-cloudwatch"
ECR_REPOSITORY="352476883983.dkr.ecr.eu-west-1.amazonaws.com/newrelic-cloudwatch"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 docker_image_tag" >&2
  exit 1
fi

eval $(asu infra-aws-yle ${TF_AWS_ROLE:-dev} aws ecr get-login --region eu-west-1)
docker build --no-cache -t "$DOCKER_IMAGE":"$1" .
docker tag "$DOCKER_IMAGE":"$1" "$ECR_REPOSITORY":"$1"
docker push "$ECR_REPOSITORY":"$1"
