

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

# Tools and Languages Installed

## Programming Languages and Runtimes

- **Python 3.12**
- **Node.js 22**
  - Includes `npm` (Node Package Manager)
- **Ruby**
- **PHP**
- **OpenJDK 17**
- **Go 1.21.5**

## Essential Tools and Libraries


- **Bash**
- **Curl**
- **Wget**
- **Git**
- **CA Certificates**
- **Build-essential** (GCC, G++, Make)
- **Libssl-dev**
- **Zlib1g-dev**
- **Libbz2-dev**
- **Libreadline-dev**
- **Libsqlite3-dev**
- **LLVM**
- **Libncurses5-dev**
- **Libncursesw5-dev**
- **Libcurl4-openssl-dev**
- **Libxml2** and **Libxml2-dev**
- **Libxslt1-dev**
- **Ruby-dev**
- **Libgmp-dev**
- **Xz-utils**
- **Apt-utils**
- **Tk-dev**
- **Libffi-dev**
- **Iputils-ping**
- **Dirb**
- **Lsd** (modern `ls` command)
- **Nano** (text editor)

## Security Tools
### found in /usr/bin
- **Ping**
- 
## found in /usr/local/bin/
- - **Wpscan** (WordPress security scanner)

### found in /root/go/bin
- **Subfinder** (Subdomain discovery tool by ProjectDiscovery)
- **Httpx** (Fast and multi-purpose HTTP tool by ProjectDiscovery)
- **Hakrawler** (Web crawler by Hakluke)
- **Hakrevdns** (Reverse DNS lookup tool by Hakluke)
- **Haklistgen** (Subdomain list generator by Hakluke)
- **Hakoriginfinder** (Origin finding tool by Hakluke)
- **Hakcheckurl** (URL checker by Hakluke)
- **Haktrails** (Trail finding tool by Hakluke)
- **Haktldextract** (TLD extraction tool by Hakluke)
- **Hakip2host** (IP to host converter by Hakluke)
- **Ffuf** (Fast web fuzzer)
- **Assetfinder** (Subdomain and asset discovery tool by Tom Nomnom)
- **Waybackurls** (Extract URLs from the Wayback Machine by Tom Nomnom)
 




- **Nmap** (Network mapper)
- **Nikto** (Web server scanner)



## Containerization Tools

- **Docker CE** (Community Edition)
  - Includes `docker-ce-cli` and `containerd.io`

## Building the Docker Image

To build the custom Docker image for OpenHands, follow these steps:

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/xbay-au/Openhands-Runtime_Custom_Image.git
   cd Openhands-Runtime_Custom_Image
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

