

# Openhands-Runtime_Custom_Image

This repository sets up a custom Docker image for the OpenHands app, following the [custom sandbox guide](https://docs.all-hands.dev/usage/how-to/custom-sandbox-guide).

## Table of Contents
- [Features](#features)
- [Building the Docker Image](#building-the-docker-image)
- [Running the Docker Container](#running-the-docker-container)
- [Subdomain Files](#subdomain-files)

## Features

This custom image includes a comprehensive set of tools for various programming languages and security testing:

Here is a formatted list of the tools installed by the provided Dockerfile:

Here is the formatted list of tools installed by the provided Dockerfile in Markdown format:

### Essential Tools:
- bash
- curl
- wget
- git
- ca-certificates
- build-essential
- libssl-dev
- zlib1g-dev
- libbz2-dev
- libreadline-dev
- libsqlite3-dev
- llvm
- libncurses5-dev
- libncursesw5-dev
- libcurl4-openssl-dev
- libxml2
- libxml2-dev
- libxslt1-dev
- ruby-dev
- libgmp-dev
- xz-utils
- apt-utils
- tk-dev
- libffi-dev
- iputils-ping
- dirb
- liblzma-dev

### Programming Languages and Related Tools:
- python3-pip
- nodejs
- npm
- ruby
- php
- openjdk-17-jdk
- nano

### Go Language and Tools:
- go (version 1.21.5)
- lsd (modern ls command)

### Security Tools:
- wpscan (WordPress security scanner)
- nmap (Network Mapper)
- subfinder (projectdiscovery subdomain discovery tool)
- httpx (projectdiscovery HTTP toolkit)
- hakrawler (Hakluke's web crawler)
- hakrevdns (Hakluke's reverse DNS tool)
- haklistgen (Hakluke's list generator)
- hakoriginfinder (Hakluke's origin finder)
- hakcheckurl (Hakluke's URL checker)
- haktrails (Hakluke's trail finder)
- haktldextract (Hakluke's TLD extractor)
- hakip2host (Hakluke's IP to host resolver)
- nikto (web server scanner)

### Additional Tools:
- perl
- libnet-ssleay-perl

This list covers all the tools and dependencies installed by the Dockerfile, categorized for better understanding.

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

```bash
docker run -it --rm --pull=always \
    -e SANDBOX_BASE_CONTAINER_IMAGE=custom-image \
    ...
```


## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/xbay-au/Openhands-custom-image/blob/main/LICENSE) file for details.

