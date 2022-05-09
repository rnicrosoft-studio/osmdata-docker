# osmdata-docker

[![Build and push Docker images CI](https://github.com/rnicrosoft-studio/osmdata-docker/actions/workflows/docker-build-publish.yml/badge.svg)](https://github.com/rnicrosoft-studio/osmdata-docker/actions/workflows/docker-build-publish.yml)
![](https://img.shields.io/badge/OSMData-docker-brightgreen)
![](https://img.shields.io/docker/image-size/rnicrosoft/osmdata/latest)
![](https://img.shields.io/docker/pulls/rnicrosoft/osmdata)
![](https://img.shields.io/badge/maintainer-rnicrosoft-blue)

Dockerfile for [OSMData](https://github.com/fossgis/osmdata) generation without `hcloud` platform requirement and website part.

## Run
```bash
docker volume create planet_data # > 160 GB
docker volume create osmdata_data
docker volume create robot_data # > 30 GB
docker run -dit \
  --name osmdata \
  -v osmdata_data:/data \
  -v planet_data:/mnt/data \
  -v robot_data:/home/robot \
  rnicrosoft/osmdata
```

Access the shell with
```bash
docker exec -it <container_id> /bin/bash
```

To transfer files or directories, see [`docker cp`](https://docs.docker.com/engine/reference/commandline/cp/)

## Usage
~~For the first run, execute `/tmp/init.sh`~~
This step had been done in docker image building stage due to network connectivity reason in some regions.
To update the packages, please refer to the script inside.

To update planet and osmdata (for details, see [run-update.sh](./master/run-update.sh))
```bash
cd /home/robot/ # to avoid permission fail of temp files
su -c run-update.sh [-p] [JOBS...] robot
```

Obtain the output data in `<robot_data>/data`, or see logs in `<robot_data>/log` if error occurs.

## Notes

Default timezone is `Asia/Shanghai`.

Tested with a 16 GB RAM machine.
