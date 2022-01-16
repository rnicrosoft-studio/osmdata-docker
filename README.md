# osmdata-docker

[![Build and push Docker images CI](https://github.com/rnicrosoft-studio/osmdata-docker/actions/workflows/docker-build-publish.yml/badge.svg)](https://github.com/rnicrosoft-studio/osmdata-docker/actions/workflows/docker-build-publish.yml)
![](https://img.shields.io/badge/OSMData-docker-brightgreen)
![](https://img.shields.io/docker/image-size/rnicrosoft/osmdata/latest)
![](https://img.shields.io/docker/pulls/rnicrosoft/osmdata)
![](https://img.shields.io/badge/maintainer-rnicrosoft-blue)

Dockerfile for [OSMData](https://github.com/fossgis/osmdata) generation without `hcloud` platform requirement and website part.

## Run
```
docker volume create planet_data # >= 160 GB
docker volume create osmdata_data
docker volume create robot_data # >= 20 GB
docker run -d \
  --name osmdata \
  -v osmdata_data:/data \
  -v planet_data:/mnt/data \
  -v robot_data:/home/robot \
  rnicrosoft/osmdata
```

Access the shell with
```
docker exec -it <container_id> /bin/bash
```

To transfer files or directories, see [`docker cp`](https://docs.docker.com/engine/reference/commandline/cp/)

## Usage
For the first run, execute
```
/tmp/init.sh
```

To update planet and osmdata (for details, see [run-update.sh](./master/run-update.sh))
```
su -c run-update.sh [-p] [JOBS...] robot
```

## Notes

Default timezone is `Asia/Shanghai`.
