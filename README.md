

# OpenHands Custom Docker Image

This repository sets up a custom Docker image for the OpenHands app, following the [custom sandbox guide](https://docs.all-hands.dev/usage/how-to/custom-sandbox-guide).

## Table of Contents
- [Features](#features)
- [Building the Docker Image](#building-the-docker-image)
- [Running the Docker Container](#running-the-docker-container)
- [Subdomain Files](#subdomain-files)

## Features

This custom image includes a comprehensive set of tools for various programming languages and security testing:

- **Programming Languages**:
  - Go
  - Node.js
  - Python (with pip)
  - Ruby
  - PHP
  - Java (OpenJDK 17)

- **Development Tools**:
  - Git
  - Build-essential (gcc, make, etc.)
  - Curl, Wget
  - Nano text editor

- **Security Tools**:
  - Nmap (with updated scripts)
  - Hydra
  - Nikto
  - Sqlmap
  - Subfinder (installed via Go as a security tool)

- **Utilities**:
  - Modern ls command (lsd)
  - Various development libraries for building software

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

## Subdomain Files

This repository also includes subdomain files generated using the `subfinder` tool:

- `subdomains.txt`: A comprehensive list of subdomains for various target websites (over 28,000 entries)
- `subdomain_200.txt`: A randomly selected subset containing exactly 200 subdomains

These files can be used as input for your applications that require subdomain information.

## Dockerfile Improvements

The Dockerfile has been optimized with the following improvements:

1. **Layer Optimization**: Package installations are split into separate layers to improve caching.
2. **Metadata**: Added additional labels for better image management (URL)
3. **Code Cleanup**:
   - Removed duplicate package installations
   - Improved formatting and comments for better readability

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/xbay-au/Openhands-custom-image/blob/main/LICENSE) file for details.

