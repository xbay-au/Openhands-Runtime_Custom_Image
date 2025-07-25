

# OpenHands Custom Docker Image

This repository sets up a custom Docker image for the OpenHands app, following the [custom sandbox guide](https://docs.all-hands.dev/usage/how-to/custom-sandbox-guide).

## Table of Contents
- [Building the Docker Image](#building-the-docker-image)
- [Running the Docker Container]
- [Subdomain Files](#subdomain-files)

## List of Programs Included in the Custom Image

- Go
- Node.js
- Python
- Nmap
- Subfinder
- Ruby
- PHP
- Java (OpenJDK 17)
- Nano text editor
- Security tools: hydra, nikto, sqlmap
- Modern ls command (lsd)

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

When running OpenHands using the docker command, replace `-e SANDBOX_RUNTIME_CONTAINER_IMAGE=...` with `-e SANDBOX_BASE_CONTAINER_IMAGE=<custom image name>`:

```
docker run -it --rm --pull=always \
    -e SANDBOX_BASE_CONTAINER_IMAGE=custom-image \
    ...
```

## Subdomain Files

This repository also includes subdomain files generated using the `subfinder` tool:

- `subdomains.txt`: A comprehensive list of subdomains for various target websites (over 28,000 entries)
- `subdomain_200.txt`: A randomly selected subset containing exactly 200 subdomains

These files can be used as input for your applications that require subdomain information.

