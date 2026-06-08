#!/bin/bash

USER_NAME="nick"
LOCAL_PATH="C:/Users/nicho/Documents/docker_home_$USER_NAME"
IMAGE="docfreezzzz/my_docker"
VERSION="v1.1"
docker pull $IMAGE:$VERSION
# Run docker headleass and mount the local path onto the home directory
docker run -dit --network host --mount type=bind,source=$LOCAL_PATH,target=/home/$USER_NAME/ \
  $IMAGE:$VERSION /bin/bash

# To attach to this container run:
# docker ps 
# To get the name of a running session, thus:
# docker attach <Container Name>
