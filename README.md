

# OpenHands Custom Docker Image

This repository sets up a custom Docker image for the OpenHands app, following the [custom sandbox guide](https://docs.all-hands.dev/usage/how-to/custom-sandbox-guide).

## Table of Contents
- [Building the Docker Image](#building-the-docker-image)
- [Running the Docker Container](#running-the-docker-container)

## List of Programs that will be included in the custom-image

## Building the Docker Image

To build the custom Docker image for OpenHands, follow these steps:

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/xbay-au/Openhands-custom-image.git
   cd Openhands-custom-image
   ```

2. Build the Docker image using the provided Dockerfile:
   ```bash
   docker build -t custom-image .
   ```

## Running the Docker Container

When running OpenHands using the docker command, replace -e SANDBOX_RUNTIME_CONTAINER_IMAGE=... with -e SANDBOX_BASE_CONTAINER_IMAGE=<custom image name>:

```
docker run -it --rm --pull=always \
    -e SANDBOX_BASE_CONTAINER_IMAGE=custom-image \
    ...
```

