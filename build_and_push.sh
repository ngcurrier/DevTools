#!/bin/bash

# check number of args
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Version Tag>" >&2
    exit 1
fi
VERSION=$1
IMAGE="my_docker"
IMAGE_LOCATION="docfreezzzz"

docker build -t $IMAGE:$VERSION .
docker tag $IMAGE:$VERSION $IMAGE_LOCATION/$IMAGE:$VERSION
docker push $IMAGE_LOCATION/$IMAGE:$VERSION
echo "Built and pushed image to: $IMAGE_LOCATION/$IMAGE:$VERSION"
