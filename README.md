

# OpenHands Custom Docker Image

This repository sets up a custom Docker image for the OpenHands app, following the [Goby custom sandbox guide](https://docs.all-hands.dev/usage/how-to/custom-sandbox-guide).

## Table of Contents
- [Prerequisites](#prerequisites)
- [Building the Docker Image](#building-the-docker-image)
- [Running the Docker Container](#running-the-docker-container)

## Prerequisites

Before you begin, ensure you have met the following requirements:
- You have installed [Docker](https://docs.docker.com/get-docker/) on your machine.

## Building the Docker Image

To build the custom Docker image for OpenHands, follow these steps:

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/xbay-au/Openhands-custom-image.git
   cd Openhands-custom-image
   ```

2. Build the Docker image using the provided Dockerfile:
   ```bash
   docker build -t openhands-custom-image .
   ```

## Running the Docker Container

To run a container using the custom OpenHands image, use the following command:

```bash
docker run -p 51879:51879 -p 55491:55491 openhands-custom-image
```

This will start the OpenHands app inside a Docker container and map ports 51879 and 55491 to your host machine.

