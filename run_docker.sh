#!/bin/bash
docker run -dit --network host --mount type=bind,source=C:/Users/nicho/Documents/docker_home_nick,target=/home/nick/ my_docker /bin/bash
