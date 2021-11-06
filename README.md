# Run pCloud storage client in a Docker container
[![Create and publish a Docker image](https://github.com/matsprea/pcloud-eu/actions/workflows/release-docker-image.yml/badge.svg)](https://github.com/matsprea/pcloud-eu/actions/workflows/release-docker-image.yml)

This Docker container allow you to run mount your pCloud storage and support the EU region.  Learn more about pCloud: <https://www.pcloud.com/>

## Pull image

```sh
docker pull ghcr.io/matsprea/pcloud-eu
```

## Running the container

```sh
docker run -it \
     --privileged \
     -v pcloud-dir:/root/.pcloud:shared \
     --name pcloud-eu \
     -e PCLOUD_REGION_EU=true \
     -e PCLOUD_USERNAME=youremail@example.com \
     -e PCLOUD_PASSWORD=securecloudpassword \
     -e PCLOUD_MOUNT=pcloud-dir \
     ghcr.io/matsprea/pcloud-eu:main 
```

Check the [Docker documentation](https://docs.docker.com/storage/bind-mounts/#choose-the--v-or---mount-flag) for more info on the mount options

## Running container

```sh
docker start pcloud-eu
```
